extends CanvasLayer

const MAX_SANITY = 100

var player: KinematicBody2D
var current_choice

func _ready():
	for i in $Selection/M/HB.get_children():
		i.connect("pressed", self, "on_selected", [i.name])
	
	$SanityTimer.connect("timeout", self, "on_sanity_drained")
	$ColorRect.material.set_shader_param("intensity", 0)

func set_max_health(value):
	$M/HB/HealthBar.max_value = value
	$M/HB/HealthBar.value = value

func set_health(value):
	$M/HB/HealthBar.value = value

func activate_sanity():
	$M/HB/SanityBar.max_value = MAX_SANITY
	$M/HB/SanityBar.value = MAX_SANITY
	$SanityTimer.start()

func on_sanity_drained():
	$M/HB/SanityBar.value -= 1
	$ColorRect.material.set_shader_param("intensity", 2 - $M/HB/SanityBar.value / 50)
	
	if $M/HB/SanityBar.value <= 0:
		$SanityTimer.stop()
		var tw = create_tween().tween_property($ColorRect, "material:shader_param/intensity", 20, 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		yield(tw, "finished")
		get_tree().change_scene("res://canvases/insanity.tscn")

func on_selected(choice):
	if choice == current_choice:
		$M/HB/SanityBar.value += 30
		$C/Label.text = "Benar!!"
		$C/AnimationPlayer.play("pop")
	else:
		$M/HB/SanityBar.value -= 5
		$C/Label.text = "Salah!!"
		$C/AnimationPlayer.play("pop")
	
	get_parent().on_selected()
	$Selection.hide()

func set_choice(choice):
	$Selection.show()
	current_choice = choice

func hide_choice():
	$Selection.hide()
