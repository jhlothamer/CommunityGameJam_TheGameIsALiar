extends Node

export var tile_map_node : NodePath

var invisible_tile_material = preload("res://assets/shaders/revealMaterial.tres")
var fake_tile_material = preload("res://assets/shaders/revealFakeMaterial.tres")

func _ready():
	process_tile_map()

func get_tile_maps() -> Array:
	var tile_map_parent = get_node(tile_map_node)
	
	return tile_map_parent.get_children()

func process_tile_map():
	var tile_maps = get_tile_maps()
	for tile_map in tile_maps:
		if tile_map.name == "invisible":
			process_invisible_tiles(tile_map)
		elif tile_map.name == "fake":
			process_fake_tiles(tile_map)

func process_invisible_tiles(tile_map : TileMap):
	tile_map.material = invisible_tile_material

func process_fake_tiles(tile_map : TileMap):
	tile_map.material = fake_tile_material
	tile_map.collision_layer = 2
	tile_map.collision_mask = 2
