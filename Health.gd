extends Node2D
#only data 


#node based compostion, create a node that you can put in other scene 

export (int) var health = 50 setget set_health 
#whenever a another node gets this, this gets calls 
# clamp =range (min to max) 

func set_health (new_health: int): 
	health = clamp(new_health, 0, 50) 

	#can emit signal if changed 
