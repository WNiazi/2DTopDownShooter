extends Node2D

onready var current_weapon: Weapon =$Pistol 

var weapons: Array=[] 

func_ready()->void: 
	weapons =get_children() 


func initialize(player: int) ->void: 
	for weapon in weapons: 
		weapon.initialize(player)
		


func _unhandled_input(event: InputEvent) ->void: 
	if event.is_action_released ("shoot"):
		weapon.shoot()
	elif event.is_action_released ("reload"):
		weapon.start_reload()

func reload (): 
	current_weapon.start_reload()
	
	
