class_name BaseCharacter
extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var name_label: Label = $"Name Label"
@onready var health_bar: ProgressBar = $"Health Bar"

var max_health: int
var current_health: int
var _name: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func setup(resource: Enemy) -> void:
	sprite_2d = $Sprite2D
	name_label = $"Name Label"
	health_bar = $"Health Bar"
	self._name = resource.name
	name_label.text = _name
	health_bar.max_value = resource.max_hp
	health_bar.value = resource.max_hp
	sprite_2d.texture = resource.image
	self.sprite_2d.texture = resource.image


func _on_area_2d_mouse_entered() -> void:
	name_label.show()
	health_bar.show()

func _on_area_2d_mouse_exited() -> void:
	name_label.hide()
	health_bar.hide()
