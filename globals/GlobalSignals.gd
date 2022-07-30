extends Node


#var score = goalScore
#var goalScore = 100  

signal bullet_fired(bullet, position, direction) 
signal bullet_impacted(position, direction)


#func enemy_killed(): 
#	score -= 1 
#	print("score")
#	if score<= 0 : 
#		print ("You win")
