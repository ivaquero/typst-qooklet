#import "@local/qooklet:0.1.0": *

#let example = toml("../0.1.0/config/info.toml").example
#cover(example)

#epigraph[
  By `epigraph()`, you can add a quote or a saying at the beginning of the book.
]

#preface(info: example)[

  By `preface()`, you can add some information about the book.

  This template is heavily based the template #link("https://github.com/ParaN3xus/haobook")[haobook]. The main difference is that `qooklet` does not provide side-note-like features which is provided by `haobook` using #link("https://github.com/nleanba/typst-marginalia")[]

  This document serves both as a test document and a tutorial for the template. You can find the source code in the `example.typ` file. The template is designed to be user-friendly and customizable, allowing you to adapt it to your specific requirements.
]

#contents(depth: 2)

#part-page[Specifications]

#show: chapter-style.with(title: "Features", info: example)

In this chapter, I will show you the features of this template.

= Builtin Styles

All of these functions are:

- Styles:
  - `chapter-style(title: title, info: info)[body]`: Style for body pages.
  - `appendix-style(title: title, info: info)[body]`: Style for appendix pages.
  - `front-matter-style(body)`: Style for front matter pages.
- Pages:
  - `cover(info, date: datetime.today())`: Add a cover page to the document.
  - `epigraph[body]`: Add an epigraph to the document.
  - `preface[body]`: Add a preface to the document.
  - `part-page[body]`: Add a part page to the document.
  - `contents(depth: depth)`: Add a table of contents to the document.

= Two Modes

The default mode is note mode, when `cover()` is called the booklet mode will be activated.

= Tweakable Config

The `info` argument in `chapter-style()` and `appendix-style()` is argument that let you customize the information of your booklet using a toml file (if you leave it alone, the following info will be empty).

You can read you info file by the following sentence

```typst
#let info = toml("your path").key-you-like
```

The toml file should look like this

```toml
[key-you-like]
    title = "Your Booklet Name"
    author = "Your Name"
    footer = "Some Info You Want to Show"
    header = "Some Info You Want to Show"
    lang = "en" # or "zh"
```

= Theorems

The theorems enviroment is implemented by #link("https://github.com/OrangeX4/typst-theorion")[theorion].

#show: chapter-style.with(title: "Usage of the Template", info: example)

The template is designed to be easy to use. You can use it to create a booklet or a note with a beautiful layout.

= Importing the Template

To use the template, you need to import like this

```typ
#import "@preview/qooklet:0.5.0": *
```

or clone the repository to your `@local` workspace

- Linux：
  - `$XDG_DATA_HOME/typst/packages/local`
  - `~/.local/share/typst/packages/local`
- macOS：`~/Library/Application\ Support/typst/packages/local`
- Windows：`%APPDATA%/typst/packages/local`

```typ
#import "@local/qooklet:0.1.0": *
```

= Suggested Document Structure

Overall, your document should be structured like this:

```typ
#import "@local/qooklet:0.1.0": *

#let info = toml(your-info-file-path).key-you-like
// for example
// #let info = toml("../config/info.toml").global

// add a cover
#cover(
  // info,
  // date: datetime.today(),
)

#epigraph[
  // Add an epigraph to the document.
]

#preface[
  // Add a preface to the document.
]

#contents

// body
#show: chapter-style.with(
  title: "chapter-title 1",
  info: info,
)

#show: chapter-style.with(
  title: "chapter-title 2",
  info: info,
)
...

// appendix
#part-page[Appendix]

#show: appendix-stylechapter-style.with(
  title: "Appendix-title 1",
  info: info,
)

#show: appendix-stylechapter-style.with(
  title: "Appendix-title 2",
  info: info,
)
...
```

#show: chapter-style.with(title: "Some Examples", info: example)

= Bellman Equation

#definition(title: "Bellman Eqation")[

  ...

  $
    text(v_π (s), fill: #rgb("#ff0000"))
    &= 𝔼[R_(t+1)|S_t = s] + γ 𝔼[G_(t+1)|S_t = s], \
    &= ∑_(a ∈ 𝒜) π(a|s) ∑_(r ∈ ℛ) p(r|s,a) +
    γ ∑_(a ∈ 𝒜) π(a|s) ∑_(s^′ ∈ 𝒮) p(s^′|s,a) v_π (s^′) \
    &= ∑_(a ∈ 𝒜) π(a|s) [∑_(r ∈ ℛ) p(r|s,a) r +
      γ ∑_(s^′ ∈ 𝒮) p(s^′|s,a) text(v_π (s^′), fill: #rgb("#ff0000"))], ∀s ∈ 𝒮
  $ <bellman>
]

= Bellman Optimal Eqation

By Eq. @bellman,...

$
  v(s) &= max_(π(s) ∈ ∏(s)) ∑_(a ∈ 𝒜) π(a|s)(∑_(r ∈ ℛ) p(r|s, a) r + γ ∑_(s^′ ∈ 𝒮) p(s^′|s, a) v(s^′)), quad &∀s ∈ 𝒮 \
  &= max_(π(s) ∈ ∏(s)) ∑_(a ∈ 𝒜) π(a|s) q(s, a), quad &∀s ∈ 𝒮
$ <boe>

= Case: Shortest Path of Islands

```typst
#let csv1 = csv("islands.csv")
#figure(
  tableq(csv1, 9, inset: 0.31em),
  caption: "Geographic Info of Islands",
  supplement: "Table",
  kind: table,
)
```

#let csv1 = csv("islands.csv")
#figure(
  tableq(csv1, 9, inset: 0.31em),
  caption: "Geographic Info of Islands",
  supplement: "Table",
  kind: table,
)

#part-page[Appendix]

#show: appendix-style.with(title: "Bibliography")

#bibliography("bib.bib", title: none)
