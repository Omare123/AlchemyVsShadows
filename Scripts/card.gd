class_name AlchemyCard extends Container
@onready var card_layout = $CardLayout
const CARD_HOLDER = preload("res://Scene/card_holder.tscn")
const card_holder = "Board/CardHolder"
var cardHighlighted = false
var offset = Vector2(52, 68)

func _on_mouse_entered():
	cardHighlighted = true

func _on_mouse_exited():
	cardHighlighted = false
	
func _on_gui_input(event):
	if (event is InputEventMouseButton) and (event.button_index == 1):
			if event.button_mask == 1:
				if cardHighlighted:
					#Press down and drag
					var cardTemp = CARD_HOLDER.instantiate()
					get_tree().get_root().get_node("Board/CardHolder").add_child(cardTemp)
					Game.cardSelected = true
					if cardHighlighted:
						card_layout.hide()
						
			elif event.button_mask == 0:
				#press up and let go
				#check for area
				if !Game.mouseOnPlacement:
					cardHighlighted = false
					card_layout.show()
				else:
					#place card on board
					get_node("../../AlchemyArea").placeCard(self)
				for i in get_tree().get_root().get_node(card_holder).get_child_count():
					get_tree().get_root().get_node(card_holder).get_child(i).queue_free()
				Game.cardSelected = false
	
