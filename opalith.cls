%% opalith.cls — a LaTeX class for university lecture notes
%% -----------------------------------------------------------------------------
%% Opalith consolidates a personal note-taking style (light elegant callout boxes,
%% giant coloured chapter numbers, blue bold text, coloured table of contents)
%% into a single, portable, documented document class.
%%
%% Usage (see README.md for the full manual):
%%   \documentclass[lang=english, accent=C09000]{opalith}
%%
%% Class options (key = value):
%%   lang          = english | italian   labels, hyphenation, decimal marker  [english]
%%   accent        = <HTML hex colour>   main colour of the document           [C09000]
%%   bluebold      = true | false        \textbf prints in blue                [true]
%%   inlinedisplay = true | false        inline maths in \displaystyle         [true]
%%   circuits      = true | false        load circuitikz                       [false]
%%   qed           = smiley | square     end-of-proof symbol                   [smiley]
%%   Any other option (11pt, oneside, letterpaper, ...) is passed to `report`.
%%
%% Released under the MIT licence (see LICENSE).
%% -----------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[2022/11/01]
\ProvidesClass{opalith}[2026/10/23 v1.0 Opalith lecture-notes class]

%% =============================================================================
%% 1. OPTIONS
%% =============================================================================
\newif\ifopalith@bluebold      \opalith@blueboldtrue
\newif\ifopalith@inlinedisplay \opalith@inlinedisplaytrue
\newif\ifopalith@circuits      \opalith@circuitsfalse
\def\opalith@lang{english}
\def\opalith@accent{C09000}
\def\opalith@qed{smiley}

\DeclareKeys[opalith]{
  lang          .store = \opalith@lang,
  accent        .store = \opalith@accent,
  qed           .store = \opalith@qed,
  bluebold      .if    = opalith@bluebold,
  inlinedisplay .if    = opalith@inlinedisplay,
  circuits      .if    = opalith@circuits,
}
\DeclareUnknownKeyHandler[opalith]{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessKeyOptions[opalith]

\def\opalith@tmp{italian}
\ifx\opalith@lang\opalith@tmp\else
  \def\opalith@tmp{english}
  \ifx\opalith@lang\opalith@tmp\else
    \ClassWarningNoLine{opalith}{Unknown language `\opalith@lang'; falling back to `english'}
    \def\opalith@lang{english}
  \fi
\fi

%% `twoside` lets fancyhdr distinguish even/odd headers; report uses `openany`,
%% so no blank pages are inserted. A4 is the default paper size.
\PassOptionsToClass{a4paper,twoside}{report}
\LoadClass{report}
\raggedbottom % keep natural page bottoms (twoside would enable \flushbottom)

%% =============================================================================
%% 2. PACKAGES
%% =============================================================================
% --- Fonts and language ------------------------------------------------------
% Text: Latin Modern (scalable Computer Modern, needed by the 64pt chapter
% numbers); T1 encoding gives correct hyphenation of accented words.
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage[\opalith@lang]{babel}

% --- Page layout -------------------------------------------------------------
\RequirePackage[top=0.85in, bottom=2cm, hmargin=0.85in,
                footskip=0.2in, headheight=14pt]{geometry}
\RequirePackage{parskip}       % no indentation, space between paragraphs
\setlength{\parindent}{0pt}

% --- Mathematics -------------------------------------------------------------
\RequirePackage{amsmath, amssymb, amsthm, mathtools}
\RequirePackage[varbb]{newpxmath} % Palatino-like maths (part of the style)
\RequirePackage{mathrsfs}         % \mathscr, loaded after newpxmath on purpose
\RequirePackage[makeroom]{cancel}

% --- Utilities ---------------------------------------------------------------
\RequirePackage{etoolbox}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage[normalem]{ulem}   % \uline; normalem keeps \emph italic
\RequirePackage{enumitem}
\RequirePackage{multicol}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{wrapfig}
\RequirePackage{caption}
\RequirePackage{siunitx}

% --- Graphics ----------------------------------------------------------------
\RequirePackage{tikz}
\usetikzlibrary{arrows.meta, positioning, calc, patterns, babel}
\RequirePackage{pgfplots}
\pgfplotsset{compat=1.18}
\ifopalith@circuits
  \RequirePackage[european]{circuitikz}
\fi

% --- Code and algorithms -----------------------------------------------------
\RequirePackage{listings}

% --- Boxes, titles, headers --------------------------------------------------
\RequirePackage[most]{tcolorbox}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{fancyhdr}

% --- Hyperlinks (loaded late, as recommended) --------------------------------
\RequirePackage{hyperref}
\RequirePackage{bookmark}
\hypersetup{
  colorlinks=true, linkcolor=black, citecolor=black, urlcolor=boldblue,
  bookmarksnumbered=true, bookmarksopen=true,
}
\RequirePackage[ruled,vlined,linesnumbered]{algorithm2e}
% Ready-to-use, turnkey algorithm configuration:
% - Lines numbered & lined rules active by default (no boilerplate needed)
% - Typewriter monospace font for algorithm body and bold typewriter keywords
% - Line numbers flush against the left margin, code indented cleanly
\SetAlgoLined
\LinesNumbered
\IncMargin{1.5em}
\SetAlFnt{\small\ttfamily}
\NewCommandCopy{\textbfblack}{\textbf}
\newcommand\opalithnlfont[1]{\textcolor{gray!70!black}{\footnotesize\normalfont #1}}
\SetNlSty{opalithnlfont}{}{}
\SetNlSkip{0.8em}
\SetAlCapFnt{\small\bfseries\normalfont\color{black}}
\SetAlCapNameFnt{\small\normalfont\color{black}}
\newcommand\opalithkwfont[1]{\textbfblack{\ttfamily #1}}
\SetKwSty{opalithkwfont}
\SetArgSty{texttt}
\SetFuncSty{texttt}
\SetDataSty{texttt}
\newcommand\opalithcommfont[1]{\small\ttfamily\itshape\color{codecomment}{#1}}
\SetCommentSty{opalithcommfont}
\AtBeginEnvironment{algorithm}{%
  \catcode95=12\relax
}
\DeclareRobustCommand{\gets}{\ensuremath{\leftarrow}}

%% =============================================================================
%% 3. LOCALISATION
%% =============================================================================
% All labels printed by the class. Edit them here or with \renewcommand.
\def\opalith@tmp{italian}
\ifx\opalith@lang\opalith@tmp
  \newcommand\opalithTheoremName{Teorema}
  \newcommand\opalithCorollaryName{Corollario}
  \newcommand\opalithLemmaName{Lemma}
  \newcommand\opalithPropositionName{Proposizione}
  \newcommand\opalithDefinitionName{Definizione}
  \newcommand\opalithFormulaName{Formula}
  \newcommand\opalithExampleName{Esempio}
  \newcommand\opalithRemarkName{Osservazione}
  \newcommand\opalithNoteName{Nota}
  \newcommand\opalithWarningName{Attenzione}
  \newcommand\opalithProofName{Dimostrazione}
  \newcommand\opalithExerciseName{Esercizio}
  \newcommand\opalithSolutionName{Soluzione}
  \newcommand\opalithPageName{Pagina}
  \newcommand\opalithYearName{Anno Accademico}
  \newcommand\opalithProfessorName{Docente}
  \newcommand\opalithByName{by}
  \newcommand\opalithAuthorName{Autore}
  \newcommand\opalithNotesBadge{APPUNTI DEL CORSO}
  \newcommand\opalithMissingImageName{Immagine mancante}
  \newcommand\opalithPlaceholderName{Figura da inserire}
  \newcommand\opalithAlgorithmName{Algoritmo}
  \sisetup{output-decimal-marker={,}}
\else
  \newcommand\opalithTheoremName{Theorem}
  \newcommand\opalithCorollaryName{Corollary}
  \newcommand\opalithLemmaName{Lemma}
  \newcommand\opalithPropositionName{Proposition}
  \newcommand\opalithDefinitionName{Definition}
  \newcommand\opalithFormulaName{Formula}
  \newcommand\opalithExampleName{Example}
  \newcommand\opalithRemarkName{Remark}
  \newcommand\opalithNoteName{Note}
  \newcommand\opalithWarningName{Warning}
  \newcommand\opalithProofName{Proof}
  \newcommand\opalithExerciseName{Exercise}
  \newcommand\opalithSolutionName{Solution}
  \newcommand\opalithPageName{Page}
  \newcommand\opalithYearName{Academic Year}
  \newcommand\opalithProfessorName{Lecturer}
  \newcommand\opalithByName{by}
  \newcommand\opalithAuthorName{Author}
  \newcommand\opalithNotesBadge{COMPREHENSIVE LECTURE NOTES}
  \newcommand\opalithMissingImageName{Missing image}
  \newcommand\opalithPlaceholderName{Figure to insert}
  \newcommand\opalithAlgorithmName{Algorithm}
\fi
\renewcommand\algorithmcfname{\opalithAlgorithmName}

%% =============================================================================
%% 4. COLOURS
%% =============================================================================
% Main document colour (chapter numbers, table of contents, header accents).
% Change it with the `accent` option or with \setaccent{HEX} in the preamble.
\definecolor{doc}{HTML}{\opalith@accent}
\colorlet{docdark}{doc!80!black}
\newcommand\setaccent[1]{\definecolor{doc}{HTML}{#1}\colorlet{docdark}{doc!80!black}}
\definecolor{boldblue}{HTML}{0055A4}  % colour of \textbf in running text

% Environment colours (redefine with \definecolor to customise)
\definecolor{colthm}{HTML}{800080}    % Theorem      — purple
\definecolor{colcor}{HTML}{7A288A}    % Corollary    — violet
\definecolor{collem}{HTML}{00754A}    % Lemma        — dark green
\definecolor{colprop}{HTML}{D05B43}   % Proposition  — brick orange
\definecolor{coldef}{HTML}{B22222}    % Definition   — brick red
\definecolor{colform}{HTML}{008080}   % Formula      — teal
\definecolor{colex}{HTML}{E88132}     % Example      — soft orange (side bar)
\definecolor{colexer}{HTML}{000000}   % Exercise     — black (side bar)
\definecolor{colwarn}{HTML}{C62828}   % Warning      — red

% Source-code colours: modern, crisp GitHub/VS-Code style (no yellow tint)
\definecolor{codeback}{HTML}{FFFFFF}
\definecolor{codeframe}{HTML}{CBD5E1}
\definecolor{codekeyword}{HTML}{0055A4}
\definecolor{codetype}{HTML}{0D9488}
\definecolor{codecomment}{rgb}{0, 0.55, 0.15}
\definecolor{codestring}{HTML}{B91C1C}
\definecolor{codenumber}{HTML}{94A3B8}

%% =============================================================================
%% 5. TEXT STYLE
%% =============================================================================
% Blue bold: \textbf{...} is blue in running text; titles use \bfseries and
% stay black. The original command is still available as \textbfblack.
\ifopalith@bluebold
  \RenewDocumentCommand{\textbf}{m}{\textbfblack{\textcolor{boldblue}{#1}}}
\fi

% Inline maths in display style (large inline fractions, as in the notes)
\ifopalith@inlinedisplay
  \everymath{\displaystyle}
\fi

% Slanted inequalities
\let\oldleq\leq
\let\oldgeq\geq
\renewcommand{\leq}{\leqslant}
\renewcommand{\geq}{\geqslant}

% Hyperlink-friendly bookmarks for titles containing styled text
\pdfstringdefDisableCommands{%
  \let\textbf\@firstofone \let\uline\@firstofone \let\circled\@firstofone}

% Captions: small text, bold label
\captionsetup{font=small, labelfont=bf}

%% =============================================================================
%% 6. CHAPTERS, SECTIONS, HEADERS
%% =============================================================================
% Numbered chapters: giant number in the accent colour, black title beside it
\titleformat{\chapter}[hang]
  {\normalfont\bfseries}
  {\fontsize{64}{64}\selectfont\textcolor{doc}{\thechapter}}
  {18pt}
  {\Huge\color{black}}
% Unnumbered chapters (contents, bibliography): same look as standard report
\titleformat{name=\chapter,numberless}[block]
  {\normalfont\Huge\bfseries\raggedright}{}{0pt}{}
\titlespacing*{name=\chapter,numberless}{0pt}{30pt}{55pt}

% Sections: black bold titles
\titleformat{\section}
  {\normalfont\Large\bfseries\color{black}}{\thesection}{0.8em}{}
\titleformat{\subsection}
  {\normalfont\large\bfseries\color{black}}{\thesubsection}{0.8em}{}
\titleformat{\subsubsection}
  {\normalfont\normalsize\bfseries\color{black}}{\thesubsubsection}{0.8em}{}
\titlespacing*{\section}{0pt}{3.2ex plus 1ex minus .2ex}{1.2ex plus .2ex}
\titlespacing*{\subsection}{0pt}{2.6ex plus 1ex minus .2ex}{0.8ex plus .2ex}
\titlespacing*{\subsubsection}{0pt}{2.2ex plus 1ex minus .2ex}{0.6ex plus .2ex}

% Horizontal rule as wide as the text
\newcommand{\ct}{\vspace{3mm}\noindent{\color{black}\rule{\textwidth}{1pt}}\par\vspace{3mm}}

% Header/footer (Academic book style)
%   even pages: "N  Chapter title ........................ page"
%   odd pages:  "page ....................... Title, by Author"
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\chaptermark}[1]{\markboth{\textcolor{doc}{\thechapter}\quad #1}{}}
\renewcommand{\sectionmark}[1]{}
\fancyhead[LE]{\small\leftmark}
\fancyhead[RE]{\small\thepage}
\fancyhead[LO]{\small\thepage}
\fancyhead[RO]{\small\itshape\opalith@headertext}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}
\fancypagestyle{plain}{% chapter opening pages
  \fancyhf{}%
  \fancyfoot[C]{\small\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}}

%% =============================================================================
%% 7. ENVIRONMENTS (light boxes, sharp corners)
%% =============================================================================
% Visual hierarchy:
%  * light box (0.4pt frame, almost invisible tint): Theorem, Lemma,
%    Corollary, Proposition, Definition, Formula, Remark, Note, Warning
%  * side bar only: Example (orange), Exercise (black)
%  * plain text with inline heading: Proof, Solution
% All numbered environments except Exercise share ONE counter per section
% (Theorem 1.2.1, Example 1.2.2, ...), so references are easy to find.
%
% Interface:  \begin{Theorem}[tcolorbox options]{Title} ... \end{Theorem}
%             \thm{Title}{Body}            (short form, title may be empty)

% Inline heading: "Label N (Title)."
\newcommand{\opalith@head}[3]{%
  {\bfseries\color{#1}#2}%
  \ifstrempty{#3}{}{\ {\bfseries(#3)}}%
  .\enspace\ignorespaces}

\tcbset{
  opalithbase/.style={
    enhanced, breakable, sharp corners,
    parbox=false, fontupper=\normalfont,
    before skip=10pt plus 2pt minus 2pt,
    after skip=10pt plus 2pt minus 2pt,
  },
  % light box: solid continuous frame (0.85pt rule and pure #1 frame color eliminate PDF sub-pixel dropping)
  coloredbox/.style={
    opalithbase,
    colback=#1!3!white,
    colframe=#1,
    boxrule=0.85pt,
    left=3.5mm, right=3.5mm, top=2.5mm, bottom=2.5mm,
    coltitle=#1, fonttitle=\bfseries,
    attach title to upper={\par\vspace{1.5mm}},
  },
  % no box at all
  plainstyle/.style={
    opalithbase, blank, left=0pt, right=0pt, top=0pt, bottom=0pt,
  },
  % thick coloured bar on the left edge
  coloredexercise/.style={
    opalithbase, frame hidden, interior hidden, boxrule=0pt, boxsep=0pt,
    borderline west={2.5pt}{0pt}{#1},
    left=4mm, right=0pt, top=1mm, bottom=1mm,
  },
}

\newcommand\opalith@title[2]{#1~\thetcbcounter\ifstrempty{#2}{}{ (#2)}}

\newtcolorbox[auto counter, number within=section]{Theorem}[2][]{%
  coloredbox=colthm, title={\opalith@title{\opalithTheoremName}{#2}}, #1}
\newtcolorbox[use counter from=Theorem]{Corollary}[2][]{%
  coloredbox=colcor, title={\opalith@title{\opalithCorollaryName}{#2}}, #1}
\newtcolorbox[use counter from=Theorem]{Lemma}[2][]{%
  coloredbox=collem, title={\opalith@title{\opalithLemmaName}{#2}}, #1}
\newtcolorbox[use counter from=Theorem]{Proposition}[2][]{%
  coloredbox=colprop, title={\opalith@title{\opalithPropositionName}{#2}}, #1}
\newtcolorbox[use counter from=Theorem]{Definition}[2][]{%
  coloredbox=coldef, title={\opalith@title{\opalithDefinitionName}{#2}}, #1}
\newtcolorbox[use counter from=Theorem]{Formula}[2][]{%
  coloredbox=colform, colback=white, halign=center,
  title={\opalith@title{\opalithFormulaName}{#2}}, #1}
\newtcolorbox[use counter from=Theorem]{Example}[2][]{%
  coloredexercise=colex,
  before upper={\opalith@head{colex}{\opalithExampleName~\thetcbcounter}{#2}}, #1}
\newtcolorbox[use counter from=Theorem]{Remark}[2][]{%
  coloredbox=black, colframe=black, colback=white,
  title={\opalith@title{\opalithRemarkName}{#2}}, #1}
\newtcolorbox[use counter from=Theorem]{Note}[2][]{%
  coloredbox=black, colframe=black, colback=white,
  title={\opalith@title{\opalithNoteName}{#2}}, #1}
\newtcolorbox[use counter from=Theorem]{Warning}[2][]{%
  coloredbox=colwarn, colframe=colwarn, colback=white,
  title={\opalith@title{\opalithWarningName}{#2}}, #1}
\newtcolorbox{Proof}[2][]{%
  plainstyle,
  before upper={\opalith@head{black}{\itshape\opalithProofName}{#2}},
  after upper={\qed}, #1}
% Exercise: own counter per section. Write the solution AFTER \end{Exercise},
% optionally inside the Solution environment.
\newtcolorbox[auto counter, number within=section]{Exercise}[2][]{%
  coloredexercise=colexer,
  before upper={\opalith@head{colexer}{\opalithExerciseName~\thetcbcounter}{#2}}, #1}
% Solution: plain text, italic heading, black square at the end
\newcommand{\solqed}{\ensuremath{\blacksquare}}
\newtcolorbox{Solution}[1][]{%
  plainstyle,
  before upper={{\itshape\ifstrempty{#1}{\opalithSolutionName}{#1}.}\enspace\ignorespaces},
  after upper={\renewcommand{\qedsymbol}{\solqed}\qed}}

% End-of-proof symbol
\def\opalith@tmp{square}
\ifx\opalith@qed\opalith@tmp
  \renewcommand\qedsymbol{\ensuremath{\blacksquare}}
\else
  \RequirePackage{tikzsymbols}
  \renewcommand\qedsymbol{$\Laughey$}
\fi

% Short forms: \cmd{Title}{Body}
\newcommand{\thm}[2]{\begin{Theorem}{#1}#2\end{Theorem}}
\newcommand{\cor}[2]{\begin{Corollary}{#1}#2\end{Corollary}}
\newcommand{\lem}[2]{\begin{Lemma}{#1}#2\end{Lemma}}
\newcommand{\prp}[2]{\begin{Proposition}{#1}#2\end{Proposition}}
\newcommand{\dfn}[2]{\begin{Definition}{#1}#2\end{Definition}}
\newcommand{\frm}[2]{\begin{Formula}{#1}#2\end{Formula}}
\newcommand{\ex}[2]{\begin{Example}{#1}#2\end{Example}}
\newcommand{\oss}[2]{\begin{Remark}{#1}#2\end{Remark}}
\newcommand{\nt}[2]{\begin{Note}{#1}#2\end{Note}}
\newcommand{\warn}[2]{\begin{Warning}{#1}#2\end{Warning}}
\newcommand{\dem}[2]{\begin{Proof}{#1}#2\end{Proof}}
\newcommand{\exer}[2]{\begin{Exercise}{#1}#2\end{Exercise}}
\newcommand{\mlenma}{\lem} % backward-compatible alias of the original notes

% Italian environment names (aliases, identical behaviour)
\NewDocumentEnvironment{Teorema}{O{}m}{\begin{Theorem}[#1]{#2}}{\end{Theorem}}
\NewDocumentEnvironment{Corollario}{O{}m}{\begin{Corollary}[#1]{#2}}{\end{Corollary}}
\NewDocumentEnvironment{Proposizione}{O{}m}{\begin{Proposition}[#1]{#2}}{\end{Proposition}}
\NewDocumentEnvironment{Definizione}{O{}m}{\begin{Definition}[#1]{#2}}{\end{Definition}}
\NewDocumentEnvironment{Esempio}{O{}m}{\begin{Example}[#1]{#2}}{\end{Example}}
\NewDocumentEnvironment{Osservazione}{O{}m}{\begin{Remark}[#1]{#2}}{\end{Remark}}
\NewDocumentEnvironment{Nota}{O{}m}{\begin{Note}[#1]{#2}}{\end{Note}}
\NewDocumentEnvironment{Attenzione}{O{}m}{\begin{Warning}[#1]{#2}}{\end{Warning}}
\NewDocumentEnvironment{Dimostrazione}{O{}m}{\begin{Proof}[#1]{#2}}{\end{Proof}}
\NewDocumentEnvironment{Esercizio}{O{}m}{\begin{Exercise}[#1]{#2}}{\end{Exercise}}
\NewDocumentEnvironment{Soluzione}{O{}}{\begin{Solution}[#1]}{\end{Solution}}

%% =============================================================================
%% 8. SMALL COMMANDS
%% =============================================================================
% Red underlined internal link:  \hyper{label}{text}
\newcommand{\hyper}[2]{%
  {\hypersetup{linkcolor=red}\textcolor{red}{\uline{\hyperref[#1]{#2}}}}}
% Make an arbitrary word referenceable:  \setword{word}{label}
\newcommand{\setword}[2]{\phantomsection#1\def\@currentlabel{\unexpanded{#1}}\label{#2}}
% Circled character, e.g. step numbers:  \circled{1}
\newcommand*\circled[1]{\tikz[baseline=(char.base)]{%
  \node[shape=circle,draw,inner sep=1pt] (char) {#1};}}

%% =============================================================================
%% 9. MATHEMATICS
%% =============================================================================
\DeclarePairedDelimiter{\abs}{\lvert}{\rvert}
\DeclarePairedDelimiter{\norm}{\lVert}{\rVert}
\DeclarePairedDelimiter{\ceil}{\lceil}{\rceil}
\DeclarePairedDelimiter{\floor}{\lfloor}{\rfloor}
\DeclarePairedDelimiter{\round}{\lfloor}{\rceil}

% Differentials and derivatives: \dd x, \dv{f}{x}, \dv[2]{f}{x}, \pdv{f}{x}
\newcommand{\dd}{\mathop{}\!\mathrm{d}}
\NewDocumentCommand\dv{o m g}{%
  \IfValueTF{#3}
    {\IfNoValueTF{#1}{\frac{\dd #2}{\dd #3}}{\frac{\dd^{#1} #2}{\dd #3^{#1}}}}
    {\IfNoValueTF{#1}{\frac{\dd}{\dd #2}}{\frac{\dd^{#1}}{\dd #2^{#1}}}}}
\newcommand*{\pdv}[3][]{\frac{\partial^{#1}#2}{\partial#3^{#1}}}

% Number sets: \RR, \RR[n] = R^n, ...
\newcommand{\RR}[1][]{\ensuremath{\ifstrempty{#1}{\mathbb{R}}{\mathbb{R}^{#1}}}}
\newcommand{\NN}[1][]{\ensuremath{\ifstrempty{#1}{\mathbb{N}}{\mathbb{N}^{#1}}}}
\newcommand{\ZZ}[1][]{\ensuremath{\ifstrempty{#1}{\mathbb{Z}}{\mathbb{Z}^{#1}}}}
\newcommand{\QQ}[1][]{\ensuremath{\ifstrempty{#1}{\mathbb{Q}}{\mathbb{Q}^{#1}}}}
\newcommand{\CC}[1][]{\ensuremath{\ifstrempty{#1}{\mathbb{C}}{\mathbb{C}^{#1}}}}

% Operators
\DeclareMathOperator{\Lap}{\mathcal{L}}
\DeclareMathOperator{\Var}{Var}
\DeclareMathOperator{\Cov}{Cov}
\DeclareMathOperator{\E}{E}
\DeclareMathOperator{\arcsinh}{arcsinh}
\DeclareMathOperator{\arccosh}{arccosh}
\DeclareMathOperator*{\argmin}{arg\,min}
\DeclareMathOperator*{\argmax}{arg\,max}
\newcommand{\defeq}{\overset{\mathrm{def}}{=}}

% Equations numbered per chapter, e.g. (2.3)
\numberwithin{equation}{chapter}

%% =============================================================================
%% 10. SOURCE CODE (listings)
%% =============================================================================
\lstdefinestyle{opalith}{
  basicstyle=\ttfamily\footnotesize\color{black},
  backgroundcolor=\color{codeback},
  frame=single, rulecolor=\color{codeframe},
  keywordstyle=\color{codekeyword}\bfseries,
  keywordstyle=[2]\color{codetype}\bfseries,
  keywordstyle=[3]\color{codekeyword}\bfseries,
  commentstyle=\color{codecomment}\itshape,
  stringstyle=\color{codestring},
  numbers=left, numbersep=7pt, numberstyle=\tiny\color{codenumber},
  language=[ANSI]C,
  morekeywords=[2]{uint8_t, uint16_t, uint32_t, uint64_t,
                   int8_t, int16_t, int32_t, int64_t,
                   size_t, bool, true, false},
  morekeywords=[3]{#include, #define, #ifdef, #ifndef, #endif, #pragma},
  breaklines=true, breakatwhitespace=false, keepspaces=true,
  showspaces=false, showstringspaces=false, showtabs=false,
  tabsize=4, captionpos=b,
  % UTF-8 accented letters in code and comments
  literate={à}{{\`a}}1 {è}{{\`e}}1 {é}{{\'e}}1 {ì}{{\`i}}1 {ò}{{\`o}}1
           {ù}{{\`u}}1 {À}{{\`A}}1 {È}{{\`E}}1 {É}{{\'E}}1 {Ù}{{\`U}}1
           {°}{{\textdegree}}1 {µ}{{$\mu$}}1,
}
\lstset{style=opalith}

%% =============================================================================
%% 11. IMAGES: placeholders and missing files
%% =============================================================================
\graphicspath{{./images/}}

% Framed box used both for missing files and for explicit placeholders
\newcommand\opalith@imagebox[2]{%
  \fbox{\begin{minipage}[c][4cm][c]{0.8\linewidth}
    \centering\small\texttt{[#1]}%
    \ifstrempty{#2}{}{\par\smallskip\itshape #2}%
  \end{minipage}}}

% \figplaceholder{description}: marks a figure that still has to be cropped
% and inserted (e.g. from the lecturer's slides). Compiles without any file.
\newcommand{\figplaceholder}[1]{\opalith@imagebox{\opalithPlaceholderName}{#1}}

% \includegraphics never stops the compilation: if the file does not exist
% (also searching \graphicspath and the usual extensions) a framed box with
% the file name is printed instead and a warning is written to the log.
\NewCommandCopy\opalith@includegraphics\includegraphics
\ExplSyntaxOn
\bool_new:N \l__opalith_img_bool
\cs_new_protected:Npn \__opalith_img_test:n #1
  {
    \file_if_exist:nT {#1} { \bool_set_true:N \l__opalith_img_bool }
    \clist_map_inline:nn { .pdf, .png, .jpg, .jpeg, .eps, .PNG, .JPG, .JPEG }
      { \file_if_exist:nT { #1 ##1 } { \bool_set_true:N \l__opalith_img_bool } }
  }
\cs_new_protected:Npn \opalith_image_exists:n #1
  {
    \bool_set_false:N \l__opalith_img_bool
    \__opalith_img_test:n {#1}
    \cs_if_exist:NT \Ginput@path
      { \tl_map_inline:Nn \Ginput@path { \__opalith_img_test:n { ##1 #1 } } }
  }
\RenewDocumentCommand\includegraphics{s O{} m}
  {
    \opalith_image_exists:n {#3}
    \bool_if:NTF \l__opalith_img_bool
      { \IfBooleanTF{#1}
          { \opalith@includegraphics*[#2]{#3} }
          { \opalith@includegraphics[#2]{#3} } }
      {
        \ClassWarning{opalith}{Image~file~`#3'~not~found;~drawing~a~placeholder}
        \opalith@imagebox{\opalithMissingImageName :~\detokenize{#3}}{}
      }
  }
\ExplSyntaxOff

%% =============================================================================
%% 12. TABLE OF CONTENTS (coloured bands)
%% =============================================================================
\newcommand\opalith@tocchapname{\chaptername}
\appto\appendix{\addtocontents{toc}{\protect\renewcommand\protect\opalith@tocchapname{\protect\appendixname}}}
\contentsmargin{0cm}
\titlecontents{chapter}[3.7pc]
  {\addvspace{30pt}}
  {\begin{tikzpicture}[remember picture, overlay]%
     \draw[fill=doc,draw=doc] (-7,-.1) rectangle (-0.4,.5);%
     \pgftext[left,x=-3.5cm,y=0.2cm]{\color{white}\Large\bfseries
       \opalith@tocchapname\ \thecontentslabel}%
   \end{tikzpicture}\color{doc}\large\bfseries}
  {\color{doc}\large\bfseries}
  {\;\titlerule\;\large\bfseries\opalithPageName\ \thecontentspage
   \begin{tikzpicture}[remember picture, overlay]
     \draw[fill=doc,draw=doc] (2pt,0) rectangle (4,0.1pt);
   \end{tikzpicture}}
\titlecontents{section}[3.7pc]
  {\addvspace{2pt}}
  {\contentslabel[\thecontentslabel]{2pc}}
  {}
  {\hfill\small\thecontentspage}
\titlecontents{subsection}[5pc]
  {\addvspace{1pt}\small}
  {\makebox[0pt][r]{--\ }}
  {}
  {\hfill\small\thecontentspage}

\renewcommand{\tableofcontents}{%
  \clearpage\phantomsection
  \pdfbookmark[0]{\contentsname}{toc}%
  \chapter*{%
    \vspace*{-20\p@}%
    \begin{tikzpicture}[remember picture, overlay]%
      \pgftext[right,x=15cm,y=0.2cm]{\color{doc}\Huge\bfseries\contentsname}%
      \draw[fill=doc,draw=doc] (13,-.75) rectangle (20,1);%
      \clip (13,-.75) rectangle (20,1);
      \pgftext[right,x=15cm,y=0.2cm]{\color{white}\Huge\bfseries\contentsname}%
    \end{tikzpicture}}%
  \markboth{\contentsname}{\contentsname}%
  \@starttoc{toc}}

%% =============================================================================
%% 13. TITLE PAGE AND DOCUMENT METADATA
%% =============================================================================
% Every field is optional: empty fields are simply not printed.
\newcommand\opalith@subtitle{}
\newcommand\opalith@institution{}
\newcommand\opalith@degree{}
\newcommand\opalith@professor{}
\newcommand\opalith@year{}
\newcommand\opalith@logo{}
\newcommand\opalith@logowidth{0.7\textwidth}
\newcommand\opalith@headertitle{\@title}
\newcommand\subtitle[1]{\renewcommand\opalith@subtitle{#1}}
\newcommand\institution[1]{\renewcommand\opalith@institution{#1}}
\newcommand\opalith@department{}
\newcommand\department[1]{\renewcommand\opalith@department{#1}}
\newcommand\opalith@coursecode{}
\newcommand\coursecode[1]{\renewcommand\opalith@coursecode{#1}}
\newcommand\degree[1]{\renewcommand\opalith@degree{#1}}
\newcommand\professor[1]{\renewcommand\opalith@professor{#1}}
\newcommand\academicyear[1]{\renewcommand\opalith@year{#1}}
\NewDocumentCommand\logo{O{0.7\textwidth} m}{%
  \renewcommand\opalith@logowidth{#1}\renewcommand\opalith@logo{#2}}
\newcommand\headertitle[1]{\renewcommand\opalith@headertitle{#1}}
\title{}\author{}

% Odd-page header: "Title, by Author" (or only the title)
\newcommand\opalith@headertext{%
  \opalith@headertitle\ifdefempty{\@author}{}{, \opalithByName\ \@author}}

\AtBeginDocument{%
  \hypersetup{pdftitle={\@title}, pdfauthor={\@author}}}

\renewcommand{\maketitle}{%
  \begin{titlepage}
    \centering
    % Optional logo or balanced top spacing
    \ifdefempty{\opalith@logo}
      {\vspace*{0.8cm}}
      {\IfFileExists{\opalith@logo}
        {\opalith@includegraphics[width=\opalith@logowidth]{\opalith@logo}\par\vspace{0.8cm}}
        {\ClassWarning{opalith}{Logo `\opalith@logo' not found; skipped}\vspace*{0.8cm}}}%
    % Institution & Department
    \ifdefempty{\opalith@institution}{}{{\LARGE\scshape\color{black} \opalith@institution\par}}%
    \ifdefempty{\opalith@department}{}{\vspace{0.25cm}{\normalsize\scshape\color{black!70} \opalith@department\par}}%
    \vspace{0.6cm}
    % Academic Classic Double Horizontal Accent Line
    {\color{doc}\rule{0.88\linewidth}{1.8pt}}\par
    \vspace{1.5mm}
    {\color{black!25}\rule{0.88\linewidth}{0.5pt}}\par
    \vspace{1.3cm}
    % Context Badge
    {\footnotesize\bfseries\scshape\color{doc} \opalithNotesBadge\par}
    \vspace{0.5cm}
    % Title & Subtitle
    {\fontsize{24}{29}\selectfont\bfseries\color{black} \@title\par}
    \ifdefempty{\opalith@subtitle}{}{\vspace{0.5cm}{\large\itshape\color{black!70} \opalith@subtitle\par}}%
    \vspace{1.2cm}
    % Subtle center separator
    {\color{black!20}\rule{3.5cm}{0.6pt}}\par
    \vspace{1.2cm}
    % Author & Lecturer block
    \ifdefempty{\opalith@professor}{%
      \ifdefempty{\@author}{}{%
        {\footnotesize\scshape\color{black!60} \opalithAuthorName\par\vspace{1.5mm}}%
        {\large\bfseries \@author\par}%
      }%
    }{%
      \ifdefempty{\@author}{%
        {\footnotesize\scshape\color{black!60} \opalithProfessorName\par\vspace{1.5mm}}%
        {\large\bfseries \opalith@professor\par}%
      }{%
        \begin{minipage}[t]{0.42\linewidth}
          \centering
          {\footnotesize\scshape\color{black!60} \opalithAuthorName\par\vspace{1.5mm}}
          {\large\bfseries \@author\par}
        \end{minipage}%
        \hfill
        \begin{minipage}[t]{0.42\linewidth}
          \centering
          {\footnotesize\scshape\color{black!60} \opalithProfessorName\par\vspace{1.5mm}}
          {\large\bfseries \opalith@professor\par}
        \end{minipage}%
      }%
    }%
    \vfill
    % Bottom block: Degree, Course code, Year, Date
    \ifdefempty{\opalith@degree}{}{{\large\scshape \opalith@degree\par}}%
    \ifdefempty{\opalith@coursecode}{}{\vspace{0.2cm}{\small\color{black!70} \opalith@coursecode\par}}%
    \vspace{0.5cm}%
    \ifdefempty{\opalith@year}{}{{\normalsize \opalithYearName\ \opalith@year\par}}%
    \vspace{0.2cm}%
    {\small\color{black!60} \@date\par}%
    \vspace{0.6cm}%
  \end{titlepage}}

\endinput
