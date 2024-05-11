#let version = "0.3.0"

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
#let standing_value = settings_json.standing_value

#let asset_copy_amount = settings_json.asset_copy_amount
#let asset_value_range = (settings_json.asset_value_range.at(0), settings_json.asset_value_range.at(1))

#let influence_copy_amount = settings_json.influence_copy_amount
#let influence_value_range = (settings_json.influence_value_range.at(0), settings_json.influence_value_range.at(1))

#let testimony_copy_amount = settings_json.testimony_copy_amount
#let testimony_value_range = (settings_json.testimony_value_range.at(0), settings_json.testimony_value_range.at(1))

#let colored_cards = settings_json.colored_cards

// Design settings
#let card_width = 2.5in
#let card_height = 3.5in
#let card_radius = 3.5mm
#let card_cut_radius = 0mm
#let skew_angle = 6deg

#let descriptions = (
  "Token": "Represents you as the [C] player.",
  "Standing": "If you loose all of these cards, you are eliminated.",
  "Pact": "Symbolizes a pact between you and another player.",
  "Asset": "Worth [X] (Value)",
  "Influence": "Trade openly.\nCannot be declined.",
  "Favour": "Announce to force the [C] player to trade with you. You both have to accept the trade.",
  "Hook": "Announce to make the [C] player discard 1 Standing.",
  "Threat": "Announce to take a card from the [C] players hand or personal pile.",
  "Secret": "Announce to force the [C] player to tell everyone how many illegal cards they have.",
  "Testimony": "When announced you are immune to Social cards with less or equal value.",
)

#let role_descriptions = (
  "Millionaire": "[Goal]Hold cards worth more or equal to " + str(hand_card_amount * 8) + ". (excluding Standing)",
  "Mafioso": "[Goal]Hold more or equal to " + str(hand_card_amount + 1) + " illegal cards, but only illegal cards. (excluding Standing and cards of your Color)",
  "Broker": "[Goal]Hold " + str(asset_copy_amount + 1) + " Assets with ascending values.",
  "Hoarder": "[Goal]Hold " + str(asset_copy_amount) + " Assets with the same value.",
  "Snitch": "[Goal]Hold " + str(hand_card_amount * 2) + " Cards. (excluding Standing)",
  "Isolationist": "[Goal]Hold only cards without value. (including Standing)",
  "Lobbyist": "[Perk]If you trade this card to another player, they loose all their Standing.",
  "Leach": "[Perk]If someone you have a Pact with wins, you win too. When you loose, you can try to sneak this card out of the game, to win later.",
  "Undead": "[Perk]When you loose, take " + str((standing_card_amount - 1)) + " Standing cards from the draw pile and shuffle it again, then remove this card from the game.",
  "Liar": "[Perk]You only loose when being accused during a trade, while having no Standing. You cannot win without Standing.", // TODO: Figure out how to handle this discretely
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

#let icon(name, color: none, width: 1.2em, height: 1.2em, side_distance: 0.4em) = [#h(side_distance/2)#box(image.decode(read("icons/" + symbols.at(name)).replace("rgb(254,255,254)", if color == none { gray } else { color }.to-hex()), width: width, height: height), inset: -0.3em)#h(side_distance)]