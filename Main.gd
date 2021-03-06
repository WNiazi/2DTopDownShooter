extends Node2D

const Player = preload("res://Player.tscn")
const GameOverScreen = preload ("res://GameOverScreen.tscn")
const PauseScreen = preload("res://PauseScreen.tscn")


onready var forest_sound =$ForestSounds
onready var bullet_manager = $BulletManager 
onready var weapon_manager =$Player/WeaponManager
onready var player: Player = $Player
onready var gui = $GUI
onready var ground = $Ground
onready var max_score =300 

func _ready() -> void: 
	$ForestSounds.play() 
	randomize() 
	GlobalSignals.connect("bullet_fired", bullet_manager, "handle_bullet_spawned")
	
	spawn_player() 
	GlobalSignals.connect("score", self, "player_won")


#func set_camera_limits(): 
#	var map_limits = $Ground.get_used_rect()
#	var map_cellsize = $Ground.cell_size	
#	camera.limit_left = map_limits.position.x * map_cellsize.x 
#	camera.limit_right = map_limits.end.x * map_cellsize.x 
#	camera.limit_top = map_limits.position.y * map_cellsize.y 
#	camera.limit_bottom = map_limits.end.y * map_cellsize.y


func spawn_player(): 
	var player = Player.instance ()
	add_child(player)
	player.connect ("died", self, "spawn_player")
	gui.set_player(player)

func player_won(): 
	var max_score = 300 
	if GlobalSignals.score == max_score: 
		handle_player_win() 
	
func handle_player_win(): 
	var game_over = GameOverScreen.instance()
	add_child(game_over) 
	game_over.set_title(true)
	get_tree().paused = true 
	
	
func handle_player_lost():
	var game_over =GameOverScreen.instance() 
	add_child(game_over)
	game_over.set_title(false)
	get_tree().paused = true 
	
	
func _unhandled_input(event: InputEvent)->void: 
	if event.is_action_pressed("pause"): 
		var pause_menu = PauseScreen.instance()
		add_child(pause_menu) 
	
