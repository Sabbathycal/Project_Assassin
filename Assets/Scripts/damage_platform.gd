extends Area2D

@export var damage_amount: int = 10

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body is PlayerController:
		body.take_damage(damage_amount)
