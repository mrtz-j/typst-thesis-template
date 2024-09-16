# Modern UiT Thesis Template

Port of the [uit-thesis](https://github.com/egraff/uit-thesis)-latex template to Typst. 

`thesis.typ` contains a full usage example, see `thesis.pdf` for a rendered pdf.

## Usage

Using the Typst Universe package/template, you can import it at the beginning of your document: 

```typ
#import "@preview/modern-uit-thesis:0.1.0": *
```

## Roadmap

- [ ] Content and pages
  - [x] Complete front page
  - [x] Back page
  - [x] Supervisors page
  - [ ] List of Definitions
  - [x] List of Abbreviations
  - [ ] Appendix
- [ ] Styling
  - [x] Headings (chapter on odd, subsection on even)
  - [ ] Font features
  - [ ] Figures (captions etc)
  - [x] Code blocks (syntax highlights)
  - [x] Tables
  - [x] Footnotes (?)
  - [ ] Style for print (pagebreak to even)
- [x] Good examples
  - [x] Use of figures, tables, code blocks
    - [x] Side by side
    - [ ] Create table from CSV
    - [ ] Codeblocks with External Code
  - [x] Citations
  - [x] Lists (unordered, ordered)
  - [x] Utilities
    - [x] Abbreviations
    - [x] TODOs, feedback, form, etc
- [x] CI/CD
  - [x] Formatting
  - [x] Build and Release pdf
  - [ ] Release as lib (TODO: Add to local index)
- [x] License

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.