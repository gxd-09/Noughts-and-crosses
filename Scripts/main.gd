extends Node2D
@export var nought_scene : PackedScene
@export var cross_scene : PackedScene

var board_size: int
var cell_size: int 
var grid_pos: Vector2i
var grid_data: Array 
var player: int
var temp_marker
var marker_panel_pos: Vector2i

# win requirements
var row_sum: int
var column_sum: int
var diagonal1_sum: int
var diagonal2_sum: int
var winner: int

#in case of draw
var count_moves: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	board_size = 700-190
	cell_size = board_size/3
	marker_panel_pos = $MarkerPanel.get_position()
	new_game()
	print(marker_panel_pos + Vector2i(cell_size/2+190, cell_size/2+75))

func new_game():
	player = 1
	winner = 0
	count_moves = 0
	grid_data = [
		[0,0,0],
		[0,0,0],
		[0,0,0]
		]
	row_sum = 0
	column_sum = 0
	diagonal1_sum = 0
	diagonal2_sum = 0
	# clear existing markers
	get_tree().call_group("noughts","queue_free")
	get_tree().call_group("crosses","queue_free")
	
	create_marker(player, marker_panel_pos + Vector2i(cell_size/2+15, cell_size/2+15), true)
	$GameOverMenu.hide()
	get_tree().paused = false
	

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
				if grid_data[grid_pos.y][grid_pos.x] == 0:
					count_moves += 1
					grid_data[grid_pos.y][grid_pos.x] = player
					# place said player's marker
					create_marker(player, grid_pos*cell_size + Vector2i(cell_size/2+190, cell_size/2+75))
					if check_win() != 0:
						$WinSFX.play()
						win_sequence()
					elif count_moves == 9:
						$WinSFX.play()
						win_sequence()
						
					player *= -1
					# clear temp
					temp_marker.queue_free()
					# replace with next player
					create_marker(player, marker_panel_pos + Vector2i(cell_size/2+15, cell_size/2+15), true)
					print(grid_data)
		
#create a function new_game()??

func create_marker(player, position, temp=false):
	if player == 1:
		var nought = nought_scene.instantiate()
		nought.position = position
		add_child(nought)
		if temp:
			temp_marker = nought
	else:
		var cross = cross_scene.instantiate()
		cross.position = position
		add_child(cross)
		if temp:
			temp_marker = cross
			
		
func check_win():
	for i in len(grid_data):
		row_sum = grid_data[i][0] + grid_data[i][1] + grid_data[i][2]
		column_sum = grid_data[0][i] + grid_data[1][i] + grid_data[2][i]
		diagonal1_sum = grid_data[0][0] + grid_data[1][1] + grid_data[2][2]
		diagonal2_sum = grid_data[0][2] + grid_data[1][1] + grid_data[2][0]
		print(row_sum)
		print(column_sum)
		print(diagonal1_sum)
		print(diagonal2_sum)
		if row_sum == 3 or column_sum == 3 or diagonal1_sum == 3 or diagonal2_sum == 3:
			winner = 1
		elif row_sum == -3 or column_sum == -3 or diagonal1_sum == -3 or diagonal2_sum == -3:
			winner = -1
	return winner


func win_sequence():
	print("Finish!")
	get_tree().paused = true
	$GameOverMenu.show()
	if winner == 1:
		$GameOverMenu/Label.text = "Player 1 wins!"
	elif winner == -1:
		$GameOverMenu/Label.text = "Player 2 wins!"
	else:
		$GameOverMenu/Label.text = "You tied!"
		
	
	
func _on_game_over_menu_restart() -> void:
	new_game()
