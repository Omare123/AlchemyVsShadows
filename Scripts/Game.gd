extends Node

const CARDS = "res://Resources/Alchemy Cards/cards.json"
const SHADOW_CARDS = "res://Resources/Shadow Cards/shadow_cards.json"
const  MAXIMUN_LEVEL = 3

var cardSelected
var mouseOnAlchemyArea = false
var mouseOnShadowCard = false
var level = 1
var offset = Vector2(48, 48)
var card_data
var shadow_card_data
var shadows_level_cap = 1

func readJSON():
	if card_data:
		return card_data
	var json_as_text = FileAccess.get_file_as_string(CARDS)
	card_data = JSON.parse_string(json_as_text)
	return card_data

func read_shadow_JSON():
	if shadow_card_data:
		return shadow_card_data
	var json_as_text = FileAccess.get_file_as_string(SHADOW_CARDS)
	shadow_card_data = JSON.parse_string(json_as_text)
	return shadow_card_data

func level_up():
	level += 1
	if shadows_level_cap < MAXIMUN_LEVEL:
		shadows_level_cap += 1
