extends Node2D

const BULLET_IMPACT = preload ("res://BulletImpact.tscn")

func _ready()->void: 
	GlobalSignals.connect ("bullet_impacted", self, "handle_bullet_impacted")
	

func handle_bullet_impacted(positon:Vector2, direction:Vector2): 
	var impact = BULLET_IMPACT.instance() 
	add_child(impact) 
	impact.global_position =position 
	impact.global_rotation = direction.angle() 
	impact.start_emitting() 
	
