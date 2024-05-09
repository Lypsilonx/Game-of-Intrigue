#import "data.typ": *
#import "cards.typ": *

#show heading.where(level: 1): it => {
  if it.level == 1 {
    set text(size: 2em)
    v(1em, weak: true)
  } else if it.level == 2 {
    set text(size: 1.5em)
  }
  it
}

#set heading(numbering: "1.")
#show outline.entry: it => {
  if it.level == 1 {
    v(1.2em, weak: true)
  }
  strong(it)
}

#set page(
  "a5",
  footer: [
    #locate(
      loc => {
        if loc.page() != 1 {
          if (calc.odd(loc.page())) {
              place(right, counter(page).display("1"));
            } else {
              place(left, counter(page).display("1"));
            }
          place(center, [Game of Intrigue])
        }
      }
    )
  ]
)
#set text(font: "Proxima Nova")

#show regex("Standing( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<standing>, [#icon("Standing")#it])
}

#show regex("Role(s)?( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<roles>, [#icon("Role")#it])
}

#show regex("Pact( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<pact>, [#icon("Pact", color: gray)#it])
}

#show regex("Asset( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<asset>, [#icon("Asset")#it])
}

#show regex("Influence( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<influence>, [#icon("Influence")#it])
}

#show regex("(Social)( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<social>, [#icon("Social", color: gray)#it])
}

#show regex("(Favour)( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<social>, [#icon("Favour", color: gray)#it])
}

#show regex("(Hook)( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<social>, [#icon("Hook", color: gray)#it])
}

#show regex("(Threat)( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<social>, [#icon("Threat", color: gray)#it])
}

#show regex("(Secret)( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<social>, [#icon("Secret", color: gray)#it])
}


#show regex("Testimony( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<testimony>, [#icon("Testimony")#it])
}

#show regex("(Color(ed)?( card(s)?)?|Color Token(s)?)"): it => {
  let gradient_colors = colors * 3
  let color_gradient = gradient.linear(..gradient_colors, relative: "parent")

  [
    #set text(weight: "bold", fill: color_gradient)
    #link(<colored>, [#box(icon("Token", color: gray))#it])
  ]
}

#show regex("(t|T)rade(d|s?)"): it => {
  set text(weight: "bold")
  link(<trade>, it)
}

#show regex("(i|I)llegal((ly)|( card(s?)))?"): it => {
  set text(weight: "bold", fill: white)
  link(<illegal>, " " + box(it, fill: red, outset: 0.2em) + " ")
}

#show regex("draw pile"): it => {
  set text(weight: "bold")
  it
}

#show regex("discard pile"): it => {
  set text(weight: "bold")
  it
}

#show regex("personal pile"): it => {
  set text(weight: "bold")
  link(<setup>, it)
}

#show regex("Visible on back"): it => {
  set text(weight: "bold")
  link(<visible_on_back>, it)
}

#show regex("pay a fine"): it => {
  set text(weight: "bold")
  link(<fine>, it)
}

#show regex("announced"): it => {
  set text(weight: "bold")
  link(<announcement>, it)
}

#show regex("remove.*from the game"): it => {
  set text(weight: "bold")
  link(<removed_from_game>, it)
}

#show regex("legality.*check(ed|s)?"): it => {
  set text(weight: "bold")
  link(<legality_check>, it)
}
#box(
  width: 100%,
  height: 100%,
  fill: black,
  radius: 0.5em,
  outset: 5em,
)
#place(
  center + horizon,
  dx: -0.5em,
  dy: -5em
)[
  #rotate(-skew_angle)[
    #skew(-skew_angle)[
      #text(
        weight: "extrabold",
        size: 5em,
        fill: white
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
      ]\
      #text(
        weight: "extrabold",
        size: 2em,
        fill: white
      )[
      a game about\ being an asshole
      ]
      #v(2em)
      #box(
        width: 150%
      )[
        #grid(
          rows: 1,
          columns: (1fr) * 7,
          fill: white,
        )[
          #icon("Pact", width: 5em, height: 5em, color: red)
          #icon("Asset", width: 5em, height: 5em, color: orange)
          #icon("Influence", width: 5em, height: 5em, color: yellow)
          #icon("Social", width: 5em, height: 5em, color: green)
          #icon("Testimony", width: 5em, height: 5em, color: blue)
          #icon("Role", width: 5em, height: 5em, color: purple)
        ]
      ]
    ]
  ]
]
#pagebreak()
#text(size: 3em, weight: "bold")[
  Game of Intrigue
]
#outline(title: "Chapters", indent: auto)

#pagebreak()
= The Game <the_game>

== Outline <outline>
In the game of intrigue you compete against at least two other players.

You draw cards and trade them with other players to gain an advantage.\
The most important cards are the Standing cards. If you loose all your Standing
cards you are eliminated. You can play it safe and try to stay in the game or
you can take risks and try to eliminate other players.

You win when everyone except you and another player is eliminated and you have the most combined card value OR by fulfilling a special role condition.

== Setup <setup>
Separate the Standing cards from the rest.\
Each player gets #standing_card_amount Standing cards. The rest are removed from the game.

Separate the Colored and Role cards from the rest.\
Each player is assigned a Color Token and gets a personal pile of their respective Colored cards. The color token is put on the table in front of the player visible to everyone.\
// The remaining Colored cards are removed from the game.
The Role cards are shuffled and each player is dealt one to the *bottom* of their personal pile.

Mix the rest of the cards into the draw pile. Each player can now draw a total
of #hand_card_amount cards from the draw pile or their personal pile or a mix of both.

#pagebreak()
== Phases <phases>
Each round all players go through these phases:

=== Discussion <discussion>
- Players can openly or secretly (other room or with paper notes or messenger
  etc.) discuss the following round or future strategies.
- Lying and manipulation are allowed
=== Trade <trade>
- Everyone gets a Chance to Trade one card with a player of their choosing.
- A trade happens between two players:
  1. Each trading player…
    1. …Offers a card
    2. …Looks at the offered card
    3. …Decides if they want to trade
  2. If any player wants to object to the trade they can now do so. Upon an accusation the legality of the traded cards is checked.
  3. If both parties decided to trade they each keep the card offered to them
=== Announcement <announcement>
1. Each player puts one card face down in front of them
2. If anyone wants to announce their card they turn it around for everyone to see
3. Announcements get resolved (See Social cards and Testimony cards)
4. All the cards in front of the players get put on the discard pile
=== Vote <vote>
- Vote for someone to discard 1 Standing
  - On a draw no one has to discard Standing
#pagebreak()
=== Draw <draw>
- Each player draws a new card from the draw pile or their personal pile
- If the draw pile is empty mix the discard pile into it

If a player has 0 Standing they *loose* and have to decide where they want to
put their cards:
- on the discard pile
- into a player hand (inheritance)
  - the chosen player must discard the amount of cards they received

If only two players are left the player with the most combined card value
*wins*.

#linebreak()
Tip: Keep your cards hidden as long as possible.\ You almost never have to show your cards to other players (see Visible on back).

#pagebreak()
= Cards <cards>
== Standing <standing>
*_(10X)_*
- Loose condition is met when all Standing is lost
== Pact <pact>
*_(C, I?, 0X)_*
- Can only be traded for another Pact card
- You can only trade with Pact cards of your color
- Cannot be discarded unless traded illegally
- If you have someone else's Pact card you cannot use a social card on them or object
  to their trades
== Asset <asset>
*_(I?, 1-9X)_*
== Influence <influence>
*_(I?, 2-5X)_*
- You cannot deny to trade for this card (except if you offered a Pact)
== Social <social>
*_(C, I?, 7-9X)_*
- Can be a Secret, Hook, Threat or Favour
- Can be announced to make the player with that Color…
  - Favour: Trade with you now
    - Follow the steps in the Trade phase
  - Hook: Vote for the same person as you
    - If two of the same Color are played the player can decide between those players
      votes
  - Threat: Not vote
  - Secret: Loose 1 Standing
== Testimony <testimony>
*_(I?, 7-9X)_*
- When Announced you are immune to social cards with less or equal value this
  Announcement phase
== Roles <roles>
Roles can be obtained by drawing all the cards from your personal pile.\
Roles come in two types:
- *Goal*: You win if you fulfill a specific condition
- *Perk*: You get a special ability

= Card properties <card_properties>
== Illegal (I) <illegal>
- Relevant during legality checks in the Trade phase
- Visible on back
== Colored (C) <colored>
- Belongs to a specific player
== Value (X) <value>
- A Number from 0-10 (0 is not shown on the card)
- Visible on back

= Card amounts <card_amounts>
#linebreak()
#grid(
  columns: 2,
  gutter: 1em,
  [
    - #player_count Color Tokens
    - #role_card_amount x Role (0X)
    - Each Color (#player_count times):\
      - #standing_card_amount Standing (10X)
      - 1 x Pact (0X)
      - #(player_count - 3) x Pact (illegal, 0X)
      - Favour (8X)
      - Favour (illegal, 9X)
      - Hook (illegal, 7X)
      - Hook (illegal, 8X)
      - Threat (illegal, 7X)
      - Threat (illegal, 8X)
      - Secret (7X)
      - Secret (illegal, 9X)
    - #(asset_copy_amount * 9) x Asset (1-9X)
    - #(asset_copy_amount * 9) x Asset (1-9X, illegal)
    - #(influence_copy_amount * 4) x Influence (2-5X)
    - #(testimony_copy_amount * 3) x Testimony (7-9X)
  ],
  [
    #let colored_card_count = player_count * (standing_card_amount + 1 + (player_count - 3) + (4 * 2))
    #let non_colored_card_count = asset_copy_amount * 9 * 2 + influence_copy_amount * 4 + testimony_copy_amount * 3
    #let card_count = colored_card_count + non_colored_card_count + player_count + role_card_amount
    #text[
      Color Tokens: #player_count\
      Roles: #role_card_amount\
      #linebreak()
      #linebreak()
      #linebreak()
      #linebreak()
      #linebreak()
      #linebreak()
      #linebreak()
      #linebreak()
      #linebreak()
      #linebreak()
      Colored cards: #(colored_card_count/player_count) per player\ ( = #colored_card_count)\
      #linebreak()
      #linebreak()
      #linebreak()
      Non-colored cards: #non_colored_card_count\
      #line()
      Total cards: #card_count
    ]
  ]
)


= Vocabulary <vocabulary>
== Legality check <legality_check>
1. If any traded card is illegal:
  1. Anyone who agreed to the trade will have to pay a fine of the combined
    value of all the illegal cards offered to the accuser
  2. If any illegal Pact was found to be offered remove them from the game (do not
    put them on the discard pile)
  3. The trade does not happen; Everyone keeps their offered cards
2. If no card is illegal:
  1. The accusing player will have to pay a fine of 5 to any of the accused
  2. The trade goes on

== Paying a fine (of X) <fine>
You have to give a card of at least the value X to another player. If you cannot
pay, you have to discard a Standing

== Visible on Back <visible_on_back>
- The small text on the back of the card contains the card's value and if it is illegal

#let card_example_scale = 70%
#grid(
  columns: (card_width * card_example_scale, card_width * card_example_scale),
  rows: (card_height *card_example_scale, auto),
  align: center,
  column-gutter: 2em,
  row-gutter: 0.5em,
  [
    #place(
      scale(card_example_scale, reflow: true)[
        #render_card_back(value: 99, illegal: true, cut_guide: false)
      ]
    )
    #place(
      dx: 3.85em * card_example_scale,
      dy: 4.05em * card_example_scale,
    )[
      #rotate(-skew_angle)[
        #skew(-skew_angle)[
          #rect(stroke: 0.1em * card_example_scale + red, width: 0.7em * card_example_scale, height: 0.7em * card_example_scale)
        ]
      ]
    ]
    #place(
      dx: 6.17em * card_example_scale,
      dy: 15.37em * card_example_scale,
    )[
      #rotate(-skew_angle)[
        #skew(-skew_angle)[
          #rect(stroke: 0.1em * card_example_scale + red, width: 2em * card_example_scale, height: 0.7em * card_example_scale)
        ]
      ]
    ]
  ],
  [
    #place(
      scale(card_example_scale, reflow: true)[
        #render_card_back(cut_guide: false)
      ]
    )
    #place(
      dx: 3.85em * card_example_scale,
      dy: 4.05em * card_example_scale,
    )[
      #rotate(-skew_angle)[
        #skew(-skew_angle)[
          #rect(stroke: 0.1em * card_example_scale + red, width: 0.7em * card_example_scale, height: 0.7em * card_example_scale)
        ]
      ]
    ]
    #place(
      dx: 6.17em * card_example_scale,
      dy: 15.37em * card_example_scale,
    )[
      #rotate(-skew_angle)[
        #skew(-skew_angle)[
          #rect(stroke: 0.1em * card_example_scale + red, width: 2em * card_example_scale, height: 0.7em * card_example_scale)
        ]
      ]
    ]
  ],
  [Value: 99, Illegal],
  [No Value, Legal]
)


== Removed from the game <removed_from_game>
- Put them back in the box