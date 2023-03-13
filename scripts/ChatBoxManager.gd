extends Node2D


func _on_InteractableNPC_send_message(chatbox):
	chatbox.show()
	add_child(chatbox)

	pass # Replace with function body.


func _on_InteractableNPC_delete_message(chatbox):
	remove_child(chatbox)
	pass # Replace with function body.
