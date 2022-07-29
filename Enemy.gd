extends KinematicBody2D
class_name Actor 

signal died 


onready var health_stat = $Health
onready var ai = $AI
onready var weapon: Weapon = $Weapon 
#working on dependency injections (connecting the weapon and AI) 
onready var collison_shape =$CollisionShape2D

export(int) var speed = 100 
export var score: = 5


func _ready() -> void: 
	ai.initialize(self, weapon) 
	#notes: this connects the ai with weapon (here ai doesn't need a weapon) 
	#weapon.initalize(Player)

func handle_hit(): 
	health_stat.health-=20 
	PlayerScore.score += score 
	if health_stat.health <=0: 
		
		queue_free() 
		#we can have a respawn timer for the enemy and start it.  prior to it should have locations for respawning

func rotate_toward(location: Vector2):
	rotation = lerp_angle(rotation, global_position.direction_to(location).angle(), 0.1)
#rotation =lerp_angle (linear interplation)  will correct turn from the actor/enemy and put in the current position =actor.rotation, and to player (.globalposition toward player) along with a weight

func velocity_toward(location: Vector2) -> Vector2:
	return global_position.direction_to(location) * speed

func has_reached_position(location: Vector2) -> bool:
	return global_position.distance_to(location) < 5
#when we are greater than 5 units away, set it as true, actor hits the patrol location reached 

func die():
	emit_signal("died")
	queue_free()
