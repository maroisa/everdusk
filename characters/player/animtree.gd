extends AnimationTree

func _physics_process(_delta):
	self.set("parameters/walk/blend_position", get_parent().velocity_static)
	self.set("parameters/jump/blend_position", get_parent().velocity_static)
	self.set("parameters/attack/blend_position", get_parent().velocity_static)
	self.set("parameters/attack2/blend_position", get_parent().velocity_static)
