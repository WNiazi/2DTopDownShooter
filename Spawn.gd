extends Node2D


const MIN_SPAWN_TIME =1.5

const Enemy = preload("res://Enemy.tscn")


#you can have different enemies using array var preloadenemies : =[preload x,y,z]

onready var respawnTimer : = $RespawnTimer
var nextSpawnTime : = 5.0 

func _ready(): 
	randomize () 
	respawnTimer.start(nextSpawnTime)
	

#spawn an enemy 
func _on_RespawnTimer_timeout():
	#spawn an enmey 
	var viewRect: = get_viewport_rect() 
	var random_x = rand_range(-viewRect.position.x, viewRect.end.x)
	var random_y = rand_range(-viewRect.position.y, viewRect.end.y)
	var respawn_location = Vector2(random_x, random_y) 
	
#	var enemyPreload =preloadEnemies[randi()% preloadedEnemies.size()] -this gives us a random enemy 
	var enemy = Enemy.instance() 
	enemy.position =Vector2(respawn_location) 
	get_tree().current_scene.add_child(enemy)
	
	nextSpawnTime -= 0.1
	if nextSpawnTime < MIN_SPAWN_TIME:
		nextSpawnTime =MIN_SPAWN_TIME
	respawnTimer.start(nextSpawnTime)
