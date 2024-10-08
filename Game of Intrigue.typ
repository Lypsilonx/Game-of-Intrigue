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

#set text(font: "Inter Tight")
#set page(
  "a5",
  background: locate(
    loc => {
      if loc.page() == 1 or loc.page() == counter(page).final().at(0) {
        box(
          width: 100%,
          height: 100%,
          fill: black,
          radius: 0.5em,
          outset: 5em,
        )
      } else {
        none
      }
    }
  ),
  footer: [
    #locate(
      loc => {
        if loc.page() == 1 {
          set text(fill: white)
          place(
            center,
            [
              // Footer text title page
            ]
          )
        }
        else if loc.page() == counter(page).final().at(0) {
          set text(fill: white)
          place(
            center,
            [
              Game of Intrigue - Version #version\
              Lyx Rothböck 2024\
            ]
          )
        } else {
          if (calc.odd(loc.page())) {
              place(right, counter(page).display("1"));
            } else {
              place(left, counter(page).display("1"));
            }
          place(center, [Game of Intrigue #text(size:0.6em)[#version]])
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
  link(<role>, [#icon("Role")#it])
}

#show regex("Goal(s)?( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<goals>, [#icon("Role")#it])
}

#show regex("Perk(s)?( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<perks>, [#icon("Role")#it])
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

#show regex("(Favour(s)?)( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<social>, [#icon("Favour", color: gray)#it])
}

#show regex("(Hook)( card(s)?)?"): it => {
  set text(weight: "bold")
  link(<social>, [#icon("Hook", color: gray)#it])
}

#show regex("(Threat(s)?)( card(s)?)?"): it => {
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

#show regex("(P|p)a(y|id)( as)? a fine"): it => {
  set text(weight: "bold")
  link(<fine>, it)
}

#show regex("announced"): it => {
  set text(weight: "bold")
  link(<announcement>, it)
}

#show regex("(R|r)emove.*from the game"): it => {
  set text(weight: "bold")
  link(<removed_from_game>, it)
}

#show regex("(l|L)egality.*check(ed|s)?"): it => {
  set text(weight: "bold")
  link(<legality_check>, it)
}
#place(
  center + horizon,
  dx: -0.5em,
  dy: -5em
)[
  #logo(banner: true)
]
#pagebreak()
#text(size: 3em, weight: "bold")[
  Game of Intrigue
]\
Version #version
#set par(leading: 0.5em)
#outline(title: "Chapters", indent: auto)

#pagebreak()
= The Game <the_game>

== Outline <outline>
#outline_text

== Setup <setup>
Separate the Standing cards from the rest.\
Each player gets #standing_card_amount Standing cards. The rest are removed from the game.

Separate the Colored cards from the rest.\
Sort them by Color and give each player one of the piles.\
The Color Token and the Pact card are put on the table in front of the player visible to everyone.\
Each player then shuffles their Colored cards and puts them face down in their personal pile.\
The remaining Colored cards are removed from the game.\

The Role cards are seperated into Goals and Perks and shuffled. Each player is dealt a Goal (into their hand) and a Perk to the *bottom* of their personal pile.\
The rest of the Role cards are removed from the game.

#let start_draw_cards = hand_card_amount - standing_card_amount - 1
Mix the rest of the cards into the draw pile. Each player can now draw a total
of #start_draw_cards cards from the draw pile or their personal pile or a mix of both (e.g. #(calc.ceil(start_draw_cards / 3 * 2)) from the draw pile and #(calc.floor(start_draw_cards / 3)) from the personal pile) and put them in their hand with their Standing cards and their Role.

== Phases <phases>
The game is played in rounds, that are split up into phases. All players collectively decide when to move on to the next phase together.
You can decide on a turn order inside of the phases (like clockwise or counter-clockwise) or spontaneously decide who goes next. After the last phase the next round starts.

The phases are:

=== Trade <trade>
Players can openly or secretly (in another room or with paper notes or via messenger etc.) discuss strategies.

Each player gets *one* Chance to Trade *one card* with a player of their choosing.
You will have to trade to participate in the Announcement phase. So even just trading for the sake of it can be a good strategy. *Bluffing is allowed!*

A trade happens between two players:
  1. Player 1 offers a card to Player 2 by openly stating the card and the player they want to trade with (can be a bluff)
  2. Player 2 decides if they want to trade. If they do they offer a card to Player 1 (also openly stating which card; can also be a bluff)
  3. Player 1 decides if they want to trade
  3. If any player wants to object to the trade they can now do so. (Count down from 3 to give other players a chance; The deal is done/protected on the count of 0) Upon an accusation the legality of the traded cards is checked (see Legality check)
  4. If both parties decided to trade (and no illegal cards were found in the previous step) they each take the card offered to them.
  5. Both players now qualify for the Announcement phase.

After everyone (except one player, if there is an uneven number of players) has traded the phase ends.

_Example:_

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

- C0(Max) announces they want to trade an Col1 Favour with C4(Rue)
- C4(Rue) accepts and offers an Asset card (Value 8) to C0(Max)
- C0(Max) accepts the trade
- C0(Max) and C4(Rue) count down from 3
- C1(Alex) objects to the trade because they are Col1 and know they haven't pulled any Favour cards from their personal pile yet, so it must be a bluff. They also know from a previous Secret card that C0(Max) has a lot of illegal cards in their hand.
- The legality of the trade is checked
  - No illegal cards were traded
- C1(Alex) decides to pay a fine to C4(Rue)
- C4(Rue) draws a card from C1(Alex)'s hand
- C0(Max) gives C4(Rue) a Testimony card (Value 2) _secretly_
- C4(Rue) gives C0(Max) a Col4 Favour card (Value 3) _secretly_
- C0(Max) and C4(Rue) now qualify for the Announcement phase
- C1(Alex) and the other players can still trade with each other

=== Announcement <announcement>
_Only after a successful trade can a player participate in this phase._

In the Announcement phase players can announce Social and Speech cards.\

1. Each qualifying player can now put one card face down in front of them
2. If anyone wants to announce their card they turn it around for everyone to see
3. Announcements get resolved (See Social cards and Speech cards) in the order of highest to lowest value (same values get sorted by a coin toss or rock, paper scissors). You cannot announce a Social card of your own Color.
4. All the cards in front of the players get put on the discard pile
#pagebreak()
=== Draw <draw>
Each player can now discard (another) one card from their hand and draws cards from the draw pile or their personal pile until they have #hand_card_amount cards in their hand.\

If the draw pile is empty mix the discard pile into it

If a player has 0 Standing they *loose* and have to decide where they want to put their cards:
- on the discard pile
- into a player hand (inheritance)
  - the chosen player must discard the amount of cards they received

If only two players are left the player with the most combined card value
*wins*.

#linebreak()
Tipp: Keep your cards hidden as long as possible.\ You almost never have to show your cards to other players (see Visible on back).

#pagebreak()
= Cards <cards>
== Types <types>
=== Standing <standing>
_Value #(standing_card_value)_

You loose when all your Standing is lost.
=== Pact <pact>
_Colored_\
_Can be Illegal_\

This card symbolizes a pact between you and another player. Pacts are placed openly next to your Color Token on the table.\
They can only be traded for another Pact card and only you can trade with your Pact card.

If you have someone else's Pact card you cannot:
- use a Social card on them
- accuse them of illegal trades

=== Asset <asset>
_Can be Illegal_\
_Value #(asset_value_range.at(0))-#(asset_value_range.at(1))_

Assets are worth their value. Thy do not have any special abilities.

=== Influence <influence>
_Can be Illegal_\
_Value #(influence_value_range.at(0))-#(influence_value_range.at(1))_

Influence cards are played during the Trade phase to make another player trade with you.

#pagebreak()
=== Social <social>
_Colored_\
_Can be Illegal_\
_Value #(calc.min(..social_cards.map(card_data => card_data.value)))-#(calc.max(..social_cards.map(card_data => card_data.value)))_

A social card can be a Secret, Hook, Threat or Favour. It can be announced during the Announcement phase to make the player with that Color…
  - Favour: Give you a card of a type of your choice (except Standing or Roles) from their hand. If they have that type of card they have to give one to you.
  - Hook: Discard 1 Standing
  - Threat: Pay a fine to you.
  - Secret: Show everyone how many illegal cards they have (Visible on back)
=== Speech <speech>
_Value #(calc.min(..(testimony_values + rebrand_values)))-#(calc.max(..(testimony_values + rebrand_values)))_

Speech cards also come in three different variants: Testimony, Rebrand and Defence. When announced they…
  - Testimony: Let you discard X illegal cards from your hand.
  - Rebrand: Let you discard X legal cards from your hand.
  - Defence: Make you immune to Social cards with less or equal value this Announcement phase


=== Role <role>
Roles can be obtained by drawing all the cards from your personal pile.\
Roles come in two types:
- *Goal*: You win if you fulfill a specific condition
- *Perk*: You get a special ability

#pagebreak()
== Properties <properties>
=== Illegal <illegal>
- Relevant during legality checks in the Trade phase
- Visible on back
=== Colored <colored>
- Belongs to a specific player
=== Value <value>
- A Number from 0-10 (0 is not shown on the card)
- Visible on back
= Vocabulary <vocabulary>
== Legality check <legality_check>
When a player objects to a trade the legality of the traded cards is checked. You can see if a card is illegal by looking at the back of the card (see Visible on back).

If any traded card is illegal:
  1. The player offering an illegal card will have to pay a fine to the accuser.
  2. The trade does not happen; Everyone keeps their offered cards
If no card is illegal:
  1. The accusing player will have to pay a fine to one of the trading players (accusors choice)
  2. The trade goes on.
#pagebreak()
== Paying a fine <fine>
You have to let the other player draw a card from your hand or personal pile.\
You can choose to protect up to #standing_card_amount cards from your hand (put them aside) or your personal pile (hold a hand over it) from being drawn from. If you have less than #standing_card_amount cards in your hand and your personal pile is empty, you cannot protect any cards.

== Removed from the game <removed_from_game>
Put them back in the box. They are not to be used this game anymore.
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
        #render_card_back(value: 99, illegal: true)
      ]
    )
    #place(
      dx: 3.85em * card_example_scale,
      dy: 3.9em * card_example_scale,
    )[
      #rotate(-skew_angle)[
        #skew(-skew_angle)[
          #rect(stroke: 0.1em * card_example_scale + red, width: 0.7em * card_example_scale, height: 0.7em * card_example_scale)
        ]
      ]
    ]
    #place(
      dx: 6.2em * card_example_scale,
      dy: 14.85em * card_example_scale,
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
        #render_card_back()
      ]
    )
    #place(
      dx: 3.85em * card_example_scale,
      dy: 3.9em * card_example_scale,
    )[
      #rotate(-skew_angle)[
        #skew(-skew_angle)[
          #rect(stroke: 0.1em * card_example_scale + red, width: 0.7em * card_example_scale, height: 0.7em * card_example_scale)
        ]
      ]
    ]
    #place(
      dx: 6.2em * card_example_scale,
      dy: 14.85em * card_example_scale,
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
#pagebreak()
= Bonus Rules <bonus_rules>

== Investments
An investment phase is added before the Trade phase.\
Each player can put any amount of cards from their hand into an investments pile. Cards on this pile cannot be played and are openly visible for anyone. They still count towards the players hand size limit, but not towards the value at the end of the game.\
=== Investment Boni
You get the following bonus per 10 total Value put into the investments pile:\
  _Either (Decide this for the whole game in advance)_\
  Hand size +1 _Or_ Announce +1 card _Or_ Add 1 value to your announced card

=== Investment Resolution
The player with the most total Value in the investments pile is the Auctioneer.\
They get to decide over ties and the turn order.

== Bribery
When you have to pay a fine you can discard cards with the total value of _the value of the illegal card you were fined for + 1_.\
You cannot dicard cards without value.

== Who wants to be a Millionaire?
Remove the Banker Role from the game.\
Anyone can win by holding cards worth more or equal to #(calc.floor(int(goal_hand_size * ((asset_value_range.at(1) + asset_value_range.at(0)) / 2) / 10) * 15)).

== Liar, Liar
Remove the Liar Role from the game. It applies to all players.\
You start with #(standing_card_amount - 1) Standing.

== Co-op
Remove the Leach Role from the game.\
Players, that have a pact together, win together.

#pagebreak()
= Material <material>
== Cards <cards>
#linebreak()
#par(leading: 1em)[
  #grid(
    columns: 2,
    gutter: 1em,
    [
      - #player_count Color Tokens
      - #role_card_amount x Role
      - #player_count x #standing_card_amount Standing (#standing_card_value)
      - Each Color (#player_count times):\
        - 1 x Pact
        #for card_data in social_cards {
          [- 1 x #(card_data.type) (#(card_data.value)#if (card_data.keys().contains("illegal") and card_data.illegal) {", illegal"})]
        }
      - #(calc.ceil(asset_copy_amount / 2) * (asset_value_range.at(1) - asset_value_range.at(0) + 1)) x Asset (#(asset_value_range.at(0))-#(asset_value_range.at(1)))
      - #(calc.floor(asset_copy_amount / 2) * (asset_value_range.at(1) - asset_value_range.at(0) + 1)) x Asset (#(asset_value_range.at(0))-#(asset_value_range.at(1)), illegal)
      - #(influence_copy_amount * (influence_value_range.at(1) - influence_value_range.at(0) + 1)) x Influence (#(influence_value_range.at(0))-#(influence_value_range.at(1)))
      - #(testimony_copy_amount * testimony_values.len()) x Testimony (#(calc.min(..testimony_values))-#(calc.max(..testimony_values)))
      - #(rebrand_copy_amount * rebrand_values.len()) x Rebrand (#(calc.min(..rebrand_values))-#(calc.max(..rebrand_values)))
      - #(defence_copy_amount) x Defence (#defence_value)
    ],
    [
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
        Non-colored cards: #non_colored_card_count\
        #line()
        Total cards: #card_count
      ]
    ]
  )
]
#pagebreak()

#let roles = for role in role_descriptions {
    (
      role.at(0),
      role.at(1).replace("[Goal]", "").replace("[Perk]", "")
    )
  }.flatten()

#let goals = roles.chunks(int(roles.len() / 2)).at(0)
#let perks = roles.chunks(int(roles.len() / 2)).at(1)

== Roles <roles>
=== Goals <goals>
#table(
  columns: 2,
  ..goals
)
#pagebreak()
=== Perks <perks>
#table(
  columns: 2,
  ..perks
)
#pagebreak()
