extends Label


const Player = preload("res://Player.tscn")
const GameOverScreen = preload ("res://GameOverScreen.tscn")



func _process(delta): 
	text =str(GlobalSignals.score)
	
