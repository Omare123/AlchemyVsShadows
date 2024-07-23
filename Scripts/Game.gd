extends Node

const CARDS = "res://Resources/Alchemy Cards/cards.json"
const SHADOW_CARDS = "res://Resources/Shadow Cards/shadow_cards.json"
const player_scene := preload("res://Scene/player.tscn")

@onready var timer: Timer = Timer.new()
const  MAXIMUN_LEVEL = 3
var player: Player
var cardSelected
var mouseOnAlchemyArea = false
var mouseOnShadowCard = false
var level = 1
var offset = Vector2(48, 48)
var card_data
var shadow_card_data
var level_time := 90.0
var shadows_level_cap = 1

func _ready():
	timer.set_wait_time(level_time)
	add_child(timer)
	timer.one_shot = true
	timer.start()
	timer.timeout.connect(_on_level_up_timeout)
	
func create_player():
	player = player_scene.instantiate()
	return player

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

func _on_level_up_timeout():
	level += 1
	if shadows_level_cap < MAXIMUN_LEVEL:
		shadows_level_cap += 1
