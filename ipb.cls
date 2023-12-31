\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ipb}[2017/07/09 base class]
\newcommand\cosupervisors[1]{\gdef\@cosupervisors{#1}}
\LoadClass[12pt,twoside]{report}

%% Required packages.
% Line spacing
\RequirePackage{setspace}
\RequirePackage{graphicx}
\RequirePackage[utf8]{inputenc}
\RequirePackage{glossaries}

%https://pt.sharelatex.com/learn/Headers_and_footers
\RequirePackage{fancyhdr}


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

%%%%%
%%%%%   SETUP MARGINS AND PENALTIES
%%%%%

% We need 1" margins except on the binding edge, where it is 1 1/2"
% Theses may be either single or double sided
  \if@twoside
     \setlength\oddsidemargin   {0\p@}
     \setlength\evensidemargin  {0\p@}
     \setlength\marginparwidth {40\p@}
  \else
     \setlength\oddsidemargin   {0\p@}
     \setlength\evensidemargin  {0\p@}
     \setlength\marginparwidth  {40\p@}
  \fi

\marginparsep 10pt
%\oddsidemargin 0.5in \evensidemargin 0in
%\marginparwidth 40pt


\topmargin 0pt \headsep 1cm
\textheight 22cm \textwidth 16cm

% Disallow page breaks at hyphens (this will give some underfull vbox's,
% so an alternative is to use \brokenpenalty=100 and manually search
% for and fix such page breaks)
\brokenpenalty=10000

\setstretch{1.5}
%%%%%
%%%%%   SETUP COMMANDS
%%%%%

%\RequirePackage{xparse}
%% Departamento
%%\NewDocumentCommand{\dept}{m}{#1}
%% Primeiro autor
%\NewDocumentCommand{\authnum}{m}{#1}
%% Segundo autor
%\NewDocumentCommand{\secauthnum}{m}{#1}
%\NewDocumentCommand{\secondauthor}{m}{#1}
%% Curso
%\NewDocumentCommand{\course}{m}{#1}
%\NewDocumentCommand{\courseyear}{m}{#1}
%% Supervisores
%\NewDocumentCommand{\supervisor}{m}{#1}
%\NewDocumentCommand{\cosupervisor}{m}{#1}

% Departamento
\def\dept#1{\gdef\@dept{#1}}

% Autores
\def\@author{Aluno} % default spelling
\def\authnum#1{\gdef\@authnum{#1}}
\def\secondauthor#1{\gdef\@secondauthor{#1}}
\def\secauthnum#1{\gdef\@secauthnum{#1}}

% Curso
\def\@course{Sistemas de Informa\c{c}\~{a}o}
\def\course#1{\gdef\@course{#1}}
\def\@courseyear{\the\year} % default spelling
\def\courseyear#1{\gdef\@courseyear{#1}}

% Supervisors
\def\@supervisor{Orientador} % default spelling
\def\supervisor#1{\gdef\@supervisor{#1}}
\def\cosupervisor#1{\gdef\@cosupervisor{#1}}

% % %  conditionals
\newif\iffigurespage
\newif\iftablespage
\figurespagetrue
\tablespagetrue

\RequirePackage{ifxetex}

\ifxetex
\usepackage{fontspec}
\else
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage{indentfirst}
\usepackage{parskip}

\setlength{\parskip}{0.2cm}
\setlength{\parindent}{1.25cm}
\onehalfspacing
\fi


\def\coverpage{%
\thispagestyle{empty}%

%\hspace{-4cm}
\begin{center}
    \includegraphics[width=0.6\columnwidth, keepaspectratio]{etc/logoh.png}\\
\end{center}


%\null\vskip1in%
\begin{center}
	\vspace{6em}
    {\Huge\expandafter{\bf \@title}}
    \vfill
    {\Large\textbf{
    \@author \ifdefined\@authnum \quad\@authnum \fi\\
}}
      \vfill
    Dissertation submitted to the School of Technology and Management of Bragan\c{c}a to obtain the Master Degree in Industrial Engineering\\
    
    \vspace{4em}
    Scientific supervision:\\
    {\@supervisor}\\
   \ifdefined\@cosupervisors
    % Iterate through the co-supervisors and display them
    \foreach \cosup in \@cosupervisors {
        { \cosup}\\ 
    }
\fi

    \vfill
    %Esta disserta\c{c}\~{a}o n\~{a}o inclui as cr\'iticas e sugest\~{o}es feitas pelo J\'uri.\\
    \vspace{2em}
	Bragança\\
	\@courseyear
\end{center}
\cleardoublepage
}

\def\titlep{%
\thispagestyle{empty}%

%\hspace{-4cm}
\begin{center}
    \includegraphics[width=0.6\columnwidth, keepaspectratio]{etc/logoh.png}\\
\end{center}


%\null\vskip1in%
\begin{center}
	\vspace{6em}
    {\Huge\expandafter{\bf \@title}}
    \vfill
    {\Large\textbf{
    \@author \ifdefined\@authnum \quad\@authnum \fi\\
}}
    \vfill
    Dissertation submitted to the School of Technology and Management of Bragan\c{c}a to obtain the Master Degree in Industrial Engineering\\
	    \vspace{4em}
	    Scientific supervision:\\
	    \@supervisor\\
    \ifdefined\@cosupervisors
    % Iterate through the co-supervisors and display them
    \foreach \cosup in \@cosupervisors {
        { \cosup}\\ 
    }
\fi
	
    \vfill
    %Esta disserta\c{c}\~{a}o n\~{a}o inclui as cr\'iticas e sugest\~{o}es feitas pelo J\'uri.\\
    \vspace{2em}
	Bragança\\
	\@courseyear
\end{center}
\cleardoublepage
}

\def\beforepreface{%
        \pagenumbering{roman}
        \pagestyle{plain}
        \coverpage
        \titlep
        %\ifdisclaimer\disclaimerpage\fi
        %\signaturepage
        %\cleardoublepage
}


\def\prefacesection{\@ifstar\@prefacesection\@@prefacesection}

\def\@prefacesection#1{%
        \chapter*{#1}
}

\def\@@prefacesection#1{%
        \chapter*{#1}
        \addcontentsline{toc}{chapter}{#1}
}

\def\afterpreface{%
\cleardoublepage
        \tableofcontents
        \iftablespage
                \listoftables
        \fi
        \iffigurespage
	%\newpage
%\mbox{}
                \listoffigures
        \fi
	}

\def\bodystart{%
        \cleardoublepage
        \pagenumbering{arabic}
%        \pagestyle{headings}

%https://pt.sharelatex.com/learn/Headers_and_footers
        \pagestyle{fancy}
        \renewcommand{\headrulewidth}{0pt}
        \renewcommand{\footrulewidth}{0pt}
        \fancyhf{}
        %\fancyhead[LE,RO]{}
        %\fancyhead[RE,LO]{}
        %\fancyfoot[CE,CO]{}
        \fancyfoot[LE,RO]{\thepage}

}

% Redefine \thebibliography to go to a new page and put an entry in the
% table of contents
\let\@ldthebibliography\thebibliography
\renewcommand{\thebibliography}[1]{\newpage
                \@ldthebibliography{#1}%
\addcontentsline{toc}{chapter}{\bibname}}


% Start out normal
%\pagestyle{headings}


\makeatother