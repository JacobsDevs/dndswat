class_name Combatant
extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
var combatant_name: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _init(resource: Enemy) -> void:
	self.sprite_2d.texture = resource.image
	self.combatant_name = resource.name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
