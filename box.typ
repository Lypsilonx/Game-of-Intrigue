#import "data.typ": *

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

#let render_box(
  box_length,
  box_height,
  box_width,
  lid_height,
  color,
  front_face_content: [],
  under_lid_front_face_content: [],
  back_face_content: [],
  left_face_content: [],
  right_face_content: [],
  top_face_content: [],
  bottom_face_content: [],
  lid_front_content: [],
  glue_strip_width: 10mm,
  cut_stroke: (paint: white, thickness: 0.4mm, dash: "dashed"),
  fold_stroke: (paint: gray.transparentize(50%), thickness: 0.2mm),
  glue_color: gray.transparentize(50%),
) = {
  let glue_pattern = pattern(size: (30pt, 30pt))[
    #place[#box(fill: color, width: 100%, height: 100%)]
    #place(line(start: (5pt, 0%), end: (-5pt, 100%), stroke: 0.3mm + glue_color))
    #place(line(start: (15pt, 0%), end: (5pt, 100%), stroke: 0.3mm + glue_color))
    #place(line(start: (25pt, 0%), end: (15pt, 100%), stroke: 0.3mm + glue_color))
    #place(line(start: (35pt, 0%), end: (25pt, 100%), stroke: 0.3mm + glue_color))
  ]

  let glue_edge_left(size: glue_strip_width, cutin: glue_strip_width) = [
    #place(left + horizon)[
      #polygon(
        fill: glue_pattern,
        stroke: 0.3mm + black,
        (0%, 0%),
        (size, cutin),
        (size, 100% - cutin),
        (0%, 100%)
      )
    ]
    #place(left + horizon)[
      #line(
        start: (0%, 0%),
        end: (0%, 100%),
        stroke: fold_stroke
      )
    ]
    #place(left + top)[
      #line(
        start: (0%, 0%),
        end: (size, cutin),
        stroke: cut_stroke
      )
    ]
    #place(left + bottom)[
      #line(
        start: (0%, 100%),
        end: (size, 100% - cutin),
        stroke: cut_stroke
      )
    ]
    #place(left + top)[
      #line(
        start: (size, cutin),
        end: (size, 100% - cutin),
        stroke: cut_stroke
      )
    ]
  ]

  let glue_edge_right(size: glue_strip_width, cutin: glue_strip_width) = [
    #place(right + horizon)[
      #polygon(
        fill: glue_pattern,
        stroke: 0.3mm + black,
        (0%, cutin),
        (size, 0%),
        (size, 100%),
        (0%, 100% - cutin)
      )
    ]
    #place(right + horizon)[
      #line(
        start: (0%, 0%),
        end: (0%, 100%),
        stroke: fold_stroke
      )
    ]
    #place(right + top)[
      #line(
        start: (0%, cutin),
        end: (size, 0%),
        stroke: cut_stroke
      )
    ]
    #place(right + bottom)[
      #line(
        start: (0%, 100% - cutin),
        end: (size, 100%),
        stroke: cut_stroke
      )
    ]
    #place(right + top)[
      #line(
        start: (-size, cutin),
        end: (-size, 100% - cutin),
        stroke: cut_stroke
      )
    ]
  ]

  let glue_edge_bottom(size: glue_strip_width, cutin: glue_strip_width) = [
    #place(bottom + center)[
      #polygon(
        fill: glue_pattern,
        stroke: 0.3mm + black,
        (cutin, 0%),
        (100% - cutin, 0%),
        (100%, size),
        (0%, size)
      )
    ]
    #place(bottom + center)[
      #line(
        start: (0%, 0%),
        end: (100%, 0%),
        stroke: 0.3mm + white
      )
    ]
    #place(bottom + center)[
      #line(
        start: (0%, -size),
        end: (100% - cutin * 2, -size),
        stroke: cut_stroke
      )
    ]
    #place(left + bottom)[
      #line(
        start: (0%, size),
        end: (cutin, 0%),
        stroke: cut_stroke
      )
    ]
    #place(right + bottom)[
      #line(
        start: (100%, size),
        end: (100% - cutin, 0%),
        stroke: cut_stroke
      )
    ]
  ]

  let glue_edge_top(size: glue_strip_width, cutin: glue_strip_width) = [
    #place(top + center)[
      #polygon(
        fill: glue_pattern,
        stroke: 0.3mm + black,
        (0%, 0%),
        (100%, 0%),
        (100% - cutin, size),
        (cutin, size)
      )
    ]
    #place(top + center)[
      #line(
        start: (0%, 0%),
        end: (100%, 0%),
        stroke: fold_stroke
      )
    ]
    #place(top + center)[
      #line(
        start: (0%, size),
        end: (100% - cutin * 2, size),
        stroke: cut_stroke
      )
    ]
    #place(left + top)[
      #line(
        start: (0%, 0%),
        end: (cutin, size),
        stroke: cut_stroke
      )
    ]
    #place(right + top)[
      #line(
        start: (100%, 0%),
        end: (100% - cutin, size),
        stroke: cut_stroke
      )
    ]
  ]

  let front_face = box(
    fill: color,
    clip: true,
    width: 100%,
    height: 100%,
    stroke: (
      left: cut_stroke,
      right: cut_stroke,
      bottom: fold_stroke,
      top: fold_stroke
    ),
  )[
    #rotate(180deg)[
      #grid(
        columns: (1fr),
        rows: (lid_height, 1fr),
        under_lid_front_face_content,
        front_face_content
      )
    ]
  ]

  let lid_front = box(
    fill: color,
    clip: true,
    width: 100%,
    height: 100%,
    stroke: (
      top: cut_stroke
    ),
  )[
    #rotate(180deg)[
      #lid_front_content
    ]
  ]

  let back_face = box(
    fill: color,
    clip: true,
    width: 100%,
    height: 100%,
    stroke: fold_stroke,
  )[
    #back_face_content
  ]

  let left_face = box(
    fill: color,
    clip: true,
    width: 100%,
    height: 100%,
    stroke: (
      top: cut_stroke,
      bottom: cut_stroke,
    ),
  )[
    #left_face_content
  ]

  let lid_right = [
    #place(right + horizon)[
      #polygon(
        fill: color,
        (100%, 0%),
        (100% - lid_height, 0%),
        (100%, 100%),
      )
    ]
    #place(right + top)[#line(start: (100%, 0%), end: (100% - lid_height, 0%), stroke: cut_stroke)]
    #place(right + horizon)[#line(start: (100% - lid_height, 0%), end: (100%, 100%), stroke: cut_stroke)]
  ]

  let right_face = box(
    fill: color,
    clip: true,
    width: 100%,
    height: 100%,
    stroke: (
      top: cut_stroke,
      bottom: cut_stroke
    ),
  )[
    #right_face_content
  ]

  let lid_left = [
    #place(left + horizon)[
      #polygon(
        fill: color,
        (0%, 0%),
        (lid_height, 0%),
        (0%, 100%),
      )
    ]
    #place(left + top)[#line(start: (0%, 0%), end: (lid_height, 0%), stroke: cut_stroke)]
    #place(left + horizon)[#line(start: (lid_height, 0%), end: (0%, 100%), stroke: cut_stroke)]
  ]

  let top_face = box(
    fill: color,
    clip: true,
    width: 100%,
    height: 100%,
    stroke: (
      top: fold_stroke,
      right: fold_stroke,
      left: fold_stroke,
    ),
  )[
    #rotate(180deg)[
      #top_face_content
    ]
  ]

  let bottom_face = box(
    fill: color,
    clip: true,
    width: 100%,
    height: 100%,
  )[
    #bottom_face_content
  ]

  let fold_in = box(
    fill: color,
    width: 100%,
    height: 100%,
    stroke: (
      left: cut_stroke,
      right: cut_stroke,
      bottom: cut_stroke
    ),
  )

  let total_width = (box_width + box_length) * 2
  let total_height = (box_width + box_height + glue_strip_width) * 2 + lid_height

  let next_biggest_a_size = str(calculate_smallest_a_size(total_width, total_height))

  set page(
    fill: gray,
    "a" + next_biggest_a_size,
    flipped: true,
    margin: 0%,
  )

  place(top + center, dx: 5mm, dy: 5mm)[
    #set text(size: 2em, fill: black)
    Print on A#next_biggest_a_size paper for correct scaling
  ]

  set align(center + horizon)
  set text(size: 4em)
  grid(
    columns: (box_length / 2 ,box_width, box_length, box_width, box_length / 2),
    rows: (lid_height, box_width, box_height, box_width, box_height, glue_strip_width * 2),
    [],
    glue_edge_right(),
    lid_front,
    glue_edge_left(),
    [],
    [],
    lid_right,
    top_face,
    lid_left,
    [],
    glue_edge_right(size: 100%, cutin: 0mm),
    right_face,
    back_face,
    left_face,
    glue_edge_left(size: 100%, cutin: 0mm),
    [],
    glue_edge_right(size: box_height, cutin: 0mm),
    bottom_face,
    glue_edge_left(size: box_height, cutin: 0mm),
    [],
    [],
    [],
    front_face,
    [],
    [],
    [],
    [],
    fold_in,
    [],
    [],
  )
}

#set text(font: "Inter Tight", fill: white)
#let card_amount = card_count
#let card_thickness = 1mm
#render_box(
  card_thickness * card_amount, card_height + 5mm,
  card_width + 5mm,
  card_height * 0.4,
  black,
  front_face_content: [
    #set text(size: 0.15em)
    #place(
      center + horizon
    )[
      #logo(banner: true)
    ]
  ],
  top_face_content: [
    #set text(size: 0.15em)
    #place(
      center + horizon
    )[
      #logo()
    ]
  ],
  left_face_content: [
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
  right_face_content: [
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
  back_face_content: [
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

