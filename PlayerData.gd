extends Node2D


signal player_total_score 
signal player_total_lives
#signal player_wins 
#signal player_lost


export (int) var max_score = 1
onready var score =max_score setget set_score 

export (int) var max_lives: = 1
onready var lives =max_lives setget set_lives


func set_score(new_score: int): 
	score = clamp(new_score, 0, 100)
	if score >= 100:
		emit_signal ("player_total_score") 


#func final_score (new_score: int): 
#	if PlayerScore.score == 100: 
#		emit_signal ("player_wins") 
#	if PlayerScore.lives == 0: 
#		emit_signal("player_lost")
	
		
func set_lives(new_lives: int): 
	lives = clamp(new_lives, 0, 3) 
	if lives >=3:  
		emit_signal ("player_total_lives")

func reset() -> void: 
	score = 0 
	lives = 3  
