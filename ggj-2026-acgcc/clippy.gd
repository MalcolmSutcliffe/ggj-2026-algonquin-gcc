extends Node2D

var window = preload("res://windows.tscn")

var currentWindow = null
var playerInstance = null

var has_player_died := false

const death_text_prompt = "Hi! It looks like you're dying to spikes. Need help?"

var affirmations_index = 0
const positive_affirmations = ["You can do it!", "I believe in you!", "You got this!", "Everyone thinks you are super cool", "brrrrrrr", "You are the best!", "I love you"]

var greetigns_index = 0
const greetings = ["Hello", "Hi", "You got this!", "My name is clippy", "stop clicking me please", "How can I help you?"]

func _on_player_died():
	if !has_player_died:
		call_deferred("spawn_window", death_text_prompt)
		has_player_died = true
	else:
		call_deferred("spawn_window", positive_affirmations[affirmations_index])
		affirmations_index = (affirmations_index + 1)%positive_affirmations.size()

func _on_player_spawned():
	get_parent().playerInstance.player_died.connect(_on_player_died)

func _on_button_button_down() -> void:
	spawn_window(greetings[greetigns_index])
	greetigns_index = (greetigns_index + 1)%greetings.size()

func spawn_window(text):
	if currentWindow != null:
		currentWindow.delete_self()
		currentWindow = null 
	var new_window = window.instantiate()
	new_window.CanBeResized = true
	new_window.CanBeMoved = true
	new_window.set_text(text)
	new_window.set_position(get_position() + Vector2(-300, -150))
	currentWindow = new_window
	get_parent().add_child(new_window)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().player_spawned.connect(_on_player_spawned)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
