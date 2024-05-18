#import "data.typ": *
#import "render.typ": *

#let render_card(type, value: none, illegal: false, color: none, cut_guide: true, supertitle: none) = {
  let has_supertitle = supertitle != none and display_supertitle
  let is_role = supertitle == "Role"
  set text(font: "Inter Tight", weight: "medium")
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
          #v(-5em)
          #scale(
            origin: center + horizon,
            x: center_symbol_scale,
            y: center_symbol_scale,
            reflow: true,
          )[
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
                  inset: (right: 1em, left: 3em)
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
            size: 7em,
            weight: "extrabold",
            fill: white
          )[
            #if (value != none) {
              value
            } else if (type != "") {
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
              size: 7em,
              weight: "extrabold",
              fill: if (color != none) {color} else {black}
            )[
              #if (value != none) {
              value
            } else if (type != "") {
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
  set text(font: "Inter Tight", weight: "medium")
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
                #text(font: "Chivo Mono", fill: secret_gradient)[
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
                #text(font: "Chivo Mono", fill: secret_gradient)[
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