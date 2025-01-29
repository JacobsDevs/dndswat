class_name TurnHandler
extends Node

@onready var npc_factory: NPCFactory = $"../NPCFactory"
@onready var character: CharacterBody2D = $"../Character"
@onready var ui: Control = $"../UI"

var actor_list: Array = []
var active_actor
var available_movement = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var e1 = npc_factory.create_enemy()
	add_child(e1)
	e1.position = Vector2(100, 100)
	actor_list.append(e1)
	actor_list.append(character)
	get_next()

# Gets the next actor in the actor_list
func get_next():
	active_actor = actor_list.pop_front()

# Gets the next actor in the actor_list without altering the original list
func preview_next():
	return actor_list[0]

# Puts the actor at the back of the actor_list
func progress_turn(move_cost: int):
	available_movement -= move_cost
	if available_movement <= 0:
		if active_actor:
			actor_list.push_back(active_actor)
		get_next()
		available_movement = 3
		ui.turn_label.set_turn(active_actor)
