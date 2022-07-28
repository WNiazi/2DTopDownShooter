extends Node2D


signal player_new_score 
signal player_new_lives
#signal player_wins 
#signal player_lost


export (int) var score: = 0 setget set_score
export (int) var lives: = 3 setget set_lives


func set_score(new_score: int)-> void: 
	score = clamp(new_score, 0, 100) 
	emit_signal ("player_new_score") 

#func final_score (new_score: int): 
#	if PlayerScore.score == 100: 
#		emit_signal ("player_wins") 
#	if PlayerScore.lives == 0: 
#		emit_signal("player_lost")
	
		
func set_lives(new_lives: int)->void: 
	lives = clamp(new_lives, 0, 3)  
	emit_signal ("player_new_lives")

func reset() -> void: 
	score = 0 
	lives = 3  
