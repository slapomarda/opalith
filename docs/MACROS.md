# Opalith Macro & Environment Reference

This document provides a concise, practical reference for all environments, macros, and configuration options available in the **Opalith** template.

---

## 1. Class Options

Loaded in `\documentclass[<options>]{opalith}`:

| Option | Values | Default | Description |
|---|---|---|---|
| `lang` | `english`, `italian` | `english` | Sets babel language, captions, decimal marker and theorem labels |
| `accent` | 6-character hex (e.g. `C09000`, `2E7D32`, `CC7221`) | `C09000` | Primary document accent colour (chapters, TOC, headers) |
| `bluebold` | `true`, `false` | `true` | When `true`, `\textbf{...}` renders in deep blue (`#0055A4`) |
| `inlinedisplay` | `true`, `false` | `true` | When `true`, inline math uses `\displaystyle` (large fractions) |
| `circuits` | `true`, `false` | `false` | Loads `circuitikz` with European styling |
| `qed` | `smiley`, `square` | `smiley` | End-of-proof symbol: smiley (`\Laughey`) or black square |

Any standard `report` class option (such as `11pt`, `oneside`, `letterpaper`) can also be passed directly.

---

## 2. Document Metadata & Title Page

Set in the preamble and printed via `\maketitle`:

```latex
\title{Full Course Title}
\subtitle{Optional Subtitle / Part Title}
\author{Your Name}
\headertitle{Short Header Title}        % Used in odd-page headers (defaults to \title)
\institution{University Name}           % Printed at the top of the title page
\department{Department Name}            % Optional department / faculty
\degree{BSc / MSc in Computer Science}  % Printed in academic details
\coursecode{Course ID / ECTS Credits}   % Optional course identifier (e.g. IN01123456 / 9 CFU)
\professor{Prof. Jane Doe}              % Lecturer name
\academicyear{2026/2027}                % Academic year
\logo[0.5\textwidth]{images/logo.png}   % Optional logo; skipped gracefully if file is missing
\date{\today}                           % Date (leave empty \date{} to omit)
```

---

## 3. Mathematical & Pedagogical Environments

All numbered environments (except `Exercise`) share **a single unified counter per section** (e.g., Theorem 1.1.1, Example 1.1.2, Definition 1.1.3), ensuring clear, intuitive cross-referencing throughout the text.

Both English and Italian environment names are fully supported:

### 3.1. Light Boxed Environments (0.4pt frame, tinted background)

| English Name | Italian Name | Short Macro | Description & Accent |
|---|---|---|---|
| `Theorem` | `Teorema` | `\thm{Title}{Content}` | Purple border (`colthm`) |
| `Corollary` | `Corollario` | `\cor{Title}{Content}` | Violet border (`colcor`) |
| `Lemma` | `Lemma` | `\lem{Title}{Content}` / `\mlenma` | Dark green border (`collem`) |
| `Proposition` | `Proposizione` | `\prp{Title}{Content}` | Brick orange border (`colprop`) |
| `Definition` | `Definizione` | `\dfn{Title}{Content}` | Brick red border (`coldef`) |
| `Formula` | `Formula` | `\frm{Title}{Content}` | Centered teal box (`colform`) |
| `Remark` | `Osservazione` | `\oss{Title}{Content}` | Neutral dark frame, white background |
| `Note` | `Nota` | `\nt{Title}{Content}` | Neutral dark frame, white background |
| `Warning` | `Attenzione` | `\warn{Title}{Content}` | Red alert box (`colwarn`) |

**Syntax example:**
```latex
% Using standard environment syntax:
\begin{Theorem}{Nyquist-Shannon Sampling Theorem}
  If a continuous signal contains no frequencies higher than $B$, it can be completely
  reconstructed from samples taken at frequency $f_s \ge 2B$.
\end{Theorem}

% Using concise shorthand macro (identical output):
\thm{Nyquist-Shannon Sampling Theorem}{
  If a continuous signal contains no frequencies higher than $B$...
}
```

### 3.2. Side-Bar Environments

- **`Example`** / **`Esempio`** (shorthand `\ex{Title}{Content}`): features an orange left accent bar. Shares the section counter.
- **`Exercise`** / **`Esercizio`** (shorthand `\exer{Title}{Content}`): features a crisp black left accent bar. Uses an **independent counter** per section.

### 3.3. Unboxed Environments

- **`Proof`** / **`Dimostrazione`** (shorthand `\dem{Title}{Content}`): italic inline header, closed by `\qedsymbol`.
- **`Solution`** / **`Soluzione`** (`\begin{Solution} ... \end{Solution}`): unboxed text, indented italic header, closed by a tombstone (`\blacksquare`).

---

## 4. Typography, Code, and Utilities

### 4.1. Text & Math Shortcuts

- `\textbf{text}`: coloured in bright dark blue (`#0055A4`).
- `\textbfblack{text}`: standard black bold font.
- `\uline{text}`: clean underline via `ulem` (while `\emph` remains italic).
- `\hyper{label}{text}`: red-underlined internal cross-reference hyperlink.
- `\setword{word}{label}`: attaches an invisible `\label` to an arbitrary printed word.
- `\circled{1}`: circled number or symbol.
- `\ct`: full-width divider rule matching the chapter style.

### 4.2. Calculus & Algebra Notation

- `\dd`: differential operator with correct mathematical spacing ($\mathrm{d}$).
- `\dv{y}{x}` or `\dv[2]{y}{x}`: first or $n$-th order total derivative $\frac{\mathrm{d}y}{\mathrm{d}x}$.
- `\pdv{f}{x}` or `\pdv[2]{f}{x}`: partial derivatives $\frac{\partial f}{\partial x}$.
- `\abs{x}`, `\norm{x}`, `\ceil{x}`, `\floor{x}`: paired self-scaling delimiters.
- `\RR`, `\NN`, `\ZZ`, `\QQ`, `\CC`: blackboard bold number sets (supports optional power, e.g. `\RR[3]` $\to \mathbb{R}^3$).
- `\Lap`, `\Var`, `\Cov`, `\E`: math operators for Laplace, Variance, Covariance, Expectation.

### 4.3. Source Code & Listings

Standard `lstlisting` blocks use the predefined `opalith` style:
```latex
\begin{lstlisting}[language=C]
int main(void) {
    printf("Hello, Opalith!\n");
    return 0;
}
\end{lstlisting}
```

### 4.4. Bulletproof Image Management

- **Missing Images Protection:** `\includegraphics{path}` checks for the file on disk. If the file is missing, it displays a cleanly formatted placeholder box with the filename, issuing a non-fatal warning instead of halting compilation.
- **Explicit Placeholders:** `\figplaceholder{Description of figure to crop from slides}` generates a standardized placeholder box. Perfect for lecture notes workflows.
