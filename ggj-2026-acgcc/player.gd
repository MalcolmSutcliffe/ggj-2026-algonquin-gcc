extends CharacterBody2D

@export var speed = 10000
@export var jump_strength = 500

signal player_died

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().move_child(self, -1)
	pass
	
func _physics_process(delta: float) -> void:
	move_horizontal(delta)
	apply_gravity(delta)
	jump()
	move_and_slide()
	
func apply_gravity(delta: float):
	velocity += get_gravity() * delta

func jump():
	if (Input.is_action_just_pressed("jump") and is_on_floor()):
		velocity.y = -jump_strength

func move_horizontal(delta: float):
	var direction = 0
	
	if Input.is_action_pressed("move_right"):
		direction += 1
	if Input.is_action_pressed("move_left"):
		direction -= 1
	
	velocity.x = direction*speed*delta
	
	if direction < 0:
		$AnimationPlayer.play("Walk_Left")
	elif direction == 0:
		$AnimationPlayer.play("Idle_Right")
	elif direction > 0:
		$AnimationPlayer.play("Walk_Right")
	elif direction == 0:
		$AnimationPlayer.play("Idle_Left")

func die():
	player_died.emit()
