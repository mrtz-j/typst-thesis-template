// Utility to highlight TODOs to easily find them in the PDF
#let TODO(body, color: yellow) = {
  rect(
    width: 100%,
    radius: 3pt,
    stroke: 0.5pt,
    fill: color,
  )[
    TODO: #body
  ]
}
