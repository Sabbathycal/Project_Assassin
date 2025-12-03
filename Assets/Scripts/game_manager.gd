extends Node


var starting_area = 1
var current_area = 1
var area_path =  'res://Assets/Scenes/Areas/'

var energy_cells = 0
var area_container : Node2D
var player : PlayerController

func _ready():
	area_container = get_tree().get_first_node_in_group('area_container')
	player = get_tree().get_first_node_in_group('player')
	load_area(starting_area)

func _next_area():
	current_area += 1
	load_area(current_area)



func load_area(area_number):
	# Checking  the new scene path
	var full_path = area_path + 'area_' + str(area_number) + '.tscn'
	#get_tree().change_scene_to_file(full_path)
	print('players enters area ' + str(area_number))
	var scene = load(full_path) as PackedScene
	if !scene:
		return
	
	#Removing the previous scene
	for child in area_container.get_children():
		child.queue_free()
		await child.tree_exited
	
	#Setting up neew scene
	var instance = scene.instantiate()
	area_container.add_child(instance)
	reset_energy_cells()
	
	var player_start_position = get_tree().get_first_node_in_group('player_start_position') as Node2D
	player.teleport_to_location(player_start_position.position)
	

func add_energy_cell():
	energy_cells += 1
	if energy_cells >= 4:
		#portal opens
		var portal = get_tree().get_first_node_in_group('area_exits') as AreaExit
		portal.open()
		

func reset_energy_cells():
	energy_cells = 0
