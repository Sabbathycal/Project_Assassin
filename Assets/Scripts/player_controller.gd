extends CharacterBody2D

# If classified as class not in the script, cannot call this whole class (which is the script)
# to another script file, basically we are calling this a file's header like C++;
#
# It lets us do the '#include' but with GDScript's '@export' making a variable be this classes'
# function (i.e @export var player_controller : PlayerController; translates to: export in variable
# 'player_controller' the class of 'PlayerController'.
class_name PlayerController

@export var speed = 10
@export var jump_power = 10

var speed_mult = 30.0
var jump_mult = -30.0
var direction = 0

#const SPEED = 100.0
#const JUMP_VELOCITY = -400.0

func _input(event):
		# Handle jump.
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_mult
		
		#Handle Jumo down
	if event.is_action_pressed("move_down"):
		set_collision_mask_value(10, false)
	else:
		set_collision_mask_value(10, true)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * (speed * speed_mult)
	else:
		velocity.x = move_toward(velocity.x, 0, ((speed * speed_mult)))

	move_and_slide()
