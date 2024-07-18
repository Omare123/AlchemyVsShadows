class_name AlchemyCard extends Node2D
@onready var animation_player = $AnimationPlayer
@onready var card_layout = $CardLayout

enum {
	ON_HAND,
	ON_FIELD,
	ATTACK,
}
var cardHighlighted = false
var state = ON_HAND
var draggable = false
var is_inside_dragable = false
var offset: Vector2
var initialPos: Vector2

# Esto maneja de manera individual los eventos que se hagan en cada carta
func _process(delta):
	if not self.draggable:
		return
	move_card()
			
func move_card():
	if Input.is_action_just_pressed("click"):
		#press down
		initialPos = global_position
		offset = get_global_mouse_position() - global_position
		Game.is_draggin = true
	if Input.is_action_pressed("click"):
		global_position = get_global_mouse_position() - offset
	elif Input.is_action_just_released("click"):
		Game.is_draggin = false
		var tween = get_tree().create_tween()
		if self.is_inside_dragable:
			tween.tween_property(self, "position", get_global_mouse_position() - offset, 0.2).set_ease(Tween.EASE_OUT)
		else:
			tween.tween_property(self, "position", initialPos, 0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_body_entered(body):
	if body.is_in_group("dropable"):
		self.is_inside_dragable = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("dropable"):
		self.is_inside_dragable = false

func _on_area_2d_mouse_entered():
	if not Game.is_draggin:
		self.draggable = true
		animation_player.play("Select")

func _on_area_2d_mouse_exited():
	if not Game.is_draggin:
		self.draggable = false
		animation_player.play("Deselect")
