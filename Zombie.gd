extends Sprite

export(int) var speed = 50 
export (int) var score = 0 

onready var health_stat = $Health
onready var collison_zombie_shape = $CollisionShape2D


var target: KinematicBody2D = null 
var actor: Actor = null 
var velocity =Vector2() 


	
func _physics_process(delta: float) -> void:
	if target != null:
		velocity = actor.rotate_toward(target.global_position) 
		
	global_position += velocity *speed *delta 
			
		
func handle_hit(): 
	health_stat.health-=20 
	PlayerScore.score += score 
	if health_stat.health <=0: 
		queue_free() 


func _on_Area2D_area_shape_entered(area):
	if area.is_in_group (""): 
		area.get_parent().queue_free() 
		
