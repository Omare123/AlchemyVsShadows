extends Control
const CARD = preload("res://Scene/card.tscn")
const RESOURCES_PATH = "res://Resourcers/"
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 3:
		var card_name = ""
		if i == 0:
			card_name = "air_card.tres"
		if i == 1:
			card_name = "fire_card.tres"
		if i == 2:
			card_name = "water_card.tres"
		
		var card_resource = CardResource.new()
		card_resource = load(RESOURCES_PATH + card_name)
		var new_card = CARD.instantiate()
		new_card.resource = card_resource
		add_child(new_card)

func _on_child_exiting_tree(node):
	var new_card = CARD.instantiate()
	add_child.call_deferred(new_card)
