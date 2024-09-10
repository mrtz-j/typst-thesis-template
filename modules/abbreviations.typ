// TODO: Update when 0.4.2 is published
// #import "@preview/glossarium:0.4.2": make-glossary, print-glossary, gls, glspl
#import "glossarium.typ": make-glossary, print-glossary, gls, glspl

#let default-print-title(entry) = {
  let short = entry.at("short")
  let long = entry.at("long", default: "")
  [#strong(smallcaps(short)) #h(0.5em) #long]
}

#let abbreviations-page(abbreviations) = {
  // --- List of Abbreviations ---
  pagebreak(weak: true, to: "even")
  set page(header: none, footer: none, numbering: none)
  align(left)[
    = List of Abbreviations
    #v(1em)
    #print-glossary(
      abbreviations,
      user-print-title: default-print-title,
      // Show all terms even if they are not referenced, default to true
      show-all: true,
      // Disable back references in abbreviations list, default to false
      disable-back-references: true
    )
  ]
}
