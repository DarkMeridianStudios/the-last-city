extends Node

const GOLD = Color("#c8a97e")
const BG_DARK = Color("#0a0a0f")
const FONT_PATH = "res://assets/fonts/Cinzel-Regular.ttf"

func _ready():
	_build_ui()

func _build_ui():
	var canvas = CanvasLayer.new()
	add_child(canvas)
	
	var bg = ColorRect.new()
	bg.color = BG_DARK
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	canvas.add_child(bg)
	
	var font = load(FONT_PATH)
	
	var title = Label.new()
	title.text = "THE LAST CITY"
	title.set_anchors_preset(Control.PRESET_TOP_WIDE)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.position.y = 80
	var title_settings = LabelSettings.new()
	title_settings.font = font
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
	
	var vbox = VBoxContainer.new()
	vbox.set_anchors_preset(Control.PRESET_CENTER)
	vbox.add_theme_constant_override("separation", 20)
	vbox.offset_left = -150
	vbox.offset_top = 0
	canvas.add_child(vbox)
	
	_add_button(vbox, "NEW GAME", font)
	_add_button(vbox, "CONTINUE", font)
	_add_button(vbox, "SETTINGS", font)

func _add_button(parent, text, font):
	var btn = Button.new()
	btn.text = text
	btn.add_theme_color_override("font_color", GOLD)
	btn.add_theme_color_override("font_hover_color", Color.WHITE)
	btn.add_theme_font_override("font", font)
	btn.add_theme_font_size_override("font_size", 24)
	btn.add_theme_stylebox_override("normal", StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("hover", StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("pressed", StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("focus", StyleBoxEmpty.new())
	btn.custom_minimum_size = Vector2(300, 50)
	parent.add_child(btn)
