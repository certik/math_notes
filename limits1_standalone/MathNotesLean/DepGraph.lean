import MathNotesLean.Limits1Flow
import ImportGraph.Lean.Environment

/-!
# Declaration-level dependency graph for `Limits1Flow.lean`

This is an analysis/tooling file (not part of the proof). For a chosen set of root
declarations it computes, via the kernel-visible dependencies of each constant
(`ConstantInfo.getUsedConstantsAsSet` = the constants occurring in a declaration's *type* and
*proof term*), the full transitive closure all the way down to the axioms. It then:

* prints a breakdown of the reachable constants by kind (def / theorem / axiom / inductive / …),
* lists the leaf axioms,
* counts the distinct source modules that actually contribute a used constant
  (i.e. how many of the vendored `Mathlib/` files are *semantically* needed), and
* writes the full edge list (`dep_edges.tsv`) and a Graphviz `dep_graph.dot`.

Run with:  `lake env lean MathNotesLean/DepGraph.lean`
-/

open Lean

namespace DepGraph

/-- Direct kernel dependencies of `n`: every constant occurring in its type or proof term. -/
def directDeps (env : Environment) (n : Name) : Array Name :=
  match env.find? n with
  | none => #[]
  | some ci => ci.getUsedConstantsAsSet.toArray.filter (· != n)

/-- Transitive closure + edge list, starting from `roots`. -/
partial def build (env : Environment) (roots : Array Name) : NameSet × Array (Name × Name) :=
  let rec go : List Name → NameSet → Array (Name × Name) → NameSet × Array (Name × Name)
    | [], visited, edges => (visited, edges)
    | n :: rest, visited, edges =>
      if visited.contains n then go rest visited edges
      else
        let visited := visited.insert n
        let deps := directDeps env n
        let edges := deps.foldl (fun e d => e.push (n, d)) edges
        go (deps.toList ++ rest) visited edges
  go roots.toList {} #[]

/-- A short tag for the kind of a constant. -/
def kindOf (env : Environment) (n : Name) : String :=
  match env.find? n with
  | none => "missing"
  | some (.axiomInfo _)  => "axiom"
  | some (.defnInfo _)   => "def"
  | some (.thmInfo _)    => "theorem"
  | some (.opaqueInfo _) => "opaque"
  | some (.quotInfo _)   => "quot"
  | some (.inductInfo _) => "inductive"
  | some (.ctorInfo _)   => "ctor"
  | some (.recInfo _)    => "recursor"

/-- Pretty-print a closure report for the given roots. -/
def report (roots : Array Name) (tag : String) : CoreM Unit := do
  let env ← getEnv
  let (nodes, edges) := build env roots
  let kinds := ["axiom","def","theorem","opaque","quot","inductive","ctor","recursor","missing"]
  let mut counts : Std.HashMap String Nat := {}
  let mut modules : NameSet := {}
  for n in nodes do
    let k := kindOf env n
    counts := counts.insert k ((counts.getD k 0) + 1)
    if let some m := env.getModuleFor? n then
      modules := modules.insert m
  IO.println s!"==== {tag} ===="
  IO.println s!"roots: {roots.toList}"
  IO.println s!"reachable constants (nodes): {nodes.size}"
  IO.println s!"dependency edges: {edges.size}"
  for k in kinds do
    if let some c := counts.get? k then
      IO.println s!"  {k}: {c}"
  -- distinct source modules that contribute at least one used constant
  let mlMods := modules.toArray.filter (fun m => ("Mathlib").isPrefixOf m.toString)
  IO.println s!"distinct source modules contributing a used constant: {modules.size}"
  IO.println s!"  of which Mathlib modules: {mlMods.size}"
  -- the leaf axioms
  let axioms := nodes.toArray.filter (fun n => kindOf env n == "axiom")
  IO.println s!"axioms ({axioms.size}): {(axioms.qsort (·.toString < ·.toString)).toList}"
  IO.println ""

/-- Write the full edge list and a Graphviz DOT for `roots`. -/
def dump (roots : Array Name) (stem : String) : CoreM Unit := do
  let env ← getEnv
  let (_, edges) := build env roots
  -- TSV edge list: source<TAB>target
  let tsv := edges.foldl (fun acc (a, b) => acc ++ s!"{a}\t{b}\n") ""
  IO.FS.writeFile s!"{stem}_edges.tsv" tsv
  -- Graphviz DOT
  let esc (n : Name) : String := "\"" ++ n.toString ++ "\""
  let body := edges.foldl (fun acc (a, b) => acc ++ s!"  {esc a} -> {esc b};\n") ""
  IO.FS.writeFile s!"{stem}.dot" s!"digraph deps \{\n  rankdir=LR;\n  node [shape=box, fontsize=8];\n{body}}\n"
  IO.println s!"wrote {stem}_edges.tsv and {stem}.dot ({edges.size} edges)"

/-- Module-level rollup: collapse every used constant to its defining module, build the induced
module→module graph, rank modules by how many used constants they contribute, and write a (small,
renderable) DOT. Returns nothing; prints a ranking and writes `{stem}_modules.dot`. -/
def moduleRollup (roots : Array Name) (stem : String) (topN : Nat := 40) : CoreM Unit := do
  let env ← getEnv
  let (nodes, edges) := build env roots
  -- count used constants per module
  let mut perMod : Std.HashMap Name Nat := {}
  for n in nodes do
    if let some m := env.getModuleFor? n then
      perMod := perMod.insert m ((perMod.getD m 0) + 1)
  -- induced module edges (dedup, drop self-loops)
  let modOf (n : Name) : Option Name := env.getModuleFor? n
  let mut modEdges : Std.HashSet (Name × Name) := {}
  for (a, b) in edges do
    match modOf a, modOf b with
    | some ma, some mb => if ma != mb then modEdges := modEdges.insert (ma, mb)
    | _, _ => pure ()
  IO.println s!"==== module rollup for {stem} ===="
  IO.println s!"modules contributing a used constant: {perMod.size}"
  IO.println s!"induced module->module edges: {modEdges.size}"
  -- ranking
  let ranked := perMod.toArray.qsort (fun a b => a.2 > b.2)
  IO.println s!"top {topN} modules by #used constants:"
  for (m, c) in ranked.toList.take topN do
    IO.println s!"  {c}\t{m}"
  -- write module DOT (small enough to render)
  let esc (n : Name) : String := "\"" ++ n.toString ++ "\""
  let body := modEdges.toArray.foldl (fun acc (a, b) => acc ++ s!"  {esc a} -> {esc b};\n") ""
  IO.FS.writeFile s!"{stem}_modules.dot"
    s!"digraph mods \{\n  rankdir=LR;\n  node [shape=box, fontsize=9];\n{body}}\n"
  -- write the full per-module ranking as TSV
  let tsv := ranked.foldl (fun acc (m, c) => acc ++ s!"{c}\t{m}\n") ""
  IO.FS.writeFile s!"{stem}_modules.tsv" tsv
  IO.println s!"wrote {stem}_modules.dot ({modEdges.size} edges) and {stem}_modules.tsv"
  IO.println ""

end DepGraph

open DepGraph MathNotesLean.Limits1Flow

/-- The four public declarations of the note. -/
def allRoots : Array Name :=
  #[``Limit, ``exists_bound_near, ``limit_mul, ``limit_iff_tendsto]

run_cmd Lean.Elab.Command.liftCoreM do
  -- The product rule alone (the actual theorem of the note):
  report #[``limit_mul] "limit_mul (the product rule)"
  -- The faithfulness bridge alone (pulls in filters / neighbourhoods):
  report #[``limit_iff_tendsto] "limit_iff_tendsto (the bridge to Mathlib's limit)"
  -- Everything the file proves:
  report allRoots "all public results of Limits1Flow"
  -- Dump artifacts for the union.
  dump allRoots "dep_graph"
  dump #[``limit_mul] "dep_graph_limit_mul"
  -- Module-level rollups (small, renderable).
  moduleRollup allRoots "dep_graph"
  moduleRollup #[``limit_mul] "dep_graph_limit_mul"
