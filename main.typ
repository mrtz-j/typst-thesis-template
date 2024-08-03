#import "modules/template.typ": *

#let abstract = [
  This is your abstract. It should be a short summary your work.
  #lorem(100)
]

#show: uit.with(
  title: "Running Distribyted Declarative Programs",
  author: "Moritz Jörg",
  degree: "INF-3983 Capstone",
  faculty: "Faculty of Science and Technology",
  department: "Department of Computer Science",
  program: "Computer Science",
  date: "December 2023",
  abstract: abstract,
  bibliography-file: "bibliography.bib",
)

= Introduction <introduction>
#include "chapters/introduction.typ"
#pagebreak()