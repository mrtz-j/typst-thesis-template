#import "global.typ": *
#import "../../utils/symbols.typ": *
#import "../../utils/todo.typ": *

This chapter will go over the template structure and its basic usage. Users should note that the file structure discussed here is merely a recommended starting point and not required for using the template package.

== Template structure <subsec:template_structure>
As opposed to lightweight and uncomplicated report templates you may be familiar with if you have used typst or #LaTeX before, this template has a slightly more involved _file structure_. Instead of writing all content in one large `thesis.typ` file, each chapter is written into its own file and imported in `thesis.typ` instead. These chapters are placed in their own directory.

@fig:file_structure shows a tree view of the default file structure of this template. In addition to the `chapters` directory, there is also one for figures. Here you can neatly store all your `.svg`, `.png` or `.PDF` files and reference them in the chapters. Alternatively, some students might prefer to organize further with a directory for each chapter for both typst content and figures, when their thesis grows in size.

#TODO()[We shouldn't have two figure folders on different depths like we currently do...]

Another important file to note is `refs.bib`. This is where you put your #BibTeX entries that will produce your bibliography, just like you are used to when working with #LaTeX.

#[
  #figure(caption: [File structure tree view])[
    #local(zebra-fill: none, number-format: none)[
      ```
      ├── figures
      │   ├── frontpage_full.svg
      │   └── ...
      ├── template
      │   ├── chapters
      │   │   ├── basic_usage.typ
      │   │   ├── global.typ
      │   │   └── ...
      │   ├── figures
      │   │   ├── some_vector_graphics.svg
      │   │   └── ...
      │   ├── refs.bib
      │   ├── thesis.pdf
      │   └── thesis.typ
      └── utils
          ├── symbols.typ
          ├── todo.typ
          └── ...
      ```
    ]
  ] <fig:file_structure>
]

== Getting Started <subsec:getting_started>
In order to get started using this template document class for your thesis, you can start off with the template you are reading right now and upload it to the typst webapp #footnote[see #link("https://typst.app")]. Very similar to Overleaf, it is an online editor which conveniently compiles and displays your document as you write, and allows for easy online access for your supervisor. You can also edit the document simultaneously with your co-author if you have one.

To initialize your local copy of the template, make sure you have `typst` installed and run `typst init @preview/unofficial-uit-thesis-template:0.1.0 my-thesis` and it will be downloaded into `my-thesis`. Now you're ready to either upload your thesis to `typst.app` or compile it locally using `typst watch` if you prefer.

Starting in `thesis.typ`, we can see a function call to a function `thesis`. This is how the thesis template style is applied to the document. There are a number of parameters that can be sent into this invokation both to provide special content like title, abstract or list of abbreviations as well as additional customization details. The default call demonstrated in `thesis.typ` should give you an idea of the usage.

