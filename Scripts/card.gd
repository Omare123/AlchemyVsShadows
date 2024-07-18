extends Container
@onready var animation_player = $AnimationPlayer
@onready var card_layout = $CardLayout

@onready var card = preload("res://Scene/card_holder.tscn")
var cardHighlighted = false

func _on_mouse_entered():
	animation_player.play("Select")
	cardHighlighted = true

func _on_mouse_exited():
	animation_player.play("Deselect")
	cardHighlighted = false

# Esto maneja de manera individual los eventos que se hagan en cada carta
func _on_gui_input(event):
	if (event is InputEventMouseButton) and (event.button_index == 1):
		if event.button_mask == 1:
			#press down
			if cardHighlighted:
				var cardTemp = card.instantiate()
				get_tree().get_root().get_node("Board/CardHolder").add_child(cardTemp)
				Game.cardSelected = true
				#card_layout.hide()
		elif event.button_mask == 0:
			#Place the card outside board
			if !Game.mouseOnPlacement:
				cardHighlighted = false
				card_layout.show()
			else:
				#Place the card on board
				self.queue_free()
				get_node("../../AlchemyPlacement").placeCard()
			for i in get_tree().get_root().get_node("Board/CardHolder").get_child_count():
					get_tree().get_root().get_node("Board/CardHolder").get_child(i).queue_free()
			Game.cardSelected = false
