extends Control

var player: = preload("res://player.tscn")
var level_1: = preload("res://levels/level_1.tscn")

func _on_back_pressed() -> void:
	$"../MainMenu".visible = true
	visible = false

func _on_1_pressed() -> void:
	enter_level(level_1)

func spawn_player() -> void:
	var player_to_spawn = player.instantiate()
	$"../..".add_child(player_to_spawn)

func enter_level(level: Resource) -> void:
	$"..".visible = false
	var level_to_spawn = level.instantiate()
	$"../..".add_child(level_to_spawn)
	spawn_player()
