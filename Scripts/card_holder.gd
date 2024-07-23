class_name CardHolder extends Container
@export var resource: CardResource
@onready var card_layout = $CardLayout

func _ready():
	if resource:
		card_layout.texture = resource.texture

func _process(delta):
	global_position = get_global_mouse_position() - Game.offset
