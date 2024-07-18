extends BoxContainer

enum {
	ON_HAND,
	ON_FIELD,
	ATTACK,
}

func _on_mouse_entered():
	Game.mouseOnPlacement = true


func _on_mouse_exited():
	Game.mouseOnPlacement = false

func placeCard(card: AlchemyCard):
	var state = card.state
	if state == ON_HAND:
		var duplicated = card.duplicate()
		duplicated.state = ON_FIELD
		#var projectResolution = ProjectSettings.get_setting("display/window/size/viewport_width")
		#var projectResolitionHeight = ProjectSettings.get_setting("display/window/size/viewport_height")
		#duplicated.global_position = Vector2(projectResolution/2, projectResolitionHeight/2) - self.position
		add_child(duplicated)
	elif state == ON_FIELD:
		card.card_layout.show()
