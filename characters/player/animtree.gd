extends AnimationTree

func _physics_process(delta):
	self.set("parameters/Idle/blend_position", get_parent().velocity_static.x)
	self.set("parameters/Walk/blend_position", get_parent().velocity_static.x)
	self.set("parameters/Jump/blend_position", get_parent().velocity_static.x)
	self.set("parameters/Attack/blend_position", get_parent().velocity_static.x)
