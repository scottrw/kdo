% vim: ft=tex
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{chantbook}[2015/08/23 Kannon Do Chantbook]
\LoadClass[12pt,openany]{book}
\RequirePackage[includehead,includefoot,top=.75in,bottom=1in,
                inner=1in,outer=1.5in]{geometry}
\RequirePackage[compact,clearempty]{titlesec}
\RequirePackage{parskip}
\RequirePackage[usenames,dvipsnames]{xcolor}
\RequirePackage{fancyhdr}
\RequirePackage{tikz}
\RequirePackage{bells}
\RequirePackage{thumb}

\newlength{\speaker}\setlength{\speaker}{5em}
\newlength{\marginadj}\setlength{\marginadj}{0.5in}

\titleformat{\part}{\Huge\bf\centering\thispagestyle{empty}}{}{0em}{}
\titleformat{\chapter}
  {\huge\bf\raggedright}
  {}
  {}
  {}
\titlespacing*{\chapter}{0pt}{-30pt}{0pt}
\titleformat{\section}
  {\Large\bf\raggedright}
  {}
  {}
  {}
\titlespacing{\section}{0pt}{0pt}{0pt}

\newenvironment{outdent}{%
  \addtolength\leftskip{-\speaker}%
}{%
  \addtolength\leftskip{\speaker}%
}

% User-visible, for setting up fonts for the services
\newcommand{\servicefont}{\fontsize{14pt}{16pt}\selectfont}

\newenvironment{services}{%
  \servicefont
  \addtolength\leftskip{\speaker}%
}{%
  \addtolength\leftskip{-\speaker}%
}

% In this class, the body text is set in from the margin by \speaker most of
% the time. This means the footer will be centered relative to the body of the
% text, but not centered on the page. \footeradj adds some space to make up for
% this.
\def\footadj{}
\renewcommand{\footrulewidth}{0.4pt}

\newcommand{\footmark}{}
\addtolength{\footskip}{18pt}
\newcommand{\chant@pagestyle}{
  \fancyhead[LE]{\slshape \rightmark}
  \fancyhead[RO]{{\slshape \rightmark}\thumbmark}
  \fancyfoot[LE,RO]{\thepage}
  \fancyfoot[C]{}
  \fancyfoot[C]{\footmark}
}

\pagestyle{fancy}
\fancypagestyle{plain}{\chant@pagestyle}
\chant@pagestyle

\renewcommand{\chaptermark}[1]{\markboth{}{#1}}
\renewcommand{\sectionmark}[1]{}

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
\addtolength{\thumb@hoff}{-1.5em}

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
\chapter*{Contents}
\markright{Contents}
\@starttoc{toc}
}
