extends Control

var player: = preload("res://gameobjects/player.tscn")
var level_1: = preload("res://levels/level_1.tscn")
var level_2: = preload("res://levels/level_2.tscn")
var level_3: = preload("res://levels/level_3.tscn")

func _on_back_pressed() -> void:
	$"../MainMenu".visible = true
	visible = false

func _on_1_pressed() -> void:
	enter_level(level_1)

func _on_2_pressed() -> void:
	enter_level(level_2)
	
func _on_3_pressed() -> void:
	enter_level(level_3)

func enter_level(level: Resource) -> void:
	$"..".visible = false
	var level_to_spawn = level.instantiate()
	$"../..".add_child(level_to_spawn)
