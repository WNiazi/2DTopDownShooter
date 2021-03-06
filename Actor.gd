extends KinematicBody2D
class_name Actor


signal died


onready var collision_shape = $CollisionShape2D
onready var health_stat = $Health
onready var ai = $AI
onready var weapon: Weapon = $Weapon


export (int) var speed = 150
export (int)var score = 0


func _ready() -> void:
	ai.initialize(self, weapon)


func rotate_toward(location: Vector2):
	rotation = lerp_angle(rotation, global_position.direction_to(location).angle(), 0.1)


func velocity_toward(location: Vector2) -> Vector2:
	return global_position.direction_to(location) * speed


func has_reached_position(location: Vector2) -> bool:
	return global_position.distance_to(location) < 5


func handle_hit():
	GlobalSignals.score +=10
	health_stat.health -= 10 
	if health_stat.health <= 0:
		die()


func die():
	emit_signal("died")
	queue_free()
