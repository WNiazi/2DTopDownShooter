extends Node2D
class_name AI 

signal state_changed(new_state)

onready var player_detection_zone = $PlayerDetectionZone
onready var patrol_timer = $PatrolTimer
#onready var path_line =$PathLine

enum State{
	PATROL,
	ENGAGE
}

#export (bool) var should_draw_path_line: =false

var current_state:int = -1 setget set_state
var actor: Actor =null 
var target: KinematicBody2D =null 
var weapon: Weapon =null 
#player to target 


#PATROL STATE 
var origin : Vector2 = Vector2.ZERO
var patrol_location: Vector2 =Vector2.ZERO
var patrol_location_reached: bool= false 
var actor_velocity: Vector2 = Vector2.ZERO 

func _ready()-> void: 
	set_state(State.PATROL)
	#path_line.visible =should_draw_path_line 
	
func _physic_process(delta: float)->void:
	match current_state: 
		State.PATROL: 
			if not patrol_location_reached: 
				actor.move_and_slide(actor_velocity)
				actor.rotate_toward(patrol_location)
				if actor.global_position.distance_to(patrol_location) <5: 
					patrol_location_reached =true 
					actor_velocity=Vector2.ZERO
					patrol_timer.start() 
		
		State.ENGAGE:
			if target !=null and weapon !=null: 
				actor.rotate_toward(target.global_position)
				var angle_to_player =actor.global_position.direction_to(target.global_position)
				if abs(actor.rotation -angle_to_player)<0.1:
					weapon.shoot() 
			else: 
				print ("In engage state but no weapon /target")
		_: print ("erro: found a state for our enemy that shouldn't exist")
			
					
func initialize (actor: KinematicBody2D, weapon: Weapon): 
	self.actor=actor
	self.weapon =weapon 
	weapon.connect("weapon_out_of_ammo", self, "handle_reload")
	
func handle_reload(): 
	weapon.start_reload() 

func set_state (new_state: int): 
	if new_state ==current_state: 
		return 
	if new_state ==State.PATROL: 
		origin =global_position 
		patrol_timer.start() 
		patrol_location_reached =true 
		
	#current_state =new states 
	#emit_signal("state_changed", current_state)
	elif new_state ==State.ENGAGE: 
		return

func _on_PatrolTimer_timeout() -> void:
	var patrol_range = 50 
	var random_x = rand_range (-patrol_range, patrol_range) 
	var random_y = rand_range(-patrol_range, patrol_range) 
	patrol_location = Vector2 (random_x, random_y) + origin 
	patrol_location_reached = false 
	actor_velocity = actor.velocity_toward(patrol_location) 
	

func _on_PlayerDetectionZone_body_entered(body: Node)-> void:
	if body.is_in_group("player"):
		set_state(State.ENGAGE)
		target = body 
		
func _on_PlayerDetectionZone_body_exited(body: Node) -> void:
	if target and body == target:
		set_state(State.PATROL)
		target = null
