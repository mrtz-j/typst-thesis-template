#let abstract_page(body) = {
  pagebreak(weak: true, to: "even")
  set page(header: none, footer: none, numbering: none)
  // --- Abstract ---
  align(left)[
    = Abstract
    #v(1em)
    #body
  ]
}
