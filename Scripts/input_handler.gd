extends Node2D

@onready var world: Node2D = $".."
@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
@onready var character: CharacterBody2D = $"../Character"
@onready var turn_handler: TurnHandler = $"../TurnHandler"
@onready var pathfinding_handler: Pathfinder = $"../PathfindingHandler"
const SELECTOR = preload("res://Scenes/Selector.tscn")
var neighbours: Array = []
var inst
var current_point
var valid_spaces = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = SELECTOR.instantiate()
	instance.position = Vector2(100, 100)
	inst = instance
	add_child(instance)

func _input(event) -> void:
	if event is InputEventMouseMotion or event is InputEventMouseButton:
		var loc = tile_map_layer.local_to_map(get_global_mouse_position())
		if valid_spaces == []:
			valid_spaces = pathfinding_handler.calculate_destinations(turn_handler.available_movement + 1, turn_handler.active_actor.position)
		if event is InputEventMouseMotion:
			var point = pathfinding_handler.astar.get_closest_point(event.global_position)
			if current_point == point:
				return
			else:
				current_point = point
				var connections = pathfinding_handler.astar.get_point_connections(point)
				for i in neighbours:
					remove_child(i)
				neighbours = []
				for i in valid_spaces:
					var inst = SELECTOR.instantiate()
					inst.position = i
					add_child(inst)
					neighbours.append(inst)
				inst.position = tile_map_layer.map_to_local(loc)
		if event is InputEventMouseButton:
			if Input.is_action_just_released("left_click"):
				if valid_spaces.has(tile_map_layer.map_to_local(loc)):
					var player_point = pathfinding_handler.astar.get_closest_point(turn_handler.active_actor.position)
					var destination = pathfinding_handler.astar.get_closest_point(tile_map_layer.map_to_local(loc))
					var path_array = pathfinding_handler.astar.get_point_path(player_point, destination)
					turn_handler.active_actor.position = tile_map_layer.map_to_local(loc)
					turn_handler.progress_turn(path_array.size() - 1)
					valid_spaces = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
