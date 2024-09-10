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

#let abstract = [
  In our increasingly interconnected digital landscape, the constant generation and consumption of data on various computing devices present challenges for ensuring constant accessibility, particularly in intermittent network scenarios. The emerging focus on distributed systems is aimed at not only managing sub- stantial data volumes but also guaranteeing storage on devices for low latency and high availability. A paradigm known as _local-first software_ prioritize the storage of data on end-user devices as opposed to relying solely on centralized cloud services.
]

#let acknowledgements = [#lorem(30)]

// Put your abbreviations/acronyms here.
// 'key' is what you will reference in the typst code
// 'short' is the abbreviation (what will be shown in the pdf on all references except the first)
// 'long' is the full acronym expansion (what will be shown in the first reference of the document)
#let abbreviations = (
  (
    key: "gc",
    short: "GC",
    long: "Garbage Collection",
  ),
  (key: "uit", short: "UiT", long: "The Arctic University of Tromsø"),
  (
    key: "cow",
    short: "COW",
    long: "Copy on Write",
  ),
)

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
  abbreviations: abbreviations,
  submission-date: datetime.today(),
  bibliography: bibliography("refs.bib", title: "Bibliography", style: "ieee"),
)

// Code blocks
#codly(languages: (
  rust: (
    name: "Rust",
    color: rgb("#CE412B"),
  ),
  // NOTE: Hacky, but fs doesn't syntax highlight
  fsi: (
    name: "F#",
    color: rgb("#6a0dad"),
  ),
))

#pagebreak()

= Introduction <introduction>
#include "./chapters/introduction.typ"
#pagebreak()
#include "./chapters/tables_and_figures.typ"
