#import "data.typ": *

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

#let render(render_card, render_card_back) = {
  let (cards, card_backs) = generate_cards(render_card, render_card_back)

  set page(
    "a4",
    // width: (card_width + cut_gutter) * cards_on_page.at(0) + cut_gutter,
    // height: (card_height + cut_gutter) * cards_on_page.at(1) + cut_gutter,
    margin: 0%,
  )

  set align(center + horizon)

  let cut_gutter = 1em
  let cut_gutter_2 = 1em
  set page(background: [
    #locate(
      loc => {
        if loc.page() < counter(page).final().at(0) - ((role_descriptions.len() + 4)/ 4) + 1 {
          place(center + horizon, dx: 25%)[
            #box(fill: black, height: 100%, width: 50%)
          ]
        }
      }
    )
  ])
  let side_distance = 50% - card_height
  grid(rows: 4, columns: (side_distance, card_height, card_height, side_distance), row-gutter: cut_gutter_2, ..cards.enumerate().map(it => {
      let role_card = (cards.len() - it.at(0)) <= role_descriptions.len() + 4
      (
      box(
        width: side_distance / 4,
        height: card_width,
        stroke: (
          top:(thickness: 0.1em, dash: "dashed"),
          bottom:(thickness: 0.1em, dash: "dashed"),
        )
      ),
      box(
        stroke: (
          top:(thickness: 0.1em, dash: "dashed"),
          bottom:(thickness: 0.1em, dash: "dashed"),
          left:(thickness: 0.1em, dash: "dashed"),
        )
      )[
        #rotate(90deg,[#it.at(1)], reflow: true)
      ],
      box(
        stroke: (
          top:(thickness: 0.1em, paint: if role_card {black} else {white}, dash: "dashed"),
          bottom:(thickness: 0.1em, paint: if role_card {black} else {white}, dash: "dashed"),
          right:(thickness: 0.1em, paint: if role_card {black} else {white}, dash: "dashed"),
        )
      )[
        #rotate(270deg,[#card_backs.at(it.at(0))], reflow: true)
      ],
      box(
        width: side_distance / 4,
        height: card_width,
        stroke: (
          top:(thickness: 0.05em, paint: if role_card {black} else {white}, dash: "dashed"),
          bottom:(thickness: 0.05em, paint: if role_card {black} else {white}, dash: "dashed"),
        )
      ),
    )
  }
  ).flatten())
}