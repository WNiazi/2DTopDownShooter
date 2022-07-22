extends Node2D


onready var bullet_manager =$BulletManager 
onready var player: Player =$Player 
#onready var camera=$Player/Camera2D
onready var gui =$GUI



func _ready() -> void: 
	randomize() 
	GlobalSignals.connect("bullet_fired", bullet_manager, "handle_bullet_spawned")
	
	spawn_player() 

func spawn_player(): 
	var player =Player.instance ()
	add_child(player)
	player.connect ("died", self, "spawn_player")
	gui.set_player(player)
	


