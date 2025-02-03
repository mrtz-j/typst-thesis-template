#let appendix-page(body) = {
  pagebreak(weak: true, to: "even")
  // --- Appendix ---
  align(left)[
    = Appendix
    #v(1em)
    #body
  ]
}

// TODO: Styling from lib.typ
// heading(level: 1)[#appendix.at("title", default: "Appendix")]
// // For heading prefixes in the appendix, the standard convention is A.1.1.
// let num-fmt = appendix.at("heading-numbering-format", default: "A.1.1.")
// counter(heading).update(0)
// set heading(
//   outlined: false,
//   numbering: (..nums) => {
//     let vals = nums.pos()
//     if vals.len() > 0 {
//       let v = vals.slice(0)
//       return numbering(num-fmt, ..v)
//     }
//   },
// )
// appendix.body
