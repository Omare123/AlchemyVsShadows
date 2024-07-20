class_name AlchemyCard extends Container

@export var resource: CardResource
@onready var card_layout = $CardLayout
@onready var anim = $Anim
@onready var label = $Label

const CARD_HOLDER = preload("res://Scene/card_holder.tscn")
const card_holder = "Board/CardHolder"

var cardHighlighted = false
var on_deck = true
var card_on_top = false
var on_hand = false
var damage = 0

func _ready():
	if resource:
		damage = resource.damage
		card_layout.texture = resource.texture
		label.text = str(damage)

func _process(delta):
	if cardHighlighted and Game.cardSelected and not on_hand:
		card_on_top = true
	else:
		card_on_top = false

func _on_mouse_entered():
	cardHighlighted = true
	if on_deck:
		anim.play("Select")

func _on_mouse_exited():
	cardHighlighted = false
	if on_deck:
		anim.play("DeSelect")
	
func _on_gui_input(event):
	if (event is InputEventMouseButton) and (event.button_index == 1):
			if event.button_mask == 1:
				if cardHighlighted:
					#Press down and drag
					var cardTemp: CardHolder = CARD_HOLDER.instantiate()
					cardTemp.resource = resource
					cardTemp.custom_minimum_size = custom_minimum_size
					get_tree().get_root().get_node(card_holder).add_child(cardTemp)
					Game.cardSelected = true
					on_hand = true
					if cardHighlighted:
						card_layout.hide()
						
			elif event.button_mask == 0:
				#press up and let go
				#check for area
				if !Game.mouseOnPlacement:
					cardHighlighted = false
					card_layout.show()
				else:
					#place card on board
					get_node("../../AlchemyArea").placeCard(self)
				for i in get_tree().get_root().get_node(card_holder).get_child_count():
					get_tree().get_root().get_node(card_holder).get_child(i).queue_free()
				Game.cardSelected = false
				on_hand = false
	
