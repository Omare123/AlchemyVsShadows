class_name ShadowCard extends Container

@onready var sprite = $Sprite2D
@onready var healthLabel = $Sprite2D/Heart/Health
@onready var damageLabel = $Sprite2D/Sword/Damage
@onready var timer = $Timer
@onready var resource: ShadowCardResource
@export var damage: int
@export var health: int
@export var level: String
@onready var dead_sound = $Dead

const MAX_MOVEMENTS = 4
const MAX_LEVEL = 3

var card_in_next_position: ShadowCard 
var card_size: Vector2 = Game.offset * 2
var movements_count = 0
var next_position = Vector2.ZERO
var mouse_over_card = false

func _ready():
	if resource:
		change_card()
		
func change_card():
	damage = resource.damage
	health = resource.health
	level = resource.level
	timer.wait_time = resource.walk_speed
	sprite.texture = resource.texture
	
func _process(_delta):
	healthLabel.text = str(health)
	damageLabel.text = str(damage)

func attack():
	var player:Player = get_tree().get_root().get_node("Board/Battle UI/Player")
	var tween := create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	var actual_position = global_position + Game.offset
	var impulse_position = Vector2(actual_position.x, actual_position.y  - 30)
	tween.tween_property(sprite, "global_position", impulse_position, 0.3)
	tween.tween_property(sprite, "global_position", player.global_position + Game.offset, 0.1)
	if movements_count == MAX_MOVEMENTS:
		player.take_damage(damage, global_position.x)
	tween.tween_property(sprite, "global_position", actual_position, 0.2).finished
	
	

func move_card():
	movements_count +=1
	card_in_next_position = check_combination()
	if card_in_next_position:
		card_in_next_position.combine_card(self)
		queue_free()
	var step_to = Vector2(global_position.x, global_position.y + card_size.y)
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	await tween.tween_property(sprite, "scale", sprite.scale + Vector2(0.2, 0.2), 0.1)
	tween.tween_property(self, "global_position", step_to, 0.2)
	await tween.tween_property(sprite, "scale", sprite.scale, 0.1).finished
	global_position = step_to
	next_position = Vector2(global_position.x, global_position.y + card_size.y )

func combine_card(card: ShadowCard):
	randomize()
	var card_level = int(level)
	var next_level = int(card.level) + card_level
	var max_evo_level = Game.shadows_level_cap + 1
	if (next_level > max_evo_level):
		next_level = max_evo_level
		
	if max_evo_level <= Game.MAXIMUN_LEVEL and card_level < max_evo_level:
		var cards_json = Game.read_shadow_JSON()
		var new_resource = ShadowCardResource.new()
		var resources_path= cards_json[str(next_level)]["resources"]
		var random_range = randi_range(0, resources_path.size() -1)
		var path = resources_path[random_range]
		new_resource = load(path)
		resource = new_resource
		change_card()
	else:
		damage += card.damage
		health += card.health

func check_combination():
	var children = get_parent().get_children() 
	for child in children:
		if child is ShadowCard and child.global_position == next_position:
			return child
			
func receive_attack(alchemy_attack):
	var calculated_health = health
	calculated_health -= alchemy_attack
	if  calculated_health <= 0:
		health = 0
	else:
		health = calculated_health
	dead_sound.play()
	if health == 0:
		queue_free()

func _on_timer_timeout():
	if movements_count < MAX_MOVEMENTS:
		move_card()
		if movements_count == MAX_MOVEMENTS:
			timer.wait_time = resource.attack_speed
	else:
		attack()

func _on_mouse_entered():
	Game.mouseOnShadowCard = true
	mouse_over_card = true


func _on_mouse_exited():
	Game.mouseOnShadowCard = false
	mouse_over_card = false
