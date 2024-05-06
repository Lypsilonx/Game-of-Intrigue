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

#show regex("([0-9]* )?Standing( card(s)?)?"): it => {
  let icon = image.decode(read("icons/" + symbols.at("Standing")).replace("rgb(254,255,254)", black.to-hex()), width: 1em, height: 0.5em)

  set text(weight: "bold")
  link(<standing>, [#box(icon)#it])
}

#show regex("Pact( card(s)?)?"): it => {
  let icon = image.decode(read("icons/" + symbols.at("Pact")).replace("rgb(254,255,254)", gray.to-hex()), width: 1em, height: 0.5em)

  set text(weight: "bold")
  link(<pact>, [#box(icon)#it])
}

#show regex("Asset( card(s)?)?"): it => {
  let icon = image.decode(read("icons/" + symbols.at("Asset")).replace("rgb(254,255,254)", gray.to-hex()), width: 1em, height: 0.5em)

  set text(weight: "bold")
  link(<asset>, [#box(icon)#it])
}

#show regex("Influence( card(s)?)?"): it => {
  let icon = image.decode(read("icons/" + symbols.at("Influence")).replace("rgb(254,255,254)", black.to-hex()), width: 1em, height: 0.5em)

  set text(weight: "bold")
  link(<influence>, [#box(icon)#it])
}

#show regex("(Favour|Hook|Threat|Secret|Social)( card(s)?)?"): it => {
  let icon = image.decode(read("icons/" + symbols.at("Favour")).replace("rgb(254,255,254)", black.to-hex()), width: 1em, height: 0.5em)

  set text(weight: "bold")
  link(<social>, [#box(icon)#it])
}

#show regex("Testimony( card(s)?)?"): it => {
  let icon = image.decode(read("icons/" + symbols.at("Testimony")).replace("rgb(254,255,254)", black.to-hex()), width: 1em, height: 0.5em)

  set text(weight: "bold")
  link(<testimony>, [#box(icon)#it])
}

#show regex("(Colored( card(s)?)?|Color Token)"): it => {
  let gradient_colors = colors * 8
  let color_gradient = gradient.linear(..gradient_colors, relative: "parent")

  let icon = image.decode(read("icons/" + symbols.at("Token")).replace("rgb(254,255,254)", black.to-hex()), width: 1em, height: 0.5em)

  [
  #set text(weight: "bold", fill: color_gradient)
  #link(<colored>, [#box(icon)#it])
  ]
}

#show regex("(t|T)rade(d|s?)"): it => {
  set text(weight: "bold")
  link(<trade>, it)
}

#show regex("illegal((ly)|( card(s?)))?"): it => {
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

#text(size: 4em, weight: "bold")[
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

You win when everyone except you and another player is eliminated and you have
the most combined card value.\

== Setup <setup>
Separate the Standing cards from the rest.\
Each player gets #standing_card_amount Standing cards. The rest are removed from the game.

Separate the Colored cards from the rest.\
Each player is assigned a Color Token and gets a personal pile of their
respective Colored cards.\
The remaining Colored cards are removed from the game.

Mix the rest of the cards into the draw pile. Each player can now draw a total
of 5 cards from the draw pile or their personal pile or a mix of both.

== Phases <phases>
Each round all players go through these phases:

=== Discussion <discussion>
- Players can openly or secretly (other room or with paper notes or messenger
  etc.) discuss the following round or future strategies.
- Lying and manipulation are allowed
=== Trade <trade>
- Everyone gets a Chance to Trade one card with a player of their choosing.
- A trade happens between two players:
  1. Each trading player… (happens hidden from other players)
    1. …Offers a card
    2. …Looks at the offered card
    3. …Decides if they want to trade
  2. If any player wants to object to the trade they can now do so. Upon an accusation the legality of the traded cards is checked.
  3. If both parties decided to trade they each keep the card offered to them
=== Announcement <announcement>
1. Each player puts one card face down in front of them
2. If anyone wants to announce their card they turn it around for everyone to see
3. Announcements get resolved
4. All the cards in front of the players get put on the discard pile
=== Vote <vote>
- Vote for someone to discard 1 Standing
  - On a draw no one has to discard Standing
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

= Cards <cards>
== Standing <standing>
*_(10X)_*
- Loose condition is met when all Standing is lost
== Pact <pact>
*_(C, I?, 0X)_*
- Can only be traded for another Pact card
- You can only trade with Pact cards of your color
- Cannot be discarded unless traded illegally
- If you have someone’s Pact card you cannot use a social card on them or object
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

= Card properties <card_properties>
== Illegal (I) <illegal>
- Visible on back
== Colored (C) <colored>
- Belongs to a specific player
== Value (X) <value>
- A Number from 0-10
- Visible on back

= Card amounts <card_amounts>

- #player_count Color Tokens
- #player_count times per color:\
  - #standing_card_amount Standing (10X)
  - 1 Pact (0X)
  - #(player_count - 3) Pact (illegal, 0X)
  - Favour (8X)
  - Favour (illegal, 9X)
  - Hook (illegal, 7X)
  - Hook (illegal, 8X)
  - Threat (illegal, 7X)
  - Threat (illegal, 8X)
  - Secret (7X)
  - Secret (illegal, 9X)
- #(asset_copy_amount * 9) Assets (1-9X)
- #(asset_copy_amount * 9) Assets (1-9X, illegal)
- #(influence_copy_amount * 4) Influence (2-5X)
- #(testimony_copy_amount * 3) Testimony (7-9X)

#line()

#let colored_card_count = player_count * (standing_card_amount + 1 + (player_count - 3) + (4 * 2))
#let non_colored_card_count = asset_copy_amount * 9 * 2 + influence_copy_amount * 4 + testimony_copy_amount * 3
#let card_count = colored_card_count + non_colored_card_count + player_count
#text[
  Tokens: #player_count\
  Colored cards: #(colored_card_count/player_count) per player (#colored_card_count)\
  Non-colored cards: #non_colored_card_count\
  Total cards: #card_count
]

= Vocabulary <vocabulary>
== Legality check <legality_check>
1. If any traded card is illegal:
  1. Anyone who agreed to the trade in 2.3. will have to pay a fine of the combined
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

#grid(
  columns: 2,
  align: center,
  column-gutter: 2em,
  row-gutter: 0.5em,
  [
    #place(
      dx: 3.85em,
      dy: 4.05em,
    )[
      #rotate(-skew_angle)[
        #skew(-skew_angle)[
          #rect(stroke: 0.1em + red, width: 0.7em, height: 0.7em)
        ]
      ]
    ]
    #place(
      dx: 6.17em,
      dy: 15.37em,
    )[
      #rotate(-skew_angle)[
        #skew(-skew_angle)[
          #rect(stroke: 0.1em + red, width: 2em, height: 0.7em)
        ]
      ]
    ]
    #render_card_back(value: 99, illegal: true, cut_guide: false)
  ],
  [
    #place(
      dx: 3.85em,
      dy: 4.05em,
    )[
      #rotate(-skew_angle)[
        #skew(-skew_angle)[
          #rect(stroke: 0.1em + red, width: 0.7em, height: 0.7em)
        ]
      ]
    ]
    #place(
      dx: 6.17em,
      dy: 15.37em,
    )[
      #rotate(-skew_angle)[
        #skew(-skew_angle)[
          #rect(stroke: 0.1em + red, width: 2em, height: 0.7em)
        ]
      ]
    ]
    #render_card_back(cut_guide: false)
  ],
  [Value: 99, Illegal],
  [No Value, Legal]
)


== Removed from the game <removed_from_game>
- Put them back in the box