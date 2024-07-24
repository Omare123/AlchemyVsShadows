extends Node

@onready var level_up_timer = $"Level Up"

var level_time := 30.0

func _ready():
	level_up_timer.set_wait_time(level_time)
	add_child(level_up_timer)
	level_up_timer.one_shot = true
	level_up_timer.start()


func _on_level_up_timeout():
	pass # Replace with function body.


func _on_monster_field_no_monsters_on_field():
	Game.level_up()
	level_up_timer.start()
