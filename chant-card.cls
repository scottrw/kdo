% vim: ft=tex
\NeedsTeXFormat{LaTeX2e}
\LoadClass{minimal}
\ProvidesClass{chant-card}[2015/11/15 Common styles for chant cards]

\usepackage{FiraSans}
\renewcommand{\familydefault}{\sfdefault}

\setlength{\parindent}{0pt}
\setlength{\parskip}{10pt plus 2pt}

\def\Large{\fontsize{16pt}{20pt}\selectfont}

\def\section#1{%
  \vskip 1cm
  {#1\centering\par}
  \myhrule
  \par
}
