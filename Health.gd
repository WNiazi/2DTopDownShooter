extends Node2D
class_name Health 

export (int) var health =100 setget set_health 


func set_health (new_health: int): 
	health = clamp(new_health, 0, 100) 
