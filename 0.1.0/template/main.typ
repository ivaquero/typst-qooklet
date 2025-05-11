#import "@local/qooklet:0.1.0": *

#show: qooklet.with(
  title: "",
  info: toml("../config/info.toml").global,
  outline-on: false,
  par-leading: 1em,
  list-indent: 1.2em,
  block-above: 1em,
  block-below: 1em,
  figure-break: false,
  paper: "iso-b5",
)
