class_name MainMenu extends Control
@onready var main_level = preload("res://Scene/board.tscn")
@onready var main = $Main
@onready var back_button = $Back

func _on_start_button_button_down():
	MainTransition.change_scene(main_level)
	#get_tree().change_scene_to_packed(main_level)

func _on_quit_button_button_down():
	get_tree().quit()
