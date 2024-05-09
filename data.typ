#let version = "0.2.1"

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

#let descriptions = (
  "Token": "Represents you as the [C] player.",
  "Standing": "If you loose all of these cards, you are eliminated.",
  "Pact": "Symbolizes a pact between you and another player.",
  "Asset": "Worth [X] (Value)",
  "Influence": "Must be accepted in a trade.",
  "Favour": "Announce to force the [C] player to trade with you.",
  "Hook": "Announce to force the [C] player to vote like you.",
  "Threat": "Announce to force the [C] player not vote.",
  "Secret": "Announce to make the [C] player loose 1 Standing.",
  "Testimony": "When announced you are immune to Social cards with less or equal value.",
)

#let player_count = colors.len()
#let standing_card_amount = 3
#let hand_card_amount = 5
#let asset_copy_amount = 2
#let influence_copy_amount = 1
#let testimony_copy_amount = 2

#let card_width = 2.5in
#let card_height = 3.5in
#let card_radius = 3.5mm
#let card_cut_radius = 0mm
#let skew_angle = 6deg

#let role_descriptions = (
  "Millionaire": "[Goal]Hold cards worth more or equal to " + str(hand_card_amount * 6) + ". (excluding Standing)",
  "Mafioso": "[Goal]Hold more or equal to " + str(hand_card_amount + 1) + " illegal cards, but only illegal cards. (excluding Standing and cards of your Color)",
  "Broker": "[Goal]Hold " + str(asset_copy_amount * 2 + 1) + " Assets with ascending values.",
  "Hoarder": "[Goal]Hold " + str(asset_copy_amount * 2) + " Assets with the same value.",
  "Snitch": "[Goal]Hold " + str(hand_card_amount * 2) + " Cards. (excluding Standing)",
  "Isolationist": "[Goal]Hold only cards without value. (including Standing)",
  "Lobbyist": "[Perk]If you trade this card to another player, they loose all their Standing.",
  "Leach": "[Perk]If someone you have a Pact with wins, you win too.",
  "Undead": "[Perk]When you loose, take " + str((standing_card_amount - 1)) + " Standing cards from the draw pile and shuffle it again, then remove this card from the game.",
  "Liar": "[Perk]You only loose when being accused during a trade, while having no Standing. You cannot win without Standing.",
  "Officer": "[Perk]Announce to force everyone to give you all their illegal cards.",
  "Speculator": "[Perk]At the end of the game each of your Asset cards is worth 5+1d4. (Throw a dice with 4 sides and add 5)",
)

#let role_card_amount = role_descriptions.len()

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
  "Testimony": "testimony.svg",
  "Role": "role.svg",
)

#let icon(name, color: none, width: 1.2em, height: 1.2em, side_distance: 0.4em) = [#box(image.decode(read("icons/" + symbols.at(name)).replace("rgb(254,255,254)", if color == none { gray } else { color }.to-hex()), width: width, height: height), inset: -0.3em)#h(side_distance)]