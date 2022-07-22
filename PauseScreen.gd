extends CanvasLayer


func _on_ContinueButton_pressed() ->void:
	get_tree().pause =false  
	queue_free() 

func _on_QuitButton_pressed() ->void:
	get_tree().paused =false 
	get_tree().change_scene("res://Menu.tscn")
