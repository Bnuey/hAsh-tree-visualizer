extends PanelContainer

@export var node_to_visualize: Node

const HashNode = preload("res://addons/hash_tree_visualizer/hash_tree_node.gd")

## node_tree_visualizer_theme.tres
const THEME: Theme = preload("uid://b1tb0vqqyjilo")

@export var max_depth: int = 10

var vbox: VBoxContainer

func _ready() -> void:
	theme = THEME
	vbox = VBoxContainer.new()
	add_child(vbox)
	
	
	build_ui_for_node()
	_rescale_ui.call_deferred()


func build_ui_for_node() -> void:
	if not node_to_visualize: node_to_visualize = get_node("..")
	_build_children(node_to_visualize, 0)


func _build_children(node: Node, depth: int) -> void:
	print(node.name + " " + str(depth))
	if depth > max_depth: return
	if node == self: return
	vbox.add_child(HashNode.new_visual(node, depth))
	if node.get_child_count() <= 0:
		return
	else:
		for child in node.get_children():
			_build_children(child, depth + 1)

func _rescale_ui() -> void:
	var viewport_size: float = get_viewport().get_visible_rect().size.y
	var control_size: float = size.y
	var scale_factor: float = viewport_size / control_size
	scale = Vector2(scale_factor, scale_factor)
