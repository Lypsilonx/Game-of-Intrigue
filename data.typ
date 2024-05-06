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
#let standing_card_amount = 3
#let asset_copy_amount = 2
#let influence_copy_amount = 1
#let testimony_copy_amount = 2

#let descriptions = (
  "Token": "Represents you as the [C] player.",
  "Standing": "If you loose all of these cards, you are eliminated.",
  "Pact": "Symbolizes a pact between you and another player.",
  "Asset": "Worth [X]",
  "Influence": "Must be accepted in a trade.",
  "Favour": "Announce to force the [C] player to trade with you.",
  "Hook": "Announce to force the [C] player to vote like you.",
  "Threat": "Announce to force the [C] player not vote.",
  "Secret": "Announce to make the [C] player loose 1 Standing.",
  "Testimony": "When announced you are immune to social cards with less or equal value."
)

#let symbols = (
  "Token": "token.svg",
  "Standing": "standing.svg",
  "Pact": "pact.svg",
  "Asset": "asset.svg",
  "Influence": "influence.svg",
  "Favour": "social.svg",
  "Hook": "social.svg",
  "Threat": "social.svg",
  "Secret": "social.svg",
  "Testimony": "testimony.svg"
)