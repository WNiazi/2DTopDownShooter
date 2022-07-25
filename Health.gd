extends Node2D
#node2d just data
class_name Health 

export (int) var health =100 setget set_health 
#whenever a another node gets this, this gets calls 
# clamp =range (min to max) 

func set_health (new_health: int): 
	health = clamp(new_health, 0, 100) 
	#can emit signal if changed 
