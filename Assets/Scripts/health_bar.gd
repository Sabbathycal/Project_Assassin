extends CharacterBody2D

@export var max_health: int = 100
var health: int = max_health


@onready var healthbar = $CanvasLayer/TextureProgressBar

func _ready():
	healthbar.max_value = max_health
	healthbar.value = health
	

func take_damage(amount: int):
	health = clamp(health - amount, 0, max_health)
	healthbar.value = health
	
	if health <= 0:
		die()
		

func die():
	print ('Player Died')
	queue_free()
