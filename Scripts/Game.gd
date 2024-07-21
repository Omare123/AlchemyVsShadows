extends Node

const CARDS = "res://Resources/cards.json"

var cardSelected
var mouseOnAlchemyArea = false
var mouseOnShadowCard = false
var offset = Vector2(52, 68)
var card_data 

func readJSON():
	if card_data:
		return card_data
	var json_as_text = FileAccess.get_file_as_string(CARDS)
	card_data = JSON.parse_string(json_as_text)
	return card_data
