#import "@preview/glossarium:0.4.1": make-glossary, print-glossary, gls, glspl

// FIXME:
// Should be able to customize glossary print function...
// #let custom-print-gloss(entry) = {
//   let short = entry.at("short")
//   let long = entry.at("long", default: "")
//   [#strong(smallcaps(short)) #h(2em) #long]
// }

#let abbreviations-page(abbreviations) = {
  // --- List of Abbreviations ---
  pagebreak(weak: true, to: "even")
  set page(header: none, footer: none, numbering: none)
  align(left)[
    = List of Abbreviations
    #v(1em)
    #print-glossary(
      abbreviations,
      // show all terms even if they are not referenced, default to true
      show-all: true,
    )
  ]
}
