extends BoxContainer
@onready var CARD_ON_BOARD = preload("res://Scene/card_on_board.tscn")

func _on_mouse_entered():
	Game.mouseOnPlacement = true


func _on_mouse_exited():
	Game.mouseOnPlacement = false

func placeCard():
	var card = CARD_ON_BOARD.instantiate()
	var projectResolution = ProjectSettings.get_setting("display/window/size/viewport_width")
	var projectResolitionHeight = ProjectSettings.get_setting("display/window/size/viewport_height")
	card.global_position = Vector2(projectResolution/2, projectResolitionHeight/2) - self.position
	add_child(card)
