% vim: ft=tex
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kdo}[2015/08/23 Kannon Do Chantbook]
\LoadClass[12pt,openany]{book}
\RequirePackage{bookdesign}
\RequirePackage[includehead,includefoot,top=.25in,bottom=1in,
                inner=0.5in,outer=0.5in]{geometry}
\RequirePackage[compact,clearempty]{titlesec}
\RequirePackage{parskip}
\RequirePackage[usenames,dvipsnames]{xcolor}
\RequirePackage{fancyhdr}
\RequirePackage{tikz}
\RequirePackage{bells}
\hyphenation{Dai-o-sho Fu-da-mit-ta A-n-an-da Shi-ki But-su Bi-sh-a-fu
Ku-r-u-s-on Kan-yu To-ku-chu Bash-a-shi-ta Uba-ki-ku-ta Shi-shi-bo-dai Vi-sa-kha
Ach-ar-ya Gya-ku-shi-tsu Sho-gaku Myo-sho Ka-ku-ro-ku-na
Sog-ya-nan-dai Cho-ko-ku}


\newlength\speaker\setlength{\speaker}{5em}
\newlength\marginadj\setlength{\marginadj}{0.5in}
\setlength\headheight{14.5pt}

\usepackage{FiraSans}
% Use the sans serif family as the text default.
\renewcommand{\familydefault}{\sfdefault}

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
  \par\nobreak\nopagebreak
}{%
  \par
  \addtolength\leftskip{\speaker}%
}

% User-visible, for setting up fonts for the services
\newcommand{\servicefont}{\fontsize{14pt}{17pt plus 2pt}\selectfont}

\newenvironment{services}{%
  \servicefont
  \addtolength\leftskip{\speaker}%
}{%
  \addtolength\leftskip{-\speaker}%
}

\newcommand{\footmark}{}
\addtolength{\footskip}{18pt}
\newcommand{\chant@pagestyle}{
  \fancyhead[LE]{\slshape \rightmark}
  \fancyhead[RO]{{\slshape \rightmark}}
  \fancyfoot[LE,RO]{\thepage}
  \fancyfoot[C]{}
  \fancyfoot[C]{\footmark}
}

\pagestyle{fancy}
\addtolength{\headsep}{5pt}
\fancypagestyle{plain}{\chant@pagestyle}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\chant@pagestyle

\renewcommand{\chaptermark}[1]{\markboth{}{#1}}
\renewcommand{\sectionmark}[1]{}

\newcommand{\speakerstyle}{\em}
\newcommand{\speak}[1]{%
  \par\pagebreak[2]
  \makebox[0em][r]{%
  \makebox[\speaker][l]{\speakerstyle #1:\hspace*{5pt}}}}
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

\newenvironment{chanttext}{
  \par\nopagebreak\nobreak
  \begin{outdent}
}{
  \par
  \end{outdent}
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
