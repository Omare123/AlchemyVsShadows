extends Container
var offset = Vector2(52, 68)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.global_position = get_global_mouse_position()
