extends Node2D

@onready var world: Node2D = $".."
@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
@onready var character: CharacterBody2D = $"../Character"
@onready var turn_handler: TurnHandler = $"../TurnHandler"
@onready var pathfinding_handler: Pathfinder = $"../PathfindingHandler"
const selector_green = preload("res://Sprites/Tiles/Block green.png")
const selector_red = preload("res://Sprites/Tiles/Block.png")
const SELECTOR = preload("res://Scenes/Selector.tscn")

var neighbours: Array = []
var pointer
var current_point
var valid_spaces = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var new_pointer = SELECTOR.instantiate()
	new_pointer.position = Vector2(100, 100)
	pointer = new_pointer
	add_child(pointer)

func _input(event) -> void:
	if event is InputEventMouseMotion or event is InputEventMouseButton:
		var loc = tile_map_layer.local_to_map(get_global_mouse_position())
		if valid_spaces == []:
			valid_spaces = pathfinding_handler.calculate_destinations(turn_handler.available_movement + 1, turn_handler.active_actor.position)
		if event is InputEventMouseMotion:
			update_pointer_position(loc)
			var point = pathfinding_handler.astar.get_closest_point(event.global_position)
			if current_point == point:
				return
			else:
				current_point = point
				var connections = pathfinding_handler.astar.get_point_connections(point)
				for i in neighbours:
					remove_child(i)
				neighbours = []
				var enemy_locations = get_enemy_locations()
				for i in valid_spaces:
					draw_valid_space(i, enemy_locations)
				

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

func draw_valid_space(space, enemy_locations):
	var valid_space = SELECTOR.instantiate()
	valid_space.position = space
	add_child(valid_space)
	for j in enemy_locations:
		set_valid_space_color(space, valid_space, j)
	neighbours.append(valid_space)
	
func set_valid_space_color(space, valid_space, j):
	if space == pathfinding_handler.astar.get_point_position(j):
			valid_space.sprite.texture = selector_red
			valid_space.sprite.modulate.a8 = 155
	else:
		valid_space.sprite.modulate.a8 = 100

func update_pointer_position(location):
	pointer.position = tile_map_layer.map_to_local(location)

func get_enemy_locations():
	var enemy_locations = []
	for i in turn_handler.actor_list:
		enemy_locations.append(pathfinding_handler.astar.get_closest_point(i.position))
	return enemy_locations
