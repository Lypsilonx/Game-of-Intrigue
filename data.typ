#let version = "0.3.3"

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
  "Pact": "Symbolizes a pact between you and the [C] player.",
  "Asset": "Worth [X] (Value)",
  "Influence": "Trade openly.\nCannot be declined.",
  "Favour": "Announce to force the [C] player to trade with you.",
  "Hook": "Announce to make the [C] player discard 1 Standing.",
  "Threat": "Announce to make the [C] player pay a fine to you.",
  "Secret": "Announce to force the [C] player to tell everyone how many illegal cards they have.",
  "Testimony": "When announced you can discard [X] illegal cards from your hand.",
  "Rebrand": "When announced you can discard [X] legal cards from your hand.",
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
  "Speech": "speech.svg",
  "Testimony": "testimony.svg",
  "Rebrand": "rebrand.svg",
  "Defence": "defence.svg",
  "Role": "role.svg",
)

#let icon(name, color: none, width: 1.2em, height: 1.2em, side_distance: 0.4em) = [#h(side_distance/2)#box(image.decode(read("icons/" + symbols.at(name)).replace("rgb(254,255,254)", if color == none { gray } else { color }.to-hex()), width: width, height: height), inset: -0.3em)#h(side_distance)]