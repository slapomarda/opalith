# Opalith — University Lecture Notes LaTeX Template

[![LaTeX](https://img.shields.io/badge/LaTeX-pdflatex-008080.svg)](https://www.latex-project.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Status: Production](https://img.shields.io/badge/Status-Tested%20%26%20Ready-brightgreen.svg)]()

**Opalith** is a clean, modern, and publication-ready LaTeX template for university lecture notes, problem sets, and course summaries in STEM disciplines (Computer Science, Telecommunications, Electronics, Mathematics, and Physics).

It consolidates and refines the distinct note-taking style originally created by [Simone Lapomarda](https://github.com/slapomarda) across three major university courses at the University of Padua into an open, modular, and portable class (`opalith.cls`).

---

## Key Aesthetic & Functional Features

- **Lightweight Modern Callout Boxes:** Theorems, definitions, lemmas, propositions, and formulas feature ultra-light tinted backgrounds (`3%` tint) with crisp solid borders (`0.85pt`) that render flawlessly across all PDF viewers and zoom levels.
- **Unified Section Counter:** All theoretical environments in a section share a single numbering sequence (e.g., Theorem 1.1.1, Definition 1.1.2, Remark 1.1.3), making theorems fast to locate when skimming and cross-referencing.
- **Side-Bar Highlights for Examples & Exercises:** Examples and exercises use distinct colored margin bars without enclosed boxes, separating problem statements from proofs and solutions.
- **Vibrant Blue Bold Text:** Inline `\textbf{...}` renders in deep cobalt blue (`#0055A4`) for rapid visual scanning during revision, while structural headings remain pitch black.
- **Giant Coloured Chapter Numerals:** Chapter openings feature a 64pt numeral colored with the document's primary accent, paired with an aligned chapter title.
- **Styled Table of Contents:** Custom header banner and chapter blocks in the document's accent color.
- **Crash-Proof Graphic Engine:** `\includegraphics` automatically falls back to an informative placeholder box if an image file is missing, preventing LaTeX compilation crashes during active note-taking.
- **Built-in Circuit & Math Support:** European-style `circuitikz`, `pgfplots` 1.18, and `listings` with styled syntax highlighting.
- **Multi-Language Ready:** First-class support for both Italian (`lang=italian`) and English (`lang=english`), adjusting labels, decimal separators, and hyphenation rules automatically.

---

## Demo Showcase

A complete, 9-page demonstration textbook titled **"Digital Transmission and Embedded Systems"** is pre-compiled and included in the repository:
- **Compiled PDF:** [`demo.pdf`](demo.pdf)
- **Source Code:** [`examples/demo.tex`](examples/demo.tex)

The showcase document is not a generic macro checklist; it is a coherent academic lecture note covering continuous/discrete Fourier transforms, the Nyquist-Shannon sampling theorem with full proof, active op-amp low-pass filtering, an embedded C interrupt service routine with a circular buffer, and real-time schedulability analysis.

---

## Repository Structure

```
Opalith/
├── opalith.cls               # Core LaTeX document class
├── main.tex                # Blank starter template for new notes
├── demo.pdf                # Ready-to-read pre-compiled showcase notes (9 pages)
├── AI_PROMPT.md            # Ready-to-use system prompt for AI-assisted note-taking
├── README.md               # Full user manual and documentation
├── LICENSE                 # MIT Open-Source Licence
├── .gitignore              # Ignores auxiliary build files
├── latexmkrc               # LaTeXmk build configuration
├── compile.bat             # Fast double-pass compiler for Windows
├── compile.sh              # Fast double-pass compiler for Linux/macOS
├── docs/
│   └── MACROS.md           # Comprehensive cheat-sheet of all environments and macros
└── examples/
    └── demo.tex            # Full source of the showcase textbook
```

---

## Quick Start

### 1. Requirements

Opalith is compatible with modern TeX distributions (**MiKTeX 23.10+** or **TeX Live 2022+**). No proprietary fonts are required; it uses standard Latin Modern and `newpxmath`.

### 2. Basic Usage

Copy `opalith.cls` into your project directory (or clone this repository) and start your document:

```latex
\documentclass[lang=english, accent=C09000, circuits=true]{opalith}

\title{Digital Signal Processing}
\subtitle{Lecture Notes & Laboratory Exercises}
\author{Alex Smith}
\professor{Prof. Alan Turing}
\institution{Faculty of Engineering}
\degree{BSc in Computer Engineering}
\academicyear{2026/2027}

\begin{document}
\maketitle
\tableofcontents

\chapter{Introduction to Discrete Systems}

\section{Linear Time-Invariant Systems}

\dfn{LTI System}{
  A system $\mathcal{H}$ is \uline{linear time-invariant} if it satisfies both the superposition
  principle and time equivariance.
}

\thm{Convolution Representation}{
  Every stable discrete LTI system is uniquely determined by its impulse response $h[n]$:
  \[
    y[n] = x[n] * h[n] = \sum_{k=-\infty}^{+\infty} x[k] h[n - k]
  \]
}

\dem{}{
  The proof follows by decomposing $x[n]$ into a weighted sum of shifted unit impulses $\delta[n-k]$.
}

\exer{Impulse Response Calculation}{
  Determine the response of the system $y[n] - 0.5 y[n-1] = x[n]$ to an input $x[n] = u[n]$.
}
\begin{Solution}
  Taking the $\mathcal{Z}$-transform of both sides yields $Y(z)(1 - 0.5 z^{-1}) = X(z)$...
\end{Solution}

\end{document}
```

### 3. Compilation

Compile your document with `pdflatex`:
```bash
# Recommended two passes to resolve table of contents and cross-references:
pdflatex main.tex
pdflatex main.tex
```

If you prefer building inside a separate `build/` directory:
```bash
mkdir build
pdflatex -output-directory=build main.tex
pdflatex -output-directory=build main.tex
```

---

## Configuration & Options

Pass options to `\documentclass[<options>]{opalith}`:

| Option | Values | Default | Purpose |
|---|---|---|---|
| `lang` | `english`, `italian` | `english` | Hyphenation, title translations, decimal separator (`.` vs `,`). |
| `accent` | 6-digit hex | `C09000` (Gold) | Primary accent colour (chapters, TOC, headers). Examples: `2E7D32` (Green), `CC7221` (Amber), `0055A4` (Blue). |
| `bluebold` | `true`, `false` | `true` | Makes `\textbf{...}` print in vibrant blue for fast visual scanning. |
| `inlinedisplay`| `true`, `false` | `true` | Forces inline math `$ ... $` to use `\displaystyle` (large fractions). |
| `circuits` | `true`, `false` | `false` | Loads `circuitikz` with European styling. |
| `qed` | `smiley`, `square`| `smiley` | Proof end tombstone: classic smiley (`\Laughey`) or solid square (`\blacksquare`). |

---

## Writing Notes with AI (Claude, ChatGPT, Gemini)

The repository includes a dedicated guide and prompt: [`AI_PROMPT.md`](AI_PROMPT.md).

1. Open [`AI_PROMPT.md`](AI_PROMPT.md) and copy the system prompt.
2. Paste it into your AI assistant along with:
   - Lecture PDF slides or transcript
   - Photos of whiteboard / lecture notes
3. The AI is specifically instructed to:
   - Match the Opalith visual hierarchy and macros.
   - Insert explicit `\figplaceholder{...}` tags for figures to be cropped manually.
   - Output either complete documents or seamlessly appendable sections without repeating preambles.

---

## Troubleshooting & FAQ

#### 1. Why does `\includegraphics` not crash when an image is missing?
Opalith overrides `\includegraphics` to check file availability on disk. If a referenced graphic is not found, a bordered placeholder box containing the requested filename is drawn instead, and a warning is written to the log. This allows you to draft text rapidly during lectures without interrupting the compilation flow.

#### 2. How do I mark a diagram that I need to screenshot from slides later?
Use the native placeholder macro:
```latex
\figplaceholder{Slide 14: Frequency response diagram from Prof. slides}
```

#### 3. How do I change the accent colour dynamically?
You can use `\setaccent{HEX}` anywhere in your preamble:
```latex
\setaccent{2E7D32} % switches primary color to forest green
```

---

## License

This project is licensed under the [MIT License](LICENSE). You are completely free to use, modify, distribute, and publish notes or books created with this template.
