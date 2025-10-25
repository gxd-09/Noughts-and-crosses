extends Node2D
@export var nought_scene : PackedScene
@export var cross_scene : PackedScene

var board_size: int
var cell_size: int 
var grid_pos: Vector2i
var grid_data: Array = [[0,0,0],[0,0,0],[0,0,0]]
var player: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	board_size = 700-190
	cell_size = board_size/3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
			

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if event.position.x > 190 and event.position.x < 700 and event.position.y < 580 and event.position.y > 75:
				# convert mouse position into grid location - account for offset
				event.position.x -= 190
				event.position.y -= 75 
				grid_pos = Vector2i(event.position / cell_size)
				print(event.position)
				print(grid_pos.x,grid_pos.y)
				if grid_data[grid_pos.y][grid_pos.x] == 0:
					grid_data[grid_pos.y][grid_pos.x] = player
					# place said player's marker
					create_marker(player, grid_pos*cell_size + Vector2i(cell_size/2+190,cell_size/2+75))
					player *= -1
					print(grid_data)
		

func create_marker(player, position):
	if player == 1:
		var nought = nought_scene.instantiate()
		nought.position = position
		add_child(nought)
	else:
		var cross = cross_scene.instantiate()
		cross.position = position
		add_child(cross)
	
	
