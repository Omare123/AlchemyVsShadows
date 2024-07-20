extends Node2D

const shawdow_card := preload("res://Scene/shadow_card.tscn")
@onready var timer = $Timer
@export var spawners: Array[Marker2D]

func spawn():
	randomize()
	if !spawners.size():
		return
	var random_spawn = spawners[randi() % spawners.size()]
	var enemy = shawdow_card.instantiate()
	if random_spawn != null:
		enemy.position = random_spawn.position
		get_parent().add_child(enemy)

func _on_timer_timeout():
	spawn()
