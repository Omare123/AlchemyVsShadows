extends HBoxContainer
const CARD = preload("res://Scene/card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 3:
		var new_card = CARD.instantiate()
		add_child(new_card)


func _on_child_exiting_tree(node):
	var new_card = CARD.instantiate()
	add_child.call_deferred(new_card)
