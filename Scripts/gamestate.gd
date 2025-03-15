extends Node

@onready var time_label: Label = $Time

# game state
enum states {
	TUTORIAL,
	MORNING,
	DAYTIME,
	NIGHT
}
var state: states = states.TUTORIAL

# in-game time
var days: int = 0
var hours: int = 0
var minutes: int = 0
var time: float = 0.0
# how many in-game minutes pass each second
const TIMESCALE: int = 30

func _ready():
	change_state(states.DAYTIME)
	
func _process(delta):
	match state:
		states.TUTORIAL:
			tutorial()
		states.MORNING:
			morning()
		states.DAYTIME:
			daytime(delta)
		states.NIGHT:
			night()

func change_state(target_state):
	state = target_state

func handle_tutorial():
	pass
	
# show initial game start screen / dialog / story or w.e
func tutorial():
	pass

# short a stock
func morning():
	pass

# where the action happens
func daytime(delta):
	_calculate_time(delta)

# end of day scoreboard
func night():
	pass

func _calculate_time(delta):
	time += delta
	minutes = int(time * TIMESCALE)
	var current_minute: int = minutes % 60
	var current_hour: int = minutes / 60
	_format_time(current_hour, current_minute)
	
# helper function for time to text
func _format_time(hour: int, minute: int):
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
	time_label.text = hour_string + ":" + minute_string + " " + meridiem
