extends Container

var card_size: Vector2 = Game.offset * 2

func move_card():
	position.y = position.y + card_size.y 
	
func _on_timer_timeout():
	move_card()
