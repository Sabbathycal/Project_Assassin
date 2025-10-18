extends Node2D

@export var player_controller : PlayerController
@export var animation_player  : AnimationPlayer
@export var sprite 			  : Sprite2D

func _process(_delta):
	# flips the character sprite, depending where it goes in the 'x' Axis
	if player_controller.direction == 1:
		sprite.flip_h = false
	elif player_controller.direction == -1:
		sprite.flip_h = true
	
	# gives player the 'move' animation, it does not need a "flip_h" property
	# because the previous "if/elif" statements already do that
	if abs(player_controller. velocity.x)> 0.0:
		animation_player.play('move')
	else:
		animation_player.play('idle')

	#Jump animation
	if player_controller.velocity.y < 0.0:
		animation_player.play('jump')
	elif player_controller.velocity.y > 0.0:
		animation_player.play('fall')
