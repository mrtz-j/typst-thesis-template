#let epigraph_page(body) = {
  // --- Epigraphs ---
  page(
    header: none,
    footer: none,
    numbering: none,
    align(right + bottom)[
      #body
    ],
  )
}
