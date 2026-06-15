#let backpage(backimage: none) = {
  set page(
    paper: "a4",
    margin: (left: 3mm, right: 3mm, top: 12mm, bottom: 12mm),
    header: none,
    footer: none,
    numbering: none,
    number-align: center,
  )

  let default-img = image("../assets/backpage.svg", width: 216mm, height: 303mm)
  let page-img = if backimage != none { backimage } else { default-img }

  // --- Back Page ---
  place(
    bottom + center,
    dy: 27mm,
    page-img,
  )
}
