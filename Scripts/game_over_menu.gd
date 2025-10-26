extends CanvasLayer

#emit the variable to the main scene
signal restart #(restart is a variable)

func _on_restart_pressed() -> void:
	restart.emit() #signal received by game_over_menu in main scene
	
