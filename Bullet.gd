extends Area2D	
class_name Bullet


export (int) var speed = 25


onready var kill_timer =$KillTimer


var direction:= Vector2.ZERO 


func _ready() ->void : 
	kill_timer.start() 
	

func _physics_process(delta: float) -> void:
	if direction != Vector2.ZERO:
		var velocity = direction * speed

		global_position += velocity 


func set_direction(direction:Vector2):
	self.direction = direction
	rotation +=direction.angle() 


func _on_KillTimer_timeout()->void:
	queue_free()

#can use area_entered if there is more types, destroy builds would use this
#duck typing, if it has this method than you do this 
func _on_Bullet_body_entered(body: Node) ->void: 
	if body.has_method("handle_hit"):
		GlobalSignals.emit_signal("bullet_impacted", body.global_position, direction)
		body.handle_hit()
	queue_free() 
