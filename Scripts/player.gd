class_name Player 
extends Container
signal player_dead
@onready var label = $Sprite2D/Label
var health = 100

func _ready():
	label.text = str(health)

func take_damage(damage, position_x):
	health -= damage
	if health <= 0:
		health = 0
		player_dead.emit()
	label.text = str(health)
