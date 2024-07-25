extends Node

@onready var level_up_timer = $"Level Up"
@onready var battle_ui = $"Battle UI"
@onready var alchemy_ui = $"Alchemy UI"
@onready var spawner = $"Battle UI/MonsterField/Spawner"
@onready var deck = $"Battle UI/Deck"
@onready var alchemy_area = $"Alchemy UI/AlchemyArea"

var monsters_on_field = true
var level_time := 10.0

func _ready():
	level_up_timer.set_wait_time(level_time)
	level_up_timer.start()


func _on_level_up_timeout():
	Game.battle_time = !Game.battle_time
	if !Game.battle_time:
		level_up_timer.stop()
		spawner.timer.stop()
		if !monsters_on_field:
			set_crafting_env()
	else:
		set_battling_env()

func _on_monster_field_no_monsters_on_field():
	if !Game.battle_time:
		set_crafting_env()
	else:
		monsters_on_field = false

func add_cards_from_table_to_deck():
	var alchemy_cards = alchemy_area.get_children()
	for child in alchemy_cards:
		child.reparent(deck)

func set_battling_env():
	add_cards_from_table_to_deck()
	Game.level_up()
	monsters_on_field = true
	alchemy_ui.visible = false
	battle_ui.visible = true
	level_up_timer.start()
	spawner.timer.start()

func set_crafting_env():
	battle_ui.visible = false
	monsters_on_field = true
	alchemy_ui.visible = true
	spawner.timer.stop()
	level_up_timer.start()
