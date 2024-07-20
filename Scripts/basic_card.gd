class_name BasicAlchemyCard extends Container
@onready var animation_player = $AnimationPlayer
@onready var card_layout = $CardLayout
const CARD = preload("res://Scene/card.tscn")

const alchemy_placement = "Board/UI/AlchemyPlacement"
var cardHighlighted = false
var offset = Vector2(52, 68)

func _on_mouse_entered():
	animation_player.play("Select")
	cardHighlighted = true

func _on_mouse_exited():
	animation_player.play("Deselect")
	cardHighlighted = false
	
func _on_gui_input(event):
	if (event is InputEventMouseButton) and (event.button_index == 1):
			if event.button_mask == 1:
				if cardHighlighted:
					#Press down and drag
					var cardTemp = CARD.instantiate()
					get_tree().get_root().get_node(alchemy_placement).add_child(cardTemp)
					Game.cardSelected = true
