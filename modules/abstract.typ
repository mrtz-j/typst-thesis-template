#let abstract_page(content) = {
  set heading(numbering: none)
  pagebreak(weak: true)
  heading(bookmarked: true)[Abstract]
  v(2em)
  content
}
