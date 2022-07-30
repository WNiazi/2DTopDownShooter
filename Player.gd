extends KinematicBody2D
class_name Player

signal player_health_changed(new_health) 
#signal player_total_score(new_score)
#signal player_total_lives (new_lives)
signal died 

export (int) var speed = 100 

onready var collision_shape = $CollisionShape2D
onready var health_stat = $Health
onready var player_score =$PlayerScore 
onready var weapon_manager = $WeaponManager
onready var weapon =$Weapon 
onready var attack_cooldown =$AttackCoolDown
#onready var player_total_score =$PlayerScore.score 
#onready var player_total_lives = $PlayerScore.lives


func _physics_process(delta: float) -> void:
	var movement_direction := Vector2.ZERO

	if Input.is_action_pressed("up"):
		movement_direction.y = -1
	if Input.is_action_pressed("down"):
		movement_direction.y = 1
	if Input.is_action_pressed("left"):
		movement_direction.x = -1
	if Input.is_action_pressed("right"):
		movement_direction.x = 1

	movement_direction = movement_direction.normalized()
	move_and_slide(movement_direction * speed )
	
	look_at(get_global_mouse_position())

#func set_camera_transform(camera_path:NodePath): 
	#camera_transform.remote_path=camera_path


func handle_hit():
	health_stat.health -= 5
	player_score.score -= 1 
	
	emit_signal ("player_health_changed", health_stat.health)
	emit_signal ("player_score_changed", player_score.score)

	if health_stat.health <= 0:
		die()
		#connect to game over
#	elif health_stat.health <=0: 
#		PlayerScore.lives -=1
#		die() 

		
func die(): 
	emit_signal ("died")
#	PlayerScore.lives -= 1
#	GlobalSignals.enemy_killed() 
#	print("on player")
	queue_free () 
#connect to gameover

		
#func _on_PlayerScore_player_total_score():
#	if player_total_score == 100: 
#		print ("on placertotal score")
#		queue_free()
