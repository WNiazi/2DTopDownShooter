extends Node2D
class_name AI


signal state_changed(new_state)


enum State {
	PATROL,
	ENGAGE,
}


onready var patrol_timer = $PatrolTimer
onready var player_detection_zone =$PlayerDetectionZone


var current_state: int = -1 setget set_state
var actor: Actor = null
var target: KinematicBody2D = null
var weapon: Weapon = null


# PATROL STATE
var origin: Vector2 = Vector2.ZERO
var patrol_location: Vector2 = Vector2.ZERO
var patrol_location_reached: bool = false
var actor_velocity: Vector2 = Vector2.ZERO



func _ready() -> void:
	set_state(State.PATROL)


func _physics_process(delta: float) -> void:

	match current_state:
		State.PATROL:
			if not patrol_location_reached:
				actor_velocity = actor.velocity_toward(patrol_location)
				actor.rotate_toward(patrol_location)
				actor.move_and_slide(actor_velocity)
				if actor.global_position.distance_to(patrol_location)<5: 
					patrol_location_reached = true
					actor_velocity = Vector2.ZERO
					patrol_timer.start()
			
		State.ENGAGE:
			if target != null and weapon != null:
				actor.rotate_toward(target.global_position)
				if abs(actor.global_position.angle_to(target.global_position)) < 0.1:
					weapon.shoot()
			else:
				print("In the engage state but no weapon/target")
		_:
			print("Error: found a state for our enemy that should not exist")


func initialize(actor: KinematicBody2D, weapon: Weapon):
	self.actor = actor
	self.weapon = weapon

	weapon.connect("weapon_out_of_ammo", self, "handle_reload")
	#from the signal in weapon, handle_reload is below
	#initalized used to make sure the siblings are all ready 


func set_state(new_state: int):
	if new_state == current_state:
		return

	if new_state == State.PATROL:
		origin = global_position
		patrol_timer.start()
		patrol_location_reached = true
		

	current_state = new_state
	emit_signal("state_changed", current_state)


func handle_reload():
	weapon.start_reload()
	#now the player says I have handled the reload, weapon handle the start_reload


func _on_PatrolTimer_timeout() -> void:
	var patrol_range = 150
	var random_x = rand_range(-patrol_range, patrol_range)
	var random_y = rand_range(-patrol_range, patrol_range)
	patrol_location = Vector2(random_x, random_y) + origin
	patrol_location_reached = false



func _on_PlayerDetectionZone_body_entered(body: Node)->void:
	set_state(State.ENGAGE)
	target = body

func _on_PlayerDetectionZone_body_exited(body: Node)->void:
		if target and body == target:
			set_state(State.PATROL)
			target = null
