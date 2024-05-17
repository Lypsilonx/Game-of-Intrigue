#import "data.typ": *

#let get_description(type, value, illegal, color, supertitle) = {
  let is_role = supertitle == "Role"
  show "[X]": it => if (value == none) {"VALUE_MISSING"} else {str(value)}
  show "_s": it => if (value == 1) {""} else {"s"}
  show "[C]": it => if (color == none) {"COLOR_MISSING"} else {color_to_string(color)}

  show regex("Social( card(s?))"): it => {
    set text(weight: "extrabold")
    [#icon("Social")#it]
  }
  show regex("Favour(s?)( card(s?))?"): it => {
    set text(weight: "extrabold")
    [#icon("Favour")#it]
  }
  show regex("Hook(s?)( card(s?))?"): it => {
    set text(weight: "extrabold")
    [#icon("Hook")#it]
  }
  show regex("Threat(s?)( card(s?))?"): it => {
    set text(weight: "extrabold")
    [#icon("Threat")#it]
  }
  show regex("Secret(s?)( card(s?))?"): it => {
    set text(weight: "extrabold")
    [#icon("Secret")#it]
  }
  show regex("Standing(s?)( card(s?)?)?"): it => {
    set text(weight: "extrabold")
    [#icon("Standing")#it]
  }
  show regex("Pact(s?)( card(s?)?)?"): it => {
    set text(weight: "extrabold")
    [#icon("Pact")#it]
  }
  show regex("Asset(s?)( card(s?)?)?"): it => {
    set text(weight: "extrabold")
    [#icon("Asset")#it]
  }
  show regex("Influence(s?)( card(s?)?)?"): it => {
    set text(weight: "extrabold")
    [#icon("Influence")#it]
  }
  show regex("Testimony(s?)( card(s?)?)?"): it => {
    set text(weight: "extrabold")
    [#icon("Testimony")#it]
  }
  show regex("Rebrand(s?)( card(s?)?)?"): it => {
    set text(weight: "extrabold")
    [#icon("Rebrand")#it]
  }
  show regex("Role(s?)( card(s?)?)?"): it => {
    set text(weight: "extrabold")
    [#icon("Role")#it]
  }
  show regex("Color( Token)?"): it => {
    set text(weight: "extrabold")
    [#icon("Token")#it]
  }
  show regex("illegal((ly)|( card((_?)s?)))?"): it => {
    set text(weight: "bold", fill: white)
      " " + box(it, fill: red, outset: 0.2em) + " "
  }

  if (is_role) {
    set align(top)
    show regex("\[(Goal|Perk)\]"): it => text(weight: "extrabold", size: 1.5em)[
      #v(0.5em)
      #it.text.slice(1, -1)
      #v(-0.5em)
    ]
    if (type == "") {
      " "
    } else {
      role_descriptions.at(type)
    }
  } else {
    descriptions.at(type)
  }
  if illegal {
    "\nillegal"
  }
}

#let generate_cards(render_card, render_card_back) = {
    // Cards
  let cards = ()
  let card_backs = ()
  for color in colors {
    for _ in range(standing_card_amount) {
      cards.push(render_card("Standing", value: standing_card_value))
      card_backs.push(render_card_back(value: standing_card_value))
    }
  }
  for color in colors {
    cards.push(render_card("Token", color: color))
    card_backs.push(render_card_back())
    cards.push(render_card("Pact", color: color))
    card_backs.push(render_card_back())
    for _ in range(player_count - 3) {
      cards.push(render_card("Pact", color: color, illegal: true))
      card_backs.push(render_card_back(illegal: true))
    }

    for card_data in social_cards {
      cards.push(render_card(card_data.type, value: card_data.value, color: color, illegal: if card_data.keys().contains("illegal") {card_data.illegal} else {false}, supertitle: "Social"))
      card_backs.push(render_card_back(value: card_data.value, illegal: if card_data.keys().contains("illegal") {card_data.illegal} else {false}))
    }
  }
  for value in range(asset_value_range.at(0), asset_value_range.at(1) + 1) {
    for _ in range(calc.ceil(asset_copy_amount / 2)) {
      cards.push(render_card("Asset", value: value))
      card_backs.push(render_card_back(value: value))
    }
  }
  for value in range(asset_value_range.at(0), asset_value_range.at(1) + 1) {
    for _ in range(calc.floor(asset_copy_amount / 2)) {
      cards.push(render_card("Asset", value: value, illegal: true))
      card_backs.push(render_card_back(value: value, illegal: true))
    }
  }
  for value in range(influence_value_range.at(0), influence_value_range.at(1) + 1) {
    for _ in range(influence_copy_amount) {
      cards.push(render_card("Influence", value: value))
      card_backs.push(render_card_back(value: value))
    }
  }
  for value in testimony_values {
    for _ in range(testimony_copy_amount) {
      cards.push(render_card("Testimony", value: value, supertitle: "Speech"))
      card_backs.push(render_card_back(value: value))
    }
  }
  for value in rebrand_values {
    for _ in range(rebrand_copy_amount) {
      cards.push(render_card("Rebrand", value: value, supertitle: "Speech"))
      card_backs.push(render_card_back(value: value))
    }
  }
  for value in defence_values {
    for _ in range(defence_copy_amount) {
      cards.push(render_card("Defence", value: value, supertitle: "Speech"))
      card_backs.push(render_card_back(value: value))
    }
  }
  for role in role_descriptions.keys() {
    cards.push(render_card(role, supertitle: "Role"))
    card_backs.push(render_card_back(role: true))
  }

  for _ in range(4) {
    cards.push(render_card("", supertitle: "Role"))
    card_backs.push(render_card_back(role: true))
  }

  return (cards, card_backs)
}

#let render_table_cutout(element, cut_gutter, side_distance, color: none, stroke_color: black, left_side: true, rotation: 270deg) = {
  let cells = (
    box(
      width: side_distance / 4,
      height: card_width,
      outset: if left_side {(left: cut_gutter)} else {(right: cut_gutter)},
      stroke: (
        top:(thickness: 0.1em, paint: stroke_color, dash: "dashed"),
        bottom:(thickness: 0.1em, paint: stroke_color, dash: "dashed"),
      ),
      fill: color
    ),
    [
      #place(center + horizon)[
        #box(
          fill: color,
          width: card_height,
          height: card_width,
          outset: (
            top: cut_gutter / 2,
            bottom: cut_gutter / 2,
            left: if left_side {cut_gutter} else {0mm},
            right: if left_side {0mm} else {cut_gutter}
          )
        )
      ]
      #place(center + horizon)[
        #box(
          width: card_height,
          height: card_width,
          stroke: (
            top:(thickness: 0.1em, paint: stroke_color, dash: "dashed"),
            bottom:(thickness: 0.1em, paint: stroke_color, dash: "dashed"),
            left: if left_side {(thickness: 0.1em, paint: stroke_color, dash: "dashed")} else {none},
            right: if left_side {none} else {(thickness: 0.1em, paint: stroke_color, dash: "dashed")}
          )   
        )
      ]
      #rotate(rotation,[#element], reflow: true)
    ]
  )

  if left_side {
    cells
  } else {
    cells.rev()
  }
}

#let render_single(render_card, render_card_back) = {
  let (cards, card_backs) = generate_cards(render_card, render_card_back)

  set page(
    width: card_width,
    height: card_height,
    margin: 0%,
  )

  set align(center + horizon)
  grid(columns: 1, ..cards.enumerate().map(it => {
    (
      it.at(1),
      card_backs.at(it.at(0))
    ).flatten()
  }
  ).flatten())
}

#let render_single_foldable(render_card, render_card_back) = {
  let (cards, card_backs) = generate_cards(render_card, render_card_back)

  set page(
    width: card_width,
    height: card_height * 2,
    margin: 0%,
  )

  set align(center + horizon)
  grid(columns: 1, ..cards.enumerate().map(it => {
    (
      rotate(180deg)[
        #card_backs.at(it.at(0))
      ],
      it.at(1)
    )
  }
  ).flatten())
}

#let render_foldable(render_card, render_card_back) = {
  let (cards, card_backs) = generate_cards(render_card, render_card_back)

  set page(
    "a4",
    margin: 0%,
  )

  set align(center + horizon)

  let cut_gutter = 1em
  let cut_gutter_2 = 1em
  let side_distance = 50% - card_height
  grid(rows: 4, columns: (side_distance, card_height, card_height, side_distance), row-gutter: cut_gutter_2, ..cards.enumerate().map(it => {
    let role_card = (cards.len() - it.at(0)) <= role_descriptions.len() + 4
    (
      render_table_cutout(it.at(1), cut_gutter_2, side_distance, rotation: 90deg),
      render_table_cutout(card_backs.at(it.at(0)), cut_gutter_2, side_distance, color: if role_card {none} else {black}, stroke_color: if role_card {black} else {white}, left_side: false)
    ).flatten()
  }
  ).flatten())
}

#let render_double_sided(render_card, render_card_back) = {
  let (cards, card_backs) = generate_cards(render_card, render_card_back)

  set page(
    "a4",
    margin: 0%,
  )

  set align(center + horizon)

  let cut_gutter = 1em
  let cut_gutter_2 = 1em
  let side_distance = 50% - card_height
  grid(rows: 4, columns: (side_distance, card_height, card_height, side_distance), row-gutter: cut_gutter_2, ..cards.enumerate().chunks(8).map(chunk => {
      for it in chunk {
        let role_card = (cards.len() - it.at(0)) <= role_descriptions.len() + 4
        render_table_cutout(it.at(1), cut_gutter_2, side_distance, left_side: calc.rem(it.at(0), 2) == 0)
      }
      for index in chunk.map(it => it.at(0)).chunks(2).map(it => it.rev()).flatten() {
        let card_back = card_backs.at(index)
        let role_card = (cards.len() - index) <= role_descriptions.len() + 4
        render_table_cutout(card_back, cut_gutter_2, side_distance, color: if role_card {none} else {black}, stroke_color: if role_card {black} else {white}, left_side: calc.rem(index, 2) == 1 )
      }
    }
  ).flatten())
}