extends Node

class_name terrain

func get_polygon():
	# get collisionshape2D child
	for child in get_children():
		if child is CollisionPolygon2D:
			return child.polygon
