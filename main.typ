#import "modules/template-1.typ": *

// #show: titlepage(
//   title: "Running Distributed Declarative Programs",
//   subtitle: none,
//   author: "Moritz Jörg",
//   degree: "INF-3983 Capstone",
//   faculty: "Faculty of Science and Technology",
//   department: "Department of Computer Science",
//   program: "Computer Science",
//   advisor: "Weihai Yu",
//   submissionDate: none,
// )

#show: uit_thesis.with(
  author: "Moritz Jörg",
  title: "Running Distributed Declarative Programs",
  degree: "INF-3983 Capstone",
  faculty: "Faculty of Science and Technology",
  department: "Department of Computer Science",
  program: "Computer Science",
  advisor: "Weihai Yu",
  // submissionDate: none,
)

#show: front_content

#include "modules/epigraph.typ"
#include "modules/abstract.typ"
#include "modules/acknowledgements.typ"

#outline(title: "Contents")
#outline(title: "List of Figures", target: figure.where(kind: image))
#outline(title: "List of Tables", target: figure.where(kind: table))
#outline(title: "List of Listings", target: figure.where(kind: raw))

#show: main_content

= Introduction <introduction>
#include "chapters/introduction.typ"
#pagebreak()
#include "chapters/tables_and_figures.typ"

#show: back_content

#show bibliography: set text(12pt)
#bibliography("bibliography.bib", title: "Bibliography", style: "ieee")

