#import "@preview/subpar:0.1.1"
#import "@preview/physica:0.9.3": *
#import "@preview/outrageous:0.1.0"
#import "@preview/glossarium:0.4.1": make-glossary, print-glossary, gls, glspl
#import "@preview/codly:1.0.0": *

#import "modules/frontpage.typ": frontpage
#import "modules/backpage.typ": backpage
#import "modules/acknowledgements.typ": acknowledgements_page
#import "modules/abstract.typ": abstract_page
#import "modules/epigraph.typ": epigraph_page
#import "modules/abbreviations.typ": abbreviations-page
#import "modules/metadata.typ": *
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
#let uit-teal-color = rgb("#0095b6")
#let uit-gray-color = rgb("#48545e")

// Helper to display two pieces of content with space between
#let fill-line(left-text, right-text) = [#left-text #h(1fr) #right-text]

#let in-appendix = state("in-appendix", false)

// The `in-outline` mechanism is for showing a short caption in the list of figures
// See https://sitandr.github.io/typst-examples-book/book/snippets/chapters/outlines.html#long-and-short-captions-for-the-outline
#let in-outline = state("in-outline", false)

// TODO: Remove if remains unused
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
    numbering: n => if in-appendix.get() {
      numbering("A.1", counter(heading).get().first(), n)
    } else {
      numbering("1.1", counter(heading).get().first(), n)
    },
    numbering-sub-ref: (m, n) => if in-appendix.get() {
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

  // The name of the supervisor(s) for your work.
  supervisor: ("John Doe"),

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

  // The contents for the epigraph page. This will be displayed after the acknowledgements.
  epigraph: none,

  // The contents for the preface page. This will be displayed after the cover page. Can
  // be omitted if you don't have one.
  preface: none,

  // The result of a call to the `outline` function or `none`.
  // Set this to `none`, if you want to disable the table of contents.
  // More info: https://typst.app/docs/reference/model/outline/
  table-of-contents: outline(),

  // The result of a call to the `bibliography` function or `none`.
  // Example: bibliography("refs.bib", title: "Bibliography", style: "ieee")
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

  // List of abbreviations
  abbreviations: none,

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

  // Required init for packages
  show: make-glossary
  show: codly-init

  // Optimize numbers with superscript
  // especially nice for bibliography entries
  show regex("\d?\dth"): w => {
    // 26th, ...
    let b = w.text.split(regex("th")).join()
    [#b#super([th])]
  }
  show regex("\d?\dst"): w => {
    // 1st
    let b = w.text.split(regex("st")).join()
    [#b#super([st])]
  }
  show regex("\d?\d[nr]d"): w => {
    // 2nd, 3rd, ...
    let s = w.text.split(regex("\d")).last()
    let b = w.text.split(regex("[nr]d")).join()
    [#b#super(s)]
  }

  // if we find in bibentries some ISBN, we add link to it
  show "https://doi.org/": w => {
    // handle DOIs
    [DOI:] + str.from-unicode(160) // 160 A0 nbsp
  }
  show regex("ISBN \d+"): w => {
    let s = w.text.split().last()
    link(
      "https://isbnsearch.org/isbn/" + s,
      w,
    ) // https://isbnsearch.org/isbn/1-891562-35-5
  }

  show footnote.entry: set par(hanging-indent: 1.5em)

  // Set the body font.
  // Default is Charter at 11pt
  set text(font: ("Charter"), size: 11pt)

  // Set raw text font.
  // Default is JetBrains Mono at 9tp with DejaVu Sans Mono as fallback
  show raw: set text(font: ("JetBrains Mono", "DejaVu Sans Mono"), size: 9pt)

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
    number-align: center,
  )

  // Configure paragraph properties.
  // Default leading is 0.65em.
  set par(leading: 0.7em, justify: true, linebreaks: "optimized")

  // Default spacing is 1.2em.
  show par: set block(spacing: 1.35em)

  // Add some vertical spacing for all headings
  show heading: it => {
    let body = if it.level > 1 {
      box(width: 35pt, counter(heading).display())
      it.body
    } else {
      it
    }
    v(2.5em, weak: true)
    body
    v(1.5em, weak: true)
  }

  // Style chapter headings
  show heading.where(level: 1): it => {
    set text(font: "Open Sans", weight: "bold", size: 24pt)

    // FIXME: Has no effect, still shows "Section"
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
            fill: uit-teal-color,
            stroke: uit-teal-color,
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
    font: "Open Sans",
    weight: "bold",
    features: ("sc", "si", "scit"),
    hyphenate: false,
  )

  set page(
    // Set page header
    header-ascent: 30%,
    header: context {
      // Get current page number
      let page-number = here().page()

      // If the current page is the start of a chapter, don't show a header
      let chapters = heading.where(level: 1)
      if query(chapters).any(it => it.location().page() == page-number) {
        return []
      }

      // Find the chapter of the section we are currently in
      let chapters-before = query(chapters.before(here()))
      if chapters-before.len() > 0 {
        let current-chapter = chapters-before.last()


        // If a new subsecion starts on this page, display that subsection.
        // Otherwise, display the last subsection
        let current-subsection = {
          let subsections = heading.where(level: 2)

          let subsections-after = query(subsections.after(here()))
          if subsections-after.len() > 0 {
            let next-subsection = subsections-after.first()
            if next-subsection.location().page() == page-number {
              (next-subsection)
            } else {
              let subsections-before = query(subsections.before(here()))
              if subsections-before.len() > 0 {
                (subsections-before.last())
              } else {
                // No subsections in this chapter, display nothing
                (none)
              }
            }
          }
        }

        let colored-slash = text(fill: uit-teal-color, "/")
        let spacing = h(3pt)

        // Display subsection count and heading
        let subsection-text = if current-subsection != none {
          let subsection-numbering = current-subsection.numbering
          let location = current-subsection.location()
          let subsection-count = numbering(subsection-numbering,..counter(heading).at(location))

          [#subsection-count #spacing #colored-slash #spacing #current-subsection.body]
        } else {
          []
        }

        // Display chapter count and heading
        let chapter-text = {
          let chapter-title = current-chapter.body
          let chapter-number = counter(heading.where(level: 1)).display()

          [CHAPTER #chapter-number #spacing #colored-slash #spacing #chapter-title]
        }

        if current-chapter.numbering != none {
          // Show current chapter on odd pages, current subsection on even
          let (left-text, right-text) = if calc.odd(page-number) {
            (counter(page).display(), chapter-text)
          } else {
            (
              subsection-text,
              counter(page).display(),
            )
          }
          text(
            weight: "thin",
            font: "Open Sans",
            size: 8pt,
            fill: uit-gray-color,
            // FIXME: Seems to have no effect
            // features: ("sc", "si", "scit"),
            fill-line(upper(left-text), upper(right-text)),
          )
        }
      }
    },
    // // Only show page numbering when not shown in header
    // numbering: context {
    //   let chapters = heading.where(level: 1)
    //   if query(chapters).any(it => it.location().page() == here().page()) {
    //     [1].text.text
    //   } else {
    //     none
    //   }
    // },
  )


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

  // Set figure numbering to follow chapter
  set figure(numbering: n => {
    let h1 = counter(heading).get().first()
    numbering("1.1", h1, n)
  })
  set figure.caption(separator: [ -- ])

  // Place table captions above table
  show figure.where(kind: table): it => {
    set figure.caption(position: top)
    // Break large tables across pages.
    set block(breakable: true)
    it
  }

  // Use lighter gray color for table stroke
  set table(
    inset: 7pt,
    stroke: (0.5pt + stroke-color),
  )
  // Show table header in small caps
  show table.cell.where(y: 0): smallcaps

  // Display inline code in a small box that retains the correct baseline.
  show raw.where(block: false): box.with(
    fill: fill-color.darken(2%),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

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
    degree: degree,
    faculty: faculty,
    department: department,
    major: major,
    submission-date: submission-date,
  )

  // Use front matter stylings
  show: front_matter

  // List of Supervisors
  // NOTE: Should we use the variables in the struct for this?
  // isupervisors()
  include "modules/supervisors.typ"

  // Epigraph
  epigraph_page()[#epigraph]

  // Abstract
  abstract_page()[#abstract]

  // Acknowledgements
  acknowledgements_page()[#acknowledgements]

  // Display outlines (table of content, table of figures, etc...)
  context {
    // Helper to target figure kinds
    let fig-t(kind) = figure.where(kind: kind)

    // The `in-outline` is for showing a short caption in the list of figures
    // See https://sitandr.github.io/typst-examples-book/book/snippets/chapters/outlines.html#long-and-short-captions-for-the-outline
    show outline: it => {
      in-outline.update(true)
      // Show table of contents, list of figures, list of tables, etc. in the table of contents
      set heading(outlined: true)
      it
      in-outline.update(false)
    }

    // Increase distance between dots on all outline fill
    set outline(fill: box(width: 1fr, repeat([#h(2.5pt) . #h(2.5pt)])))

    pagebreak()

    // Common padding to use on outline entries
    let entry-padding = 0.5em

    // Styling for ToC
    // NOTE: When/if setting fill dependent on the depth becomes easily possible
    // in typst itself, we can remove the 'outrageous' package
    [
      #show outline.entry: outrageous.show-entry.with(
        ..outrageous.presets.typst,
        font-weight: ("bold", auto),
        fill: (none, auto),
        font: ("Carter", "Carter"),
        vspace: (1.5em, 0.5em),
        // FIXME: This should work...
        // fill-right-pad: .4cm,
        // fill-align: true,

        // Manually add indent and spacing
        body-transform: (lvl, body) => {
          let indent = (lvl - 1) * 1.5em
          // Entries with (number, text, page) should have more spacing between number and text
          let spaced-entry = if "children" in body.fields() {
            let (number, space, ..text) = body.children
            [#number #h(entry-padding) #text.join()]
          } else {
            body
          }
          [#h(indent) #spaced-entry]
        },
        // Manually add spacing between fill and page number
        page-transform: (lvl, page) => {
          if lvl > 1 {
            [#h(entry-padding) #page]
          } else {
            page
          }
        }
      )
      #outline(title: "Contents")
    ]

    // Styling for remaining outlines
    show outline.entry: outrageous
      .show-entry
      .with(
      ..outrageous.presets.typst,
      // Don't display 'figure' or 'table' before each entry
      body-transform: (lvl, body) => {
        if "children" in body.fields() {
          let (fig-type, space, number, colon, ..text) = body.children
          [#number #h(entry-padding) #text.join()]
        } else {
          body
        }
      },
      // Manually add spacing between fill and page number
      page-transform: (lvl, page) => {
        [#h(entry-padding) #page]
      }
    )

    // ToF, ToT and ToL are optional
    if figure-index.enabled {
      outline(title: "List of Figures", target: fig-t(image))
    }
    if table-index.enabled {
      outline(title: "List of Tables", target: fig-t(table))
    }
    if listing-index.enabled {
      outline(title: "List of Listings", target: fig-t(raw))
    }
  }

  // Table of abbreviations
  if abbreviations != none {
    abbreviations-page(abbreviations)
  }

  // Use main matter stylings
  show: main_matter

  // Thesis content
  body

  // Use back matter stylings
  show: back_matter

  //Style bibliography
  if bibliography != none {
    pagebreak()
    // show std-bibliography: set text(0.95em)
    show std-bibliography: set text(12pt)
    // Use default paragraph properties for bibliography.
    show std-bibliography: set par(
      leading: 0.65em,
      justify: false,
      linebreaks: auto,
    )
    bibliography
  }

  // Display back page
  backpage()
}
