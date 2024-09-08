// central place where libraries are imported
// (or macros are defined)
// which are used within all the chapters:
#import "chapters/global.typ": *

#let epigraph = [
  "The problem with object-oriented languages is they’ve got all this implicit \
  environment that they carry around with them. You wanted a banana but \
  what you got was a gorilla holding the banana and the entire jungle." \
  --- Joe Armstrong
]

#let abstract = [#lorem(30)]

#let acknowledgements = [#lorem(30)]

#show: thesis.with(
  author: "<author>",
  title: "<title>",
  degree: "<degree>",
  faculty: "<faculty>",
  department: "<department>",
  major: "<major>",
  supervisor: "<supervisor>",
  abstract: abstract,
  epigraph: epigraph,
  acknowledgements: acknowledgements,
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
  submission-date: datetime.today(),
  bibliography: bibliography("refs.bib", title: "Bibliography", style: "ieee"),
)

#include "./chapters/glossary.typ"
#pagebreak()

= Introduction <introduction>
#include "./chapters/introduction.typ"
#pagebreak()
#include "./chapters/tables_and_figures.typ"
