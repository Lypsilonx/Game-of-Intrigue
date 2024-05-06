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

#let card_width = 2.5in
#let card_height = 3.5in
#let skew_angle = 6deg

#let render_card(type, value: none, illegal: false, color: none, cut_guide: true) = {
  set text(font: "Proxima Nova", weight: "medium")
  box(
    width: card_width,
    height: card_height,
    stroke: if cut_guide {(thickness: 0.1pt, dash: "dashed")} else {none},
    radius: 3.5mm,
    clip: true,
  )[
    #align(center + horizon)[
      #box(
        width: 100% - 1em,
        height: 100% - 1em,
        radius: 3mm,
        stroke: 0.3em + if color == none { black } else { color },
        inset: 0.5em
      )[
        // Symbol
        #if (symbols.keys().contains(type) and symbols.at(type) != none) {
          let symbol = image.decode(read("icons/" + symbols.at(type))
          .replace("rgb(0,0,0)", if color == none { gray.to-hex() } else { "rgb(0,0,0)" })
          .replace("rgb(254,255,254)", if color == none { black } else { color }.to-hex()), width: 2.5em, height: 2.5em)

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
          
          place(
            center + horizon,
            dy: -1.5em
          )[
            #scale(origin: center + horizon, x: 500%, y: 500%)[
              #rotate(0deg)[
                #symbol
              ]
            ]
          ]
        }

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

        #set align(center + top)
        #v(2.5em)
        #text(
          weight: "extrabold",
          size: 2.5em
        )[
          #type
        ]

        // Description
        #v(35%)
        #box(
          width: 100%,
          height: 25%,
          clip: true,
        )[
          #place(top + center)[
            #line()
          ]
          #align(horizon)[
            #text(
              fill: black.transparentize(40%)
            )[
              #let desc = descriptions.at(type)
              #if value != none {
                desc = desc.replace("[X]", str(value))
              }
              #if color != none {
                desc = desc.replace("[C]", color_to_string(color))
              }
              #desc
              #if illegal {
                "\n(illegal)"
              }
            ]
          ]
          #place(bottom + center)[
            #line()
          ]
        ]
      ]
    ]
  ]
}

#let render_card_back(value: none, illegal: false, cut_guide: true) = {
  set text(font: "Proxima Nova", weight: "medium")
  box(
    width: card_width,
    height: card_height,
    stroke: if cut_guide {(thickness: 0.1pt, dash: "dashed")} else {none},
    radius: 3.5mm,
    clip: true,
  )[
    #align(center + horizon)[
      #box(
        width: 100% - 1em,
        height: 100% - 1em,
        radius: 3mm,
        stroke: 0.3em + black,
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
                #let secret_gradient = gradient.linear(..colors, angle: 45deg, relative: "parent")
                #v(2.5em)
                #text(font: "Monaco", fill: secret_gradient)[
                  #repeat("GAME OF INTRIGUE")
                  #repeat("OF INTRIGUE GAME")
                  #repeat("INTRIGUE GAME OF")
                  #repeat("GAME OF INTRIGUE")
                  #repeat("OF INTRIGUE GAME")
                  #repeat("INTRIGUE GAME " + if (value == none) {"OF"} else { if (value < 10) {"0"} + str(value)})
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
                  size: 5em
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
                  #repeat(if (illegal) {"GAME OF ILLEGALE"} else {"GAME OF INLEGALE"})
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
    cards.push(render_card("Standing", value: 10))
    card_backs.push(render_card_back(value: 10))
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
  cards.push(render_card("Favour", value: 8, color: color))
  card_backs.push(render_card_back())
  cards.push(render_card("Favour", value: 9, color: color, illegal: true))
  card_backs.push(render_card_back(illegal: true))
  cards.push(render_card("Hook", value: 7, color: color, illegal: true))
  card_backs.push(render_card_back(illegal: true))
  cards.push(render_card("Hook", value: 8, color: color, illegal: true))
  card_backs.push(render_card_back(illegal: true))
  cards.push(render_card("Threat", value: 7, color: color, illegal: true))
  card_backs.push(render_card_back(illegal: true))
  cards.push(render_card("Threat", value: 8, color: color, illegal: true))
  card_backs.push(render_card_back(illegal: true))
  cards.push(render_card("Secret", value: 7, color: color))
  card_backs.push(render_card_back())
  cards.push(render_card("Secret", value: 9, color: color, illegal: true))
  card_backs.push(render_card_back(illegal: true))
}
#for i in range(asset_copy_amount * 9) {
  cards.push(render_card("Asset", value: calc.rem(i, 9) + 1))
  card_backs.push(render_card_back(value: calc.rem(i, 9) + 1))
  cards.push(render_card("Asset", value: calc.rem(i, 9) + 1, illegal: true))
  card_backs.push(render_card_back(value: calc.rem(i, 9) + 1, illegal: true))
}
#for i in range(influence_copy_amount * 4) {
  cards.push(render_card("Influence", value: calc.rem(i, 4) + 2))
  card_backs.push(render_card_back(value: calc.rem(i, 4) + 2))
}
#for i in range(testimony_copy_amount * 3) {
  cards.push(render_card("Testimony", value: calc.rem(i, 3) + 7))
  card_backs.push(render_card_back(value: calc.rem(i, 3) + 7))
}

// Render
#let cards_on_page = (3, 3)
#let cut_gutter = 1em

#set page(
  "a4",
  // width: (card_width + cut_gutter) * cards_on_page.at(0) + cut_gutter,
  // height: (card_height + cut_gutter) * cards_on_page.at(1) + cut_gutter,
  margin: 0%,
)

#set align(center + horizon)
#grid(rows: cards_on_page.at(1), columns: cards_on_page.at(0), gutter: cut_gutter, ..cards)
#pagebreak()
#grid(rows: cards_on_page.at(1), columns: cards_on_page.at(0), gutter: cut_gutter, ..card_backs)