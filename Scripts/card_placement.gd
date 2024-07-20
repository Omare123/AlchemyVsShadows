extends Container

enum {
	ON_HAND,
	ON_FIELD,
	ATTACK,
}
var offset = Vector2(52, 68)

func _on_mouse_entered():
	Game.mouseOnPlacement = true

func _on_mouse_exited():
	Game.mouseOnPlacement = false

func placeCard(card):
	card.get_parent().remove_child(card)
	card.global_position = get_global_mouse_position() - self.global_position - offset
	card.card_layout.show()
	add_child(card)
