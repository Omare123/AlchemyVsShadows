extends Control

func placeCard(card_on_hand: AlchemyCard):
	var children = get_children()
	for shadow_card in children:
		if shadow_card is ShadowCard and shadow_card.mouse_over_card == true:
			shadow_card.receive_attack(card_on_hand.resource.damage)
			break
	card_on_hand.queue_free()
