extends Node2D

const PLAYER = preload("res://player.tscn")
var playerInstance = null

@export var spawnpoint : Vector2

func respawn_player():
	if playerInstance != null:
		playerInstance.queue_free()
		playerInstance = null
	spawn_player()

func spawn_player():
	if playerInstance != null:
		return
	playerInstance = PLAYER.instantiate()
	call_deferred("add_child", playerInstance)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_player()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
