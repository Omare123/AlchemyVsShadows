extends Node

const CARDS = "res://Resources/Alchemy Cards/cards.json"
const player_scene := preload("res://Scene/player.tscn")

var player: Player
var cardSelected
var mouseOnAlchemyArea = false
var mouseOnShadowCard = false
var offset = Vector2(48, 48)
var card_data
	
func create_player():
	player = player_scene.instantiate()
	return player

func readJSON():
	if card_data:
		return card_data
	var json_as_text = FileAccess.get_file_as_string(CARDS)
	card_data = JSON.parse_string(json_as_text)
	return card_data
