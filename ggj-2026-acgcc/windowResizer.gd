extends Control

var start : Vector2
var initialPosition : Vector2
var isMoving : bool
var isResizing : bool
var resizeX : bool
var resizeY : bool
var initialSize : Vector2

@export var HitBox : CollisionShape2D

@export var minimumSizeY : int
@export var minimumSizeX : int

@export var CanBeResized := true

@export var moverTop : detectMouse
@export var resizerTop : detectMouse
@export var resizerLeft : detectMouse
@export var resizerRight : detectMouse
@export var resizerBottom : detectMouse
@export var resizerBottomLeft : detectMouse
@export var resizerBottomRight : detectMouse
@export var resizerTopLeft : detectMouse
@export var resizerTopRight : detectMouse

var mouse_is_over : bool = false

func _ready():
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))
	set_size(Vector2(minimumSizeX, minimumSizeY))

func _on_mouse_entered():
	mouse_is_over = true

func _on_mouse_exited():
	mouse_is_over = false

func send_to_front():
	get_parent().get_parent().move_child(get_parent(), -1)

func _input(event):
	# make sure event is mouse event
	if not event is InputEventMouse:
		return
	
	if Input.is_action_just_pressed("LeftMouseDown"):
		# move to front
		if (mouse_is_over):
			send_to_front()
		
		if moverTop.get_is_mouse_over():
			start = event.position
			initialPosition = get_global_position()
			isMoving = true
		
		elif resizerTop.get_is_mouse_over():
			start.y = event.position.y
			initialPosition.y = get_global_position().y
			initialSize.y = get_size().y
			isResizing = true
			resizeY = true
		
		elif resizerRight.get_is_mouse_over():
			start.x = event.position.x
			initialSize.x = get_size().x
			resizeX = true
			isResizing = true
			
		elif resizerLeft.get_is_mouse_over():
			start.x = event.position.x
			initialPosition.x = get_global_position().x
			initialSize.x = get_size().x
			isResizing = true
			resizeX = true
			
		elif resizerBottom.get_is_mouse_over():
			start.y = event.position.y
			initialSize.y = get_size().y
			resizeY = true
			isResizing = true
			
		elif resizerBottomRight.get_is_mouse_over():
			start.x = event.position.x
			start.y = event.position.y
			initialSize.x = get_size().x
			initialSize.y = get_size().y
			isResizing = true
			resizeY = true
			resizeX = true
			
		elif resizerBottomLeft.get_is_mouse_over():
			start.x = event.position.x
			start.y = event.position.y
			initialPosition.x = get_global_position().x
			initialSize.x = get_size().x
			initialSize.y = get_size().y
			isResizing = true
			resizeY = true
			resizeX = true
		
		elif resizerTopLeft.get_is_mouse_over():
			start.x = event.position.x
			start.y = event.position.y
			initialPosition.x = get_global_position().x
			initialPosition.y = get_global_position().y
			initialSize.x = get_size().x
			initialSize.y = get_size().y
			isResizing = true
			resizeY = true
			resizeX = true
		
		elif resizerTopRight.get_is_mouse_over():
			start.x = event.position.x
			start.y = event.position.y
			initialPosition.y = get_global_position().y
			initialSize.x = get_size().x
			initialSize.y = get_size().y
			isResizing = true
			resizeY = true
			resizeX = true
		
	if Input.is_action_pressed("LeftMouseDown"):
		if isMoving:
			set_position(initialPosition + (event.position - start))
			send_to_front()
		
		if isResizing:
			var newWidth = get_size().x
			var newHeight = get_size().y
			
			if resizeX:
				newWidth = initialSize.x - (start.x - event.position.x)
				newWidth = max(minimumSizeX, newWidth)
			if resizeY:
				newHeight = initialSize.y - (start.y - event.position.y)
				newHeight = max(minimumSizeY, newHeight)
				
			if initialPosition.x != 0:
				newWidth = initialSize.x + (start.x - event.position.x)
				newWidth = max(minimumSizeX, newWidth)
				set_position(Vector2(initialPosition.x - (newWidth - initialSize.x), get_position().y))
			
			if initialPosition.y != 0:
				newHeight = initialSize.y + (start.y - event.position.y)
				newHeight = max(minimumSizeY, newHeight)
				set_position(Vector2(get_position().x, initialPosition.y - (newHeight - initialSize.y)))
			
			send_to_front()
			set_size(Vector2(newWidth, newHeight))
			var rect = get_global_rect()
			HitBox.shape.size = Vector2(newWidth, newHeight)
			HitBox.position = rect.size/2
			
		
	if Input.is_action_just_released("LeftMouseDown"):
		isMoving = false
		initialPosition = Vector2(0,0)
		resizeX = false
		resizeY = false
		isResizing = false


func _on_close_button_pressed() -> void:
	self.queue_free()
