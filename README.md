# Opalith — University Lecture Notes LaTeX Template

[![LaTeX](https://img.shields.io/badge/LaTeX-pdflatex-008080.svg)](https://www.latex-project.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**Opalith** is a modern, modular LaTeX document class (`opalith.cls`) designed for university lecture notes, study guides, and problem sets in STEM disciplines.

It focuses on clean typography, structured visual hierarchy, and an uninterrupted writing workflow during lectures.

---

## Key Features

- **Thematic Callout Boxes:** Pre-configured environments for theorems, definitions, lemmas, propositions, and formulas with subtle backgrounds and consistent styling.
- **Unified Section Numbering:** Theoretical environments within a section share a single sequential counter (e.g., Theorem 1.1, Definition 1.2) for fast referencing.
- **Dedicated Environments for Exercises:** Side-bar callouts to clearly separate problem statements from proofs and solutions.
- **Fail-Safe Image Handling:** `\includegraphics` gracefully falls back to a placeholder if an asset is missing, preventing compilation halts during active note-taking.
- **STEM-Ready:** Out-of-the-box support for `circuitikz` (European convention), `pgfplots`, and styled code listings (`listings`).
- **Bilingual Support:** Configurable for both English and Italian (adapts typography, labels, and decimal separators).

---

## Repository Structure

```text
.
├── opalith.cls         # Core document class
├── main.tex            # Minimal starter document
├── demo.pdf            # Pre-compiled sample document
├── latexmkrc           # Build configuration
├── docs/
│   └── MACROS.md       # Macros and environments reference
├── examples/
│   └── demo.tex        # Full source for demo.pdf
└── AI_PROMPT.md        # Reference prompt for LLM-assisted transcription
```

---

## Quick Start

### Prerequisites

A modern TeX distribution (**TeX Live 2022+** or **MiKTeX 23.10+**) with standard packages (`newpxmath`, `tcolorbox`, `pgfplots`).

### Minimal Example

Include `opalith.cls` in your project directory and configure the document preamble:

```latex
\documentclass[lang=english, accent=0055A4, circuits=true]{opalith}

\title{Digital Signal Processing}
\subtitle{Lecture Notes}
\author{Author Name}
\professor{Prof. Alan Turing}
\institution{Faculty of Engineering}
\academicyear{2026/2027}

\begin{document}
\maketitle
\tableofcontents

\chapter{Discrete Systems}

\section{Linear Time-Invariant Systems}

\dfn{LTI System}{
  A system $\mathcal{H}$ is linear time-invariant if it satisfies both 
  superposition and time-invariance.
}

\thm{Impulse Response Representation}{
  Every stable discrete LTI system is uniquely determined by its impulse response $h[n]$:
  \[
    y[n] = x[n] * h[n] = \sum_{k=-\infty}^{+\infty} x[k] h[n - k]
  \]
}

\exer{Calculation}{
  Compute the output response for $x[n] = u[n]$ and $h[n] = 0.5^n u[n]$.
}
\begin{Solution}
  Applying the discrete convolution sum yields...
\end{Solution}

\end{document}
```

### Compilation

Compile using `pdflatex` (two passes recommended for TOC and cross-references):

```bash
pdflatex main.tex
pdflatex main.tex
```

Alternatively, use the provided `compile.sh` / `compile.bat` or run `latexmk -pdf main.tex`.

---

## Class Options

Pass desired options to `\documentclass[<options>]{opalith}`:

| Option | Values | Default | Description |
|---|---|---|---|
| `lang` | `english`, `italian` | `english` | Sets language labels, hyphenation, and decimal separators. |
| `accent` | 6-digit hex code | `C09000` | Primary accent color (chapters, TOC accents, callout borders). |
| `bluebold` | `true`, `false` | `true` | Highlights bold inline text in accent blue for quick scanning. |
| `inlinedisplay` | `true`, `false` | `true` | Enforces `\displaystyle` formatting in inline math environments. |
| `circuits` | `true`, `false` | `false` | Loads and sets up `circuitikz` with European conventions. |
| `qed` | `square`, `smiley` | `square` | Proof termination symbol. |

*Note: You can override the accent color mid-document using `\setaccent{HEX_CODE}`.*

---

## AI-Assisted Note Taking

A dedicated system prompt is available in [`AI_PROMPT.md`](AI_PROMPT.md). It instructs LLMs (Claude, ChatGPT, Gemini) to format raw lecture slides, audio transcripts, or handwriting notes directly into valid Opalith LaTeX markup, using correct macro hierarchies and `\figplaceholder{...}` tags for missing graphics.

---

## License

Distributed under the [MIT License](LICENSE). You are free to use, modify, and distribute this template for personal and academic work.
````<FollowUp>
Vuoi che adatti anche il contenuto di uno degli altri file (ad esempio `AI_PROMPT.md` o `MACROS.md`) per mantenerli coerenti con questa struttura?
</FollowUp>
