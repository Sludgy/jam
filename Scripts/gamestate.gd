extends Node

@onready var budget_label: Label3D = $"3DScene/SubViewport/Desk/paper/DailyBudget"
@onready var short_count_label: RichTextLabel = $UI/Opening/Screen/Count
@onready var short_cost_label: RichTextLabel = $UI/Opening/Screen/Cost
@onready var clock_time: Label3D = $"3DScene/SubViewport/Desk/clock/Time"
@onready var graph = get_node("Graph")

@onready var ticker_name: Label = $Background/TickerBoard/TickerName
@onready var ticker_budget : Label = $Background/TickerBoard/TickerBudget
@onready var callLight : MeshInstance3D = $"3DScene/SubViewport/Desk/phone/callLight"

@onready var dialog_control: Control = $UI/Dialog
@onready var portrait_sprite: Sprite2D = $UI/Dialog/PortraitSprite
@onready var dialog_label: Label = $UI/Dialog/DialogSprite/Dialog
@onready var name_label: Label = $UI/Dialog/DialogSprite/Name
@onready var yes_no_sprite: Sprite2D = $UI/Dialog/YesNoSprite
@onready var player_dialog_control: Control = $UI/PlayerDialog
@onready var player_dialog_label: Control = $UI/PlayerDialog/DialogSprite/Dialog

@onready var buttons_control: Control = $UI/Opening/Screen/Buttons

# in-game time
var days: int = 0
var hours: int = 0
var previous_minute: int = -1
var minutes: int = 0
var time: float = 0.0
# how many in-game minutes pass each second
const TIMESCALE: int = 3
#const TIMESCALE: int = 30
# how many minutes it takes for a phone call to occur
const PHONE_CALL_FREQUENCY: int = 45
# grow stocks on the half hour
const STOCK_GROWTH_FREQUENCY: int = 30

# amount to increase/decrease a stock when a choice is made
const STOCK_INCREASE_AMOUNT: int = 5
const STOCK_DECREASE_AMOUNT: int = 10

# game state
enum states {
	TUTORIAL,
	RECEIVEBUDGET,
	STARTOFDAY,
	DAYTIME,
	ENDOFDAY,
	SUMMARY,
	WINLOSE
}
var state: states = states.TUTORIAL

var shorting: Array[int] = [0, 0, 0, 0]
var total: int = 0

const DAILY_BUDGET = 1000
const KAPUT_THRESHOLD = 10

var current_call = 0
var call_waiting = false

func _ready():
	# randomize calls once at the start of the game
	Manager.calls.shuffle()
	update_stocks()
	change_state(states.RECEIVEBUDGET)
	
	for i in buttons_control.get_children():
		i.connect("add_subtract_button_pressed", _on_add_subtract)
	
func _process(delta):
	match state:
		states.TUTORIAL:
			tutorial()
		states.RECEIVEBUDGET:
			receive_budget()
		states.STARTOFDAY:
			startofday()
		states.DAYTIME:
			daytime(delta)
		states.ENDOFDAY:
			endofday()
		states.SUMMARY:
			summary()
		states.WINLOSE:
			winlose()

func change_state(target_state):
	state = target_state
	
# show initial game start screen / dialog / story or w.e
func tutorial():
	pass
	
func receive_budget():
	Manager.budget += DAILY_BUDGET
	update_budget()
	change_state(states.STARTOFDAY)

# short a stock
func startofday():
	$UI/Opening.show()

# where the action happens
func daytime(delta):
	_calculate_time(delta)
	if call_waiting:
		if minutes % 2 == 0:
			callLight.show()
		else:
			callLight.hide()

# end of day scoreboard
func endofday():
	var total = 0
	for i in Manager.stocks.size():
		total = total + (Manager.stocks[i]["history"][Manager.stocks[i]["history"].size()-1]*Manager.stocks[i]["shorted_count"])
	Manager.budget = Manager.budget - total
	update_budget()
	change_state(states.SUMMARY)
	
func summary():
	change_state(states.RECEIVEBUDGET)
	reset_time()
	days += 1
	
func winlose():
	pass
	
func reset_time():
	time = 0
	previous_minute = -1
	minutes = 0
	hours = 0

func _calculate_time(delta):
	time += delta
	minutes = int(time * TIMESCALE)
	var current_minute: int = minutes % 60
	var current_hour: int = minutes / 60
	_update_time(current_hour, current_minute)
	# time to clock off
	if (current_hour == 6):
		call_waiting = false
		_hang_up()
		change_state(states.ENDOFDAY)
	if (previous_minute != minutes):
		previous_minute = minutes
		if (minutes % STOCK_GROWTH_FREQUENCY == 0):
			grow_stocks()
			graph.update_graph()
		if (minutes % PHONE_CALL_FREQUENCY == 0):
			if (!call_waiting) && !dialog_control.is_visible_in_tree():
				_update_phone()
	
# start a phone call
func _update_phone():
	call_waiting = true
	# play sounds, animations etc.
	
# hang up - basically just close all dialogs and place the phone down
func _hang_up():
	if (dialog_control.is_visible_in_tree()):
		$"3DScene/SubViewport/Desk/AnimationPlayer".play_backwards("phone_pickup")
		player_dialog_control.hide()
		dialog_control.hide()

func _pickup_phone():
	callLight.hide()
	$"3DScene/SubViewport/Desk/AnimationPlayer".play("phone_pickup")
	if (current_call != 0):
		current_call+=1
	var phonecall = Manager.calls[current_call]
	dialog_label.text = phonecall["dialog"]
	name_label.text = phonecall["caller"]
	var texture = load("res://Assets/2D/UI/Portraits/"+phonecall["caller"]+".png")
	portrait_sprite.texture = texture
	
	await get_tree().create_timer(0.3).timeout
	dialog_control.show()
	yes_no_sprite.show()
	
func _on_phone_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
		if call_waiting:
			call_waiting = false
			print("Picking up phone")
			_pickup_phone()
	
# yes = 0, no = 1
func _handle_dialog_choice(choice: bool):
	yes_no_sprite.hide()
	# affect stocks
	# LOOP EACH STOCK
	for i in Manager.stocks.size():
		for j in Manager.calls[current_call]["effect"].size():
			if Manager.stocks[i]["id"] == Manager.calls[current_call]["effect"][j]:
				if (j == 0):
					_increase_stock(i, choice)
				else:
					_increase_stock(i, !choice)
			
	update_stocks()
	# display player quote
	player_dialog_label.text = Manager.calls[current_call]["options"][int(choice)]
	player_dialog_control.show()
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		match(state):
			states.TUTORIAL:
				change_state(states.RECEIVEBUDGET)
			states.DAYTIME:
				if player_dialog_control.is_visible_in_tree():
					current_call = current_call + 1
					_hang_up()
			states.SUMMARY:
				change_state(states.RECEIVEBUDGET)

func _increase_stock(id: int, decrease: bool):
	# if we want to decrease instead, make the amount negative
	var multiplier = 1
	var amount = STOCK_INCREASE_AMOUNT
	if decrease:
		multiplier = -1
		amount = STOCK_DECREASE_AMOUNT
	print("CHANGE STOCK " + Manager.stocks[id]["id"] + " BY " + str(multiplier) + "*" + str(amount))
	Manager.stocks[id]["history"].append(Manager.stocks[id]["history"][Manager.stocks[id]["history"].size()-1] + (amount*multiplier))

func _on_no_pressed() -> void:
	_handle_dialog_choice(1)

func _on_yes_pressed() -> void:
	_handle_dialog_choice(0)
	
# helper function for time to text
func _update_time(hour: int, minute: int):
	# our day starts at 10am
	var hour_adjusted: int = hour+10
	var hour_string: String = ""
	var minute_string: String = ""
	var meridiem: String = ""
	if (hour_adjusted >= 12):
		meridiem = "PM"
		if (hour_adjusted > 12):
			hour_adjusted -= 12
	else:
		meridiem = "AM"
	if (hour_adjusted <= 9):
		hour_string = "0" + str(hour_adjusted)
	else:
		hour_string = str(hour_adjusted)
	if (minute <= 9):
		minute_string = "0" + str(minute)
	else:
		minute_string = str(minute)
	if minute % 10 == 0:
		clock_time.text = hour_string + ":" + minute_string
		
func _on_add_subtract(id: int, operation: bool):
	# 0 = SUBTRACTION, 1 = ADDITION
	if operation:
		shorting[id] += 1
	else:
		# dont go below zero
		if (shorting[id] != 0):
			shorting[id] -= 1
	update_shorts()
	
func update_shorts():
	total = 0
	var cost_text: String = ""
	var count_text: String = ""
	for i in shorting.size():
		count_text = count_text + str(shorting[i]) + "\n"
		var mini_total: int = shorting[i] * Manager.stocks[i]["history"][Manager.stocks[i]["history"].size()-1]
		total = total + mini_total
		cost_text = cost_text + "$" + str(mini_total) + "\n"
	cost_text = cost_text + "$" + str(total)
	short_count_label.text = count_text
	short_cost_label.text = cost_text

func _on_open_market_pressed() -> void:
	# short stocks
	# cant short more than 200% of your budget
	if total <= Manager.budget*2:
		# sell the stocks
		for i in shorting.size():
			if shorting[i] != 0:
				# set shorted to the price you sold them at (this is how we calculate if we make profit or loss)
				Manager.stocks[i]["shorted"] = Manager.stocks[i]["history"][Manager.stocks[i]["history"].size()-1]
				Manager.stocks[i]["shorted_count"] = shorting[i]
				
				# money, yum
				Manager.budget += Manager.stocks[i]["shorted"]*Manager.stocks[i]["shorted_count"]
		update_budget()
		$UI/Opening.hide()
		change_state(states.DAYTIME)

func update_budget():
	budget_label.text = "Today's Budget " + "\n" + "$" + str(Manager.budget)

func grow_stocks():
	for i in Manager.stocks.size():
		var new_price = Manager.stocks[i]["history"][Manager.stocks[i]["history"].size()-1] * Manager.stocks[i]["growth"]
		Manager.stocks[i]["history"].append(int(new_price))
		# print the latest price
		print(Manager.stocks[i]["history"][Manager.stocks[i]["history"].size()-1])
	update_stocks()

func update_stocks():
	var label_text: String = ""
	var name_text: String = ""
	var budget_text: String = ""
	for i in Manager.stocks.size():
		label_text += Manager.stocks[i]["id"] + " " + "Value: " + str(Manager.stocks[i]["history"][Manager.stocks[i]["history"].size()-1]) + "\n"
		name_text += Manager.stocks[i]["id"] + "\n"
		budget_text += "$" + str(Manager.stocks[i]["history"][Manager.stocks[i]["history"].size()-1]) + "\n"
		
	ticker_name.text = name_text
	ticker_budget.text = budget_text
