#import "global.typ": *

// Not listed in table of contents (the outline)
// Not numbered
// #heading(numbering: none, outlined: false)[List of Abbreviations]
// #set page(numbering: "i")
// #counter(page).update(1)
// #set heading(numbering: none)
// #show heading.where(level: 1): it => {
//   it
//   v(6%, weak: true)
// }

// Add list of terms
// Usage within text will then be #gls(<key>) or plurals #glspl(<key>)
// Output is sorted by key
#print-glossary(
  (
    (
      key: "gc", short: "GC", long: "Garbage Collection", desc: [Garbage collection is the common name for the term automatic memory management.],
    ),
    (key: "uit", short: "UiT", long: "The Arctic University of Tromsø"),
    (
      key: "cow", short: "COW", long: "Copy on Write", desc: [Copy on Write is a memory allocation strategy where arrays are copied if they
        are to be modified.],
    ),
  ),
  // show all term even if they are not referenced, default to true
  show-all: true,
)
