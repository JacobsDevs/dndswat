extends Node

var actor_list: Array = []
var active_actor
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Gets the next actor in the actor_list
func get_next():
	return actor_list.pop_front()

func preview_next():
	return actor_list[0]
