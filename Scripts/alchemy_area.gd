extends Container

enum {
	ON_HAND,
	ON_FIELD,
	ATTACK,
}
const CARD = preload("res://Scene/card.tscn")

func _on_mouse_entered():
	Game.mouseOnPlacement = true

func _on_mouse_exited():
	Game.mouseOnPlacement = false

func placeCard(card: AlchemyCard):
	var card_overlap = card_to_combine(card)
	if card_overlap != null:
		var new_card = combine_card(card_overlap, card)
		card_overlap.queue_free()
		card.queue_free()
		add_child(new_card)
		return
	card.get_parent().remove_child(card)
	card.global_position = get_global_mouse_position() - self.global_position - Game.offset
	card.card_layout.show()
	card.on_deck = false
	add_child(card)

func card_to_combine(placing_card):
	var cards = get_children()
	for card in cards:
		if card.card_on_top and card != placing_card:
			return card

func combine_card(card_one, card_two):
	print(card_one, " ", card_two)
	var new_card :AlchemyCard = CARD.instantiate()
	var new_resource = CardResource.new()
	new_resource = load("res://Resourcers/explosion_card.tres")
	new_card.resource = new_resource
	new_card.global_position = get_global_mouse_position() - self.global_position - Game.offset
	new_card.on_deck = false
	return new_card
	
