extends WindowResizer

@export var distance : int
@export var direction : Vector2
@export var period : int
@export var startingPosition: Vector2

var totalTime = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	totalTime += delta
	if (totalTime > period):
		totalTime -= period
	#print(sin(2*PI*totalTime/period))
	set_position(startingPosition + sin(2*PI*totalTime/period)*direction*distance)
	update_position()
	
func _on_close_button_pressed() -> void:
	pass
