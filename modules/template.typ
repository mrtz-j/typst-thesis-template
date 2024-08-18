#import "metadata.typ": *
#import "titlepage.typ": titlepage
#import "backpage.typ": backpage
#import "abstract.typ": abstract_page

#let default_args = arguments(
  title: none,
  author: author,
  subtitle: none,
  lang: "en",
  degree: "Master",
  faculty: faculty,
  department: department,
  program: program,
  date: none,
  abstract: none,
  acknowledgements: none,
  epigraph: none,
  dedication: none,
  bibliography-file: none,
)

#let uit(..passed_args, body) = {
  // Merge default arguments with passed arguments
  let args = default_args.named() + passed_args.named()

  // if args.lang not in ("en", "no") {
  //   panic([This template only supports English "en" or Norwegian "no".])
  // }

  // if args.degree not in ("Master", "Bachelor", "Capstone") {
  //   panic(
  //     [This template only supports "Master", "Bachelor" and "Capstone" theses.],
  //   )
  // }

  let body-font = "Open Sans"
  let sans-font = "Noto Sans"

  // Set up the document
  set document(title: args.title, author: args.author)

  set page(
    paper: "a4",
    width: 210mm,
    height: 297mm,
    margin: (top: 12mm, right: 12mm, left: 12mm, bottom: 12mm),
    numbering: "1", number-align: right,
  )

  set text(font: body-font, size: 12pt, lang: "en")

  set heading(level: 1, numbering: "1.1", supplement: [Chapter])

  show heading.where(level: 1) : it => block(
    width: 100%,
    stroke: none,
    [
      #v(1in)
      #set text(28pt, weight: "bold")
      #set align(left)
      #if it.numbering != none [
        #block(stroke: none, spacing: 0em, [Chapter #counter(heading).display()])
      ]
      #v(1em)
      #block(stroke: none, spacing: 0em, it.body)
      #v(0.5in)
    ],
  )

  titlepage(
    title: args.title,
    subtitle: args.subtitle,
    degree: args.degree,
    faculty: args.faculty,
    department: args.department,
    program: args.program,
    author: args.author,
    submissionDate: args.date,
  )

  // Show the abstract
  if args.abstract != none { abstract_page(args.abstract) }

  pagebreak(weak: true, to: "even")

  body

  // Display the bibliography
  if args.bibliography-file != none {
    show bibliography: set text(12pt)
    bibliography("../" + args.bibliography-file, title: "Bibliography", style: "ieee")
  }
}
