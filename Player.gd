extends KinematicBody2D

onready var Sprite_Default = preload("res://forklift.png")
onready var Sprite_Crate = preload("res://forklift crate.png")

export var move_speed : float
export var acceleration : float
export var turn_speed : float

onready var spritestack = $ViewportContainer/Viewport/SpriteStack

var speed = 0

func _physics_process(delta):
	
	# Input
	var steering = Input.get_axis("left","right")
	var movement = Input.get_axis("reverse","accelerate")
	if movement < 0: movement *= 0.5
	
	# Steer
	var angle = spritestack.angle
	angle += steering * speed * turn_speed * delta
	var direction = Vector2.RIGHT.rotated(angle-PI/2)
	
	# Accelerate
	var target_speed = move_speed * movement
	speed = move_toward(speed,target_speed,delta*acceleration)
	
	
	spritestack.angle = angle
	move_and_slide(direction * speed)
