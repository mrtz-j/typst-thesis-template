#let titlepage(
  title: "",
  subtitle: "",
  degree: "",
  faculty: "",
  department: "",
  program: "",
  advisor: "",
  author: "",
  submissionDate: none,
) = {
  set document(title: title, author: author)
  set page(
    paper: "a4",
    margin: (left: 3mm, right: 3mm, top: 12mm, bottom: 27mm),
    header: none,
    footer: none,
    numbering: none,
    number-align: center,
  )

  let body-font = "Open Sans"
  let sans-font = "Noto Sans"

  set text(font: body-font, size: 12pt, lang: "en")

  set par(leading: 1em)

  // --- Title Page ---
  place(top + left, image("../figures/logo.svg", width: 100%, height: 100%))

  // Faculty and Department
  place(top + left, dy: 32mm, dx: 27mm, text(12pt, weight: "light", faculty))
  place(
    top + left,
    dy: 37mm,
    dx: 27mm,
    text(12pt, weight: "light", department),
  )

  // Title
  place(top + left, dy: 45mm, dx: 27mm, text(14pt, weight: "semibold", title))

  // Subtitle (optional)
  if (subtitle != "") {
    place(top + left, dy: 55mm, dx: 27mm, text(12pt, weight: "light", subtitle))
  }

  place(
    top + left,
    dy: 63mm,
    dx: 27mm,
    text(12pt, weight: "light", "Advisor: " + advisor),
  )
  // Author
  // place(top + left, dy: 57mm, dx: 27mm, text(10pt, weight: "light", author))

  // Description, Degree and Program
  // place(top + left, dy: 63mm, dx: 27mm, text(
  //   10pt,
  //   weight: "light",
  //   degree + " thesis in " + program + " -- " + submissionDate,
  // ))

  // Image
  place(
    bottom + center,
    dy: 27mm,
    image("../figures/frontpage_full.svg", width: 216mm, height: 303mm),
  )

  pagebreak()
}