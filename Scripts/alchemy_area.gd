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

func placeCard(card_on_hand: AlchemyCard):
	var card_on_field = card_to_combine(card_on_hand)
	if card_on_field != null:
		var new_card = combine_card(card_on_field, card_on_hand)
		if new_card:
			card_on_field.queue_free()
			card_on_hand.queue_free()
			add_child(new_card)
			return
	card_on_hand.get_parent().remove_child(card_on_hand)
	card_on_hand.global_position = get_global_mouse_position() - self.global_position - Game.offset
	card_on_hand.card_layout.show()
	card_on_hand.on_deck = false
	add_child(card_on_hand)

func card_to_combine(card_on_hand):
	var cards = get_children()
	for card in cards:
		if card.card_on_top and card != card_on_hand:
			return card

func combine_card(card_on_field: AlchemyCard, card_on_hand: AlchemyCard):
	var combination = get_combination(card_on_field, card_on_hand)
	if combination == null:
		return
	var new_card :AlchemyCard = CARD.instantiate()
	var new_resource = CardResource.new()
	new_resource = load(get_resource_path(combination))
	new_card.resource = new_resource
	new_card.global_position = get_global_mouse_position() - self.global_position - Game.offset
	new_card.on_deck = false
	return new_card

func get_combination(card_on_field: AlchemyCard, card_on_hand: AlchemyCard):
	var card_on_field_data = Game.readJSON()[card_on_field.resource.id]
	var card_on_hand_data = Game.readJSON()[card_on_hand.resource.id]
	
	var combination_on_field_data = card_on_field_data["combinations"]
	var combination_on_hand_data = card_on_hand_data["combinations"]
	#had to make it like this because basic card would have combination information
	if !combination_on_field_data or !combination_on_hand_data:
		return
	return combination_on_field_data[card_on_hand.resource.id]

func get_resource_path(id : String):
	var cards_data = Game.readJSON()
	var card_data = cards_data[id]
	return card_data["resource"]
