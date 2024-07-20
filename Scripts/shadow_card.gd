class_name ShadowCard extends Container

@onready var healthLabel = $Health
@onready var damageLabel = $Damage
@onready var timer = $Timer

const MAX_MOVEMENTS = 3

@export var damage = 1
@export var health = 2
 
var card_size: Vector2 = Game.offset * 2
var movements_count = 0
var next_position = Vector2.ZERO

func _process(delta):
	healthLabel.text = "Vida: " + str(health)
	damageLabel.text = "Daño: " + str(damage)

func move_card():
	var card_in_next_position = check_combination()
	if card_in_next_position:
		card_in_next_position.combine_card(self)
		queue_free()
	movements_count +=1
	position.y = position.y + card_size.y 
	next_position = Vector2(position.x, position.y + card_size.y )

func combine_card(card: ShadowCard):
	damage += card.damage
	health += card.health

func check_combination():
	var children = get_parent().get_children() 
	for child in children:
		if child is ShadowCard and child.position == next_position:
			return child

func _on_timer_timeout():
	if movements_count < MAX_MOVEMENTS:
		move_card()
	else:
		timer.stop()
