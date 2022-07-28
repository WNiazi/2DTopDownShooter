extends Node2D

signal score_updated 
signal player_died 


var score: = 0 setget set_score
var lives: = 3 setget set_lives

func reset() -> void: 
	score = 0 
	lives = 3 


func set_score(value: int)-> void: 
	score = value 
	emit_signal ("score_updated") 


func set_lives(value: int)->void: 
	lives = value 
	emit_signal ("player_died")
