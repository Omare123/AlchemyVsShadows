extends CanvasLayer
@onready var animation_player = $AnimationPlayer
@onready var audio_stream_player = $AudioStreamPlayer

var next_scene
var changed = false

func change_scene(targer):
	animation_player.play("transition")
	next_scene = targer
	changed = true

func _on_animation_player_animation_finished(anim_name):
	if changed:
		if next_scene != null:
			get_tree().change_scene_to_packed(next_scene)
		animation_player.play_backwards("transition")
		changed = false
		audio_stream_player.play()
