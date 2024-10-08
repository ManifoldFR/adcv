%% adcv.cls
%% Copyright 2016-2020 Alessandro Rossini.
%
% This work may be distributed and/or modified under the conditions of the LaTeX Project Public License (LPPL) version 1.3 or later.
%
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX version 2005/12/01 or later.
%
% This work consists of the files adcv.cls, adcv_en.def, bib_alessandro_rossini.bib, and cv_alessandro_rossini_en.tex.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{adcv}[2016/12/15 Adaptive CV]

% This block defines a new command called \getrelativepath which can be used to
% define a macro containing the relative path to a file given as input. See
% below.
%
% Courtesy of user Phelype Oleinik on Tex StackExchange, with a minor change to
% print a '.' at the beginning of the relative path:
% https://tex.stackexchange.com/a/533260
\RequirePackage{expl3}
\ExplSyntaxOn
\str_new:N \l__carsten_tmpa_str
\cs_new_protected:Npn \__carsten_tmp:w { }
\cs_new_protected:Npn \getrelativepath #1 #2
  {
    \str_set:Nx \l__carsten_tmpa_str { ./\@currname.\@currext }
    \exp_args:NV \str_if_in:NnTF \l__carsten_tmpa_str {#2}
      {
        \str_if_eq:VnTF \l__carsten_tmpa_str {#2}
          { \tl_set:Nn #1 { } }
          { \exp_args:Nx \__carsten_parse_path:nN { \tl_to_str:n {#2} } #1 }
      }
      { \msg_error:nnxx { carsten } { wrong-path } {#2} { \l__carsten_tmpa_str } }
  }
\cs_new_protected:Npn \__carsten_parse_path:nN #1 #2
  {
    \cs_set_protected:Npn \__carsten_tmp:w ##1 #1 \q_mark ##2 ##3 \q_stop
      {
        \quark_if_nil:nTF {##2}
          { \tl_set:Nn #2 {##1} }
          { \msg_error:nn { carsten } { unexpected-error } }
      }
    \use:x
      {
        \__carsten_tmp:w
          \exp_not:V \l__carsten_tmpa_str \exp_not:n { \q_mark \q_nil }
                        \tl_to_str:n {#1} \exp_not:n { \q_mark \q_mark }
            \exp_not:N \q_stop
      }
  }
\msg_new:nnn { carsten } { wrong-path }
  { Unexpected~path~error.~'#1'~not~found~in~'#2'. }
\msg_new:nnn { carsten } { unexpected-error }
  { This~should~not~happen. }
\ExplSyntaxOff

% Using this command a new macro \thispath is defined, which can be used to
% refer to files in the same directory as the adcv.cls file using the correct
% relative paths with respect to the main document
\getrelativepath\thispath{adcv.cls}

% Options

\newif\ifextended
\extendedfalse
\DeclareOption{extended}{
  \extendedtrue
}

\newif\ifonline
\onlinefalse
\DeclareOption{online}{
  \onlinetrue
}

\newif\ifprint
\printfalse
\DeclareOption{print}{
  \printtrue
}

% This command includes the specified file either from the current document path
% or from the class file path, raising an error if not found in any of those.
\newcommand\InputIfFileExistsMultiple[2]{
  \InputIfFileExists{#1}{}{
    \InputIfFileExists{\thispath/#1}{}{
      \ClassError{adcv}{#2 definition file '#1' not found.}
    }
  }
}

% Defines a new command to declare language options
\newcommand\DeclareLangOption[2]{
  \DeclareOption{#1}{
    \AtEndOfPackage{
      \InputIfFileExistsMultiple{adcv_#1.def}{#2}
    }
  }
}

\DeclareLangOption{bg}{Bulgarian}

\DeclareLangOption{hr}{Croatian}

\DeclareLangOption{cs}{Czech}

\DeclareLangOption{da}{Danish}

\DeclareLangOption{nl}{Dutch}

\DeclareLangOption{en}{English}

\DeclareLangOption{et}{Estonian}

\DeclareLangOption{fi}{Finnish}

\DeclareLangOption{fr}{French}

\DeclareLangOption{de}{German}

\DeclareLangOption{el}{Greek}

\DeclareLangOption{hu}{Hungarian}

\DeclareLangOption{ga}{Irish}

\DeclareLangOption{it}{Italian}

\DeclareLangOption{lv}{Latvian}

\DeclareLangOption{lt}{Lithuanian}

\DeclareLangOption{mt}{Maltese}

\DeclareLangOption{no}{Norwegian}

\DeclareLangOption{pl}{Polish}

\DeclareLangOption{pt}{Portuguese}

\DeclareLangOption{ro}{Romanian}

\DeclareLangOption{sk}{Slovak}

\DeclareLangOption{sl}{Slovenian}

\DeclareLangOption{es}{Spanish}

\DeclareLangOption{sv}{Swedish}

\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{article}
}

\ExecuteOptions{en}
\ProcessOptions
\LoadClass{article}

% Geometry

\RequirePackage[top=2cm,left=2cm,right=2cm,bottom=2cm,a4paper]{geometry}

\newlength\adcv@leftcol
\newlength\adcv@centercol
\newlength\adcv@rightcol
\newlength\adcv@colsep
\newlength\adcv@leftcentercol
\newlength\adcv@centerrightcol
\newlength\adcv@langcol

\setlength{\adcv@leftcol}{11em}
\setlength{\adcv@rightcol}{9em}
\setlength{\adcv@colsep}{1em}
\setlength{\adcv@centercol}{\textwidth}
\addtolength{\adcv@centercol}{-\adcv@leftcol}
\addtolength{\adcv@centercol}{-\adcv@rightcol}
\addtolength{\adcv@rightcol}{-2\adcv@colsep}
\setlength{\adcv@leftcentercol}{\textwidth}
\addtolength{\adcv@leftcentercol}{-\adcv@rightcol}
\addtolength{\adcv@leftcentercol}{-\adcv@colsep}
\setlength{\adcv@centerrightcol}{\textwidth}
\addtolength{\adcv@centerrightcol}{-\adcv@leftcol}
\addtolength{\adcv@centerrightcol}{-\adcv@colsep}
\setlength\adcv@langcol{0.2\adcv@centerrightcol}
\addtolength{\adcv@langcol}{-2\tabcolsep}
\addtolength{\adcv@langcol}{-2\arrayrulewidth}

% Colours

\RequirePackage{xcolor}

\definecolor{white}{HTML}{FFFFFF}
\definecolor{lightgray}{HTML}{474747}
\definecolor{gray}{HTML}{404040}
% \definecolor{paynegray}{HTML}{353E49}
\definecolor{black}{HTML}{000000}
\definecolor{paynegray}{HTML}{272F38}
% \definecolor{coralpink}{HTML}{FF706C}
\definecolor{coralpink}{HTML}{FF3E3A}

\ifprint
  \colorlet{regulartext}{black}
  \colorlet{headerfill}{white}
  \colorlet{headertext}{black}
  \colorlet{lighttext}{paynegray}
  \colorlet{linktext}{coralpink}
\else
  \colorlet{regulartext}{gray}
  \colorlet{headerfill}{paynegray}
  \colorlet{headertext}{white}
  \colorlet{lighttext}{lightgray}
  \colorlet{linktext}{coralpink}
\fi

% Hyperref

\RequirePackage{hyperref}

\hypersetup{
  colorlinks=true,
  allcolors=linktext
}

\ifextended
  \AtBeginDocument{%
    \hypersetup{%
      pdfauthor={\adcv@firstname~\adcv@lastname},%
      pdftitle={\adcv@firstname~\adcv@lastname\adcv@cvofkey}%
    }%
  }
\else
  \AtBeginDocument{%
    \hypersetup{%
      pdfauthor={\adcv@firstname~\adcv@lastname},%
      pdftitle={\adcv@firstname~\adcv@lastname\adcv@resumeofkey}%
    }%
  }
\fi

% Fonts

\RequirePackage{fontspec}

\newcommand\fontspath{ \thispath/fonts/ }

\setmainfont[
  Path = \fontspath,
  BoldFont = Roboto-Bold.ttf,
  ItalicFont = Roboto-Italic.ttf,
  BoldItalicFont = Roboto-BoldItalic.ttf,
  Color=regulartext
]{Roboto-Light.ttf}

\newfontfamily\regular[Path = \fontspath, Color=regulartext]{Roboto-Regular.ttf}
\newfontfamily\light[Path = \fontspath, Color=regulartext]{Roboto-Light.ttf}
\newfontfamily\thin[Path = \fontspath, Color=regulartext]{Roboto-Thin.ttf}
\newfontfamily\regularheader[Path = \fontspath, Color=headertext]{Roboto-Regular.ttf}
\newfontfamily\thinheader[Path = \fontspath, Color=headertext]{Roboto-Thin.ttf}

\newcommand*{\lighttext}{\addfontfeature{Color=lighttext}}
\newcommand*{\linktext}{\addfontfeature{Color=linktext}}

\def\@sectioncolor#1#2#3{{\addfontfeature{Color=linktext} #1#2#3}}
\def\HyColor@@@@UseColor#1\@nil{\addfontfeatures{Color=linktext}}

\renewcommand{\section}[1]{\vspace{.5\baselineskip}{\Large\bfseries\@sectioncolor #1}}
\renewcommand{\subsection}[2]{\large\bfseries #2}

% Header

\RequirePackage{tikz}

\newcommand*{\adcvname}[3]{\def\adcv@firstname{#1}\def\adcv@lastname{#2}\def\adcv@degree{#3}}
\newcommand*{\adcvtitle}[1]{\def\adcv@title{#1}}
\newcommand*{\adcvaddress}[4]{\def\adcv@street{#1}\def\adcv@postalcode{#2}\def\adcv@locality{#3}\def\adcv@country{#4}}
\newcommand*{\adcvphone}[1]{\def\adcv@phone{#1}}
\newcommand*{\adcvemail}[3]{\def\adcv@emaillocal{#1}\def\adcv@emaildomainsecond{#2}\def\adcv@emaildomaintop{#3}}
\newcommand*{\adcvwebsite}[2]{\def\adcv@websiteurl{#1}\def\adcv@websitetext{#2}}
\newcommand*{\adcvgithub}[2]{\def\adcv@githuburl{#1}\def\adcv@gittext{#2}}
\newcommand*{\adcvlinkedin}[2]{\def\adcv@linkedinurl{#1}\def\adcv@linkedintext{#2}}

\graphicspath{{\thispath/icons/}}

\ifprint
  \newcommand*{\aticon}{\includegraphics[height=0.75em]{at_print.png}}
  \newcommand*{\doticon}{\includegraphics[height=0.1em]{dot_print.png}}
\else
  \newcommand*{\aticon}{\includegraphics[height=0.75em]{at.png}}
  \newcommand*{\doticon}{\includegraphics[height=0.1em]{dot.png}}
\fi

\newcommand*{\chaticon}{\includegraphics[height=0.75em]{chat.pdf}}
\newcommand*{\envelopeicon}{\includegraphics[height=0.75em]{envelope.pdf}}
\newcommand*{\houseicon}{\includegraphics[height=0.75em]{house.pdf}}
\newcommand*{\githubicon}{\includegraphics[height=0.75em]{github.pdf}}
\newcommand*{\linkedinicon}{\includegraphics[height=0.75em]{linkedin.png}}
\newcommand*{\phoneicon}{\includegraphics[height=0.75em]{phone.pdf}}
\newcommand*{\placeicon}{\includegraphics[height=0.75em]{place.pdf}}

\ifonline
  \def\adcv@address{\placeicon~\adcv@locality,~\adcv@country}
  \def\adcv@email{\envelopeicon~{\linktext\adcv@emaillocal\aticon\adcv@emaildomainsecond\doticon\adcv@emaildomaintop}}
  \def\adcv@telephone{}
\else
  %\def\adcv@address{\placeicon~\adcv@street,~\adcv@postalcode~\adcv@locality,~\adcv@country}
  \def\adcv@address{\placeicon~\adcv@locality,~\adcv@country}
  \def\adcv@email{\envelopeicon~\href{mailto:\adcv@emaillocal @\adcv@emaildomainsecond.\adcv@emaildomaintop}{\adcv@emaillocal @\adcv@emaildomainsecond.\adcv@emaildomaintop}}
  \def\adcv@telephone{\phoneicon~\adcv@phone}
\fi

\AtBeginDocument{%
  \begin{tikzpicture}[remember picture, overlay]%
    \node [rectangle, fill=headerfill, minimum width=\paperwidth, minimum height=8em, anchor=north] (box) at (current page.north) {};%
    \node [text=headertext, anchor=center] (name) at (box) {%
      {\Huge\thinheader\adcv@firstname~\regularheader\adcv@lastname\thinheader,~\adcv@degree}%
    };%
    \node [text=headertext, anchor=north] at (name.south) {%
      \Large\thinheader\adcv@title%
    };%
  \end{tikzpicture}%

  \vspace{\baselineskip}%

  \ifdefined\adcv@websiteurl%
    \ifx\adcv@websiteurl\empty%
      \def\adcv@website{}%
    \else%
      \def\adcv@website{\houseicon~\href{\adcv@websiteurl}{\adcv@websitetext}}%
    \fi%
  \else%
    \def\adcv@website{}%
  \fi%
  \ifdefined\adcv@githuburl%
  	\ifx\adcv@githuburl\empty%
  		\def\adcv@github{}%
  	\else%
  		\def\adcv@github{\githubicon~\href{\adcv@githuburl}{\adcv@gittext}}%
  	\fi%
  \else%
	\def\adcv@github{}%
  \fi%
  
  \ifdefined\adcv@linkedinurl%
  	\ifx\adcv@linkedinurl\empty%
  		\def\adcv@linkedin{}%
  	\else%
  		\def\adcv@linkedin{\linkedinicon~\href{\adcv@linkedinurl}{\adcv@linkedintext}}%
  	\fi%
  \else%
  	\def\adcv@linkedin{}%
  \fi%

  \begin{center}%
    \ifonline%
      \adcv@address~\adcv@email~\adcv@website~\adcv@linkedin~\adcv@github%
    \else%
      \adcv@address~\adcv@telephone%

      \adcv@email~\adcv@website~\adcv@linkedin~\adcv@github%
    \fi%
  \end{center}%
}

% Footer

\RequirePackage{array}
\RequirePackage{fancyhdr}
\RequirePackage{totpages}

\newcommand*{\adcvdate}[1]{\def\adcv@date{#1}}

\def\adcv@totpages{~/~\ref{TotPages}}
\def\adcv@page{\adcv@pagekey~\thepage\adcv@totpages}

\AtBeginDocument{%
  \pagestyle{fancy}%
  \fancyhead{}%
  \fancyfoot[C]{\footnotesize\light\adcv@firstname~\adcv@lastname\ifextended\adcv@cvofkey\else\adcv@resumeofkey\fi, \adcv@date, \adcv@telephone~\adcv@email}%
  \fancyfoot[R]{\raggedleft\footnotesize\light\adcv@page}%
  \renewcommand{\headrulewidth}{0em}%
  \setlength\footskip{\baselineskip}%
}

% Tables

\RequirePackage{longtable}
\RequirePackage{parskip}

\setlength{\LTpre}{\parskip}
\setlength{\LTpost}{0em}
\setlength{\LTleft}{0em}
\setlength{\LTright}{0em}

\newenvironment*{adcvtabletwo}{\begin{longtable}[l]{@{}>{\raggedright}p{\adcv@leftcentercol}@{\hspace{\adcv@colsep}} @{}>{\raggedleft}p{\adcv@rightcol}@{}}}{\end{longtable}}

\newenvironment*{adcvtabletworev}{\begin{longtable}[l]{@{}>{\raggedleft}p{\adcv@leftcol}@{\hspace{\adcv@colsep}} @{}>{\raggedright}p{\adcv@centerrightcol}@{}}}{\end{longtable}}

\newcommand*{\adcvrowtwo}[2]{#1 & #2\tabularnewline}
\newcommand*{\adcvrowmulti}[1]{\multicolumn{2}{@{}p{\textwidth}}{\lighttext #1}\tabularnewline}

\newenvironment*{adcvtablethree}{\begin{longtable}[l]{@{}>{\raggedright}p{\adcv@leftcol}@{\hspace{\adcv@colsep}} @{}>{\raggedright}p{\adcv@centercol}@{} @{\hspace{\adcv@colsep}}>{\raggedleft}p{\adcv@rightcol}@{}}}{\end{longtable}}

\newcommand*{\adcvrowthree}[3]{\bfseries #1 & #2 & #3\tabularnewline}

\newcommand*{\adcvrowskip}{\tabularnewline[-\parskip]}

% Languages

\newenvironment*{adcvlanguages}{\begin{longtable}[l]{@{}>{\raggedleft}p{\adcv@leftcol}@{\hspace{\adcv@colsep}} @{}p{\adcv@centerrightcol}@{}}}{\end{longtable}}

\newcommand*{\adcvmothertongue}[1]{{\adcv@mothertonguekey} & {\bfseries #1}\tabularnewline[0em]}

\newcommand*{\adcvlanguagesheader}{%
  \adcv@otherkey$^{\mbox{\scriptsize1}}$ &%
  \setlength\extrarowheight{0em}%
  \begin{tabular}[t]{|m{\adcv@langcol}|m{\adcv@langcol}|m{\adcv@langcol}|m{\adcv@langcol}|m{\adcv@langcol}|}%
    \firsthline%
    \multicolumn{2}{|c|}{{\bfseries\adcv@understandingkey}} & \multicolumn{2}{c|}{{\bfseries\adcv@speakingkey}} & \centering{\bfseries\adcv@writingkey}\tabularnewline%
    \cline{1-4}%
    \centering\small{\adcv@listeningkey} & \centering\small{\adcv@readingkey} & \centering\small{\adcv@interactionkey} & \centering\small{\adcv@productionkey} & \tabularnewline%
    \hline%
  \end{tabular}\tabularnewline[-\arrayrulewidth]%
}

\newcommand*{\adcvlanguage}[7]{%
  \bfseries #2$^{\mbox{\scriptsize#1}}$ &%
  \setlength\extrarowheight{0em}%
  \begin{tabular}{|m{\adcv@langcol}|m{\adcv@langcol}|m{\adcv@langcol}|m{\adcv@langcol}|m{\adcv@langcol}|}%
    \hline%
    #3 & #4 & #5 & #6 & #7\tabularnewline%
    \hline%
  \end{tabular}\tabularnewline[-\arrayrulewidth]%
}

\newcommand*{\adcvlanguagesfooter}{\adcvrowtwo{}{\footnotesize$^{\mbox{1}}$\textit{\adcv@cefrkey}}}
\newcommand*{\adcvlanguagesfootnote}[2]{\adcvrowtwo{}{\footnotesize$^{\mbox{#1}}$\textit{#2}}}

\newcommand*{\adcvCEF}[2]{%
  \begin{tabular}{@{}>{\footnotesize}p{0.2\adcv@langcol}@{\hspace{1mm}}>{\footnotesize\centering}p{0.75\adcv@langcol}@{}}%
    #1 & #2\tabularnewline%
  \end{tabular}%
}

\newcommand*{\adcvAOne}{\adcvCEF{A1}{\adcv@basickey}}
\newcommand*{\adcvATwo}{\adcvCEF{A2}{\adcv@basickey}}
\newcommand*{\adcvBOne}{\adcvCEF{B1}{\adcv@independentkey}}
\newcommand*{\adcvBTwo}{\adcvCEF{B2}{\adcv@independentkey}}
\newcommand*{\adcvCOne}{\adcvCEF{C1}{\adcv@fluentkey}}
\newcommand*{\adcvCTwo}{\adcvCEF{C2}{\adcv@fluentkey}}

% Publications

\RequirePackage[backend=biber,block=par,defernumbers=false,maxnames=99,sorting=none,style=numeric]{biblatex}
\RequirePackage{csquotes}
\urlstyle{same}

\DeclareFieldFormat[article]{title}{#1}
\DeclareFieldFormat[inproceedings]{title}{#1}
\DeclareFieldFormat[misc]{title}{#1}
\DeclareFieldFormat[report]{title}{#1}

\renewcommand*{\newunitpunct}{\addcomma\space}

\DeclareBibliographyDriver{article}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \newblock%
  {%
    \small\lighttext%
    \usebibmacro{journal+issuetitle}%
    \newunit%
    \printfield{pages}%
    \newunit%
    \printlist{publisher}%
    \setunit{}%
    \newblock%
    \iffieldundef{doi}{%
      \iffieldundef{isbn}{}{%
        \printfield{isbn}%
        \newblock%
      }%
    }{%
      \printfield{doi}%
      \newblock%
    }%
    \printfield{url}%
    \newblock%
  }%
  \vspace{.5\baselineskip}%
}

\DeclareBibliographyDriver{inproceedings}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \newblock%
  {%
    \small\lighttext%
    \printfield{booktitle}%
    \newunit%
    \printfield{year}%
    \newunit%
    \printlist{publisher}%
    \setunit{}%
    \newblock%
    \iffieldundef{doi}{%
      \iffieldundef{isbn}{}{%
        \printfield{isbn}%
        \newblock%
      }%
    }{%
      \printfield{doi}%
      \newblock%
    }%
    \printfield{url}%
    \newblock%
  }%
  \vspace{.5\baselineskip}%
}

\DeclareBibliographyDriver{report}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \newblock%
  {%
    \small\lighttext%
    \printlist{institution}%
    \newunit%
    \printfield{year}%
    \setunit{}%
    \newblock%
    \printfield{isbn}%
    \newblock%
  }%
  \vspace{.5\baselineskip}%
}

\DeclareBibliographyDriver{misc}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \newblock%
  {%
    \small\lighttext%
    \printfield{year}%
    \newblock%
    \printfield{note}%
    \newblock%
  }%
  \vspace{.5\baselineskip}%
}

\DeclareNameFormat{author}{%
  \small\lighttext%
  \nameparts{#1}%
  \ifblank{\namepartgiven}{}{\namepartgiven\space}\namepartfamily%
  \ifthenelse{\value{listcount}<\value{liststop}}{\addcomma\space}{}%
}

% Presentations

\RequirePackage{enumitem}

\newenvironment*{adcvpresentations}{%
  \setlist[enumerate]{labelsep=1em}%
  \renewcommand{\theenumi}{[\arabic{enumi}]}%
  \renewcommand{\labelenumi}{\theenumi}%
  \begin{enumerate}%
}{%
  \end{enumerate}%
}

\newcommand*{\adcvpresentation}[2]{\item #1\\{\small\lighttext #2}}
