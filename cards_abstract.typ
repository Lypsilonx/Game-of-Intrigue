#import "data.typ": *

#let render_card(type, value: none, illegal: false, color: none, cut_guide: true, supertitle: none) = {
  let has_supertitle = supertitle != none and display_supertitle
  let is_role = supertitle == "Role"
  set text(font: "Proxima Nova", weight: "medium")
  box(
    width: card_width,
    height: card_height,
    stroke: if cut_guide {(thickness: 0.1pt, dash: "dashed")} else {none},
    radius: card_cut_radius,
    clip: true,
  )[
    #align(center + horizon)[
      #box(
        width: 100% - 1em,
        height: 100% - 1em,
        radius: card_radius - 0.5mm
      )[
        // Color
        #place(
          center + top,
          dy: -0.5em
        )[
          #polygon(
            fill: if (color != none) {color} else {black}.transparentize(50%),
            (0%, 0%),
            (110%, 0%),
            (110%, 55%),
            (0%, 55%),
          )
        ]
        #place(center + horizon)[
          #polygon(
            fill: if (color != none) {color} else {black}.transparentize(50%),
            (0%, 0%),
            (110%, 0%),
            (0%, 110%)
          )
        ]
        #place(center + horizon)[
          #polygon(
            fill: if (color != none) {color} else {black}.transparentize(50%),
            (0%, 0%),
            (140%, 0%),
            (0%, 110%)
          )
        ]
        #place(center + horizon)[
          #polygon(
            fill: if (color != none) {color} else {black}.transparentize(50%),
            (0%, 0%),
            (250%, 0%),
            (0%, 110%)
          )
        ]

        // Symbol
        #let symbol_name = type
        #if (is_role) {
          symbol_name = "Role"
        }
        #let symbol_color = icon(symbol_name, color: color, width: 2.5em, height: 2.5em, side_distance: 0em)
        #let symbol = icon(symbol_name, color: white, color2: if type == "Standing" {white} else {black}, width: 2.5em, height: 2.5em, side_distance: 0em)
        
        #let center_symbol_scale = 400%
        #scale(origin: center + horizon, x: center_symbol_scale, y: center_symbol_scale, reflow: true)[
          #symbol
        ]
        #if type == "Standing" [
          #v(-1em)
          #scale(origin: center + horizon, x: center_symbol_scale, y: center_symbol_scale, reflow: true)[
            #rotate(180deg)[
              #symbol_color
            ]
          ]
        ]

        // Illegal
        #place(
          right + horizon,
          dy: -1.25em
        )[
          #rotate(-90deg, reflow: true)[
            #text(
              weight: "extrabold",
              size: 2.5em
            )[
              #box(
                width: 100% + 1em,
                height: 1em,
                fill: white
              )[
                #box(
                  width: 100%,
                  height: 0.8em,
                  inset: (right: 1em, left: 3em)
                )[
                  #text(
                    size: 0.35em,
                    fill: if (color != none) {color} else {black}
                  )[
                    #if (illegal) {
                      repeat("ILLEGAL")
                    }
                  ]
                ]
              ]
            ]
          ]
        ]

        // Type
        #place(
          left + horizon,
          dy: -1.25em
        )[
          #rotate(90deg, reflow: true)[
            #text(
              weight: "extrabold",
              size: 2.5em
            )[
              #box(
                width: 100% + 1em,
                height: 1em,
                fill: if (color != none) {color} else {black}
              )[
                #box(
                  width: 100%,
                  height: 0.8em,
                  inset: if (value != none or type != "Standing") {(right: 1em, left: 3em)} else {(right: 1em, left: 1em)}
                )[
                  #rotate(180deg, reflow: true)[
                    #text(
                      size: 0.35em,
                      fill: white
                    )[
                      #if (has_supertitle) [
                        #text(
                          size: 0.8em
                        )[
                          #upper(supertitle)
                        ]#h(0.5em)
                      ]
                      #upper(type)
                    ]
                  ]
                  // Accessiblity stripes
                  #let thickness = 0.1em
                  #place(
                    horizon + right,
                    dy: -0.1em,
                    dx: 0.5em
                  )[
                    #rotate(-90deg, reflow: true)[
                      #if colors.contains(color) {
                        for i in range(colors.position(e => e == color) + 1) {
                          if (calc.rem(i, 2) == 0) {
                            v(thickness * 2, weak: true)
                          }

                          box(
                            width: 1em,
                            height: thickness,
                            fill: white
                          )
                          v(thickness, weak: true)
                        }
                      }
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]

        // Value
        #place(
          top + left,
          dy: 0.2em
        )[
          #text(
            size: 8em,
            weight: "extrabold",
            fill: white
          )[
            #if (value != none) {
              value
            } else if (type != "Standing") {
              type.at(0)
            }
          ]
        ]
        
        #place(
          bottom + right,
          dy: -0.2em
        )[
          #rotate(180deg)[
            #text(
              size: 8em,
              weight: "extrabold",
              fill: if (color != none) {color} else {black}
            )[
              #if (value != none) {
              value
            } else if (type != "Standing") {
              type.at(0)
            }
            ]
          ]
        ]
      ]
    ]
  ]
}

#let render_card_back(value: none, illegal: false, cut_guide: true, role: false) = {
  set text(font: "Proxima Nova", weight: "medium")
  box(
    width: card_width,
    height: card_height,
    stroke: if cut_guide {(thickness: 0.1pt, dash: "dashed")} else {none},
    radius: card_cut_radius,
    clip: true,
    fill: if role {white} else {black},
  )[
    #align(center + horizon)[
      #box(
        width: 100% - 1em,
        height: 100% - 1em,
        radius: card_radius - 0.5mm,
        stroke: 1em + if role { white } else { black },
        inset: (left: 0.5em, right: 0.5em, top: -0.5em, bottom: -0.5em),
        clip: true
      )[
        // Illegal
        #place(
          center + horizon,
          dx: -1.2em,
        )[
          #v(-0.8em)
          #rotate(-skew_angle)[
            #skew(-skew_angle)[
              #text(
                weight: "extrabold",
                size: 0.358em
              )[
                #set align(center + top)
                #let secret_gradient = if role { gradient.linear(..colors, angle: 45deg, relative: "parent")} else { white }
                #v(2.5em)
                #text(font: "Monaco", fill: secret_gradient)[
                  #repeat("GAME OF INTRIGUE")
                  #repeat("OF INTRIGUE GAME")
                  #repeat("INTRIGUE GAME OF")
                  #repeat("GAME OF INTRIGUE")
                  #repeat("OF INTRIGUE GAME")
                  #repeat("INTRIGUE GAME " + if (value == none or value == 0) {"OF"} else { if (value < 10) {"0"} + str(value)})
                  #repeat("GAME OF INTRIGUE")
                  #repeat("OF INTRIGUE GAME")
                  #repeat("INTRIGUE GAME OF")
                  #repeat("GAME OF INTRIGUE")
                  #repeat("OF INTRIGUE GAME")
                  #repeat("INTRIGUE GAME OF")
                ]
                #v(2em, weak: true)
                #text(
                  weight: "extrabold",
                  size: 5em,
                  fill: if role {black} else {white}
                )[
                  GAME
                  #text(
                    weight: "bold",
                    size: 0.8em
                  )[
                    #h(-0.2em)
                    of
                  ]
                  INTRIGUE
                ]
                #v(2em, weak: true)
                #text(font: "Monaco", fill: secret_gradient)[
                  #repeat("GAME OF INTRIGUE")
                  #repeat("OF INTRIGUE GAME")
                  #repeat("INTRIGUE GAME OF")
                  #repeat(if (illegal) {"GAME OF ILLEGALE"} else {"GAME OF INTRIGUE"})
                  #repeat("OF INTRIGUE GAME")
                  #repeat("INTRIGUE GAME OF")
                  #repeat("GAME OF INTRIGUE")
                  #repeat("OF INTRIGUE GAME")
                  #repeat("INTRIGUE GAME OF")
                  #repeat("GAME OF INTRIGUE")
                  #repeat("OF INTRIGUE GAME")
                  #repeat("INTRIGUE GAME OF")
                  #repeat("GAME OF INTRIGUE")
                  #repeat("OF INTRIGUE GAME")
                  #repeat("INTRIGUE GAME OF")
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  ]
}


// Cards
#let cards = ()
#let card_backs = ()
#for color in colors {
  for _ in range(standing_card_amount) {
    cards.push(render_card("Standing"))
    card_backs.push(render_card_back())
  }
}
#for color in colors {
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
#for value in range(asset_value_range.at(0), asset_value_range.at(1) + 1) {
  for _ in range(calc.ceil(asset_copy_amount / 2)) {
    cards.push(render_card("Asset", value: value))
    card_backs.push(render_card_back(value: value))
  }
}
#for value in range(asset_value_range.at(0), asset_value_range.at(1) + 1) {
  for _ in range(calc.floor(asset_copy_amount / 2)) {
    cards.push(render_card("Asset", value: value, illegal: true))
    card_backs.push(render_card_back(value: value, illegal: true))
  }
}
#for value in range(influence_value_range.at(0), influence_value_range.at(1) + 1) {
  for _ in range(influence_copy_amount) {
    cards.push(render_card("Influence", value: value))
    card_backs.push(render_card_back(value: value))
  }
}
#for value in testimony_values {
  for _ in range(testimony_copy_amount) {
    cards.push(render_card("Testimony", value: value, supertitle: "Speech"))
    card_backs.push(render_card_back(value: value))
  }
}
#for value in rebrand_values {
  for _ in range(rebrand_copy_amount) {
    cards.push(render_card("Rebrand", value: value, supertitle: "Speech"))
    card_backs.push(render_card_back(value: value))
  }
}
#for value in defence_values {
  for _ in range(defence_copy_amount) {
    cards.push(render_card("Defence", value: value, supertitle: "Speech"))
    card_backs.push(render_card_back(value: value))
  }
}
#for role in role_descriptions.keys() {
  cards.push(render_card(role, supertitle: "Role"))
  card_backs.push(render_card_back(role: true))
}

// Render
#set page(
  "a4",
  // width: (card_width + cut_gutter) * cards_on_page.at(0) + cut_gutter,
  // height: (card_height + cut_gutter) * cards_on_page.at(1) + cut_gutter,
  margin: 0%,
)

#set align(center + horizon)

// #let cards_on_page = (3, 3)
// #let cut_gutter = 1em
// #grid(rows: cards_on_page.at(1), columns: cards_on_page.at(0), gutter: cut_gutter, ..cards)
// #pagebreak()
// #grid(rows: cards_on_page.at(1), columns: cards_on_page.at(0), gutter: cut_gutter, ..card_backs)

#let cards_on_page = (2, 4)
#let cut_gutter = 1em
#set page(background: [
  #place(center + horizon)[
    #box(width: card_height * 2, height: 100%, stroke: (thickness: 0.1pt, dash: "dashed"), fill: white)
  ]
  #place(center + horizon)[
    #box(width: 100%, height: card_width * cards_on_page.at(1), stroke: (thickness: 0.1pt, dash: "dashed"), fill: white)
  ]
])
#grid(rows: cards_on_page.at(1), columns: cards_on_page.at(0), ..cards.enumerate().map(it => (
  rotate(90deg,[#it.at(1)], reflow: true),
  rotate(270deg,[#card_backs.at(it.at(0))], reflow: true)
)).flatten())