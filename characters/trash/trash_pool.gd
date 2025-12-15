extends Node2D
class_name Pool

func spawn():
	for i in get_children():
		if !i.active:
			i.set_active(true)
			i.global_position = self.global_position
			i.velocity = Vector2(-1, 0)
			i.position = Vector2(-24, 2)
			return
