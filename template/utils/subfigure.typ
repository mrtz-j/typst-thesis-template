#import "global.typ": in-appendix, subpar

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
      numbering("1.1a", counter(heading).get().first(), m, n)
    },
    // NOTE: Reset the gutter for the sub figure content
    // so listings render with their normal tight line spacing.
    show-sub: it => {
      set grid(gutter: 0pt)
      it
    },
    show-sub-caption: (num, it) => {
      it
      v(.65em)
    },
  )
}
