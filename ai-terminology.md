# A Physicist/Mathematician's Glossary for AI Terminology

## Why this document exists

Modern AI vocabulary borrows heavily from physics, mathematics, signal
processing, and chemistry — but uses many of those terms in narrower,
different, or simply incorrect senses. This causes three problems:

1. **Clarity.** Readers from those fields are misled into expecting the
   original meaning, and waste effort translating back.
2. **Discoverability.** Well-understood, established neutral terms
   (e.g. *array*, *reduced precision*, *cross-correlation*) get
   displaced, making it harder for AI to interoperate intellectually
   with adjacent fields.
3. **Intellectual hygiene.** Coining a fancier name for an existing
   concept obscures rather than clarifies.

This document is a side-by-side glossary aimed at two audiences:

- **Physicists / mathematicians / numerical analysts** coming into AI,
  so they know what AI papers actually mean.
- **AI practitioners**, so they know which of their everyday terms
  collide with established usage elsewhere.

Each entry carries a verdict:

- **keep** — borrowed correctly; no action needed.
- **replace** — a clearer, established term exists; use it. If the
  audience includes AI practitioners, parenthesize the AI term on
  first use (see *How to use this in writing* below).

## How this happened (briefly)

The terminology drift has at least four sources, and most terms below
involve a mix of them rather than a single cause:

1. **Established terms already existed and were not adopted.** For
   *array* and *reduced precision* in particular, neutral terms had
   been in use in numerical computing and DSP for decades. The AI
   community simply chose other names.
2. **Path dependence.** Once one influential paper uses a term, the
   rest of the field follows.
3. **Inheritance from an adjacent technical field.** Some AI terms
   come from a related field where they had a legitimate meaning,
   then collide with established usage elsewhere. *Quantization* is
   the clearest example: in signal processing it correctly refers
   to mapping a continuous (or higher-precision) signal to a coarser
   discrete set, and the AI usage is a straightforward extension to
   weights. The collision is with physics, where *quantization*
   means something entirely different.
4. **Branding / aspiration.** Some terms (e.g. *neural network*,
   *intelligence*, *hallucination*) were chosen for their evocative or
   aspirational tone, not their technical precision. Anthropomorphic
   borrowings are not automatically bad — *attention* is a defensible
   one, because the metaphor carries genuine explanatory content (see
   below). The problem is anthropomorphism used purely for flavor,
   without a corresponding operational meaning.

The cost is borne by readers from adjacent fields who must
continuously translate.

## Summary table

| AI term | What it means in AI | Established / physics-math meaning | Suggested neutral term | Verdict |
|---|---|---|---|---|
| tensor (the object, e.g. `tf.Tensor`, `torch.Tensor`) | multi-dimensional array of numbers | multilinear map / section of a tensor bundle with transformation laws | n-d array, ndarray | replace |
| tensor product, tensor contraction (the operations) | operations on tensors that preserve the tensor property; also applicable to plain arrays | same | — (correctly named) | keep |
| quantization | reducing weight/activation precision (e.g. FP32 → INT8) | (physics) replacing classical observables with operators on Hilbert space | precision reduction, low-precision conversion, weight discretization | replace |
| distillation | training a small "student" model to mimic a large "teacher" | (chemistry) purification by selective evaporation | student–teacher training, mimicry training | replace |
| convolution (CNN) | sliding dot product, *no* kernel flip | $(f * g)(t) = \int f(\tau)\, g(t-\tau)\, d\tau$ — *with* flip | cross-correlation | replace |
| inference | running the trained model forward on an input to produce a prediction | (statistics) drawing conclusions from data, **with uncertainty quantification** (posteriors, intervals, hypothesis tests) | prediction, forward pass, evaluation | replace |
| learning | (loosely) the process by which a model's parameters improve with data; in practice synonymous with *training* | (cognitive) acquiring knowledge or skill | training (preferred when both work) | keep (with caveat) |
| training | iterative fitting of model parameters from data, typically by stochastic gradient descent | (statistics / ML) same — long-established usage | — | keep |
| neural network | layered parameterized nonlinear function | (biology) network of actual neurons | parameterized function, differentiable circuit | replace |
| attention | softmax-weighted average of value vectors, with weights interpretable as where the model is "looking" | (cognitive science) selective focus | — | keep |
| hallucination | model emits fluent but false content | (medicine) false perceptual experience | false generation, fabrication | replace |
| embedding | dense vector representation of a discrete object | (algebra) injective homomorphism; (topology) injective map that is a homeomorphism onto its image | — | keep |
| regularization | adding penalty terms to discourage overfitting | (inverse problems) adding terms to stabilize ill-posed problems | — | keep |
| gradient descent | iterative update along $-\nabla L$ | same | — | keep |
| backpropagation | reverse-mode automatic differentiation through the model | reverse-mode AD | — | keep |

## Notable entries

### Tensor → array  (verdict: *replace*)

In NumPy, the data type is called `ndarray` (n-dimensional array). This
is the honest name. The use of "tensor" for multi-way arrays did not
originate with TensorFlow or PyTorch — it goes back at least to the
psychometrics / chemometrics literature (Tucker, 1966; Harshman, 1970,
CANDECOMP/PARAFAC), and earlier ML frameworks already used it: Torch
(originally a C++ library from ≈2002; a Lua scripting interface was
added in Torch5 around 2008, and the rewrite around LuaJIT, Torch7,
came in 2011), and Theano (from 2007). TensorFlow and PyTorch
inherited and entrenched the convention rather than introducing it.

#### What a tensor actually is

A **tensor** is a single, basis-independent object. In general it is
an element of a tensor product space

$$W_1 \otimes \cdots \otimes W_n$$

where each $W_i$ is a vector space or its dual. Equivalently (in
finite dimensions), it is a multilinear map on the duals of the
$W_i$. In the common physics setting where all factors are taken from
a single vector space $V$, with $p$ copies of $V$ and $q$ copies of
$V^*$, this is called a **$(p, q)$-tensor** on $V$:

$$V \otimes \cdots \otimes V \otimes V^* \otimes \cdots \otimes V^* \qquad (p \text{ copies of } V,\ q \text{ copies of } V^*).$$

The "components with transformation law" view used in physics is the
same object presented in a chosen basis — not a separate definition.

Concretely: once a basis is chosen for $V$ (and the corresponding
dual basis for $V^*$), a $(p, q)$-tensor

$$T = \sum T^{i_1 \cdots i_p}{}_{j_1 \cdots j_q}\, e_{i_1} \otimes \cdots \otimes e_{i_p} \otimes e^{j_1} \otimes \cdots \otimes e^{j_q}$$

is represented by the array of components
$T^{i_1 \cdots i_p}{}_{j_1 \cdots j_q}$. Change the basis, and the
same tensor is represented by a different array, related to the
first by the transformation law. The tensor is the basis-independent
object; the array is its coordinate representation.

#### Tensor fields and manifolds

In physics, the word "tensor" almost always refers to a **tensor
field**: a tensor attached to each point of a manifold (e.g. the
metric $g_{\mu\nu}(x)$ on spacetime, the stress tensor
$\sigma_{ij}(x)$ in continuum mechanics). Change of basis in this
setting is induced by change of coordinates on the manifold.

A tensor *field* requires a manifold; a *tensor* by itself does not.
A single vector space supports tensors and change of basis without
any manifold structure. For example, the inertia tensor of a rigid
body is most naturally a single $(0, 2)$-tensor on $\mathbb{R}^3$ —
a symmetric bilinear form on the angular-velocity space, with
rotational kinetic energy $\tfrac{1}{2}\, I(\omega, \omega)$ — and
transforms under $\mathrm{SO}(3)$ without need for any manifold
beyond the underlying vector space. In Euclidean $\mathbb{R}^3$ with
the standard metric one routinely identifies $V$ with $V^*$ and so
views $I$ equivalently as a $(1, 1)$-tensor (a linear map $V \to V$),
under which it sends the angular-velocity vector $\omega$ to the
angular-momentum vector $L = I \omega$. In physics practice the
manifold is almost always present anyway, so for a physicist
"tensor" and "tensor field" are nearly synonymous.

#### Why AI "tensors" are not tensors

Calling AI arrays "tensors" fails on every part of the definition:

- **No tensor product space.** There is no $V_1 \otimes \cdots \otimes V_n$ behind the
  array. The axes are labels (token, channel, head), not factors of
  a tensor product.
- **No change of basis.** No other basis is ever considered, so no
  transformation law is ever invoked. The standard "basis" is fixed
  by fiat, but only because no alternative is meaningful.
- **No basis-independent object.** The array is not the coordinate
  representation of anything abstract; it *is* the object.
- **No manifold (in the usual case).** Some axes do correspond to
  coordinates on an underlying space — the H/W axes of an image, the
  time axis of a sequence, the xyz axes of a voxel grid — but that
  space's symmetries are not made part of the object's type, and no
  transformation law under them is imposed.

So AI "tensors" are not tensors with a fixed basis, with the
transformation law suppressed. They are arrays — full stop. The
honest name is **array** (or **n-d array** / **ndarray**, as NumPy
calls it).

A small exception: in **equivariant neural networks** and
**geometric deep learning** ($\mathrm{SO}(3)$/$\mathrm{SE}(3)$-equivariant
models, gauge-equivariant lattice models, etc.), genuine tensor
structure is explicit and transformation laws under group actions
are central. In those areas the word *tensor* is used correctly.

#### A note on tensor *operations*

Even when the objects in ML are arrays rather than genuine tensors,
the *operations* called **tensor product** and **tensor contraction**
are correctly named.

- The **tensor product** and **tensor contraction** are defined first
  as operations on tensors. They are called *tensor* operations
  because they **preserve the tensor property**: if the inputs are
  tensors, the output is guaranteed to be a tensor (it transforms
  correctly under change of basis). This closure property is what
  makes them tensor operations.
- The same operations can also be applied to plain arrays. The outer
  (tensor) product of arrays preserves their full multi-index
  structure: combining shapes $(m, n)$ and $(p, q)$ gives an array of
  shape $(m, n, p, q)$ — in NumPy this is `np.tensordot(a, b, axes=0)`
  or `np.einsum('ij,kl->ijkl', a, b)`. This is *not* the same as the
  **Kronecker product** `np.kron`, which is a related but distinct
  operation that flattens the result to shape $(m \cdot p,\ n \cdot q)$;
  the Kronecker product is one way to *represent* a tensor product as a
  matrix, not the tensor product itself. Likewise, **contraction**
  over a chosen pair of indices is a specific operation that, in a
  $(p, q)$-tensor, pairs one upper index against one lower index to
  yield a $(p-1, q-1)$-tensor; it is conveniently *written* using the
  Einstein summation **convention** (the notational shorthand in
  which repeated upper/lower indices are implicitly summed), but it
  is not identical to that convention — the broader index notation in
  which Einstein summation lives also expresses operations like
  **outer products** ($a^i b^j = T^{ij}$) and **index permutations**
  ($T^{ij} \mapsto T^{ji}$), which involve no repeated index and
  hence no contraction. (Conversely, traces and matrix multiplications
  *are* contractions, written using Einstein summation on the
  repeated index.)
  When the inputs are not tensors, the outputs of these operations
  are just arrays, with no transformation guarantee. The *operation*
  is still the tensor operation; what is lost is only the tensor
  character of the operands.

So `np.tensordot`, `np.einsum`, and the general vocabulary of "tensor
product" and "contraction" in ML libraries are *correctly* named,
even though `tf.Tensor` and `torch.Tensor` are misleading names for
the *objects*. The misuse is at the level of the noun, not the verbs.

### Quantization → precision reduction  (verdict: *replace*)

In physics, **quantization** is the construction of a quantum theory
from a classical one — for example, replacing Poisson brackets with
commutators (canonical quantization), or computing the functional
integral $\int \mathcal{D}\varphi\, \exp(i S[\varphi]/\hbar)$ over
field configurations (path-integral quantization; "sum over
histories" is Feynman's heuristic phrasing for what is technically a
continuous functional integral, not a sum). This is a deep
conceptual change of mathematical framework.

In AI, "quantization" means converting weights and/or activations from
FP32 to a lower-precision format (FP16, BF16, INT8, INT4, …).

The established computer-engineering terms are **fixed-point
arithmetic**, **low-precision arithmetic**, and **reduced precision**.

Signal processing does have its own meaning of "quantization" —
mapping a continuous (or higher-precision discrete) signal to a coarser
discrete set — which is much closer to the AI usage than the physics
meaning. So the AI usage is not entirely invented; it is the
signal-processing meaning extended to weights. Even so, **precision
reduction** or **weight discretization** are clearer for a general
audience and avoid the collision with physics.

### Distillation → student–teacher training  (verdict: *replace*)

Training a small "student" model to match the output distribution of
a large "teacher" model. The idea predates the *distillation* name:
it was introduced as **model compression** by Buciluă, Caruana, and
Niculescu-Mizil (KDD 2006) — training a small neural network to
mimic a large ensemble — and developed further by Ba and Caruana
(NeurIPS 2014, "Do Deep Nets Really Need to Be Deep?"). Hinton,
Vinyals, and Dean (2015) added the temperature-scaled soft-target
formulation and coined the name *knowledge distillation*. The
chemistry metaphor — extracting the "essence" of the teacher into a
smaller container — is a metaphor, not a technical correspondence.

Better names: **student–teacher training**, **mimicry training**,
**soft-target imitation**, or generically **model compression by
imitation**.

Note: *decimation* is sometimes proposed as a replacement but is not
better. In signal processing, decimation means uniform downsampling
(keeping every n-th sample), which is a different operation; and the
Latin root literally means "removal of every tenth" (a Roman military
punishment), so the DSP usage is itself a stretch and inheriting it
would only propagate the misappropriation. *Reduced model* describes
the result, not the procedure.

### Convolution → cross-correlation  (verdict: *replace*)

The operation in a convolutional layer is

$$y[i] = \sum_k x[i + k]\, w[k]$$

with **no** flip of the kernel. The mathematical convolution is

$$(x * w)[i] = \sum_k x[i - k]\, w[k]$$

with the flip. The two coincide only when the kernel is symmetric.

The CNN operation is a form of **cross-correlation**: the
signal-processing definition is
$(x \star w)[i] = \sum_k x[k]\, w[k + i]$ (with a complex conjugate
on $x$ in the complex case), which differs from the CNN formula only
by which operand is shifted and by the sign of the lag. The
substantive point is the same — no kernel flip — so following the
writing convention above, call the operation cross-correlation in
prose, with *convolution* parenthesized on first use if the audience
is used to the AI term.

### Inference → prediction / forward pass  (verdict: *replace*)

This is one of the cleanest collisions in the glossary. In
statistics, **inference** is the whole game: drawing conclusions
from data, almost always with explicit uncertainty quantification
— confidence intervals, posterior distributions, hypothesis tests,
predictive distributions. It is not a synonym for "computing an
output."

In AI, "inference" has been narrowed to mean *running the trained
model forward on a new input* and reading off a point prediction.
There is typically no uncertainty quantification at all. A
statistician reading "we ran inference on 10,000 examples"
reasonably expects posteriors or intervals and instead gets a batch
of argmaxes.

A natural defense of the AI usage is that LLMs do produce
probability distributions: each forward pass yields
$p(\text{next token} \mid \text{context})$, and sampling at
temperature $\tau > 0$ gives stochastic output with calculable
probabilities. Doesn't that match Webster's "calculated degrees of
certainty"?

Two reasons it doesn't. **First**, the distribution is over
*outputs* (which token to emit), not over *unknowns* (parameters,
latent variables, hypotheses). Statistical inference produces
$p(\theta \mid \text{data})$ — a posterior over an unknown.
The LLM forward pass produces $p(y \mid x, \theta)$ with $\theta$
fixed — a predictive likelihood. These are structurally different
objects; the LLM has no posterior over anything. **Second**, the
same term is used for $\tau = 0$ greedy decoding, which is a fully
deterministic function of the input, indistinguishable in nature
from a CNN classifier's argmax. A genuinely probabilistic-prediction
term would have to exclude this case; "inference" doesn't, because
in practice it just means *run the model forward*.

There is a smaller historical wrinkle worth noting: the term was
originally used correctly in two earlier ML lineages. In symbolic
AI / expert systems, the *inference engine* of a rule-based system
genuinely did Webster's sense 2a — applying inference rules to
derive new propositions from a knowledge base. In probabilistic /
Bayesian ML, *variational inference*, *MCMC inference*, and
*posterior inference* in graphical models, HMMs, and VAEs all
correctly compute $p(\text{latents} \mid \text{observations})$ with
full uncertainty quantification. The modern AI usage is a
degenerate generalization of the Bayesian one: the deep learning
community extended "inference" from "computing a posterior" to
"running any forward pass," stripping out the very thing that made
the original usage correct.

The neutral alternatives here lose nothing and gain precision:

- **prediction** — what the operation actually produces.
- **forward pass** — what it actually computes.
- **evaluation** — when it happens (at deployment, or on a test
  set).

Unlike *training* (where the neutral synonym *parameter fitting*
loses some procedural flavor), nothing is lost by switching. Use
one of these in prose, with *inference* parenthesized on first use
if the audience expects the AI term.

### Hallucination → false generation / fabrication  (verdict: *replace*)

"Hallucination" refers to a sensory experience in the absence of an
external stimulus. LLMs do not perceive anything; they generate
fluent text that is not grounded in fact. The literally accurate
terms are **false generation** or **fabrication**.

*Confabulation* — in clinical neurology and psychiatry, the
production of false memories without intent to deceive, typically
associated with Korsakoff syndrome, frontal-lobe damage, or dementia
— is sometimes proposed as a replacement. It is closer to what LLMs
do than *hallucination*, but it is also a metaphor (LLMs have no
episodic memory to confabulate from) and carries clinical baggage,
so **false generation** and **fabrication** are preferred.

### Neural network → parameterized function  (verdict: *replace*)

The term dates to McCulloch and Pitts (1943) and Rosenblatt (1958),
when the biological analogy was genuinely the inspiration. Modern
deep networks are essentially layered nonlinear function approximators
with little structural resemblance to biological neurons.

The honest descriptions are **parameterized nonlinear function**,
**differentiable circuit**, or simply **deep model**. Following the
writing convention, use one of these in prose, with *neural network*
parenthesized on first use. The biological framing should not be
taken literally.

### Attention  (verdict: *keep*)

In a transformer, "attention" is

$$\operatorname{Attention}(Q, K, V) = \operatorname{softmax}\!\left(\frac{Q K^\top}{\sqrt{d_k}}\right) V$$

where $Q$, $K$, $V$ are the query, key, and value arrays and $d_k$ is
the key (and query) dimension; in multi-head attention $d_k$ is
generally smaller than the model dimension $d_{\text{model}}$, so the
distinction matters. Mechanically, the operation is a
softmax-weighted average of value vectors, with weights computed
from a similarity score $Q K^\top$ between each query and each key.

The cognitive metaphor is, for once, operationally meaningful rather
than purely decorative. The softmax produces a probability
distribution over keys (tokens) that typically concentrates most of
its mass on a small number of them and suppresses the rest. For each
query, this distribution literally is "how much weight each token
gets" in the output — equivalent in this context to *which tokens
the model is looking at when computing this position's update*. The
term was introduced in Bahdanau et al. (2014) for neural machine
translation, where the weights showed which source word the decoder
was aligning with each target word it produced; the alignment
behavior is what motivated the name. In multi-head attention,
different heads learn to focus on different structural relations
(local syntactic dependencies, long-range coreference, etc.), which
is again well captured by the metaphor.

Unlike *tensor* or *quantization*, "attention" also does not collide
with a precise technical meaning in another field — cognitive
"attention" is itself a loose concept, so the borrowing imports
intuition without overwriting a sharper definition.

Caveat for the physics/math reader: the model is not consciously
focusing on anything. "Attention" here is shorthand for the
softmax-weighted averaging operation above, and the "where it is
looking" interpretation is a useful way to read the weights, not a
claim about cognition. Equivalent neutral descriptions are
**softmax mixing**, **content-based gating**, and **kernel smoothing
with a learned kernel**; these are sometimes useful when the
operational view is what matters.

This entry illustrates the general principle: anthropomorphic
borrowings are acceptable when the metaphor carries genuine
operational content. They are objectionable when used purely for
flavor (cf. *hallucination*, *intelligence*).

### Training and learning  (verdict: *keep* / *keep with caveat*)

**Training** is the iterative procedure that fits a model's
parameters to data, typically by stochastic gradient descent on a
loss function. The term predates deep learning by decades in
statistics and classical ML: *training set*, *training error*,
*supervised training* were all standard usage well before backprop.
There is no collision with another field's precise meaning — a
statistician will read "train the model" exactly as intended.
*Training* also carries operational content that pure synonyms like
*parameter fitting* lose: the iteration, the data dependence, the
notion of a training loop with a held-out test set. Use it freely.

**Learning** is more anthropomorphic but, like *attention*, has an
operational core: the parameters change in response to data in a way
that reduces loss, which fits Mitchell's classical definition
(improvement in performance on a task with experience). Compound
terms — *machine learning*, *supervised/unsupervised learning*,
*learning rate*, *learning curve*, *deep learning* — are entrenched
technical vocabulary and should be used as-is; trying to replace
*machine learning* with *machine parameter fitting* is a non-starter.

Caveats for *learning*:

- It imports more cognitive flavor than *training*. The model is not
  acquiring knowledge in any cognitive sense; it is fitting
  parameters.
- When *training* and *learning* are both available as a verb
  ("the model was trained" vs. "the model learned"), prefer
  *trained* — it is the more mechanical and accurate description.

In short: *training* is fine, *learning* is fine in established
compounds, and **nonlinear regression** / **parameter estimation**
remain useful framings for a physics/math audience that wants the
underlying operation made explicit.

## How to use this in writing

The recommendation is the same in every context, including pure-AI
ones: **use the neutral term, and put the AI term in parentheses on
first use** so readers familiar only with the AI vocabulary can
follow. After the first use, the neutral term stands alone.

Example:

```
# Reduced Precision (Quantization) Details

The arrays (tensors) in the MoE attention have reduced precision
(quantization) to mxfp4. But all other arrays have the full
precision bf16.
```

Notice that on first use both *reduced precision (quantization)* and
*arrays (tensors)* are flagged, and from then on the neutral terms
are used directly.

This convention has several benefits:

- It is understandable to readers from physics, math, statistics, and
  signal processing without translation.
- It is understandable to AI practitioners, because the AI term is
  introduced on first use.
- It does not invent new vocabulary; the neutral terms already exist
  and are in wide use in adjacent fields.
- It puts gentle pressure on the AI vocabulary to converge with the
  rest of computational science, rather than diverging further.

When writing strictly for an audience that already shares the
established (physics / math / statistics / medicine) meanings —
for example, a physics paper that happens to touch on ML — the
parenthetical AI term can be dropped entirely. Reserve *tensor*,
*quantization*, *inference*, *convolution*, and *hallucination*
for their original meanings in those contexts.

## Open questions / things still to refine

- Should *logit* be on the list? (It comes from log-odds in
  statistics; in deep learning it has drifted to mean any pre-softmax
  score, even when no log-odds interpretation applies.)
- Should *kernel* (in the CNN sense) be on the list? It collides with
  the kernel-methods sense and with operator-theoretic kernels.
- Should *latent space*, *manifold hypothesis*, *energy*, *temperature*
  be discussed? Each has a more precise physics/math meaning that is
  only loosely respected in AI.
- Verdict on *embedding* — kept here, but worth a sentence on the
  loose AI usage (any low-dimensional vector representation) vs the
  strict mathematical sense (in algebra, an injective homomorphism;
  in topology, an injective continuous map that is a homeomorphism
  onto its image — i.e. *more* than just "injective and
  structure-preserving").
