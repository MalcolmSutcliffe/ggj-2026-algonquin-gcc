extends Node2D

var window = preload("res://windows.tscn")

var currentWindow = null
var playerInstance = null

const death_text_prompt = "Hi! It looks like you're dying to spikes. Need help?"

func _on_player_died():
	call_deferred("spawn_window", death_text_prompt)

func _on_player_spawned():
	get_parent().playerInstance.player_died.connect(_on_player_died)

func on_click():
	# spawn text box from clicks
	pass

func spawn_window(text):
	if currentWindow != null:
		currentWindow.queue_free()
		currentWindow = null 
	var new_window = window.instantiate()
	new_window.CanBeResized = false
	new_window.CanBeMoved = false
	new_window.set_text(text)
	new_window.set_position(get_position() + Vector2(-500, -200))
	get_parent().add_child(new_window)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().player_spawned.connect(_on_player_spawned)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
