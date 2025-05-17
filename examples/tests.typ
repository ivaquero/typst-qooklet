#let label-chapter = <chapter>
#let label-part = <part>

#let contents-style(body, depth: 2) = {
  assert(depth in (1, 2), message: "depth can only be either 1 or 2")


  show link: set text(black)
  show heading.where(level: 1): it => {
    set text(22pt)
    it
    v(0.1em)
  }

  set outline(
    title: {
      heading(
        outlined: true,
        level: 1,
        "Contents",
      )
    },
  )

  show outline.entry: x => {
    let fill = box(width: 1fr, x.fill)
    let loc = x.element.location()
    let prefix = x.prefix()
    let func = x.element.func()

    let chap-index = context counter(label-chapter).at(loc).at(0)
    let part-index = context counter(label-part).at(loc).at(0)

    if (depth >= 1) and (func == figure) {
      link(
        loc,
        {
          (
            chap-index + "." + h(.5em) + smallcaps(strong(x.body())) + fill + strong(x.page()) + v(0em)
          )
        },
      )
    } else if (depth == 2) and (x.level == 1) and (prefix != none) {
      link(
        loc,
        {
          strong(
            if prefix.has("children") {
              h(1.2em) + chap-index + "." + prefix.children.at(1) + h(.5em)
            } else if prefix.has("text") {
              prefix + h(.5em)
            }
              + x.body(),
          )
          fill + strong(x.page())
        },
      )
      v(0em)
    }
  }
  body
}

#let contents(depth: 2) = {
  show: contents-style.with(depth: depth)
  outline(target: selector(heading).or(label-part).or(label-chapter), depth: depth)
  pagebreak(to: "odd")

  show outline: it => if query(it.target) == () { }
}

#let chapter-style(body, title: "") = {
  align(
    center,
    [#figure(
        text(
          36pt,
          title,
          style: "italic",
          weight: "bold",
        ),
        kind: "title",
        supplement: none,
        numbering: _ => none,
        caption: title,
      )#label-chapter],
  )

  show pagebreak.where(weak: true): it => {
    counter(heading).update(0)
    it
  }

  show figure.caption.where(kind: "title"): none
  pagebreak()

  body
}

#let part(title) = {
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

  pagebreak()
}

#contents(depth: 2)

#part("Part I")

#show: chapter-style.with(title: "Chapter 1")

#show: chapter-style.with(title: "Chapter 2")

#part("Part II")

#show: chapter-style.with(title: "Chapter 3")

#show: chapter-style.with(title: "Chapter 4")
