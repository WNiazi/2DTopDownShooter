extends Node2D

const Player = preload("res://Player.tscn")
const GameOverScreen = preload("res://GameOverScreen.tscn")
const PauseScreen = preload("res://PauseScreen.tscn")


onready var bullet_manager = $BulletManager 
onready var player: Player = $Player 
onready var camera = $Player/Camera2D
onready var gui = $GUI
onready var ground = $Ground


func _ready() -> void: 
	randomize() 
	GlobalSignals.connect("bullet_fired", bullet_manager, "handle_bullet_spawned")
	
	spawn_player() 
	set_camera_limits() 
	#var emeny_respawns =$EnemyRespawnPoints 
	#var player_respawns = $PlayerRespawnPoints
	
func set_camera_limits(): 
	var map_limits = $Ground.get_used_rect()
	var map_cellsize = $Ground.cell_size	
	camera.limit_left = map_limits.position.x * map_cellsize.x 
	camera.limit_right = map_limits.end.x * map_cellsize.x 
	camera.limit_top = map_limits.position.y * map_cellsize.y 
	camera.limit_bottom = map_limits.end.y * map_cellsize.y


func spawn_player(): 
	var player =Player.instance ()
	add_child(player)
	player.connect ("died", self, "spawn_player")
	gui.set_player(player)
	
#func handle_player_win(): 
	#var game_over =GamerOverScreen.instance()
	#add_child(game_over) 
	#game_over.set(title(true)
	#get_tree().paused =true 
	
#func handle_player_lost(): 
	#var game_over =GameOverScreen.instance() 
	#add_child(game_over)
	#game_over.set_title(false)
	#get_tree().paused =true 
	
	
func _unhandled_input(event: InputEvent)->void: 
	if event.is_action_pressed("pause"): 
		var pause_menu = PauseScreen.instance()
		add_child(pause_menu) 
	

