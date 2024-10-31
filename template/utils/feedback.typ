#let feedback(feedback: none, response: none, ..messages) = {
  if (response != none and feedback == none) {
    panic("Expected response to have a feedback message.")
  }

  if (feedback, response).all(x => x == none) and (messages.pos().len() == 0) {
    panic("Feedback must either have a feedback message or a list of messages.")
  }

  counter("feedback").step()
  rect(
    width: 100%,
    inset: 10pt,
    radius: 3pt,
    stroke: 0.5pt + blue,
    fill: blue.lighten(75%),
  )[
    #text(
      weight: 700,
      context (counter("feedback").display() + ". Feedback: "),
    )
    #if (feedback != none) {
      feedback
    }

    #if (response != none) {
      line(length: 100%, stroke: 0.5pt + blue)
      [#text(weight: 700, "Response: ") #response]
    }

    #if (messages.pos().len() != 0) {
      for (i, message) in messages.pos().enumerate() {
        // do not draw a line before the first message
        if (calc.rem(i, 2) == 0) and (i != 0) {
          line(length: 100%, stroke: 0.5pt + blue)
        }

        let (author, content, date) = message
        let role = if calc.even(i) {
          "Feedback"
        } else {
          "Response"
        }
        let color = if calc.even(i) {
          blue.lighten(10%)
        } else {
          navy.lighten(10%)
        }

        block(
          width: 100%,
          fill: color.lighten(90%),
          outset: 5pt,
          radius: 3pt,
        )[
          #text(weight: 700, fill: color, role + " from " + author + ": ")
          #content
          #if date != none {
            text(size: 0.8em, style: "italic")[ (#date)]
          }
        ]
      }
    }
  ]
}
