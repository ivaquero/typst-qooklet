#import "dependencies.typ": *
#import "common.typ": *
#import "referable.typ": *
#import "front-matters.typ": part-page
#import "chapters.typ": align-odd-even, chapter-title, heading-numbering, heading-size-style

#let appendix-style(
  body,
  title: "",
  info: default-info,
  styles: default-styles,
  names: default-names,
  heading-depth: 3,
) = {
  let lang = info.lang
  show: book-style.with(styles: styles)

  set text(font: styles.fonts.at(lang).context, size: 10.5pt, lang: lang)

  align(center, chapter-title(title, book: true, lang: lang, appendix: true))

  let append-index = context counter-appendix.display("A.")
  show heading: heading-size-style
  set heading(
    numbering: (..numbers) => heading-numbering(
      ..numbers,
      prefix: append-index,
      heading-depth: heading-depth,
    ),
  )

  set page(
    header: context {
      set text(size: 8pt)
      align-odd-even("", title, hide: true)
      line(length: 100%)
    },
    footer: context {
      set text(size: 8pt)
      let page_num = here().page()
      align-odd-even(info.title, page_num)
    },
  )

  show math.equation: equation-numbering-style.with(prefix: "appendix")
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    it
  }

  show ref: ref-style.with(lang: lang, names: names, prefix: "appendix")
  show figure: figure-supplement-style
  show figure.where(kind: table): set figure.caption(position: top)
  show raw.where(block: true): code-block-style

  set-theorion-numbering("A.1")
  body
}
