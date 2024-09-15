#import "global.typ": *
#import "../../utils/symbols.typ": *
This chapter will demonstrate how to insert, manipulate and reference figures of various types. The functionality offered by typst to work with figures is powerful and relatively intuitive, especially if you're coming from #LaTeX. However, this template also features a few additional lightweight packages to further simplify working with figures.

== Images <subsec:images>
Typst allows us to render images in formats such as `png`, `jpg` and `svg` out of the box. Using the vector graphic format `svg` is recommended when applicable, for instance when inserting graphs and plots, as it ensures good quality and readability when printed or viewed on a large screen. Be aware that `svg` images may render differently when rendered on different PDF viewers in some cases.

#figure(caption: [A plot from python's matplotlib, exported to svg])[
  #image("../figures/plot_serial.svg")
] <fig:blur_plot>

Inserting a figure in typst is very simple, and we can now easily refer to @fig:blur_plot anywhere in the document. We can also easily customize the image, for instance by adjusting the width of it so that it doesn't take up as much space, like @fig:blur_plot_small. The typst documentation #footnote[see #link("https://typst.app/docs/reference/visualize/image/")] covers images more in depth.

#figure(caption: [A smaller version of the figure])[
  #image("../figures/plot_serial.svg", width: 30%)
] <fig:blur_plot_small>

#pagebreak()
== Tables <subsec:tables>
Creating a basic table with typst is quite simple, yet we can also customize them a great deal if we would like to. This thesis template also has some custom default styling for tables, to make the stroke gray and headers distinct.

#figure(
  table(
    columns: 3,
    table.header(
      [name],
      [weight],
      [food],
    ),

    [mouse], [10 g], [cheese],
    [cat], [1 kg], [mice],
    [dog], [10 kg], [cats],
    [t-rex], [10 Mg], [dogs],
  ),
  caption: [Table with default styling],
) <tab:default_styling>

While @tab:default_styling is a very simple table with no extra styling, @tab:rowspan is more advanced, using bold for the headers and letting them span multiple rows/columns. Note that we also set the alignment for the text inside the table cells.

#figure(
  table(
    columns: 7,
    align: center + horizon,
    /* --- header --- */
    table.header(
      // table.cell lets us access properties such as rowspan and colspan to customize the cells
      table.cell([*Classifier*], rowspan: 2),
      table.cell([*Precision*], colspan: 6),
      [1],
      [2],
      [3],
      [1&2],
      [1&3],
      [All],
    ),
    /* --- body --- */
    [Perceptron],
    [0.78],
    [0.82],
    [0.24],
    [0.81],
    [0.77],
    [0.83],
    [Decision Tree],
    [0.65],
    [0.79],
    [0.56],
    [0.75],
    [0.65],
    [0.73],
    [One-Class SVM],
    [0.74],
    [0.72],
    [0.50],
    [0.80],
    [0.73],
    [0.85],
    [Isolation Forest],
    [0.54],
    [0.51],
    [0.52],
    [0.53],
    [0.54],
    [0.53],
  ),
  caption: [A slightly more elaborate table],
) <tab:rowspan>

On a page break, a table can also break and continue on the subsequent page. If a table header and/or footer is set, like in @tab:break, these will also repeat on both pages by default.

#figure(
  caption: [A table that breaks with the page],
  table(
    columns: 3,
    fill: (_, y) => if y == 0 {
      gray.lighten(75%)
    },
    table.header[Week][Distance (km)][Time (hh:mm:ss)],
    [1], [5], [00:30:00],
    [2], [7], [00:45:00],
    [3], [10], [01:00:00],
    [4], [12], [01:10:00],
    [5], [15], [01:25:00],
    [6], [18], [01:40:00],
    [7], [20], [01:50:00],
    [8], [22], [02:00:00],
    [...], [...], [...],
    table.footer[_Goal_][_42.195_][_02:45:00_],
  ),
) <tab:break>

We can also override the default styling to customize tables. @tab:break sets a custom fill color for the header and @tab:hlines uses `table.hline()` to enable the border stroke on certain lines only. The second column in @tab:hlines is also set to fill all space available to it.

#figure(
  table(
    stroke: none,
    columns: (auto, 1fr),
    table.header(),
    [09:00], [Badge pick up],
    [09:45], [Opening Keynote],
    [10:30], [Talk: Typst's Future],
    [11:15], [Session: Good PRs],
    table.hline(start: 1),
    [Noon], [_Lunch break_],
    table.hline(start: 1),
    [14:00], [Talk: Tracked Layout],
    [15:00], [Talk: Automations],
    [16:00], [Workshop: Tables],
    table.hline(),
    [19:00], [Day 1 Attendee Mixer],
  ),
  caption: [A table with no border stroke],
) <tab:hlines>

There is a lot more customization to be done with tables. Read the official table guide #footnote[see #link("https://typst.app/docs/guides/table-guide/")] to discover how to create a table by reading a `csv` file with typst, achieving zebra highlighting and much more.

== Listings <subsec:listings>
For code listings, this template uses a third party package called *codly* #footnote[see #link("https://typst.app/universe/package/codly")] in order to provide some out of the box styling and proper syntax highlighting. Unless you want to customize the appearance you don't need to touch codly at all, simply create a normal code block like you would in markdown.

#figure(caption: [Hello world! in rust])[
  ```rust
  pub fn main() {
    println!("Hello, world!");
  }
  ```
] <raw:rust>

By default, code listings are configured with zebra lines, line numbering and a label displaying the programming language, like the rust snippet in @raw:rust. If we want to, we can disable or customize these features locally using the codly `#local()` function, demonstrated with @raw:fsharp.

// FIXME: Empty label is still shown as a tiny circle
// NOTE: As the code snippet is within the #local call here, we need to specify the figure kind to get 'Listing' instead of 'Figure'
#figure(caption: [F\# snippet with no zebras and label], kind: raw)[
  #local(zebra-fill: none, display-name: false)[
    ```fsi
    [<EntryPoint>]
    let main () =
      "Hello, world!"
      |> printfn
    ```
  ]
] <raw:fsharp>

We can also skip lines in the code snippet. Note that it doesn't actually skip lines in your snippet, but rather changes the line numbers to represent skipped code. This is demonstrated in @raw:c below.

#figure(caption: [C snippet with skipped lines], kind: raw)[
  #local(skips: ((2, 15),))[
    ```c
    int main() {
      printf("Hello, world!");
      return(0);
    }
    ```
  ]
] <raw:c>

Codly also allows us to highlight code using line and column positions. @raw:python demonstrates highlighting a line and giving it a tag "assignment".

#figure(caption: [Python snippet with highlights], kind: raw)[
  #local(highlights: (
    (line: 1, start: 3, end: none, fill: blue, tag: "assignment"),
  ))[
    ```python
    if __name__ == "__main__":
      d = {'a': 1}
      print("Hello, world!")
    ```
  ]
] <raw:python>
