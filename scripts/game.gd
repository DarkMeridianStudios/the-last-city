extends Node

const GOLD = Color("#c8a97e")
const BG_DARK = Color("#0a0a0f")
const DARK_PANEL = Color("#0f0f1a")
const RED = Color("#c0392b")
const GREEN = Color("#27ae60")
const FONT_PATH = "res://assets/fonts/Cinzel-Regular.ttf"

var resources = {
	"population": 1000,
	"food": 500,
	"money": 200
}

var events = [
	{
		"text": "A plague spreads through the eastern districts.\nThousands are at risk.\nYour advisors await your command.",
		"choices": [
			{"text": "QUARANTINE THE DISTRICT", "population": -50, "food": -30, "money": -20},
			{"text": "DISTRIBUTE MEDICINE", "population": -10, "food": -10, "money": -80}
		]
	},
	{
		"text": "Merchants from the north offer a trade deal.\nThey want food in exchange for gold.",
		"choices": [
			{"text": "ACCEPT THE DEAL", "population": 0, "food": -100, "money": 150},
			{"text": "REFUSE THE OFFER", "population": 0, "food": 0, "money": -20}
		]
	},
	{
		"text": "A drought threatens the harvest.\nFarmers need resources to survive the season.",
		"choices": [
			{"text": "FUND THE FARMERS", "population": 20, "food": 80, "money": -100},
			{"text": "IMPOSE RATIONING", "population": -30, "food": 20, "money": 0}
		]
	},
	{
		"text": "Rebels have seized the eastern gate.\nThe city guard requests permission to act.",
		"choices": [
			{"text": "SEND THE GUARD", "population": -20, "food": 0, "money": -50},
			{"text": "NEGOTIATE PEACE", "population": 10, "food": -20, "money": -30}
		]
	},
	{
		"text": "A noble family offers a large donation.\nIn return, they want a seat on the council.",
		"choices": [
			{"text": "ACCEPT THEIR GOLD", "population": -10, "food": 0, "money": 200},
			{"text": "DECLINE THE OFFER", "population": 20, "food": 0, "money": -10}
		]
	}
]

var current_event = 0
var font
var canvas
var pop_label
var food_label
var money_label
var event_label
var choice_btns = []
var turn_label

func _ready():
	font = load(FONT_PATH)
	_build_ui()
	_show_event()

func _build_ui():
	canvas = CanvasLayer.new()
	add_child(canvas)
	
	var bg = ColorRect.new()
	bg.color = BG_DARK
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	canvas.add_child(bg)
	
	# Верхняя панель
	var top_panel = ColorRect.new()
	top_panel.color = DARK_PANEL
	top_panel.set_anchors_preset(Control.PRESET_TOP_WIDE)
	top_panel.offset_bottom = 90
	canvas.add_child(top_panel)
	
	var top_line = ColorRect.new()
	top_line.color = GOLD
	top_line.set_anchors_preset(Control.PRESET_TOP_WIDE)
	top_line.offset_top = 89
	top_line.offset_bottom = 91
	canvas.add_child(top_line)
	
	var hbox = HBoxContainer.new()
	hbox.set_anchors_preset(Control.PRESET_TOP_WIDE)
	hbox.offset_top = 10
	hbox.offset_bottom = 80
	hbox.offset_left = 30
	hbox.offset_right = -30
	hbox.add_theme_constant_override("separation", 50)
	canvas.add_child(hbox)
	
	pop_label = _add_resource(hbox, "POPULATION", str(resources.population))
	food_label = _add_resource(hbox, "FOOD", str(resources.food))
	money_label = _add_resource(hbox, "MONEY", str(resources.money))
	
	# Номер хода справа
	turn_label = Label.new()
	turn_label.text = "DAY 1"
	turn_label.set_anchors_preset(Control.PRESET_TOP_RIGHT)
	turn_label.offset_left = -120
	turn_label.offset_top = 30
	var ts = LabelSettings.new()
	ts.font = font
	ts.font_size = 16
	ts.font_color = Color("#555555")
	turn_label.label_settings = ts
	canvas.add_child(turn_label)
	
	# Карточка события
	var card = ColorRect.new()
	card.color = DARK_PANEL
	card.set_anchors_preset(Control.PRESET_CENTER)
	card.offset_left = -300
	card.offset_right = 300
	card.offset_top = -170
	card.offset_bottom = 170
	canvas.add_child(card)
	
	var card_line_top = ColorRect.new()
	card_line_top.color = GOLD
	card_line_top.set_anchors_preset(Control.PRESET_CENTER)
	card_line_top.offset_left = -300
	card_line_top.offset_right = 300
	card_line_top.offset_top = -170
	card_line_top.offset_bottom = -168
	canvas.add_child(card_line_top)
	
	event_label = Label.new()
	event_label.set_anchors_preset(Control.PRESET_CENTER)
	event_label.offset_left = -270
	event_label.offset_right = 270
	event_label.offset_top = -150
	event_label.offset_bottom = 30
	event_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	event_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	event_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	var es = LabelSettings.new()
	es.font = font
	es.font_size = 19
	es.font_color = Color("#dddddd")
	event_label.label_settings = es
	canvas.add_child(event_label)
	
	# Разделитель внутри карточки
	var divider = ColorRect.new()
	divider.color = Color("#333333")
	divider.set_anchors_preset(Control.PRESET_CENTER)
	divider.offset_left = -250
	divider.offset_right = 250
	divider.offset_top = 35
	divider.offset_bottom = 37
	canvas.add_child(divider)
	
	var btn1 = _add_choice("", -155, 100)
	var btn2 = _add_choice("", 155, 100)
	choice_btns = [btn1, btn2]
	btn1.pressed.connect(_on_choice.bind(0))
	btn2.pressed.connect(_on_choice.bind(1))
	
	# Кнопка назад в меню
	var back_btn = Button.new()
	back_btn.text = "← MENU"
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
	back_btn.pressed.connect(_on_back)
	canvas.add_child(back_btn)

func _add_resource(parent, label_text, value):
	var vbox = VBoxContainer.new()
	parent.add_child(vbox)
	
	var lbl = Label.new()
	lbl.text = label_text
	var s1 = LabelSettings.new()
	s1.font = font
	s1.font_size = 13
	s1.font_color = Color("#666666")
	lbl.label_settings = s1
	vbox.add_child(lbl)
	
	var val = Label.new()
	val.text = value
	var s2 = LabelSettings.new()
	s2.font = font
	s2.font_size = 24
	s2.font_color = GOLD
	val.label_settings = s2
	vbox.add_child(val)
	
	return val

func _add_choice(text, offset_x, offset_y):
	var btn = Button.new()
	btn.text = text
	btn.set_anchors_preset(Control.PRESET_CENTER)
	btn.offset_left = offset_x - 145
	btn.offset_right = offset_x + 145
	btn.offset_top = offset_y - 28
	btn.offset_bottom = offset_y + 28
	btn.add_theme_color_override("font_color", GOLD)
	btn.add_theme_color_override("font_hover_color", Color.WHITE)
	btn.add_theme_font_override("font", font)
	btn.add_theme_font_size_override("font_size", 15)
	btn.add_theme_stylebox_override("normal", StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("hover", StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("pressed", StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("focus", StyleBoxEmpty.new())
	canvas.add_child(btn)
	return btn

func _show_event():
	var e = events[current_event % events.size()]
	event_label.text = e.text
	choice_btns[0].text = e.choices[0].text
	choice_btns[1].text = e.choices[1].text
	turn_label.text = "DAY " + str(current_event + 1)

func _on_choice(index):
	var e = events[current_event % events.size()]
	var choice = e.choices[index]
	
	resources.population += choice.population
	resources.food += choice.food
	resources.money += choice.money
	
	resources.population = max(0, resources.population)
	resources.food = max(0, resources.food)
	resources.money = max(0, resources.money)
	
	_update_resource(pop_label, resources.population)
	_update_resource(food_label, resources.food)
	_update_resource(money_label, resources.money)
	
	current_event += 1
	
	if resources.population <= 0 or resources.food <= 0:
		_game_over()
	else:
		_show_event()

func _update_resource(label, value):
	label.text = str(value)
	if value < 100:
		label.label_settings.font_color = RED
	elif value < 300:
		label.label_settings.font_color = Color("#e67e22")
	else:
		label.label_settings.font_color = GOLD

func _game_over():
	event_label.text = "The city has fallen.\nYour people have lost faith.\nThe Last City is no more."
	choice_btns[0].text = "TRY AGAIN"
	choice_btns[1].text = "MAIN MENU"
	choice_btns[0].pressed.disconnect(_on_choice.bind(0))
	choice_btns[1].pressed.disconnect(_on_choice.bind(1))
	choice_btns[0].pressed.connect(_restart)
	choice_btns[1].pressed.connect(_on_back)

func _restart():
	get_tree().reload_current_scene()

func _on_back():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
