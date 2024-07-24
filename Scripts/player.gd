class_name Player 
extends Container

var health = 100

func take_damage(damage, position_x):
	health -= damage
	if health <= 0:
		Game.game_over()
