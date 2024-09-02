#let acknowledgement(body) = {
  pagebreak(weak: true, to: "even")

  // --- Acknowledgements ---
  align(
    center,
    heading(
      numbering: none,
      outlined: true,
      bookmarked: true,
      level: 1,
    )[Abstract],
  )
  v(2em)
  body
}