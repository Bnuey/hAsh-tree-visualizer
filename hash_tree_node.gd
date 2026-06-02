extends HBoxContainer

const HashNode = preload("res://addons/hash_tree_visualizer/hash_tree_node.gd")
const VISUAL_NODE_SCENE: PackedScene = preload("uid://blfuajfq0tuk3")
const CIRCLE_TEXTURE: Texture = preload("uid://daem04r486sax")

const color_node: Color = "#659AA1"
const COLOR_3D: Color = "#fe8686"
const COLOR_2D: Color = "#257BA2"
const COLOR_CONTROL: Color = "#37d282"



@export var label: Label

static func new_visual(node: Node, depth: int) -> HashNode:
	var instance := VISUAL_NODE_SCENE.instantiate() as HashNode
	for i in depth:
		var vsep := VSeparator.new()
		instance.add_child(vsep)
		instance.move_child(vsep, 0)
	
	instance.label.text = node.name
	
	instance.modulate = instance._get_color_for_node(node)
	return instance
	
func _get_color_for_node(node: Node) -> Color:
	if node is Node2D: return COLOR_2D
	elif node is Node3D: return COLOR_3D
	elif node is Control: return COLOR_CONTROL
	else: return color_node
