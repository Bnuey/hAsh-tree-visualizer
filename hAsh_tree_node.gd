class_name hAsh_Node extends HBoxContainer

const VISUAL_NODE_SCENE: PackedScene = preload("uid://blfuajfq0tuk3")

const color_node: Color = Color.WHITE
const COLOR_3D: Color = "#FF5555FF"
const COLOR_2D: Color = "#6393FFFF"
const COLOR_CONTROL: Color = "#6AFF7CFF"

const CIRCLE_TEXTURE: Texture = preload("uid://daem04r486sax")

@export var label: Label

static func new_visual(node: Node, depth: int) -> hAsh_Node:
	var instance := VISUAL_NODE_SCENE.instantiate()	 as hAsh_Node
	for i in depth:
		var vsep := VSeparator.new()
		instance.add_child(vsep)
		instance.move_child(vsep, 0)
	
	instance.label.text = node.name
	
	instance.get_node("%Circle").modulate = instance._get_color_for_node(node)
	return instance
	
func _get_color_for_node(node: Node) -> Color:
	if node is Node2D: return COLOR_2D
	elif node is Node3D: return COLOR_3D
	elif node is Control: return COLOR_CONTROL
	else: return color_node
