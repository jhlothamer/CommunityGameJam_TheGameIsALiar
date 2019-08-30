extends Node

export var tile_map_node : NodePath

var invisible_tile_material = preload("res://assets/shaders/revealMaterial.tres")
var fake_tile_material = preload("res://assets/shaders/revealFakeMaterial.tres")

var portal_scene = preload("res://scenes/environment/exitDoor.tscn")
var spike_scene = preload("res://scenes/environment/spike.tscn")

var object_offset = Vector2(8.0, -8.0)

func _ready():
	process_tile_map()

func get_tile_maps() -> Array:
	var tile_map_parent = get_node(tile_map_node)
	return tile_map_parent.get_children()

func process_tile_map():
	var tile_maps = get_tile_maps()
	for tile_map in tile_maps:
		if tile_map is TileMap:
			if tile_map.name.begins_with("invisible"):
				process_invisible_tiles(tile_map)
			elif tile_map.name.begins_with("fake"):
				process_fake_tiles(tile_map)
		elif tile_map is Node2D:
			process_objects(tile_map)
		

func process_objects(object_layer):
	for obj in object_layer.get_children():
		var type = obj.get_meta("type")
		print(type)
		var new_object = null
		
		if type == "portal":
			new_object = portal_scene
		elif type == "spike":
			new_object = spike_scene
			
		if new_object:
			var new_instance = new_object.instance()
			get_parent().get_node("objects").add_child(new_instance)
			new_instance.set_position(obj.get_position() + object_offset)
			if object_layer.name.begins_with("invisible"):
				process_invisible_object(new_instance)
			elif object_layer.name.begins_with("fake"):
				process_fake_object(new_instance)
			if obj.has_meta("flip") and new_instance.has_method("flip"):
				new_instance.flip(true)
	#remove object layer
	object_layer.queue_free()

func process_invisible_tiles(tile_map : TileMap):
	tile_map.material = invisible_tile_material

func process_fake_tiles(tile_map : TileMap):
	tile_map.material = fake_tile_material
	tile_map.collision_layer = 2
	tile_map.collision_mask = 2

func get_level_bottom():
	var depth = 0
	var tile_maps = get_tile_maps()
	for tile_map in tile_maps:
		if tile_map is TileMap:
			var rect = tile_map.get_used_rect()
			var tile_height = tile_map.cell_size.y
			var map_depth = (rect.position.y + rect.size.y ) * tile_height
			if map_depth > depth:
				depth = map_depth
	return depth
			
func process_fake_object(obj):
	obj.material = fake_tile_material
	if obj.has_method("set_fake_collision"):
		obj.set_fake_collision()

func process_invisible_object(obj):
	obj.material = invisible_tile_material