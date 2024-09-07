// #import "@preview/nixy-thesis-typst:0.1.0": *
#import "../lib.typ": *

#let epigraph = [
  "The problem with object-oriented languages is they’ve got all this implicit \
  environment that they carry around with them. You wanted a banana but \
  what you got was a gorilla holding the banana and the entire jungle." \
  --- Joe Armstrong
]

#let abstract = [This is the abstract.]

#let acknowledgements = [This is the acknowledgements.]

#show: thesis.with(
  author: "Moritz Jörg",
  title: "Running Distributed Declarative Programs",
  degree: "Capstone",
  faculty: "Faculty of Science and Technology",
  department: "Department of Computer Science",
  major: "Computer Science INF-3983 ",
  advisor: "Weihai Yu",
  abstract: abstract,
  epigraph: epigraph,
  acknowledgements: acknowledgements,
  bibliography: bibliography("refs.bib", title: "Bibliography", style: "ieee"),
  // submission-date: none,
)

= Introduction <introduction>
#include "./chapters/introduction.typ"
#pagebreak()
// #include "./chapters/tables_and_figures.typ"