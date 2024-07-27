extends Node

@onready var level_up_timer = $"Level Up"
@onready var battle_ui = $"Battle UI"
@onready var alchemy_ui = $"Alchemy UI"
@onready var MonsterField = $"Battle UI/MonsterField"
@onready var deck = $"Battle UI/Deck"
@onready var alchemy_area = $"Alchemy UI/AlchemyArea"
@onready var label = $Label

var spawner
var monsters_on_field = true
var level_time := 30.0
var max_level = 6
var min_spawner_timer = 1

func _process(_delta):
	label.text = get_time()
	
func get_time():
	var time_left = level_up_timer.time_left
	var minutes = floor(time_left/60)
	var seconds = int(time_left) % 60
	return "Time left: %02d s" % [seconds]
	
func _ready():
	spawner = MonsterField.get_child(0)
	level_up_timer.set_wait_time(level_time)
	level_up_timer.start()

func _on_level_up_timeout():
	Game.battle_time = !Game.battle_time
	if !Game.battle_time:
		level_up_timer.stop()
		spawner.timer.stop()
		var spawner_time = spawner.timer.wait_time
		if spawner_time > min_spawner_timer:
			spawner.timer.wait_time = spawner_time - 0.5
		if !monsters_on_field:
			set_crafting_env()
	else:
		set_battling_env()

func _on_monster_field_no_monsters_on_field():
	monsters_on_field = false
	if !Game.battle_time:
		set_crafting_env()
		

func add_cards_from_table_to_deck():
	var alchemy_cards = alchemy_area.get_children()
	for child in alchemy_cards:
		child.reparent(deck)

func set_battling_env():
	MainTransition.change_scene(null)
	remove_card_holder()
	add_cards_from_table_to_deck()
	Game.level_up()
	monsters_on_field = true
	alchemy_ui.visible = false
	battle_ui.visible = true
	level_up_timer.start()
	spawner.timer.start()

func set_crafting_env():
	MainTransition.change_scene(null)
	remove_card_holder()
	battle_ui.visible = false
	monsters_on_field = true
	alchemy_ui.visible = true
	spawner.timer.stop()
	level_up_timer.start()

func remove_card_holder():
	var card_in_hand = get_child(0).get_child(0)
	if card_in_hand:
		get_child(0).get_child(0).queue_free()
