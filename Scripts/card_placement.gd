extends StaticBody2D

enum {
	ON_HAND,
	ON_FIELD,
	ATTACK,
}


func placeCard(card: AlchemyCard):
	var state = card.state
	if state == ON_HAND:
		var duplicated = card.duplicate()
		duplicated.state = ON_FIELD
		add_child(duplicated)
	elif state == ON_FIELD:
		card.card_layout.show()
