extends Node2D

@onready var world: Node2D = $".."
@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
@onready var character: CharacterBody2D = $"../Character"
const SELECTOR = preload("res://Scenes/Selector.tscn")
var inst

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = SELECTOR.instantiate()
	instance.position = Vector2(100, 100)
	inst = instance
	add_child(instance)

func _input(event) -> void:
	if event is InputEventMouseMotion or event is InputEventMouseButton:
		var loc = tile_map_layer.local_to_map(event.global_position)
		if event is InputEventMouseMotion:
			print("Coods is " + str(tile_map_layer.local_to_map(event.global_position)))
			inst.position = tile_map_layer.map_to_local(loc)
		if event is InputEventMouseButton:
			if Input.is_action_just_released("left_click"):
				print("Ok!")
				character.position = tile_map_layer.map_to_local(loc)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
