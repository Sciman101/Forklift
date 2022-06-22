tool
extends Node2D

export var texture : Texture setget _set_texture
export var num_cells : int = 1 setget _set_num_cells
export(float, 0, 6.284) var angle : float setget _set_angle
export var offset : Vector2 setget _set_offset

export var seperation : Vector2 = Vector2.DOWN setget _set_seperation
export var shadow_seperation : Vector2 = Vector2.DOWN
export var start_slice : int = 0 setget _set_start
export var end_slice : int = -1 setget _set_end
export var flip_z : bool setget _set_flip_z

export var draw_shadow : bool

var iterator

var regions = []

func _draw():
	if not texture: return
	
	var w = texture.get_width()
	var h = texture.get_height()
	var h2 = h/num_cells
	
	if draw_shadow:
		for slice in iterator:
			# Get region
			var src_rect = Rect2(0,slice*h2,w,h2)
			var target_rect = Rect2(-w/2,-h2/2,w,h2)
			
			draw_set_transform(Vector2((num_cells-slice)*-shadow_seperation.x,(num_cells-slice)*-shadow_seperation.y) + offset,angle,Vector2.ONE)
			draw_texture_rect_region(texture,target_rect,src_rect,Color.black)
	
	for slice in iterator:
		# Get region
		var src_rect = Rect2(0,slice*h2,w,h2)
		var target_rect = Rect2(-w/2,-h2/2,w,h2)
		
		draw_set_transform(Vector2((num_cells-slice)*-seperation.x,(num_cells-slice)*-seperation.y) + offset,angle,Vector2.ONE)
		draw_texture_rect_region(texture,target_rect,src_rect)

func _set_texture(val):
	texture = val
	update()
func _set_num_cells(val):
	var ma = 0 if not texture else texture.get_height()
	num_cells = clamp(val,0,ma)
	_calculate_iterator()
	update()
func _set_angle(val):
	angle = val
	update()
func _set_offset(val):
	offset = val
	update()
func _set_seperation(val):
	seperation = val
	update()
func _set_start(val):
	start_slice = clamp(val,0,num_cells)
	_calculate_iterator()
	update()
func _set_end(val):
	end_slice = clamp(val,-1,num_cells)
	_calculate_iterator()
	update()
func _set_flip_z(val):
	flip_z = val
	_calculate_iterator()
	update()

func _calculate_iterator():
	if flip_z:
		iterator = range(start_slice,num_cells if end_slice == -1 else end_slice)
	else:
		iterator = range(num_cells if end_slice == -1 else end_slice,start_slice-1,-1)
