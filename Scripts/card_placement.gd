extends Control

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

func placeCard(card: AlchemyCard):
	var state = card.state
	if state == ON_HAND:
		var duplicated = card.duplicate()
		duplicated.state = ON_FIELD
		duplicated.global_position = get_global_mouse_position() - self.position - offset
		add_child(duplicated)
	elif state == ON_FIELD:
		var tween = card.create_tween()
		tween.tween_property(self, "global_position", get_global_mouse_position() - self.position, 0.2).set_ease(Tween.EASE_OUT)
