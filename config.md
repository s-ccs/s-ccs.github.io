<!--
Add here global page variables to use throughout your website.
-->
+++
author = "S-CCS"
mintoclevel = 2

# Add here files or directories that should be ignored by Franklin, otherwise
# these files might be copied and, if markdown, processed by Franklin which
# you might not want. Indicate directories by ending the name with a `/`.
# Base files such as LICENSE.md and README.md are ignored by default.
ignore = ["node_modules/"]

# RSS (the website_{title, descr, url} must be defined to get RSS)
generate_rss = true
website_title = "S-CCS Homepage"
website_descr = "This is the homepage of the Stuttgart Computational Cognitive Science (S-CCS) lab at the University of Stuttgart"
website_url   = "https://s-ccs.github.io/s-ccs/"
+++

<!--
Add here global latex commands to use throughout your pages.
-->
\newcommand{\R}{\mathbb R}
\newcommand{\scal}[1]{\langle #1 \rangle}

\newcommand{\colorStrip}[1]{~~~<div class="color-strip-!#1"></div>~~~}
\newcommand{\textImage}[2]{~~~<div class="text-image"><img src="/assets/!#1"></div>~~~}

\newcommand{\thesis}[1]{~~~<div class=date>[<a href=!#1>Thesis PDF</a>]</div>~~~}
\newcommand{\date}[1]{~~~</a> </h1> <div class=date>!#1</div>~~~}
\newcommand{\thesislink}[1]{~~~<div class="thesis-link">| <a href=!#1>Thesis PDF</a></div>~~~}
