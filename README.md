# Build html

```
myst start
```

# Build pdf

```
myst build --tex && (cd _build/exports/paper_tex && tectonic paper.tex)
open _build/exports/paper_tex/paper.pdf
```
