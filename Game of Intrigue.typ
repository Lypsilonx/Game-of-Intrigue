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

#set text(font: "Proxima Nova")
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
        } else {
          set text(fill: white)
          place(
            center,
            [
              Game of Intrigue - Version #version\
              Lyx Rothböck 2024\
            ]
          )
        }
      }
    )
  ]
)

#show regex("Standing( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<standing>, [#icon("Standing")#it])
}

#show regex("Role(s)?( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<roles>, [#icon("Role")#it])
}

#show regex("Pact(s)?( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<pact>, [#icon("Pact", color: gray)#it])
}

#show regex("Asset(s)?( card(s)?)?"): it => {
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

#show regex("Speech( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<speech>, [#icon("Speech")#it])
}

#show regex("Testimony( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<speech>, [#icon("Testimony")#it])
}

#show regex("Rebrand( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<speech>, [#icon("Rebrand")#it])
}

#show regex("Defence( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<speech>, [#icon("Defence")#it])
}

#show regex("Color(ed)?(( card(s)?)|( Token(s)?))?"): it => {
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

#show regex("(l|L)egality.*check(ed|s)?"): it => {
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
          #icon("Speech", width: 5em, height: 5em, color: blue)
          #icon("Role", width: 5em, height: 5em, color: purple)
        ]
      ]
    ]
  ]
]
#pagebreak()
#text(size: 3em, weight: "bold")[
  Game of Intrigue
]\
Version #version
#outline(title: "Chapters", indent: auto)

#pagebreak()
= The Game <the_game>

== Outline <outline>
In the Game of Intrigue, you compete against at least two other players. You draw cards and trade them with other players to gain an advantage.

The most important cards are the Standing cards. If you loose all your Standing cards you are eliminated. You can play it safe and try to stay in the game or you can take risks and try to eliminate other players.

When everyone except two players are eliminated. The player with the most valueable cards wins.

But beware! After players draw their Role cards they get powerfull abilities or goals that can even win them the game.

== Setup <setup>
Separate the Standing cards from the rest.\
Each player gets #standing_card_amount Standing cards. The rest are removed from the game.

Separate the Colored cards from the rest.\
Sort them by Color and give each player one of the piles.\
The Color Token is put on the table in front of the player visible to everyone. Each player then shuffles their Colored cards and puts them face down in their personal pile.\
The remaining Colored cards are removed from the game.\

The Role cards are shuffled and each player is dealt one to the *bottom* of their personal pile.\
The rest of the Role cards are removed from the game.

Mix the rest of the cards into the draw pile. Each player can now draw a total
of #hand_card_amount cards from the draw pile or their personal pile or a mix of both (e.g. #(calc.ceil(hand_card_amount / 3 * 2)) from the draw pile and #(calc.floor(hand_card_amount / 3)) from the personal pile) abd put them in their hand with their Standing cards.

#pagebreak()
== Phases <phases>
The game is played in rounds, that are split up into phases. All players collectively decide when to move on to the next phase together.
You can decide on a turn order inside of the phases (like clockwise or counter-clockwise) or spontaneously decide who goes next. After the last phase the next round starts.

The phases are:

=== Discussion <discussion>
Players can openly or secretly (in another room or with paper notes or via messenger etc.) discuss the following round or future strategies.

Lying and manipulation are allowed
=== Trade <trade>
Each player now gets *one* Chance to Trade *one card* with a player of their choosing.
You will have to trade to participate in the Announcement and Draw phase. So even just trading for the sake of it can be a good strategy. *Bluffing is allowed!*

A trade happens between two players:
  1. Player 1 offers a card to Player 2 by openly stating the card and the player they want to trade with (can be a bluff)
  2. Player 2 decides if they want to trade. If they do they offer a card to Player 1 (also openly stating which card; can also be a bluff)
  3. Player 1 decides if they want to trade
  3. If any player wants to object to the trade they can now do so. Upon an accusation the legality of the traded cards is checked (see Legality check)
  4. If both parties decided to trade (and no illegal cards were found in the previous step) they each take the card offered to them.
  5. Both players now qualify for the following phases.

Example:

#show regex("C[0-9]\([a-zA-Z ]*\)"): it => {
  set text(fill: colors.at(int(it.text.at(1))))
  it.text.slice(
    it.text.match("(").start + 1,
    it.text.len() - 1
  )
}

#show regex("Col[0-9]"): it => {
  let color = colors.at(int(it.text.at(3)))
  set text(fill: color)
  color_to_string(color)
}

- C0(Max) announces they want to trade an Col1 Favour with C4(Nic)
- C4(Nic) accepts and offers an Asset card (Value 8) to C0(Max)
- C0(Max) accepts the trade
- C1(Alex) objects to the trade because they are Col1 and know they haven't pulled any Favour cards from their personal pile yet, so it must be a bluff. They also know from a previous Secret card that C0(Max) has a lot of illegal cards in their hand.
- The legality of the trade is checked
  - No illegal cards were traded
- C1(Alex) gives C4(Nic) an Asset card (Value 6) as a fine
- C0(Max) gives C4(Nic) a Testimony card (Value 7) _secretly_
- C4(Nic) gives C0(Max) a Col4 Favour card (Value 8) _secretly_
- C0(Max) and C4(Nic) now qualify for the Announcement and Draw phase
- C1(Alex) and the other players can still trade with each other

=== Announcement <announcement>
_Only after a successful trade can a player participate in the Announcement and Draw phase._

In the Announcement phase players can announce Social and Speech cards.\

1. Each qualifying player puts one card face down in front of them
2. If anyone wants to announce their card they turn it around for everyone to see
3. Announcements get resolved (See Social cards and Speech cards)
4. All the cards in front of the players get put on the discard pile
=== Draw <draw>
_Only for players that successfully traded in the Trade phase and announced in the Announcement phase_

Each player draws cards from the draw pile or their personal pile until they have #(hand_card_amount + standing_card_amount) cards in their hand.\

If the draw pile is empty mix the discard pile into it

If a player has 0 Standing they *loose* and have to decide where they want to
put their cards:
- on the discard pile
- into a player hand (inheritance)
  - the chosen player must discard the amount of cards they received

If only two players are left the player with the most combined card value
*wins*.

#linebreak()
Tipp: Keep your cards hidden as long as possible.\ You almost never have to show your cards to other players (see Visible on back).

#pagebreak()
= Cards <cards>
== Standing <standing>

You loose when all your Standing is lost.
== Pact <pact>
*_(C, I?)_*

This card symbolizes a pact between you and another player.\
It can only be traded for another Pact card and only you can trade with your Pact card. It cannot be discarded.

If you have someone else's Pact card you cannot:
- use a Social card on them
- accuse them of illegal trades

== Asset <asset>
*_(I?, #(asset_value_range.at(0))-#(asset_value_range.at(1))X)_*

Assets are worth their value. Thy do not have any special abilities.

== Influence <influence>
*_(I?, #(influence_value_range.at(0))-#(influence_value_range.at(1))X)_*

Influence cards must be traded openly and cannot be declined. They are low value cards that can bloat your hand.

== Social <social>
*_(C, I?, #(calc.min(..social_cards.map(card_data => card_data.value)))-#(calc.max(..social_cards.map(card_data => card_data.value)))X)_*

A social card can be a Secret, Hook, Threat or Favour. It can be announced during the Announcement phase to make the player with that Color…
  - Favour: Trade with you now (Follow the steps in the Trade phase)
  - Hook: Discard 1 Standing
  - Threat: Let you draw a card from their hand or personal pile (excluding roles)
  - Secret: Show everyone how many illegal cards they have (Visible on back)
== Speech <speech>
*_(I?, #(calc.min(..(testimony_values + rebrand_values)))-#(calc.max(..(testimony_values + rebrand_values)))X)_*

Speech cards also come in three different variants: Testimony, Rebrand and Defence. When announced they…
  - Testimony: Let you discard X illegal cards from your hand.
  - Rebrand: Let you discard X legal cards from your hand.
  - Defence: Make you immune to Social cards with less or equal value this Announcement phase


== Roles <roles>
Roles can be obtained by drawing all the cards from your personal pile.\
Roles come in two types:
- *Goal*: You win if you fulfill a specific condition
- *Perk*: You get a special ability

== Properties <properties>
=== Illegal (I) <illegal>
- Relevant during legality checks in the Trade phase
- Visible on back
=== Colored (C) <colored>
- Belongs to a specific player
=== Value (X) <value>
- A Number from 0-10 (0 is not shown on the card)
- Visible on back
#pagebreak()
== Material <material>
#linebreak()
#grid(
  columns: 2,
  gutter: 1em,
  [
    - #player_count Color Tokens
    - #role_card_amount x Role
    - #player_count x #standing_card_amount Standing
    - Each Color (#player_count times):\
      - 1 x Pact
      - #(player_count - 3) x Pact (illegal)
      #for card_data in social_cards {
        [- 1 x #(card_data.type) (#(card_data.value)X#if (card_data.keys().contains("illegal") and card_data.illegal) {", illegal"})]
      }
    - #(calc.ceil(asset_copy_amount / 2) * (asset_value_range.at(1) - asset_value_range.at(0) + 1)) x Asset (#(asset_value_range.at(0))-#(asset_value_range.at(1))X)
    - #(calc.floor(asset_copy_amount / 2) * (asset_value_range.at(1) - asset_value_range.at(0) + 1)) x Asset (#(asset_value_range.at(0))-#(asset_value_range.at(1))X, illegal)
    - #(influence_copy_amount * (influence_value_range.at(1) - influence_value_range.at(0) + 1)) x Influence (#(influence_value_range.at(0))-#(influence_value_range.at(1))X)
    - #(testimony_copy_amount * testimony_values.len()) x Testimony (#(calc.min(..testimony_values))X-#(calc.max(..testimony_values))X)
    - #(rebrand_copy_amount * rebrand_values.len()) x Rebrand (#(calc.min(..rebrand_values))X-#(calc.max(..rebrand_values))X)
    - #(defence_copy_amount * defence_values.len()) x Defence (#(calc.min(..defence_values))X-#(calc.max(..defence_values))X)
  ],
  [
    #let colored_card_count = player_count * ((player_count - 2) + social_cards.len())
    #let non_colored_card_count = asset_copy_amount * (asset_value_range.at(1) - asset_value_range.at(0) + 1) + influence_copy_amount * (influence_value_range.at(1) - influence_value_range.at(0) + 1) + testimony_copy_amount * testimony_values.len() + rebrand_copy_amount * rebrand_values.len() + defence_copy_amount * defence_values.len()
    #let card_count = colored_card_count + non_colored_card_count + player_count + role_card_amount + standing_card_amount * player_count
    #text[
      Color Tokens: #player_count\
      Roles: #role_card_amount\
      Standing: #(standing_card_amount * player_count)\
      #linebreak()
      #for _ in range(social_cards.len()) {
        linebreak()
      }
      Colored cards: #(colored_card_count/player_count) per player\ ( = #colored_card_count)\
      #linebreak()
      #linebreak()
      #linebreak()
      #linebreak()
      #linebreak()
      Non-colored cards: #non_colored_card_count\
      #line()
      Total cards: #card_count
    ]
  ]
)
#pagebreak()
= Vocabulary <vocabulary>
== Legality check <legality_check>
When a player objects to a trade the legality of the traded cards is checked. You can see if a card is illegal by looking at the back of the card (see Visible on back).

If any traded card is illegal:
  1. The player offering an illegal card will have to pay a fine of half its value (rounded down) to the accuser.
  2. If any illegal Pacts were found to be offered remove them from the game. (Tipp: Pacts are the only illegal cards without a value)
  3. The trade does not happen; Everyone keeps their offered cards
If no card is illegal:
  1. The accusing player will have to pay a fine of 3 to one of the trading players (accusors choice)
  2. The trade goes on.

== Paying a fine (of X) <fine>
You have to give a card of at least the value X to another player.

== Removed from the game <removed_from_game>
Put them back in the box. They are not to be used this game anymore.
#pagebreak()
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