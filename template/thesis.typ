// #import "@preview/nixy-thesis-typst:0.1.0": *
#import "../lib.typ": *

#show: thesis.with(
  author: "Moritz Jörg",
  title: "Running Distributed Declarative Programs",
  degree: "Capstone",
  faculty: "Faculty of Science and Technology",
  department: "Department of Computer Science",
  program: "Computer Science INF-3983 ",
  advisor: "Weihai Yu",
  // submissionDate: none,
)

#show: front_matter

#include "../modules/supervisors.typ"
#include "../modules/epigraph.typ"
#include "../modules/abstract.typ"
#include "../modules/acknowledgements.typ"

#outline(title: "Contents")
#outline(title: "List of Figures", target: figure.where(kind: image))
#outline(title: "List of Tables", target: figure.where(kind: table))
#outline(title: "List of Listings", target: figure.where(kind: raw))

#show: main_matter

= Introduction <introduction>
#include "./chapters/introduction.typ"
#pagebreak()
#include "./chapters/tables_and_figures.typ"

#show: back_matter

#show bibliography: set text(12pt)
#bibliography("bibliography.bib", title: "Bibliography", style: "ieee")

