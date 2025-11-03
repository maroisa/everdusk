extends KinematicBody2D

const SPEED = 150

var velocity_static = Vector2()
var velocity = Vector2()

onready var animstate = $AnimationTree.get("parameters/playback")
