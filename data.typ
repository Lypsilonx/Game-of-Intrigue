#let version = "1.0.3"

// Game settings
#let colors = (
  red,
  orange,
  yellow,
  green,
  blue,
  purple,
)
#let color_to_string(color) = {
  if color == blue { "Blue" }
  else if color == green { "Green" }
  else if color == red { "Red" }
  else if color == yellow { "Yellow" }
  else if color == purple { "Purple" }
  else if color == orange { "Orange" }
  else { "Unknown" }
}
#let player_count = colors.len()

#let settings_json = json("game_settings.json")
#let hand_card_amount = settings_json.hand_card_amount
#let standing_card_amount = settings_json.standing_card_amount
#let standing_card_value = settings_json.standing_card_value

#let asset_copy_amount = settings_json.asset_copy_amount
#let asset_value_range = (settings_json.asset_value_range.at(0), settings_json.asset_value_range.at(1))

#let influence_copy_amount = settings_json.influence_copy_amount
#let influence_value_range = (settings_json.influence_value_range.at(0), settings_json.influence_value_range.at(1))

#let testimony_copy_amount = settings_json.testimony_copy_amount
#let testimony_values = settings_json.testimony_values

#let rebrand_copy_amount = settings_json.rebrand_copy_amount
#let rebrand_values = settings_json.rebrand_values

#let defence_copy_amount = settings_json.defence_copy_amount
#let defence_values = settings_json.defence_values

#let social_cards = settings_json.social_cards

// Design settings
#let card_width = 2.5in
#let card_height = 3.5in
#let card_radius = 3.5mm
#let card_cut_radius = 0mm
#let skew_angle = 6deg
#let display_supertitle = settings_json.display_supertitle

#let descriptions = (
  "Token": "Represents you as the [C] player.",
  "Standing": "If you loose all of these cards, you are eliminated.",
  "Pact": "Symbolizes a pact with the [C] player. Removed from the game when discarded.",
  "Asset": "Worth [X] (Value)",
  "Influence": "Trade openly.\nCannot be declined.",
  "Favour": "Announce to ask the [C] player for a card. (excluding Standing and Roles)",
  "Hook": "Announce to make the [C] player discard 1 Standing.",
  "Threat": "Announce to make the [C] player pay a fine to you.",
  "Secret": "Announce to force the [C] player to tell everyone how many illegal cards they have.",
  "Testimony": "When announced you can discard [X] illegal card_s from your hand.",
  "Rebrand": "When announced you can discard [X] legal card_s from your hand.",
  "Defence": "When announced you are immune to Threat cards up to a Value of [X].",
)

#let goal_hand_size = calc.ceil(hand_card_amount * 1.5)
#let role_descriptions = (
  "Millionaire": "[Goal]Hold cards worth more or equal to " + str(calc.floor(int(goal_hand_size * ((asset_value_range.at(1) + asset_value_range.at(0)) / 2) / 10) * 10)) + ". (excluding Standing)",
  "Mafioso": "[Goal]Hold more or equal to " + str(goal_hand_size) + " illegal cards, but only illegal cards. (excluding Standing and cards of your Color)",
  "Broker": "[Goal]Hold " + str(goal_hand_size) + " cards with ascending values.",
  "Hoarder": "[Goal]Hold " + str(calc.ceil(asset_copy_amount * 0.8)) + " Assets with the same value.",
  "Snitch": "[Goal]Hold " + str(calc.floor(goal_hand_size * 1.5)) + " Cards. (excluding Standing)",
  "Isolationist": "[Goal]Hold only cards without value. (including Standing)",
  "Tyrant": "[Goal](3-5 Players) Hold 2 Threats for all other players.\n(6-8 Players) Hold Threats for all other players.",
  "Politician": "[Goal](3-5 Players) Hold 2 Favours for all other players.\n(6-8 Players) Hold Favours for all other players.",
  "Lobbyist": "[Perk]If you trade this card to another player, they have to discard all their Standing.", // TODO: Make it so that people want to trade Role cards
  "Leach": "[Perk]If someone you have a Pact with wins, you win too. When you loose, you can try to sneak this card out of the game, to win later.",
  "Undead": "[Perk]When you loose, take " + str((standing_card_amount - 1)) + " Standing cards from the draw pile and shuffle it again, then remove this card from the game.",
  "Liar": "[Perk]You only loose when being accused during a trade, while having no Standing. You cannot win without Standing.", // TODO: Figure out how to handle this discretely
  "Officer": "[Perk]Announce to force everyone to give you all their illegal cards.",
  "Speculator": "[Perk]At the end of the game each of your Asset cards is worth 5+1d4. (Throw a dice with 4 sides and add 5)",
  "Salesperson": "[Perk]Announce to discard all your cards (excluding Standing)",
  "Banker": "[Perk]Announce to force everyone to give you all their Assets.",
)

#let role_card_amount = role_descriptions.len()

#let colored_card_count = player_count * ((player_count - 2) + social_cards.len())
#let non_colored_card_count = asset_copy_amount * (asset_value_range.at(1) - asset_value_range.at(0) + 1) + influence_copy_amount * (influence_value_range.at(1) - influence_value_range.at(0) + 1) + testimony_copy_amount * testimony_values.len() + rebrand_copy_amount * rebrand_values.len() + defence_copy_amount * defence_values.len()
#let card_count = colored_card_count + non_colored_card_count + player_count + role_card_amount + standing_card_amount * player_count

#let symbols = (
  "Token": "token.svg",
  "Standing": "standing.svg",
  "Pact": "pact.svg",
  "Asset": "asset.svg",
  "Influence": "influence.svg",
  "Social": "social.svg",
  "Favour": "favour.svg",
  "Hook": "hook.svg",
  "Threat": "threat.svg",
  "Secret": "secret.svg",
  "Speech": "speech.svg",
  "Testimony": "testimony.svg",
  "Rebrand": "rebrand.svg",
  "Defence": "defence.svg",
  "Role": "role.svg",
)

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

#let icon(name, color: none, color2: black, width: 1.2em, height: 1.2em, side_distance: 0.4em) = [
  #h(side_distance/2)#box(
    inset: -0.3em,
    image.decode(
      width: width,
      height: height,
      read("icons/" + symbols.at(name))
      .replace(
        "rgb(254,255,254)",
        if color == none {
          gray
        } else {
          color
        }.to-hex()
      )
      .replace(
        "rgb(0,0,0)",
        color2.to-hex()
      )
    )
  )#h(side_distance)
]

#let logo_text = [
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
      of\
    ]
    INTRIGUE
  ]\
]

#let icon_banner = [
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

#let logo(subtitle: true, banner: false) = [
  #rotate(-skew_angle)[
    #skew(-skew_angle)[
      #logo_text
      #if subtitle [
        #text(
          weight: "extrabold",
          size: 2em,
          fill: white
        )[
        a game about\ being an asshole
        ]
      ]
      #if banner [ 
        #v(2em)
        #icon_banner
      ]
    ]
  ]
]

#let outline_text = [
  In the Game of Intrigue, you compete against at least two other players. You draw cards and trade them with other players to gain an advantage.

  The most important cards are the Standing cards. If you loose all your Standing cards you are eliminated. You can play it safe and try to stay in the game or you can take risks and try to eliminate other players.

  When everyone except two players are eliminated. The player with the most valueable cards wins.

  But beware! After players draw their Role cards they get powerfull abilities or goals that can even win them the game.
]