@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type("NodeTreeVisualizer", "VBoxContainer", preload("uid://d2fmqwwjd2moi"), preload("uid://wghseu75lg0x"))

func _exit_tree() -> void:
	remove_custom_type("NodeTreeVisualizer")
