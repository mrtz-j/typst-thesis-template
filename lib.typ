#import "@preview/subpar:0.1.1"
#import "@preview/physica:0.9.3": *

#import "modules/metadata.typ": *
#import "modules/frontpage.typ": frontpage
#import "modules/backpage.typ": backpage
#import "utils/print_pagebreak.typ": *

// Workaround for the lack of an `std` scope.
#let std-bibliography = bibliography
#let std-smallcaps = smallcaps
#let std-upper = upper

// Overwrite the default `smallcaps` and `upper` functions with increased spacing between
// characters. Default tracking is 0pt.
#let smallcaps(body) = std-smallcaps(text(tracking: 0.6pt, body))
#let upper(body) = std-upper(text(tracking: 0.6pt, body))

// Colors used across the template.
#let stroke-color = luma(200)
#let fill-color = luma(250)

#let fill-line(left-text, right-text) = [#left-text #h(1fr) #right-text]
#let isappendix = state("isappendix", false)

// The `in-outline` mechanism is for showing a short caption in the list of figures
// See https://sitandr.github.io/typst-examples-book/book/snippets/chapters/outlines.html#long-and-short-captions-for-the-outline
#let in-outline = state("in-outline", false)

#let flex-caption(long, short) = (
  context {
    if in-outline.get() {
      short
    } else {
      long
    }
  }
)

// ---

#let front_matter(body) = {
  set page(numbering: "i")
  counter(page).update(1)
  set heading(numbering: none)
  show heading.where(level: 1): it => {
    it
    v(6%, weak: true)
  }
  body
}

#let main_matter(body) = {
  set page(numbering: "1")
  counter(page).update(1)
  counter(heading).update(0)
  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    it
    v(12%, weak: true)
  }
  body
}

#let back_matter(body) = {
  set heading(numbering: "A", supplement: [Appendix])
  // Without this, the header says "Chapter F"
  counter(heading.where(level: 1)).update(0)
  // Without this, the table of contents line says "Chapter F"
  counter(heading).update(0)
  body
}

#let subfigure = {
  subpar.grid.with(
    numbering: n => if isappendix.get() {
      numbering("A.1", counter(heading).get().first(), n)
    } else {
      numbering("1.1", counter(heading).get().first(), n)
    },
    numbering-sub-ref: (m, n) => if isappendix.get() {
      numbering("A.1a", counter(heading).get().first(), m, n)
    } else {
      numbering("a", m, n)
    },
  )
}

// This function gets your whole document as its `body` and formats it
#let thesis(
  // The title for your work.
  title: [Your Title],

  // Subtitle for your work.
  subtitle: none,

  // Author.
  author: "Author",

  // The name of the advisor(s) for your work.
  advisor: ("John Doe"),

  // The paper size to use.
  paper-size: "a4",

  // The degree you are working towards
  degree: "INF-3983 Capstone",

  // What you are majoring in
  major: "Computer Science",

  // The faculty and department at which you are workings
  faculty: "Faculty of Science and Technology",
  department: "Department of Computer Science",

  // Date that will be displayed on cover page.
  // The value needs to be of the 'datetime' type.
  // More info: https://typst.app/docs/reference/foundations/datetime/
  // Example: datetime(year: 2024, month: 03, day: 17)
  date: datetime.today(),

  // The date that you are submitting your work.
  submission-date: datetime.today(),

  // Format in which the date will be displayed on cover page.
  // More info: https://typst.app/docs/reference/foundations/datetime/#format
  date-format: "[month repr:long] [day padding:zero], [year repr:full]",

  // An abstract for your work. Can be omitted if you don't have one.
  abstract: none,

  // The contents for the acknowledgements page. This will be displayed after the
  // abstract. Can be omitted if you don't have one.
  acknowledgements: none,

  // The contents for the preface page. This will be displayed after the cover page. Can
  // be omitted if you don't have one.
  preface: none,

  // The result of a call to the `outline` function or `none`.
  // Set this to `none`, if you want to disable the table of contents.
  // More info: https://typst.app/docs/reference/model/outline/
  table-of-contents: outline(),

  // The result of a call to the `bibliography` function or `none`.
  // Example: bibliography("refs.bib")
  // More info: https://typst.app/docs/reference/model/bibliography/
  bibliography: none,

  // Whether to start a chapter on a new page.
  chapter-pagebreak: true,

  // Whether the document is a print document.
  is-print: false,

  // Display an index of figures (images).
  figure-index: (
    enabled: true,
    title: "Figures",
  ),

  // Display an index of tables
  table-index: (
    enabled: true,
    title: "Tables",
  ),

  // Display an index of listings (code blocks).
  listing-index: (
    enabled: true,
    title: "Listings",
  ),

  // The content of your work.
  body,
) = {
  // Set the document's metadata.
  set document(
    title: title,
    author: author,
    date: if date != none {
      date
    } else {
      auto
    },
  )

  // Set the body font.
  // Default is Linux Libertine at 11pt
  set text(font: ("Libertinus Serif", "Linux Libertine"), size: 12pt)
  // set text(font: ("Utopia LaTeX"), size: 11pt)

  // Set raw text font.
  // Default is Iosevka at 9pt
  show raw: set text(font: ("Iosevka"), size: 9pt)

  // Configure page size and margins.
  set page(
    paper: "a4",
    margin: (
      bottom: 5cm,
      top: 4cm,
      inside: 26.2mm,
      outside: 37mm,
    ),
    numbering: "1",
    number-align: right,
  )

  // Configure paragraph properties.
  // Default leading is 0.65em.
  set par(leading: 0.7em, justify: true, linebreaks: "optimized")
  // Default spacing is 1.2em.
  show par: set block(spacing: 1.35em)

  show heading: it => {
    v(2.5em, weak: true)
    it
    v(1.5em, weak: true)
  }

  // Style chapter headings.
  show heading.where(level: 1): it => {
    set text(font: "Noto Sans", weight: "bold", size: 24pt)

    // Has no effect, still shows "Section"
    set heading(supplement: [Chapter])

    let heading_number = if heading.numbering == none {
      []
    } else {
      text(counter(heading.where(level: 1)).display(), size: 32pt)
    }

    // Start chapter headings on a new page
    pagebreak(weak: true)

    v(16%)
    if heading.numbering != none {
      stack(
        dir: ltr,
        move(
          dy: 32pt,
          polygon(
            fill: rgb("#0095b6"),
            stroke: rgb("#0095b6"),
            (0pt, 0pt),
            (5pt, 0pt),
            (25pt, -60pt),
            (20pt, -60pt),
          ),
        ),
        heading_number,
      )
      v(1.0em)
      it.body
      v(0.5em)
    } else {
      it.body
    }
  }

  // Configure heading numbering.
  set heading(numbering: "1.1")

  // Do not hyphenate headings.
  show heading: set text(
    font: "Noto Sans",
    features: ("sc", "si", "scit"),
    hyphenate: false,
  )

  // Set page header
  set page(
    header-ascent: 30%,
    header: context {
      // Get current page number.
      let page-number = here().page()

      // [ #repr(query(<disable_header>).map(el => el.location().page()).slice(0, 5)) ]
      // If the current page is the start of a chapter, don't show a header
      let target = heading.where(level: 1)
      if query(target).any(it => it.location().page() == page-number) {
        // return [New chapter! page #here().page()]
        return []
      }

      // Find the chapter of the section we are currently in.
      let before = query(target.before(here()))
      if before.len() > 0 {
        let current = before.last()

        let chapter-title = upper(current.body)
        let chapter-number = counter(heading.where(level: 1)).display()
        // let chapter-number-text = [#current.supplement Chapter #chapter-number]
        let chapter-number-text = [#chapter-number]

        // Get next subsection name and number for header
        let subsection = query(heading.where(level: 2)).first()
        // let next-subsection = subsection.

        let colored-slash = text(fill: rgb("#0095b6"), "/")

        if current.numbering != none {
          let (left-text, right-text) = if calc.odd(page-number) {
            ([#counter(page).display()], chapter-title)
          } else {
            let spacing = h(7pt)
            (
              stack(
                dir: ltr,
                "CHAPTER",
                spacing,
                chapter-number,
                spacing,
                colored-slash,
                spacing,
                chapter-title,
              ),
              [#counter(page).display()],
            )
          }
          text(
            weight: "thin",
            font: "Noto Sans",
            size: 9pt,
            tracking: 0.1em,
            fill: rgb("#2B3333"),
            features: ("sc", "si", "scit"),
            fill-line(left-text, right-text),
          )
          // v(-1em)
          // line(length: 100%, stroke: 0.5pt)
        }
      }
    },
  )

  // The `in-outline` is for showing a short caption in the list of figures
  // See https://sitandr.github.io/typst-examples-book/book/snippets/chapters/outlines.html#long-and-short-captions-for-the-outline
  show outline: it => {
    in-outline.update(true)
    // Show table of contents, list of figures, list of tables, etc. in the table of contents
    set heading(outlined: true)
    it
    in-outline.update(false)
  }

  // Indent nested entries in the outline.
  set outline(indent: auto, fill: repeat([#h(2.5pt) . #h(2.5pt)]))

  show outline.entry: it => {
    // Only apply styling if we're in the table of contents (not list of figures or list of tables, etc.)
    if it.element.func() == heading {
      if it.level == 1 {
        v(1.5em, weak: true)
        strong(it)
      } else {
        it
      }
    } else {
      it
    }
  }

  // Configure equation numbering.
  set math.equation(numbering: n => {
    let h1 = counter(heading).get().first()
    numbering("(1.1)", h1, n)
  })

  show math.equation.where(block: true): it => {
    set align(left)
    // Indent
    pad(left: 2em, it)
  }

  // FIXME: Has no effect?
  // set place(clearance: 2em)

  set figure(
    numbering: n => {
      let h1 = counter(heading).get().first()
      numbering("1.1", h1, n)
    },
    gap: 1.5em,
  )
  set figure.caption(separator: [ -- ])

  show figure.caption: it => {
    if it.kind == table {
      align(center, it)
    } else {
      align(left, it)
    }
  }
  show figure.where(kind: table): it => {
    set figure.caption(position: top)
    // Break large tables across pages.
    set block(breakable: true)
    it
  }
  set table(stroke: none)

  // Set raw text font.
  show raw: set text(font: ("Iosevka", "JetBrains Mono"), size: 9pt)

  // Display inline code in a small box that retains the correct baseline.
  // show raw.where(block: false): box.with(
  //   fill: luma(250).darken(2%), inset: (x: 3pt, y: 0pt), outset: (y: 3pt), radius: 2pt,
  // )

  // Display block code with padding.
  show raw.where(block: true): block.with(inset: (x: 5pt))

  // Show a small maroon circle next to external links.
  show link: it => {
    // Workaround for ctheorems package so that its labels keep the default link styling.
    if type(it.dest) == label {
      return it
    }
    it
    h(1.6pt)
    super(
      box(height: 3.8pt, circle(radius: 1.2pt, stroke: 0.7pt + rgb("#993333"))),
    )
  }

  // Display front page
  frontpage(
    title: title,
    subtitle: subtitle,
    author: author,
    advisor: advisor,
    degree: degree,
    faculty: faculty,
    department: department,
    major: major,
    submission-date: submission-date,
  )

  // Thesis content
  body

  // Display back page
  backpage()
}
