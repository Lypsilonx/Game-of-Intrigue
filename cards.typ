#import "data.typ": *
#import "render.typ": *

#let render_card(type, value: none, illegal: false, color: none, supertitle: none) = {
  let has_supertitle = supertitle != none and display_supertitle
  let is_role = supertitle == "Role"
  set text(font: "Inter Tight", weight: "medium")
  box(
    width: card_width,
    height: card_height,
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
        // Accessiblity stripes
        #let thickness = 0.3em
        #place(
          top + left,
          dy: 2em,
          dx: -1em
        )[
          #if colors.contains(color) {
            for i in range(colors.position(e => e == color) + 1) {
              if (calc.rem(i, 2) == 0) {
                v(thickness * 2, weak: true)
              }

              box(
                width: 10%,
                height: thickness,
                fill: white
              )
              v(thickness, weak: true)
            }
          }
        ]

        #place(
          bottom + right,
          dy: -2em,
          dx: 1em
        )[
          #rotate(180deg)[
            #if colors.contains(color) {
              for i in range(colors.position(e => e == color) + 1) {
                if (calc.rem(i, 2) == 0) {
                  v(thickness * 2, weak: true)
                }

                box(
                  width: 10%,
                  height: thickness,
                  fill: white
                )
                v(thickness, weak: true)
              }
            }
          ]
        ]

        // Symbol
        #let symbol_name = type
        #if (is_role) {
          symbol_name = "Role"
        }
        #let symbol = icon(symbol_name, color: color, width: 2.5em, height: 2.5em, side_distance: 0em)
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
            #v(if (has_supertitle) {1em} else {2.5em})
            #text(
              weight: "extrabold",
              size: 2.5em
            )[
              #if (has_supertitle) {
                text(supertitle, size: 0.7em)
                v(-1em)
              }
              #if (type == "") {
                " "
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
                #get_description(type, value, illegal, color, supertitle)
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

#let render_card_back(value: none, illegal: false, role: false) = {
  set text(font: "Inter Tight", weight: "medium")
  box(
    width: card_width,
    height: card_height,
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

// Render
#render(if sys.inputs.keys().contains("render_type") {sys.inputs.render_type} else {"single"}, render_card, render_card_back)