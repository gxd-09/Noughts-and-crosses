extends Node2D

var board_size: int
var cell_size: int 
var grid_pos: Vector2i
var grid_data: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	board_size = $Board.texture.get_width()
	cell_size = board_size/3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
			

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if event.position.x > 190 and event.position.x < 700 and event.position.y < 580 and event.position.y > 75:
				# convert mouse position into grid location
				grid_pos = Vector2i((event.position/cell size)
				print(event.position)
				grid_data[grid_pos.y][grid_pos.x] = 1
				print(grid_data)

func new_game():
	grid_data = [
		[0,0,0],
		[0,0,0],
		[0,0,0]
		]
