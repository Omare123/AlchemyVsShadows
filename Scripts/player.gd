class_name Player 
extends Container

@onready var label = $Sprite2D/Label
var health = 100

func _ready():
	label.text = str(health)

func take_damage(damage, position_x):
	health -= damage
	if health <= 0:
		label.text = "0"
		Game.game_over()
	label.text = str(health)
