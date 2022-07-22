extends CanvasLayer

#make sure to attach to the right one

func _on_RestartButton_pressed() -> void: 
	get_tree().paused =false 
	get_tree().change_scene ("res://Main.tscn")
	
	
	
func _on_QuitButton_pressed() ->void: 
	get_tree().quit()
	
	#have to get a way to die and sent it over to gameoverscreen 


func _on_MainMenuButton_pressed():
	 get_tree().change_scene("res://Menu.tscn")
