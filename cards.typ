#import "data.typ": *

// Functions
#let skew(angle, vscale: 1, body) = {
  let (a,b,c,d)= (1,vscale*calc.tan(angle),0,vscale)
  let E = (a + d)/2
  let F = (a - d)/2
  let G = (b + c)/2
  let H = (c - b)/2
  let Q = calc.sqrt(E*E + H*H)
  let R = calc.sqrt(F*F + G*G)
  let sx = Q + R
  let sy = Q - R
  let a1 = calc.atan2(F,G)
  let a2 = calc.atan2(E,H)
  let theta = (a2 - a1) /2
  let phi = (a2 + a1)/2
  
  set rotate(origin: bottom+center)
  set scale(origin: bottom+center)
  
  rotate(phi,scale(x: sx*100%, y: sy*100%,rotate(theta,body)))
}

#let render_card(type, value: none, illegal: false, color: none, cut_guide: true, role: none) = {
  let is_role = type == "Role" and role != none
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
        radius: card_radius - 0.5mm,
        stroke: 0.3em + if color == none { black } else { color },
        inset: 0.5em
      )[
        // Symbol
        #let symbol = icon(type, color: color, width: 2.5em, height: 2.5em, side_distance: 0em)
        #if (symbols.keys().contains(type) and symbols.at(type) != none) {
          place(
            top + left,
            dy: -0.2em
          )[
            #symbol
          ]
          
          place(
            bottom + right,
            dy: 0.2em
          )[
            #rotate(180deg)[
              #symbol
            ]
          ]
        }

        // Value
        #if (value != none) {
          place(
            top + right,
            dy: 0.2em
          )[
            #text(
              size: 2em,
              weight: "bold",
            )[
              #value
            ]
          ]
          
          place(
            bottom + left,
            dy: -0.2em
          )[
            #rotate(180deg)[
              #text(
                size: 2em,
                weight: "bold",
              )[
                #value
              ]
            ]
          ]
        }
        
        #let center_symbol_scale = if (is_role) {300%} else {500%}
        #grid(
          align: top + center,
          columns: 1,
          rows: (auto, auto, 1fr),
          [
            #v(if (is_role) {1em} else {2.5em})
            #text(
              weight: "extrabold",
              size: 2.5em
            )[
              #if (is_role) {
                text(type, size: 0.7em)
                v(-1em)
                role
              } else {
                type
              }
            ]
            #v(0.5em)
          ],
          // Center Symbol
          box(
          )[
            #scale(origin: center + horizon, x: center_symbol_scale, y: center_symbol_scale, reflow: true)[
              #rotate(0deg)[
                #symbol
              ]
            ]
          ],
          // Description
          box(
            width: 100%,
            height: 100% - 1em,
            clip: true,
          )[
            #place(top + center)[
              #line()
            ]
            #align(horizon)[
              #text(
              )[
                #show "[X]": it => if (value == none) {"VALUE_MISSING"} else {str(value)}
                #show "[C]": it => if (color == none) {"COLOR_MISSING"} else {color_to_string(color)}

                #show regex("Social( card(s?))"): it => {
                  set text(weight: "extrabold")
                  [ #icon("Social")#it]
                }
                #show regex("Standing(s?)( card(s?)?)?"): it => {
                  set text(weight: "extrabold")
                  [ #icon("Standing")#it]
                }
                #show regex("Pact(s?)( card(s?)?)?"): it => {
                  set text(weight: "extrabold")
                  [ #icon("Pact")#it]
                }
                #show regex("Asset(s?)( card(s?)?)?"): it => {
                  set text(weight: "extrabold")
                  [ #icon("Asset")#it]
                }
                #show regex("Influence(s?)( card(s?)?)?"): it => {
                  set text(weight: "extrabold")
                  [ #icon("Influence")#it]
                }
                #show regex("Testimony(s?)( card(s?)?)?"): it => {
                  set text(weight: "extrabold")
                  [ #icon("Testimony")#it]
                }
                #show regex("Role(s?)( card(s?)?)?"): it => {
                  set text(weight: "extrabold")
                  [ #icon("Role")#it]
                }
                #show regex("Color( Token)?"): it => {
                  set text(weight: "extrabold")
                  [ #icon("Token")#it]
                }
                #show regex("illegal((ly)|( card(s?)))?"): it => {
                  set text(weight: "bold", fill: white)
                   " " + box(it, fill: red, outset: 0.2em) + " "
                }

                #let desc = if (is_role) {
                  set align(top)
                  show regex("\[(Goal|Perk)\]"): it => text(weight: "extrabold", size: 1.5em)[
                    #v(0.5em)
                    #it.text.slice(1, -1)
                    #v(-0.5em)
                  ]
                  role_descriptions.at(role)
                } else {
                  descriptions.at(type)
                }
                #desc
                #if illegal {
                  "\nillegal"
                }
              ]
            ]
            #place(bottom + center)[
              #line()
            ]
          ]
        )



        // Illegal
        #place(
          center + horizon,
          dx: -0em,
          dy: 2.2em
        )[
          #skew(-skew_angle)[
            #rotate(-skew_angle, reflow: true)[
              #if (illegal) {
                text(
                  weight: "extrabold",
                  size: 2.5em
                )[
                  #box(
                    width: 100%,
                    height: 1em,
                    fill: white
                  )[
                    #box(
                      width: 100%,
                      height: 0.8em,
                      fill: red
                    )[
                      #text(
                        size: 0.35em,
                        fill: white
                      )[
                        #repeat("ILLEGAL")
                      ]
                    ]
                  ]
                ]
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
        stroke: if role { 0.3em + black } else { 0.2em + white },
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
    cards.push(render_card("Standing", value: standing_value))
    card_backs.push(render_card_back(value: standing_value))
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

  for card_data in colored_cards {
    cards.push(render_card(card_data.type, value: card_data.value, color: color, illegal: if card_data.keys().contains("illegal") {card_data.illegal} else {false}))
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
#for i in range(testimony_value_range.at(0), testimony_value_range.at(1) + 1) {
  for _ in range(testimony_copy_amount) {
    cards.push(render_card("Testimony", value: i))
    card_backs.push(render_card_back(value: i))
  }
}
#for role in role_descriptions.keys() {
  cards.push(render_card("Role", role: role))
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