class_name Pathfinder
extends Node

@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"

var astar = AStar2D.new()
var directions: Array[Vector2] = [Vector2(0, 32), Vector2(0, -32), Vector2(32, 0), Vector2(-32, 0)]
var location_dict: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	build_points()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func build_points():
	for i in tile_map_layer.get_used_cells():
		var location = tile_map_layer.map_to_local(i)
		location_dict[location] = true
		if tile_map_layer.get_cell_source_id(i) == 0:
			astar.add_point(astar.get_available_point_id(), location, 1)
	for i in astar.get_point_ids():
		var point_location = astar.get_point_position(i)
		for j in directions:
			if location_dict.has(point_location + j):
				var connection_id = tile_map_layer.get_cell_source_id(tile_map_layer.local_to_map(point_location + j))
				if connection_id == 0:
					astar.connect_points(i, astar.get_closest_point(point_location + j))

func calculate_destinations(speed: int, position: Vector2):
	var successful_paths: Array
	for i in astar.get_point_ids():
		var potential_path = astar.get_point_path(astar.get_closest_point(position), i)
		if potential_path.size() <= speed and potential_path.size() > 1:
			successful_paths.append(potential_path)
	var uniq: Dictionary
	for i in successful_paths:
		for j in i:
			uniq[j] = 1
	return uniq.keys()
