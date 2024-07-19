class_name AlchemyCard extends Container
@onready var animation_player = $AnimationPlayer
@onready var card_layout = $CardLayout
@onready var card_copy = preload("res://Scene/card_holder.tscn")
const card_holder = "Board/CardHolder"

enum {
	ON_DECK,
	ON_HAND,
	ON_FIELD,
	ATTACK,
}
var cardHighlighted = false
var state = ON_DECK
var offset = Vector2(52, 68)

func _on_mouse_entered():
	if state == ON_DECK:
		animation_player.play("Select")
	cardHighlighted = true

func _on_mouse_exited():
	if state == ON_DECK:
		animation_player.play("Deselect")
	cardHighlighted = false
	
func _process(delta):
	if state == ON_HAND:
		global_position = get_global_mouse_position() - offset
# Esto maneja de manera individual los eventos que se hagan en cada carta
func _on_gui_input(event):
	match state:
		ON_DECK:
			createCopy(event)
		ON_HAND: 
			move_card(event)
		ON_FIELD:
			pass
		ATTACK:
			pass
		_: 
			pass

func createCopy(event):
	if (event is InputEventMouseButton) and (event.button_index == 1):
		if event.button_mask == 1:
			#press down
			var new_card = duplicate()
			new_card.state = ON_HAND
			get_parent().add_child(new_card)
			
func move_card(event):
	if (event is InputEventMouseButton) and (event.button_index == 1):
		state = ON_FIELD
		global_position = get_global_mouse_position() - offset

func card_on_heand(hide = false):
	if cardHighlighted:
		global_position = get_global_mouse_position()
		#var cardTemp = card_copy.instantiate()
		#get_tree().get_root().get_node(card_holder).add_child(cardTemp)
		#Game.cardSelected = true
		#if hide:
			#card_layout.hide()
