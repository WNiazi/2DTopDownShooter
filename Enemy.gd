extends KinematicBody2D

onready var health_stat = $Health
onready var ai = $AI
onready var weapon = $Weapon 

export(int) var speed =100 

func _ready()->void: 
	ai.initalize(self, weapon)


func handle_hit(): 
	health_stat.health-=20 
	if health_stat.health <=0: 
		queue_free() 

func rotate_toward (location: Vector2): 
	rotation= lerp (rotation, global_position.direction_to(location).angle(), 0.1)

func velocity_toward (location: Vector2) -> Vector2: 
	return global_position.direction_to(location) * speed
	
				
