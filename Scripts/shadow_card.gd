class_name ShadowCard extends Container

@onready var healthLabel = $Sprite2D/Health
@onready var damageLabel = $Sprite2D/Damage
@onready var timer = $Timer

@onready var player: Player = %Player

const MAX_MOVEMENTS = 3

@export var damage = 1
@export var health = 2
 
var card_size: Vector2 = Game.offset * 2
var movements_count = 0
var next_position = Vector2.ZERO
var mouse_over_card = false

func _process(_delta):
	healthLabel.text = "health: " + str(health)
	damageLabel.text = "attack: " + str(damage)

func attack():
	if movements_count == MAX_MOVEMENTS:
		get_tree().get_root().get_node("Board/Player").take_damage(damage)

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
			

func receive_attack(alchemy_attack):
	var calculated_health = health
	calculated_health -= alchemy_attack
	if  calculated_health <= 0:
		health = 0
	else:
		health = calculated_health
	
	if health == 0:
		queue_free()

func _on_timer_timeout():
	if movements_count < MAX_MOVEMENTS:
		move_card()
	else:
		timer.wait_time = 4
		attack()


func _on_mouse_entered():
	Game.mouseOnShadowCard = true
	mouse_over_card = true


func _on_mouse_exited():
	Game.mouseOnShadowCard = false
	mouse_over_card = true
