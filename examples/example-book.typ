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

#contents(depth: 1)

#part-page()[Specifications]

#show: chapter-style.with(title: "Features", info: example)

In this chapter, I will show you all the features of this template.

= General Styles

== Cover Style

== Front Matter Style

=== Figures

When I'm adding a figure, the caption will be shown in the margin.

#figure(
  rect(
    width: 100%,
    height: 1cm,
    fill: gradient.linear(..color.map.rainbow),
  ),
  caption: [A rainbow],
)

=== References Style

When I'm referencing something great@maedje2022typst, a detailed reference will be shown in the margin.

= Customizable Styles

#show: chapter-style.with(title: "Usage of the Template", info: example)

// #chapter-img(image("0.1.0/assets/cloud.jpg"))

The template is designed to be easy to use. You can use it to create a booklet or a note with a beautiful layout.

In this chapter, I will show you how to initialize the template and use a variety of utility functions provided.

= Importing the Template

To use the template, you need to import like this

```typ
#import "@preview/qooklet:0.4.0": *
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

The default mode is note mode, when `cover()` is called the booklet mode will be activated.

In addition to the four functions returned by `template`, functions independent of booklet mode are also imported. All of these functions are:

- Styles:
  - `front-matter-style(body)`: Style for front matter pages.
  - `appendix-style(body)`: Style for appendix pages.
  - `chapter-style(body)`: Style for body pages.
- Pages:
  - `cover(info, date: datetime.today())`: Add a cover page to the document.
  - `epigraph(body)`: Add an epigraph to the document.
  - `preface(body)`: Add a preface to the document.
  - `contents`: Add a table of contents to the document.
  - `part-page(body)`: Add a part page to the document.
- Utils:
  - `chapter-img(body, img, label: none)`: Add a heading of level 1 with a banner image to the document.

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
#show: appendix-style
...
```

For the body of the document, the template provides you with at least three hierarchical levels of structure:
- `part-page`: The `part-page` will create a single page with a title. You can use it to create a new chapter or a new part in your document.
- `= Heading` or `chapter-img`: The level 1 heading will create a chapter starting from a new page. Specifically, the `chapter-img` will create a heading with an image banner.
- `= Section`: The level 2 heading will create a section.

For the appendix, it's almost the same as the body. But their heading numbering is `"A.1"`.

= Usage of Some Functions

In this chapter, I will show you how to use some functions, mainly tool functions, as well as some page functions.

== Heading Image

The `chapter-img` function will create a level 1 heading with an image banner.

Still buggy, don't use it at the moment.

#show: chapter-style.with(title: "Enviroments", info: example)

= Theorems

The theorems enviroment is implemented by #link("https://github.com/OrangeX4/typst-theorion")[theorion].

= An Example

== Bellman Equation

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

== Bellman Optimal Eqation

By Eq. @bellman,...

$
  v(s) &= max_(π(s) ∈ ∏(s)) ∑_(a ∈ 𝒜) π(a|s)(∑_(r ∈ ℛ) p(r|s, a) r + γ ∑_(s^′ ∈ 𝒮) p(s^′|s, a) v(s^′)), quad &∀s ∈ 𝒮 \
  &= max_(π(s) ∈ ∏(s)) ∑_(a ∈ 𝒜) π(a|s) q(s, a), quad &∀s ∈ 𝒮
$ <boe>

== Case: Shortest Path of Islands

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

#part-page()[Appendix]

#show: appendix-style.with(title: "Bibliography")

#bibliography("bib.bib", title: none)

#show: appendix-style.with(title: "Notes")

I hate writing notes.
