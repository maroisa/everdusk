extends KinematicBody2D

signal on_hit

export var health: int = 100

func _ready():
	self.connect("on_hit", self, "on_hit")
	if $Sprite.material:
		$Sprite.material = $Sprite.material.duplicate()

func on_hit():
	self.health -= 1 
	if self.health <= 0:
		$Sprite.modulate.a = 0.5
		$CollisionShape2D.set_deferred("disabled", true)
	
	$Sprite.material.set_shader_param("flash", true)
	yield(get_tree().create_timer(0.1), "timeout")
	$Sprite.material.set_shader_param("flash", false)
