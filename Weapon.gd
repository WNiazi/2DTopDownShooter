extends Node2D
class_name Weapon 

signal weapon_ammo_changed (new_ammo_count)
signal weapon_out_of_ammo


export (PackedScene) var Bullet

export (int) var max_ammo: int = 10
export (bool) var semi_auto: bool = true 
#might need a emu 

var current_ammo: int = max_ammo setget set_current_ammo


onready var end_of_gun = $EndOfGun 
onready var animation_player = $AnimationPlayer
onready var muzzle_flash = $MuzzleFlash
onready var attack_cooldown =$AttackCoolDown


func _ready() ->void: 
	muzzle_flash.hide() 
	current_ammo = max_ammo


func start_reload(): 
	animation_player.play("reload")
	#fom the AI "handle_reload" function 
	
	
func _stop_reload(): 
	current_ammo = max_ammo 
	emit_signal("weapon_ammo_changed", current_ammo)
	#add to animation_finished under animation player+> node ; if this happens then call on "reload"

func set_current_ammo(new_ammo: int) : 
	var actual_ammo =clamp (new_ammo, 0, max_ammo)
	if actual_ammo != current_ammo:
		current_ammo = actual_ammo
		if current_ammo == 0: 
			emit_signal("weapon_out_of_ammo")
		
		emit_signal("weapon_ammo_changed", current_ammo)
	
	
func shoot (): 
	if current_ammo != 0 and attack_cooldown.is_stopped() and Bullet != null: 
		var bullet_instance = Bullet.instance()
		var direction = (end_of_gun.global_position -global_position).normalized()
		GlobalSignals.emit_signal("bullet_fired", bullet_instance, end_of_gun.global_position, direction)
		attack_cooldown.start() 
		animation_player.play("muzzle_flash")
		set_current_ammo(current_ammo - 1)
		
#	

		

