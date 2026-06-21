extends Node

const GOLD = Color("#c8a97e")
const BG_DARK = Color("#0a0a0f")
const FONT_PATH = "res://assets/fonts/Cinzel-Regular.ttf"

var font
var canvas
var main_view
var settings_view
var create_view

var player_name = "Aldric"
var chosen_trait = "RUTHLESS"

func _ready():
	font = load(FONT_PATH)
	_build_ui()

func _build_ui():
	canvas = CanvasLayer.new()
	add_child(canvas)

	var bg = ColorRect.new()
	bg.color = BG_DARK
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	canvas.add_child(bg)

	_build_main_view()
	_build_create_view()
	_build_settings_view()
	create_view.visible = false
	settings_view.visible = false

func _build_main_view():
	main_view = Control.new()
	main_view.set_anchors_preset(Control.PRESET_FULL_RECT)
	canvas.add_child(main_view)

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
	main_view.add_child(title)

	var line = ColorRect.new()
	line.color = GOLD
	line.set_anchors_preset(Control.PRESET_CENTER_TOP)
	line.offset_left = -200
	line.offset_right = 200
	line.offset_top = 155
	line.offset_bottom = 157
	main_view.add_child(line)

	var subtitle = Label.new()
	subtitle.text = "A city. A plague. Your choices."
	subtitle.set_anchors_preset(Control.PRESET_TOP_WIDE)
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.position.y = 170
	var sub_settings = LabelSettings.new()
	sub_settings.font = font
	sub_settings.font_size = 18
	sub_settings.font_color = Color("#888888")
	subtitle.label_settings = sub_settings
	main_view.add_child(subtitle)

	var vbox = VBoxContainer.new()
	vbox.set_anchors_preset(Control.PRESET_CENTER)
	vbox.add_theme_constant_override("separation", 20)
	vbox.offset_left = -150
	vbox.offset_top = 30
	main_view.add_child(vbox)

	var btn_new = _add_button(vbox, "NEW GAME")
	var btn_continue = _add_button(vbox, "CONTINUE")
	var btn_settings = _add_button(vbox, "SETTINGS")

	btn_new.pressed.connect(_on_new_game)
	btn_continue.pressed.connect(_on_continue)
	btn_settings.pressed.connect(_on_settings)

	var version = Label.new()
	version.text = "v0.3 — Dark Meridian Studios"
	version.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	version.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	version.offset_top = -40
	var v_settings = LabelSettings.new()
	v_settings.font = font
	v_settings.font_size = 12
	v_settings.font_color = Color("#444444")
	version.label_settings = v_settings
	main_view.add_child(version)

func _build_create_view():
	create_view = Control.new()
	create_view.set_anchors_preset(Control.PRESET_FULL_RECT)
	canvas.add_child(create_view)

	var title = Label.new()
	title.text = "CREATE YOUR RULER"
	title.set_anchors_preset(Control.PRESET_TOP_WIDE)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.position.y = 60
	var ts = LabelSettings.new()
	ts.font = font
	ts.font_size = 36
	ts.font_color = GOLD
	title.label_settings = ts
	create_view.add_child(title)

	# Portrait placeholder circle
	var portrait_bg = ColorRect.new()
	portrait_bg.color = Color("#1a1a26")
	portrait_bg.set_anchors_preset(Control.PRESET_CENTER_TOP)
	portrait_bg.offset_left = -60
	portrait_bg.offset_right = 60
	portrait_bg.offset_top = 130
	portrait_bg.offset_bottom = 250
	create_view.add_child(portrait_bg)

	var portrait_border = ColorRect.new()
	portrait_border.color = GOLD
	portrait_border.set_anchors_preset(Control.PRESET_CENTER_TOP)
	portrait_border.offset_left = -62
	portrait_border.offset_right = 62
	portrait_border.offset_top = 128
	portrait_border.offset_bottom = 130
	create_view.add_child(portrait_border)

	var portrait_icon = Label.new()
	portrait_icon.text = "♛"
	portrait_icon.set_anchors_preset(Control.PRESET_CENTER_TOP)
	portrait_icon.offset_left = -60
	portrait_icon.offset_right = 60
	portrait_icon.offset_top = 150
	portrait_icon.offset_bottom = 230
	portrait_icon.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	portrait_icon.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	var pis = LabelSettings.new()
	pis.font = font
	pis.font_size = 48
	pis.font_color = GOLD
	portrait_icon.label_settings = pis
	create_view.add_child(portrait_icon)

	# Name input
	var name_label = Label.new()
	name_label.text = "YOUR NAME"
	name_label.set_anchors_preset(Control.PRESET_CENTER_TOP)
	name_label.offset_left = -150
	name_label.offset_right = 150
	name_label.offset_top = 270
	name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	var nls = LabelSettings.new()
	nls.font = font
	nls.font_size = 14
	nls.font_color = Color("#888888")
	name_label.label_settings = nls
	create_view.add_child(name_label)

	var name_input = LineEdit.new()
	name_input.text = player_name
	name_input.set_anchors_preset(Control.PRESET_CENTER_TOP)
	name_input.offset_left = -120
	name_input.offset_right = 120
	name_input.offset_top = 295
	name_input.offset_bottom = 330
	name_input.add_theme_color_override("font_color", GOLD)
	name_input.add_theme_font_override("font", font)
	name_input.add_theme_font_size_override("font_size", 20)
	name_input.alignment = HORIZONTAL_ALIGNMENT_CENTER
	name_input.max_length = 16
	name_input.text_changed.connect(func(t): player_name = t)
	create_view.add_child(name_input)

	# Trait selection
	var trait_label = Label.new()
	trait_label.text = "CHOOSE YOUR NATURE"
	trait_label.set_anchors_preset(Control.PRESET_CENTER_TOP)
	trait_label.offset_left = -200
	trait_label.offset_right = 200
	trait_label.offset_top = 350
	trait_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	var tls = LabelSettings.new()
	tls.font = font
	tls.font_size = 14
	tls.font_color = Color("#888888")
	trait_label.label_settings = tls
	create_view.add_child(trait_label)

	var trait_box = HBoxContainer.new()
	trait_box.set_anchors_preset(Control.PRESET_CENTER_TOP)
	trait_box.offset_left = -270
	trait_box.offset_right = 270
	trait_box.offset_top = 380
	trait_box.add_theme_constant_override("separation", 15)
	create_view.add_child(trait_box)

	var btn_ruthless = _add_trait_button(trait_box, "RUTHLESS", "Harsh choices, efficient outcomes")
	var btn_compassionate = _add_trait_button(trait_box, "COMPASSIONATE", "People love you, coffers empty faster")
	var btn_cunning = _add_trait_button(trait_box, "CUNNING", "More options in every intrigue")

	btn_ruthless.pressed.connect(func(): _select_trait("RUTHLESS", [btn_ruthless, btn_compassionate, btn_cunning]))
	btn_compassionate.pressed.connect(func(): _select_trait("COMPASSIONATE", [btn_ruthless, btn_compassionate, btn_cunning]))
	btn_cunning.pressed.connect(func(): _select_trait("CUNNING", [btn_ruthless, btn_compassionate, btn_cunning]))

	_select_trait("RUTHLESS", [btn_ruthless, btn_compassionate, btn_cunning])

	# Begin button
	var begin_btn = _add_button(create_view, "BEGIN YOUR REIGN")
	begin_btn.set_anchors_preset(Control.PRESET_CENTER_BOTTOM)
	begin_btn.offset_left = -150
	begin_btn.offset_right = 150
	begin_btn.offset_top = -100
	begin_btn.offset_bottom = -50
	begin_btn.pressed.connect(_start_game)

	var back_btn = Button.new()
	back_btn.text = "← BACK"
	back_btn.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
	back_btn.offset_left = 20
	back_btn.offset_top = -50
	back_btn.offset_right = 150
	back_btn.offset_bottom = -15
	back_btn.add_theme_color_override("font_color", Color("#555555"))
	back_btn.add_theme_color_override("font_hover_color", GOLD)
	back_btn.add_theme_font_override("font", font)
	back_btn.add_theme_font_size_override("font_size", 14)
	back_btn.add_theme_stylebox_override("normal", StyleBoxEmpty.new())
	back_btn.add_theme_stylebox_override("hover", StyleBoxEmpty.new())
	back_btn.add_theme_stylebox_override("pressed", StyleBoxEmpty.new())
	back_btn.add_theme_stylebox_override("focus", StyleBoxEmpty.new())
	back_btn.pressed.connect(_close_create)
	create_view.add_child(back_btn)

func _add_trait_button(parent, trait_name, description):
	var vbox = VBoxContainer.new()
	vbox.custom_minimum_size = Vector2(160, 100)
	parent.add_child(vbox)

	var btn = Button.new()
	btn.text = trait_name
	btn.custom_minimum_size = Vector2(160, 40)
	btn.add_theme_color_override("font_color", Color("#666666"))
	btn.add_theme_color_override("font_hover_color", GOLD)
	btn.add_theme_font_override("font", font)
	btn.add_theme_font_size_override("font_size", 14)
	btn.add_theme_stylebox_override("normal", StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("hover", StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("pressed", StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("focus", StyleBoxEmpty.new())
	vbox.add_child(btn)
	btn.set_meta("trait_name", trait_name)

	var desc = Label.new()
	desc.text = description
	desc.custom_minimum_size = Vector2(160, 60)
	desc.autowrap_mode = TextServer.AUTOWRAP_WORD
	desc.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	var ds = LabelSettings.new()
	ds.font = font
	ds.font_size = 11
	ds.font_color = Color("#666666")
	desc.label_settings = ds
	vbox.add_child(desc)

	return btn

func _select_trait(trait_name, buttons):
	chosen_trait = trait_name
	for btn in buttons:
		if btn.get_meta("trait_name") == trait_name:
			btn.add_theme_color_override("font_color", GOLD)
		else:
			btn.add_theme_color_override("font_color", Color("#666666"))

func _build_settings_view():
	settings_view = Control.new()
	settings_view.set_anchors_preset(Control.PRESET_FULL_RECT)
	canvas.add_child(settings_view)

	var title = Label.new()
	title.text = "SETTINGS"
	title.set_anchors_preset(Control.PRESET_TOP_WIDE)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.position.y = 80
	var ts = LabelSettings.new()
	ts.font = font
	ts.font_size = 40
	ts.font_color = GOLD
	title.label_settings = ts
	settings_view.add_child(title)

	var back_btn = _add_button(settings_view, "BACK")
	back_btn.set_anchors_preset(Control.PRESET_CENTER)
	back_btn.pressed.connect(_close_settings)

func _add_button(parent, text):
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
	return btn

func _on_new_game():
	main_view.visible = false
	create_view.visible = true

func _on_continue():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_settings():
	main_view.visible = false
	settings_view.visible = true

func _close_settings():
	settings_view.visible = false
	main_view.visible = true

func _close_create():
	create_view.visible = false
	main_view.visible = true

func _start_game():
	GameData.player_name = player_name
	GameData.player_trait = chosen_trait
	get_tree().change_scene_to_file("res://scenes/game.tscn")
