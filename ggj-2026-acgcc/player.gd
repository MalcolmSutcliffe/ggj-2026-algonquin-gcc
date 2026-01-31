extends CharacterBody2D
@export var speed = 10000
@export var jump_strength = 500
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size
	
func _physics_process(delta: float) -> void:
	move_horizontal(delta)
	apply_gravity(delta)
	
	if Input.is_action_just_pressed("jump"):
		try_jump()
	
	move_and_slide()

func apply_gravity(delta: float):
	velocity += get_gravity() * delta

func try_jump():
	if (is_on_floor()):
		velocity.y = -jump_strength

func move_horizontal(delta: float):
	var direction = 0
	
	direction = Input.get_axis("move_left", "move_right")
	
	velocity.x = direction * speed * delta
	
	if direction:
		if direction < 0:
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
