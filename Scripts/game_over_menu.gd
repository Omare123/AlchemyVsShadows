extends CanvasLayer
@onready var pause_ui = $Control
var pause = true

func _ready():
	get_tree().paused = pause

func _on_restart_button_down():
	get_tree().paused = false
	get_tree().reload_current_scene()
	queue_free()

func _on_quit_button_down():
	get_tree().quit()
