extends KinematicBody2D
class_name Actor 

signal died 

onready var health_stat = $Health
onready var ai = $AI
onready var weapon: Weapon = $Weapon 
#working on dependency injections (connecting the weapon and AI) 
onready var collison_shape =$CollisionShape2D

export(int) var speed =150 

func _ready()->void: 
	ai.initalize(self, weapon)
	#notes: this connects the ai with weapon (here ai doesn't need a weapon) 
	#weapon.initalize(Player)


func handle_hit(): 
	health_stat.health-=20 
	if health_stat.health <=0: 
		queue_free() 

func rotate_toward(location: Vector2):
	rotation = lerp_angle(rotation, global_position.direction_to(location).angle(), 0.1)


func velocity_toward(location: Vector2) -> Vector2:
	return global_position.direction_to(location) * speed


#func has_reached_position(location: Vector2) -> bool:
	#return global_position.distance_to(location) < 5


func die():
	emit_signal("died")
	queue_free()
