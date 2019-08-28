extends Node

export var tile_map_node : NodePath

var invisible_tile_material = preload("res://assets/shaders/revealMaterial.tres")
var fake_tile_material = preload("res://assets/shaders/revealFakeMaterial.tres")

var portal_scene = preload("res://scenes/environment/exitDoor.tscn")

func _ready():
	process_tile_map()

func get_tile_maps() -> Array:
	var tile_map_parent = get_node(tile_map_node)
	return tile_map_parent.get_children()

func process_tile_map():
	var tile_maps = get_tile_maps()
	for tile_map in tile_maps:
		if tile_map is TileMap:
			if tile_map.name == "invisible":
				process_invisible_tiles(tile_map)
			elif tile_map.name == "fake":
				process_fake_tiles(tile_map)
		elif tile_map is Node2D:
			process_objects(tile_map)
		

func process_objects(object_layer):
	for obj in object_layer.get_children():
		var type = obj.get_meta("type")
		var new_object = null
		
		if type == "portal":
			new_object = portal_scene
			
		if new_object:
			var new_instance = new_object.instance()
			get_parent().get_node("objects").add_child(new_instance)
			new_instance.set_position(obj.get_position())
	#remove object layer
	object_layer.queue_free()

func process_invisible_tiles(tile_map : TileMap):
	tile_map.material = invisible_tile_material

func process_fake_tiles(tile_map : TileMap):
	tile_map.material = fake_tile_material
	tile_map.collision_layer = 2
	tile_map.collision_mask = 2

func get_level_bottom():
	var tile_maps = get_tile_maps()
	for tile_map in tile_maps:
		if tile_map is TileMap:
			var rect = tile_map.get_used_rect()
			var depth = rect.y * tile_map.cell_size.y
			return depth
			
func post_import(scene):
	return scene