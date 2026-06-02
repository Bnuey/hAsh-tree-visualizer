extends PanelContainer

@export var node_to_visualize: Node

const HashNode = preload("res://addons/hash_tree_visualizer/hash_tree_node.gd")

## node_tree_visualizer_theme.tres
const THEME: Theme = preload("uid://b1tb0vqqyjilo")

@export var max_depth: int = 10

@export var render_scale: int = 2

var vbox: VBoxContainer
var sub_viewport: SubViewport

func _ready() -> void:
	theme = THEME
	vbox = VBoxContainer.new()
	add_child(vbox)
	build_ui_for_node()
	_rescale_ui.call_deferred()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		print("Screenshotting UI")
		_screenshot_ui.call_deferred()

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

func _screenshot_ui() -> void:
	var original_size: Vector2 = scale
	_create_sub_viewport()
	_create_ouput_rect()
	_scale_to_render_scale()
	await RenderingServer.frame_post_draw
	_save_image_to_png()
	await RenderingServer.frame_post_draw
	await RenderingServer.frame_post_draw
	_revert_to_original_size(original_size)

func _create_sub_viewport() -> void:
	sub_viewport = SubViewport.new()
	$"..".add_child(sub_viewport)
	reparent(sub_viewport)

func _create_ouput_rect() -> void:
	var output: TextureRect = TextureRect.new()
	$"../..".add_child(output)
	output.texture = sub_viewport.get_texture()

func _scale_to_render_scale() -> void:
	scale = Vector2(render_scale, render_scale)
	sub_viewport.size = get_rect().size

func _save_image_to_png() -> void:
	await RenderingServer.frame_post_draw
	var raw: Image = sub_viewport.get_texture().get_image()
	raw.convert(Image.FORMAT_RGBA8)
	raw.save_png(OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP) + "/node-tree.png")

func _revert_to_original_size(original: Vector2) -> void:
	scale = original
	sub_viewport.size = get_rect().size
