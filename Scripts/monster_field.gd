class_name MonstersField extends Control
var timer_is_stop = false
signal no_monsters_on_field

func monsters_on_field(shadow_card: ShadowCard):
	var children = get_children()
	for child in children:
		if child is ShadowCard and child != shadow_card:
			return true
	return false

func placeCard(card_on_hand: AlchemyCard):
	var children = get_children()
	for shadow_card in children:
		if shadow_card is ShadowCard and shadow_card.mouse_over_card == true:
			shadow_card.receive_attack(card_on_hand.resource.damage)
			break
	card_on_hand.queue_free()

func _on_level_up_timeout():
	timer_is_stop = true

func _on_child_exiting_tree(node):
	if timer_is_stop and not monsters_on_field(node):
		print("_on_child_exiting_tree")
		no_monsters_on_field.emit()
		get_child(0).start_level()
		timer_is_stop = false
