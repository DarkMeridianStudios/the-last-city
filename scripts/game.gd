extends Node

const GOLD = Color("#c8a97e")
const BG_DARK = Color("#0a0a0f")
const DARK_PANEL = Color("#0f0f1a")
const RED = Color("#c0392b")
const FONT_PATH = "res://assets/fonts/Cinzel-Regular.ttf"

var resources = {
	"population": 1000,
	"food": 500,
	"money": 200
}

var events = [
	{
		"text": "A plague spreads through the eastern districts.\nThousands are at risk.",
		"advisor": "MAYOR ALDRIC",
		"line": "\"We cannot let fear rule the city, but we cannot ignore the dead either.\"",
		"choices": [
			{"text": "QUARANTINE THE DISTRICT", "population": -50, "food": -30, "money": -20},
			{"text": "DISTRIBUTE MEDICINE", "population": -10, "food": -10, "money": -80}
		]
	},
	{
		"text": "Merchants from the north offer a trade deal.\nThey want food in exchange for gold.",
		"advisor": "TREASURER VESNA",
		"line": "\"Gold fills vaults, but empty stomachs fill graves.\"",
		"choices": [
			{"text": "ACCEPT THE DEAL", "population": 0, "food": -100, "money": 150},
			{"text": "REFUSE THE OFFER", "population": 0, "food": 0, "money": -20}
		]
	},
	{
		"text": "A drought threatens the harvest.\nFarmers need resources to survive.",
		"advisor": "MAYOR ALDRIC",
		"line": "\"A starving farmer plants no seeds for next year.\"",
		"choices": [
			{"text": "FUND THE FARMERS", "population": 20, "food": 80, "money": -100},
			{"text": "IMPOSE RATIONING", "population": -30, "food": 20, "money": 0}
		]
	},
	{
		"text": "Rebels have seized the eastern gate.\nThe city guard requests permission to act.",
		"advisor": "COMMANDER ORYN",
		"line": "\"Mercy shown to traitors is a knife handed to your enemies.\"",
		"choices": [
			{"text": "SEND THE GUARD", "population": -20, "food": 0, "money": -50},
			{"text": "NEGOTIATE PEACE", "population": 10, "food": -20, "money": -30}
		]
	},
	{
		"text": "A noble family offers a large donation.\nIn return, they want a seat on the council.",
		"advisor": "TREASURER VESNA",
		"line": "\"Every gift has a string attached. The question is how long it is.\"",
		"choices": [
			{"text": "ACCEPT THEIR GOLD", "population": -10, "food": 0, "money": 200},
			{"text": "DECLINE THE OFFER", "population": 20, "food": 0, "money": -10}
		]
	},
	{
		"text": "Refugees from a fallen settlement beg at the gates.\nThey carry little but their will to survive.",
		"advisor": "MAYOR ALDRIC",
		"line": "\"We were strangers once too, in a city not so different.\"",
		"choices": [
			{"text": "LET THEM IN", "population": 80, "food": -60, "money": -20},
			{"text": "TURN THEM AWAY", "population": -5, "food": 0, "money": 0}
		]
	},
	{
		"text": "Soldiers have not been paid in weeks.\nMurmurs of mutiny spread through the barracks.",
		"advisor": "COMMANDER ORYN",
		"line": "\"An unpaid sword finds new masters quickly.\"",
		"choices": [
			{"text": "PAY THEM IN FULL", "population": 0, "food": 0, "money": -120},
			{"text": "PROMISE FUTURE PAY", "population": -15, "food": 0, "money": 0}
		]
	},
	{
		"text": "A wandering healer claims she can cure the sick.\nHer methods are unorthodox and unproven.",
		"advisor": "TREASURER VESNA",
		"line": "\"Desperation makes believers of us all.\"",
		"choices": [
			{"text": "LET HER TRY", "population": 30, "food": 0, "money": -40},
			{"text": "TURN HER AWAY", "population": -20, "food": 0, "money": 0}
		]
	},
	{
		"text": "Grain stores show signs of rot.\nA portion of the harvest may be lost.",
		"advisor": "MAYOR ALDRIC",
		"line": "\"Better to lose grain now than lives later.\"",
		"choices": [
			{"text": "BURN THE SPOILED GRAIN", "population": 0, "food": -60, "money": -10},
			{"text": "RISK USING IT ANYWAY", "population": -40, "food": 40, "money": 0}
		]
	},
	{
		"text": "A rival city proposes an alliance.\nThey ask for troops in an upcoming campaign.",
		"advisor": "COMMANDER ORYN",
		"line": "\"Allies today, conquerors tomorrow.\"",
		"choices": [
			{"text": "JOIN THE ALLIANCE", "population": -30, "food": -20, "money": 100},
			{"text": "STAY NEUTRAL", "population": 0, "food": 0, "money": -30}
		]
	},
	{
		"text": "Citizens demand a festival to lift their spirits\nafter months of hardship.",
		"advisor": "TREASURER VESNA",
		"line": "\"Bread alone does not feed the soul.\"",
		"choices": [
			{"text": "HOLD THE FESTIVAL", "population": 40, "food": -50, "money": -60},
			{"text": "FOCUS ON SURVIVAL", "population": -20, "food": 0, "money": 0}
		]
	},
	{
		"text": "An informant claims a councilor is plotting treason.\nThe evidence is thin but troubling.",
		"advisor": "COMMANDER ORYN",
		"line": "\"Suspicion is a fire — it can warm or burn the house down.\"",
		"choices": [
			{"text": "ARREST THE COUNCILOR", "population": -10, "food": 0, "money": -20},
			{"text": "INVESTIGATE QUIETLY", "population": 0, "food": 0, "money": -40}
		]
	},
	{
		"text": "Bandits raid the southern trade road.\nMerchants refuse to travel without protection.",
		"advisor": "COMMANDER ORYN",
		"line": "\"An abandoned road starves a city.\"",
		"choices": [
			{"text": "ESCORT THE CARAVANS", "population": -10, "food": 0, "money": -50},
			{"text": "ABANDON THE ROUTE", "population": 0, "food": -40, "money": 0}
		]
	},
	{
		"text": "A harsh winter approaches faster than expected.\nFirewood and shelter are running low.",
		"advisor": "MAYOR ALDRIC",
		"line": "\"The cold does not negotiate. We must move first.\"",
		"choices": [
			{"text": "BUY EMERGENCY SUPPLIES", "population": 10, "food": 0, "money": -90},
			{"text": "RATION WHAT WE HAVE", "population": -35, "food": -30, "money": 0}
		]
	},
	{
		"text": "Children have begun working the fields\nto compensate for the labor shortage.",
		"advisor": "TREASURER VESNA",
		"line": "\"We are spending a future to pay for a present.\"",
		"choices": [
			{"text": "ALLOW IT FOR NOW", "population": 0, "food": 50, "money": 20},
			{"text": "FORBID CHILD LABOR", "population": 5, "food": -20, "money": -10}
		]
	},
	{
		"text": "A captured spy from a neighboring city\nawaits your judgment.",
		"advisor": "COMMANDER ORYN",
		"line": "\"Execute him and send a message. Free him and send another kind.\"",
		"choices": [
			{"text": "EXECUTE THE SPY", "population": -5, "food": 0, "money": 0},
			{"text": "RELEASE HIM AS A GESTURE", "population": 10, "food": 0, "money": -30}
		]
	},
	{
		"text": "The old aqueduct is crumbling.\nWithout repair, clean water will become scarce.",
		"advisor": "MAYOR ALDRIC",
		"line": "\"Stone does not ask for patience. It simply falls.\"",
		"choices": [
			{"text": "REPAIR IT IMMEDIATELY", "population": 15, "food": 0, "money": -110},
			{"text": "DELAY THE REPAIRS", "population": -25, "food": 0, "money": 0}
		]
	},
	{
		"text": "A traveling merchant offers rare seeds\nsaid to grow in any soil, any season.",
		"advisor": "TREASURER VESNA",
		"line": "\"Miracles in this world usually come with a price tag.\"",
		"choices": [
			{"text": "BUY THE SEEDS", "population": 0, "food": 60, "money": -70},
			{"text": "DISMISS THE CLAIM", "population": 0, "food": 0, "money": 0}
		]
	}
]

var shuffled_events = []
var current_event = 0
var font
var canvas
var pop_label
var food_label
var money_label
var event_label
var advisor_label
var advisor_line_label
var choice_btns = []
var turn_label

func _ready():
	font = load(FONT_PATH)
	shuffled_events = events.duplicate()
	shuffled_events.shuffle()
	_apply_trait_modifiers()
	_build_ui()
	_show_event()

func _apply_trait_modifiers():
	match GameData.player_trait:
		"COMPASSIONATE":
			resources.population += 100
		"CUNNING":
			resources.money += 100
		"RUTHLESS":
			resources.food += 100

func _build_ui():
	canvas = CanvasLayer.new()
	add_child(canvas)
	
	var bg = ColorRect.new()
	bg.color = BG_DARK
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	canvas.add_child(bg)
	
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
	
	var ruler_label = Label.new()
	ruler_label.text = "RULER " + GameData.player_name
	ruler_label.set_anchors_preset(Control.PRESET_TOP_RIGHT)
	ruler_label.offset_left = -220
	ruler_label.offset_top = 12
	var rs = LabelSettings.new()
	rs.font = font
	rs.font_size = 13
	rs.font_color = Color("#555555")
	ruler_label.label_settings = rs
	canvas.add_child(ruler_label)
	
	turn_label = Label.new()
	turn_label.text = "DAY 1"
	turn_label.set_anchors_preset(Control.PRESET_TOP_RIGHT)
	turn_label.offset_left = -220
	turn_label.offset_top = 35
	var ts = LabelSettings.new()
	ts.font = font
	ts.font_size = 16
	ts.font_color = Color("#555555")
	turn_label.label_settings = ts
	canvas.add_child(turn_label)
	
	var card = ColorRect.new()
	card.color = DARK_PANEL
	card.set_anchors_preset(Control.PRESET_CENTER)
	card.offset_left = -320
	card.offset_right = 320
	card.offset_top = -200
	card.offset_bottom = 200
	canvas.add_child(card)
	
	var card_line_top = ColorRect.new()
	card_line_top.color = GOLD
	card_line_top.set_anchors_preset(Control.PRESET_CENTER)
	card_line_top.offset_left = -320
	card_line_top.offset_right = 320
	card_line_top.offset_top = -200
	card_line_top.offset_bottom = -198
	canvas.add_child(card_line_top)
	
	event_label = Label.new()
	event_label.set_anchors_preset(Control.PRESET_CENTER)
	event_label.offset_left = -290
	event_label.offset_right = 290
	event_label.offset_top = -180
	event_label.offset_bottom = -50
	event_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	event_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	event_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	var es = LabelSettings.new()
	es.font = font
	es.font_size = 19
	es.font_color = Color("#dddddd")
	event_label.label_settings = es
	canvas.add_child(event_label)
	
	advisor_label = Label.new()
	advisor_label.set_anchors_preset(Control.PRESET_CENTER)
	advisor_label.offset_left = -290
	advisor_label.offset_right = 290
	advisor_label.offset_top = -45
	advisor_label.offset_bottom = -25
	advisor_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	var ads = LabelSettings.new()
	ads.font = font
	ads.font_size = 13
	ads.font_color = GOLD
	advisor_label.label_settings = ads
	canvas.add_child(advisor_label)
	
	advisor_line_label = Label.new()
	advisor_line_label.set_anchors_preset(Control.PRESET_CENTER)
	advisor_line_label.offset_left = -290
	advisor_line_label.offset_right = 290
	advisor_line_label.offset_top = -20
	advisor_line_label.offset_bottom = 35
	advisor_line_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	advisor_line_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	var als = LabelSettings.new()
	als.font = font
	als.font_size = 13
	als.font_color = Color("#999999")
	advisor_line_label.label_settings = als
	canvas.add_child(advisor_line_label)
	
	var divider = ColorRect.new()
	divider.color = Color("#333333")
	divider.set_anchors_preset(Control.PRESET_CENTER)
	divider.offset_left = -280
	divider.offset_right = 280
	divider.offset_top = 45
	divider.offset_bottom = 47
	canvas.add_child(divider)
	
	var btn1 = _add_choice("", -175, 130)
	var btn2 = _add_choice("", 175, 130)
	choice_btns = [btn1, btn2]
	btn1.pressed.connect(_on_choice.bind(0))
	btn2.pressed.connect(_on_choice.bind(1))
	
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
	btn.offset_left = offset_x - 165
	btn.offset_right = offset_x + 165
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
	if current_event >= shuffled_events.size():
		shuffled_events = events.duplicate()
		shuffled_events.shuffle()
		current_event = 0
	
	var e = shuffled_events[current_event]
	event_label.text = e.text
	advisor_label.text = e.advisor
	advisor_line_label.text = e.line
	choice_btns[0].text = e.choices[0].text
	choice_btns[1].text = e.choices[1].text
	turn_label.text = "DAY " + str(current_event + 1)

func _on_choice(index):
	var e = shuffled_events[current_event]
	var choice = e.choices[index]
	
	var pop_change = choice.population
	if GameData.player_trait == "COMPASSIONATE" and pop_change < 0:
		pop_change = int(pop_change * GameData.get_trait_modifier("population_loss"))
	
	resources.population += pop_change
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
	event_label.text = "The city has fallen.\nYour reign, " + GameData.player_name + ", ends here."
	advisor_label.text = ""
	advisor_line_label.text = ""
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
