#import "data.typ": *
#import "@preview/boxr:0.1.0": *

#let a_size(exponent) = {
  let a0_size = (841mm, 1189mm)

  for i in range(exponent) {
    let last_a_size = a0_size

    a0_size = (last_a_size.at(1) / 2, last_a_size.at(0))
  }

  return a0_size
}

#let calculate_smallest_a_size(width, height) = {

  let current_a_size = 0
  let current_size = a_size(current_a_size)
  
  while (width < current_size.at(1) and height < current_size.at(0)) {
    current_a_size = current_a_size + 1
    current_size = a_size(current_a_size)
  } 
  return current_a_size - 1
}

#let card_amount = card_count
#let card_thickness = 1mm
#let structure_args = (
  width: card_thickness * card_amount,
  height: card_height + 5mm,
  depth: card_width + 5mm,
  lid-size: card_height * 0.4,
  tab-size: 25pt,
)

#let size = get-structure-size(
  json("box_lid.json"),
  ..structure_args
)
#let total_width = size.at(0)
#let total_height = size.at(1)

#let next_biggest_a_size = str(calculate_smallest_a_size(total_width, total_height))

#set page(
  fill: gray,
  "a" + next_biggest_a_size,
  flipped: true,
  margin: 0%,
)

#set text(font: "Inter Tight", fill: white, size: 4em)
#place(top + center, dx: 5mm, dy: 5mm)[
  #set text(size: 0.5em, fill: black)
  Print on A#next_biggest_a_size paper for correct scaling
]

#set align(center + horizon)

#render-structure(
  json("box_lid.json"),
  ..structure_args,
  color: black,
  cut-stroke: (thickness: 1pt, paint: white, dash: "dashed"),
  fold-stroke: 0.3pt + gray,
  [
    //front
    #rotate(180deg)[
      #v(card_height * 0.4)
      #set text(size: 0.15em)
      #logo(banner: true)
    ]
  ],
  [
    //top
    #rotate(180deg)[
      #set text(size: 0.15em)
      #logo()
    ]
  ],
  [
    //left
    #set text(size: 0.1em)
    #place(
      center + horizon,
      dy: -8em,
    )[
      #logo()
    ]

    #place(
      center + bottom,
      dy: -23mm,
    )[
      #box(width: 100%, height: 6.3em, fill: gradient.linear(white, black))
    ]
  ],
  [
    //right
    #set text(size: 0.1em)
    #place(
      center + horizon,
      dy: -8em,
    )[
      #logo()
    ]

    #place(
      center + bottom,
      dy: -23mm,
    )[
      #box(width: 100%, height: 6.3em, fill: gradient.linear(black, white))
    ]
  ],
  [
    //back
    #set text(
      size: 0.18em,
      fill: white
    )
    #set align(left + top)
    #box(
      height: 45%,
      inset: (
        top: 3em,
        left: 3em,
        right: 3em
      )
    )[
      #set par(justify: true)
      #columns(2, gutter: 3em)[
        #text(size: 1.2em)[
          #outline_text
        ]
      ]
    ]
    #v(1fr)
    #box(
      inset: (
        left: 3em,
        right: 3em
      )
    )[
      3-#player_count players#h(1fr)Ages: 12+#h(1fr)Playtime: 30-60 min.#h(1fr)Contains: #card_amount cards
    ]
    #v(1fr)
    #set text(size: 0.8em)
    #set align(center)
    #icon_banner
    #v(23mm)

    #place(
      center + bottom,
      dy: -10mm,
      [
        Game of Intrigue - Version #version\
        Lyx Rothböck 2024\
      ]
    )
  ]
)