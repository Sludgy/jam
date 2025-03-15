extends Node2D

var LINE_WIDTH = 2
var LINE_COLOUR_BULLISH = Color.GREEN
var LINE_COLOUR_BEARISH = Color.RED
var POINT_SPACING = 20

# TODO update graph every hour
func _ready() -> void:
	for i in Manager.stocks.size():
		plot_graph(Manager.stocks[i])

func plot_graph(stock):
	var line = Line2D.new()
	line.width = LINE_WIDTH
	line.default_color = LINE_COLOUR_BULLISH
	# set colour to red if stock on downtrend
	var size = stock["history"].size()
	if (size > 1):
		if stock["history"][size-1] < stock["history"][size-2]:
			line.default_color = LINE_COLOUR_BEARISH
	var points: Array[Vector2] = []
	
	for i in size:
		points.append(Vector2(i*POINT_SPACING, -stock["history"][i]))
	line.points = points
	add_child(line)
