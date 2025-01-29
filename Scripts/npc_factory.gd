class_name NPCFactory
extends Node

@onready var combatant = preload('res://Scenes/combatant.tscn')
@onready var data: Resource = preload("res://Resources/Goblin.tres")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_enemy() -> Combatant:
	var enemy: Combatant = combatant.instantiate()
	enemy.setup(data)
	return enemy
