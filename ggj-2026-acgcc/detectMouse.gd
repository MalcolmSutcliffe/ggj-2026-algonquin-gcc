class_name detectMouse extends Control

var mouse_is_over : bool = false

func _ready():
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered():
	mouse_is_over = true

func _on_mouse_exited():
	mouse_is_over = false

func get_is_mouse_over() -> bool:
	return mouse_is_over
