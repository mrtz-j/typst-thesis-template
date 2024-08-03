#let abstract_page(content) = {
  pagebreak(weak: true, to: "even")
  align(
    center,
    heading(numbering: none, outlined: true, bookmarked: true, level: 1)[Abstract],
  )
  v(2em)
  content
}