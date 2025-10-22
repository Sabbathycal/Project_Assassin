extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		GameManager.add_energy_cell()
		queue_free()
		print('player picked up cell ' + str(GameManager.energy_cells) + ' from area ' + str(GameManager.current_area))
	
