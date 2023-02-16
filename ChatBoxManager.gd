extends Node2D

func send_chat(chatbox : ChatBox):
	chatbox.show()
	add_child(chatbox)

