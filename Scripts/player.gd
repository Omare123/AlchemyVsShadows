class_name Player 
extends StaticBody2D

signal health_depleted

var health = 100

func take_damage(damage, position_x):
	print(damage, " ", position_x)
	health -= damage
	if health <= 0:
		health_depleted.emit()
