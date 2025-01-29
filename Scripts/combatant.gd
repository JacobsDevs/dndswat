class_name Combatant
extends Node2D

var sprite_2d: Sprite2D
var _name: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func setup(resource: Enemy) -> void:
	sprite_2d = $Sprite2D
	print(resource.name)
	print(resource.image)
	self._name = resource.name
	self.sprite_2d.texture = resource.image

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
