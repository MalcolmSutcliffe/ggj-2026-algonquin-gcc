extends Node2D

var window = preload("res://gameobjects/windows.tscn")
var negative_window = preload("res://gameobjects/negative_window.tscn")

var currentWindow = null
var playerInstance = null

var has_player_died := false

var greetings_index = 0
const greetings = ["Hello, I am negative clippy", "my text is negative", "that is a solid looking pillar there"]

func _on_button_button_down() -> void:
	spawn_negative_window(greetings[greetings_index])
	greetings_index = (greetings_index + 1)%greetings.size()
	
func spawn_negative_window(text):
	if currentWindow != null:
		currentWindow.delete_self()
		currentWindow = null 
	var new_window = negative_window.instantiate()
	new_window.CanBeResized = true
	new_window.CanBeMoved = true
	new_window.set_text(text)
	new_window.set_position(get_position() + Vector2(-300, -150))
	currentWindow = new_window
	get_parent().add_child(new_window)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
