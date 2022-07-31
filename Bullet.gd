extends Area2D	
class_name Bullet


export (int) var speed = 10


onready var kill_timer =$KillTimer

var direction:= Vector2.ZERO 

#below: what do you want to have going, you want to start the timer
func _ready() ->void : 
	kill_timer.start() 
	
#if you want a movement velocity (direction *speed) 
func _physics_process(delta: float) -> void:
	if direction != Vector2.ZERO:  #only move if you have direction
		var velocity = direction * speed

		global_position += velocity 

#sets the direction of the bullet 
func set_direction(direction:Vector2):
	self.direction = direction
	rotation +=direction.angle() 

#destroys the bullet after x time  use the signal timeout, one shot= single shot
func _on_KillTimer_timeout()->void:
	queue_free()

#can use area_entered if there is more types, destroy builds would use this
#duck typing, if it has this method than you do this 
func _on_Bullet_body_entered(body: Node) ->void: 
	if body.has_method("handle_hit"):
		GlobalSignals.emit_signal("bullet_impacted", global_position, direction)
		body.handle_hit()
		queue_free() 
		
		#above you can doe an bullet-impact vs envir-impact
