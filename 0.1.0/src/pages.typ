#import "styles.typ": *
#import "utils.typ": chap-title, default-info, default-layout

#let cover(
  title: "The Book Title",
  date: datetime.today(),
  info: default-info,
  layout: default-layout,
) = {
  show: cover-style

  let title = if title == "" { info.book } else { title }
  let lang = info.lang
  let author = info.author

  align(
    center + horizon,
    [
      #text(
        size: 36pt,
        weight: "bold",
        font: layout.fonts.at(lang).title,
        title,
      )
      #v(1em)
      #text(24pt, font: layout.fonts.at(lang).author, author)
      #v(1em)
      #text(18pt, date.display())
    ],
  )
}

#let epigraph(
  body,
) = {
  show: cover-style
  align(
    center + horizon,
    text(16pt, body),
  )
}

#let preface(body, info: default-info, layout: default-layout, names: default-names) = {
  show: common-style
  show: front-matter-style

  let lang = info.lang
  let author = info.author

  heading(
    level: 1,
    text(
      names.sections.at(lang).preface,
      font: layout.fonts.at(lang).preface,
    ),
  )
  body
  align(right)[#emph(author)]
  pagebreak()
}

#let label-part = <part>
#let contents = {
  show: contents-style
  outline(target: selector(heading).or(label-part).or(chap-title), depth: 3)
}

#let part-page(title) = {
  show: front-matter-style
  show figure.caption: none
  align(
    center + horizon,
    [
      #figure(
        text(36pt, strong(title)),
        kind: "part",
        supplement: none,
        numbering: _ => none,
        caption: title,
      ) #label-part
    ],
  )
}
