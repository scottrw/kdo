% vim: ft=tex
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{chantbook}[2015/08/23 Kannon Do Chantbook]
\LoadClass[12pt,openany]{book}
% \RequirePackage{fullpage}
\RequirePackage[compact,clearempty]{titlesec}
% \RequirePackage{amssymb}
\RequirePackage{parskip}
\RequirePackage[usenames,dvipsnames]{xcolor}
\RequirePackage{multicol}
\RequirePackage{fancyhdr}
\RequirePackage{tikz}
\RequirePackage{bells}

\newlength{\speaker}\setlength{\speaker}{4em}
\setlength{\columnsep}{1.5\speaker}
\newlength{\marginadj}\setlength{\marginadj}{0.5in}

\addtolength{\evensidemargin}{-\marginadj}
\addtolength{\oddsidemargin}{-\marginadj}
\addtolength{\textwidth}{2\marginadj}

\addtolength{\evensidemargin}{\speaker}
\addtolength{\oddsidemargin}{\speaker}
\addtolength{\textwidth}{-\speaker}

\titleformat{\part}{\Huge\bf\centering\thispagestyle{empty}}{}{0em}{}
\titleformat{\chapter}
  {\huge\bf\raggedright}
  {}
  {-\speaker}
  {}
\titlespacing*{\chapter}{0pt}{-30pt}{0pt}
\titleformat{\section}
  {\Large\bf\raggedright}
  {}
  {-\speaker}
  {}
\titlespacing{\section}{0pt}{0pt}{0pt}

% thumb position: 1in + \hoffset + \oddsidemargin + \marginparsep + \textwidth
% Thumb tabs
\newif\ifthumb@enabled
\newlength{\thumb@skip}\setlength{\thumb@skip}{7em}
\newlength{\thumb@voff}\setlength{\thumb@voff}{1in}
\gdef\thumb@title{}  % contains the most recent thumbtab title
\newcommand{\thumb}[1]{%
  \thumb@enabledtrue
  \global\def\thumb@title{#1}%
  \addtolength{\thumb@voff}{\thumb@skip}%
}
\newcommand{\thumbfmt}[1]{{\bf\sffamily #1}}
\newlength{\thumb@hoff}  % distance from right edge of text to right edge of page.
\newcommand{\thumb@mark}{%
  \ifthumb@enabled%
  \hbox to 0pt{\raisebox{-\thumb@voff}[0pt][0pt]{%
    \hbox to \thumb@hoff{%
      \hfill
      \begin{tikzpicture}
        \draw[black,fill=black] (0,0) circle (3em);
	\draw[black,fill=black] (0,-3em) rectangle (1.5,3em);
        \draw[color=white] (0,0)
          node[rotate=90,above=.5ex] {\thumbfmt{\thumb@title}};
      \end{tikzpicture}
    }%
  }}%
  \fi%
}

\newif\ifoutdent
\newenvironment{outdent}{%
\outdenttrue
\global\leftskip-\speaker}%
{\global\leftskip0in
\outdentfalse}

% In this class, the body text is set in from the margin by \speaker most of
% the time. This means the footer will be centered relative to the body of the
% text, but not centered on the page. \footeradj adds some space to make up for
% this.
\def\footadj{%
  \ifodd\c@page\hspace*{\speaker}%
  \else\hspace*{-\speaker}\fi
  \ifoutdent\else\hspace*{-\speaker}\fi}
\renewcommand{\footrulewidth}{0.4pt}

\newcommand{\footmark}{}
\addtolength{\footskip}{18pt}
\newcommand{\chant@pagestyle}{
  \fancyhead[LE]{\slshape \rightmark}
  \fancyhead[RO]{{\slshape \rightmark}\thumb@mark}
  \fancyhfoffset[L]{\speaker}
  \fancyfoot[LE,RO]{\thepage}
  \fancyfoot[C]{}
  \fancyfoot[C]{\footmark}
}

\pagestyle{fancy}
\fancypagestyle{plain}{\chant@pagestyle}
\chant@pagestyle

\renewcommand{\chaptermark}[1]{\markboth{}{#1}}
\renewcommand{\sectionmark}[1]{}

% \newcommand{\speak}[1]{\par\makebox[0em][r]{\makebox[\speaker][l]{#1}}}
\newcommand{\speakerstyle}{\em}
\newcommand{\speak}[1]{\par\makebox[0em][r]{{\speakerstyle #1:\hspace*{5pt}}}}
\newcommand{\doan}{\speak{Doan}}
\newcommand{\doshi}{\speak{Doshi}}
\newcommand{\sangha}{\speak{Sangha}}
\newcommand{\tenken}{\speak{Tenken}}
\newcommand{\kokyo}{\speak{Kokyo}}

\newcommand{\chanttitle}[1]{%
\addcontentsline{toc}{section}{#1}%
\underline{#1} $\sim$ \largebell%
}

\newcommand{\bigspace}{\hspace*{1em}}


\newenvironment{chant}[1]{%
\chanttitle{#1}
\par
\begin{outdent}}{%
\par
\end{outdent}
}
\newenvironment{chant*}{%
\par
\begin{outdent}}{
\par
\end{outdent}}

\setlength{\thumb@hoff}{\paperwidth}
\addtolength{\thumb@hoff}{-1in}
\addtolength{\thumb@hoff}{-\hoffset}
\addtolength{\thumb@hoff}{-\oddsidemargin}
\addtolength{\thumb@hoff}{-\marginparsep}
\addtolength{\thumb@hoff}{-\textwidth}
\addtolength{\thumb@hoff}{3em}

%% After this point, no page layout changes should be made, or the thumbtabs
%will get screwed up.

\renewenvironment{titlepage}{%
\thispagestyle{empty}
\topskip0pt
\vspace*{\fill}
\begin{center}
}{
\end{center}
\vspace*{\fill}
\newpage
}

\newenvironment{colophon}{%
\thispagestyle{empty}
\topskip0pt
\vspace*{\fill}
}{
\newpage
}

\newenvironment{dedication}{%
  \thispagestyle{empty}
  \vspace{1in}
  \begingroup
  \fontsize{17pt}{21pt}\selectfont\em
  \setlength{\parskip}{18pt plus 2pt}
  \begin{center}
}{%
  \end{center}
  \endgroup
  \newpage
}

% We just define our own version of \part, since the LaTeX version appears to be
% hopelessly hard to customize.
\renewcommand{\part}[1]{%
  \cleardoublepage
  \thispagestyle{empty}
  \topskip0pt
  \vspace*{\fill}
  \begin{center}
    {\Huge\bfseries #1}
  \end{center}
  \vfill\null
  \newpage
}

%% Table of contents customization
% redefining \contentsname doesn't work, because it's uppercased somehow.
\setcounter{secnumdepth}{-1}
\setcounter{tocdepth}{1}

% Prevent LaTeX from uppercasing the Contents name in the header. Sadly,
% MakeUppercase is hardcoded into the definition of \tableofcontents, so this
% is the easiest way to get it out.
\renewcommand{\tableofcontents}{
\begin{outdent}
\chapter*{Contents}
\markright{Contents}
\@starttoc{toc}
\end{outdent}
}
