extends Node

const GOLD = Color("#c8a97e")
const BG_DARK = Color("#0a0a0f")
const FONT_PATH = "res://assets/fonts/Cinzel-Regular.ttf"

var font

func _ready():
	font = load(FONT_PATH)
	_build_ui()

func _build_ui():
	var canvas = CanvasLayer.new()
	add_child(canvas)
	
	var bg = ColorRect.new()
	bg.color = BG_DARK
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	canvas.add_child(bg)
	
	var font_loaded = load(FONT_PATH)
	
	var title = Label.new()
	title.text = "THE LAST CITY"
	title.set_anchors_preset(Control.PRESET_TOP_WIDE)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.position.y = 80
	var title_settings = LabelSettings.new()
	title_settings.font = font_loaded
	title_settings.font_size = 52
	title_settings.font_color = GOLD
	title.label_settings = title_settings
	canvas.add_child(title)
	
	var line = ColorRect.new()
	line.color = GOLD
	line.set_anchors_preset(Control.PRESET_CENTER_TOP)
	line.offset_left = -200
	line.offset_right = 200
	line.offset_top = 155
	line.offset_bottom = 157
	canvas.add_child(line)
	
	var subtitle = Label.new()
	subtitle.text = "A city. A plague. Your choices."
	subtitle.set_anchors_preset(Control.PRESET_TOP_WIDE)
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.position.y = 170
	var sub_settings = LabelSettings.new()
	sub_settings.font = font_loaded
	sub_settings.font_size = 18
	sub_settings.font_color = Color("#888888")
	subtitle.label_settings = sub_settings
	canvas.add_child(subtitle)
	
	var vbox = VBoxContainer.new()
	vbox.set_anchors_preset(Control.PRESET_CENTER)
	vbox.add_theme_constant_override("separation", 20)
	vbox.offset_left = -150
	vbox.offset_top = 30
	canvas.add_child(vbox)
	
	var btn_new = _add_button(vbox, "NEW GAME", font_loaded)
	var btn_continue = _add_button(vbox, "CONTINUE", font_loaded)
	var btn_settings = _add_button(vbox, "SETTINGS", font_loaded)
	
	btn_new.pressed.connect(_on_new_game)
	btn_continue.pressed.connect(_on_continue)
	btn_settings.pressed.connect(_on_settings)
	
	var version = Label.new()
	version.text = "v0.1 — Dark Meridian Studios"
	version.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	version.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	version.offset_top = -40
	var v_settings = LabelSettings.new()
	v_settings.font = font_loaded
	v_settings.font_size = 12
	v_settings.font_color = Color("#444444")
	version.label_settings = v_settings
	canvas.add_child(version)

func _add_button(parent, text, font_loaded):
	var btn = Button.new()
	btn.text = text
	btn.add_theme_color_override("font_color", GOLD)
	btn.add_theme_color_override("font_hover_color", Color.WHITE)
	btn.add_theme_font_override("font", font_loaded)
	btn.add_theme_font_size_override("font_size", 24)
	btn.add_theme_stylebox_override("normal", StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("hover", StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("pressed", StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("focus", StyleBoxEmpty.new())
	btn.custom_minimum_size = Vector2(300, 50)
	parent.add_child(btn)
	return btn

func _on_new_game():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_continue():
	# TODO: загрузка сохранения
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_settings():
	pass
