extends Area2D

var active = false
var velocity: Vector2

func _ready():
	self.connect("body_entered", self, "on_entered")
	set_active(false)

func on_entered(body):
	print(body.name)
	self.set_active(false)
	body.emit_signal("on_hit", 1)

func set_active(active: bool):
	self.active = active
	$CollisionShape2D.set_deferred("disabled", !active)
	
	if active: self.show()
	else: self.hide()
	

func _physics_process(delta):
	if active:
		self.position += velocity * 3
		if self.position.length() > 500:
			set_active(false)


func _on_Bullet_body_entered(body):
	print(body)
