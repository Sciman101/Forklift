extends Area2D

var knocked_over = false
var motion = Vector2.ZERO

func _on_Cone_body_entered(body):
	if not knocked_over:
		knocked_over = true
		modulate = Color.darkgray
		motion = Vector2(rand_range(-1,1),rand_range(-1,1)).normalized() * rand_range(100,250)
		rotation_degrees = rand_range(0,360)
		z_index = -100
		
		Scorekeeper.add_damage(5)

func _process(delta):
	if knocked_over:
		position += motion * delta
		rotation_degrees += motion.length_squared() * 0.001
		motion = lerp(motion,Vector2.ZERO,delta*5)
