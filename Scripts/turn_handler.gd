extends Node

var actor_list: Array = []
var active_actor
var goblin: Enemy = preload("res://Resources/Goblin.tres")
var combatant = preload("res://Scenes/combatant.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var combi = load("res://Scripts/combatant.gd")
	var cb: Node2D = combi.new(goblin)
	actor_list.append(cb.name)
	add_child(cb)
	cb.position = Vector2(200, 200)
	print(actor_list)

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta: float) -> void:
	pass

# Gets the next actor in the actor_list
func get_next():
	return actor_list.pop_front()

# Gets the next actor in the actor_list without altering the original list
func preview_next():
	return actor_list[0]

# Puts the actor at the back of the actor_list
func progress_turn():
	actor_list.push_back(active_actor)
	active_actor = actor_list.pop_front()
