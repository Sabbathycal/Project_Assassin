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
@export var camera : Camera2D

var speed_mult = 30.0
var jump_mult = -30.0
var direction = 0

@export var max_health: int = 100
var health: int = max_health

@onready var healthbar = $CanvasLayer/TextureProgressBar

func _ready():
	if healthbar:
		healthbar.max_value = max_health
		healthbar.value = health
	else:
		print('Error: TextureProgressBar no encontrado (NODO)')


func take_damage(amount: int):
	health = clamp(health - amount, 0, max_health)
	healthbar.value = health
	
	if health <= 0:
		die()
		

func die():
	print ('Player Died')
	queue_free()


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

func _process(delta: float) -> void:
	if healthbar and camera:
		var canvas_transform : Transform2D = camera.get_canvas_transform()
		var inv_transform : Transform2D = canvas_transform.affine_inverse()
		var screen_pos : Vector2 = inv_transform.basis_xform(position)

		healthbar.position = screen_pos + Vector2(0, -40)

func teleport_to_location(new_location):
	camera.position_smoothing_enabled = false
	position = new_location
	await get_tree().physics_frame
	camera.position_smoothing_enabled = true
