extends HBoxContainer

const HashNode = preload("res://addons/hash_tree_visualizer/hash_tree_node.gd")
const VISUAL_NODE_SCENE: PackedScene = preload("uid://blfuajfq0tuk3")
const CIRCLE_TEXTURE: Texture = preload("uid://daem04r486sax")

const THEME: Theme = preload("uid://b1tb0vqqyjilo")

var COLOR_2D: Color = THEME.get_color("color_2d", "NodeColors")
var COLOR_3D: Color = THEME.get_color("color_3d", "NodeColors")
var color_node: Color = THEME.get_color("color_node", "NodeColors")
var COLOR_CONTROL: Color = THEME.get_color("color_control", "NodeColors")



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
