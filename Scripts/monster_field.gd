class_name MonstersField extends Control
var timer_is_stop = false
var no_monsters_on_field: Signal

func _ready():
	Game.timer.timeout.connect(_on_level_up_timeout)

func _process(_delta):
	if timer_is_stop and not monsters_on_field():
		print("MonstersField monsters_on_field")
		no_monsters_on_field.emit()
		timer_is_stop = false
		Game.level_up()
		get_child(0).level_up()
		
func monsters_on_field():
	var children = get_children()
	for child in children:
		if child is ShadowCard:
			return true
	return false

func placeCard(card_on_hand: AlchemyCard):
	var children = get_children()
	for shadow_card in children:
		if shadow_card is ShadowCard and shadow_card.mouse_over_card == true:
			shadow_card.receive_attack(card_on_hand.resource.damage)
			break
	card_on_hand.queue_free()


func _on_level_up_timeout():
	timer_is_stop = true
