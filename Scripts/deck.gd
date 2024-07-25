extends Control
const CARD = preload("res://Scene/card.tscn")
const basic_cards = ["water", "air", "fire"]

#var deck: Array[AlchemyCard]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#for i in 3:
		#create_card(i)

func _on_child_exiting_tree(node):
	if get_child_count() == 0:
		for number in 3:
			var i = randi_range(0, 2)
			create_card(i)

func create_card(index):
	var cards_json = Game.readJSON()
	var card_resource = CardResource.new()
	var path = cards_json[basic_cards[index]].resource
	card_resource = load(path)
	var new_card = CARD.instantiate()
	new_card.resource = card_resource
	add_child.call_deferred(new_card)
