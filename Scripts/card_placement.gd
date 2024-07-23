extends Container

enum {
	ON_HAND,
	ON_FIELD,
	ATTACK,
}

func _on_mouse_entered():
	Game.mouseOnAlchemyArea = true

func _on_mouse_exited():
	Game.mouseOnAlchemyArea = false

func placeCard(card):
	card.get_parent().remove_child(card)
	card.global_position = get_global_mouse_position() - self.global_position - Game.offset
	card.card_layout.show()
	add_child(card)
