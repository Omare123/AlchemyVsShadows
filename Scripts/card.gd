class_name AlchemyCard extends Container
@onready var animation_player = $AnimationPlayer
@onready var card_layout = $CardLayout
@onready var card_copy = preload("res://Scene/card_holder.tscn")
const card_holder = "Board/CardHolder"

enum {
	ON_HAND,
	ON_FIELD,
	ATTACK,
}
var cardHighlighted = false
var state = ON_HAND

func change_state(new_state):
	state = new_state
		
func _on_mouse_entered():
	if state == ON_HAND:
		animation_player.play("Select")
	cardHighlighted = true

func _on_mouse_exited():
	if state == ON_HAND:
		animation_player.play("Deselect")
	cardHighlighted = false

# Esto maneja de manera individual los eventos que se hagan en cada carta
func _on_gui_input(event):
	match state:
		ON_HAND: 
			createCopy(event)
		ON_FIELD:
			move_card(event)
		ATTACK:
			pass
		_: 
			pass

func createCopy(event):
	if (event is InputEventMouseButton) and (event.button_index == 1):
		if event.button_mask == 1:
			#press down
			card_on_heand()
		elif event.button_mask == 0:
			#Place the card outside board
			if !Game.mouseOnPlacement:
				cardHighlighted = false
				card_layout.show()
			else:
				#Place the card on board
				#self.queue_free()
				get_node("../../AlchemyPlacement").placeCard(self)
			for i in get_tree().get_root().get_node(card_holder).get_child_count():
					get_tree().get_root().get_node(card_holder).get_child(i).queue_free()
			Game.cardSelected = false
			
func move_card(event):
	if (event is InputEventMouseButton) and (event.button_index == 1):
		if event.button_mask == 1:
			#press down
			card_on_heand(true)
	elif event.button_mask == 0:
			#Place the card outside board
			if !Game.mouseOnPlacement:
				cardHighlighted = false
				card_layout.show()
			else:
				get_node("../../AlchemyPlacement").placeCard(self)
			for i in get_tree().get_root().get_node(card_holder).get_child_count():
					get_tree().get_root().get_node(card_holder).get_child(i).queue_free()
			Game.cardSelected = false

func card_on_heand(hide = false):
	if cardHighlighted:
		var cardTemp = card_copy.instantiate()
		get_tree().get_root().get_node(card_holder).add_child(cardTemp)
		Game.cardSelected = true
		if hide:
			card_layout.hide()
