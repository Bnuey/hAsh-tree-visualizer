@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type("NodeTreeVisualizer", "PanelContainer", preload("uid://d2fmqwwjd2moi"), preload("uid://dk6pdk3jcqvbr"))

func _exit_tree() -> void:
	remove_custom_type("NodeTreeVisualizer")
