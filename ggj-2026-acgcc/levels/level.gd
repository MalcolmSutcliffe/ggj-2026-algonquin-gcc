extends Node2D

const PLAYER = preload("res://gameobjects/player.tscn")
var playerInstance = null

signal player_spawned

@export var spawnpoint : Vector2
@export var terrain_poly : CollisionPolygon2D

func _on_player_died():
	respawn_player()

func respawn_player():
	if playerInstance != null:
		playerInstance.queue_free()
		playerInstance = null
	spawn_player()
	
func spawn_player():
	if playerInstance != null:
		return
	playerInstance = PLAYER.instantiate()
	playerInstance.player_died.connect(_on_player_died)
	playerInstance.position = spawnpoint
	call_deferred("add_child", playerInstance)
	player_spawned.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_terrain()
	spawn_player() 
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_terrain(new_poly):
	for innocent_child in $ProgramaticTerrain.get_children():
		innocent_child.queue_free()
	for poly in new_poly:
		var new_poly_instance = CollisionPolygon2D.new()
		new_poly_instance.polygon = poly
		$ProgramaticTerrain.add_child(new_poly_instance)

func make_terrain():
	pass
	var level_terrain = null
	
	# loop through children
	for child in get_children():
		# select group marked "terrain"
		if !child.is_in_group("terrain"):
			continue
		
		if level_terrain == null:
			level_terrain = [child.get_polygon()]
			continue
		
		if child.is_in_group("negative"):
			var poly2 = child.get_polygon()
			var new_level_terrain = []
			for poly in level_terrain:
				var new_poly = Geometry2D.clip_polygons(poly, poly2)
				for new_new_poly in new_poly:
					new_level_terrain.append(new_new_poly)
			level_terrain = new_level_terrain
		else:
			level_terrain.append(child.get_polygon())
	
	# set collision shape to the level terrain
	set_terrain(level_terrain)
