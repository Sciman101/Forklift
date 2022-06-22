extends CanvasLayer

onready var tween = $Tween
onready var damages_label = $Damages

var damages = 0

func add_damage(dmg:int):
	if damages == 0:
		tween.interpolate_property(damages_label,'rect_position:y',-48,8,0.2,Tween.TRANS_CUBIC,Tween.EASE_OUT)
		tween.start()
	damages += dmg
	damages_label.text = "Damages: %d$" % damages
