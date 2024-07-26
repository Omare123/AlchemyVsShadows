extends Control
const CARD = preload("res://Scene/card.tscn")
const basic_cards = ["water", "air", "fire"]
const show_cards = 4

func _on_child_exiting_tree(node):
	var child_count = get_child_count()
	if child_count > show_cards:
		get_child(show_cards).visible = true
		
	if child_count == 0:
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

func _on_child_entered_tree(node):
	if get_child_count() >= show_cards:
		node.visible = false
