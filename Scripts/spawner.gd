extends Node2D

const shawdow_card := preload("res://Scene/shadow_card.tscn")
@onready var timer: Timer = $Timer
@export var spawners: Array[Marker2D]
var monster_field: MonstersField
var time_to_stop = false

func spawn():
	randomize()
	if !spawners.size():
		return
	var random_range = randi_range(1, Game.shadows_level_cap)
	var cards_json = Game.read_shadow_JSON()
	var card_resource = ShadowCardResource.new()
	var resources_path= cards_json[str(random_range)]["resources"]
	random_range = randi_range(0, resources_path.size() -1)
	var path = resources_path[random_range]
	card_resource = load(path)
	var random_spawn = spawners[randi() % spawners.size()]
	var enemy: ShadowCard = shawdow_card.instantiate()
	enemy.resource = card_resource
	if random_spawn != null:
		enemy.position = random_spawn.position
		get_parent().add_child(enemy)

func _on_timer_timeout():
	spawn()
