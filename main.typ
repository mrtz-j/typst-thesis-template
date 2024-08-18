#import "modules/template-1.typ": *

#let abstract = [
  This is your abstract. It should be a short summary your work.
  #lorem(100)
]

#let epigraph = [
    Wings are a constraint that makes\
    it possible to fly.\
    --- Robert Bringhurst
]

#show: uit_template.with(
  title: "Running Distributed Declarative Programs",
  author: "Moritz Jörg",
  degree: "INF-3983 Capstone",
  faculty: "Faculty of Science and Technology",
  department: "Department of Computer Science",
  program: "Computer Science",
  date: "December 2023",
  abstract: abstract,
  epigraph: epigraph,
  bibliography-file: "bibliography.bib",
)

= Introduction <introduction>
#include "chapters/introduction.typ"
#pagebreak()
