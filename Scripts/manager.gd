extends Node

var budget: int = 0

var stocks = [
	{"name": "Stock 1", "history": [100], "shorted": 0, "shorted_count": null},
	{"name": "Stock 2", "history": [120], "shorted": 0, "shorted_count": null},
	{"name": "Stock 3", "history": [110], "shorted": 0, "shorted_count": null},
	{"name": "Stock 4", "history": [100], "shorted": 0, "shorted_count": null},
	{"name": "Stock 5", "history": [90], "shorted": 0, "shorted_count": null}
]

var calls = [
	{"id": 0, "dialog": "We gotta cut the meat products, fill them out. Will the customers notice?", "read": false, "options": [{"dialog": "Tofu. No difference."}, {"dialog": "I don't fuck with baby food."}], "choice": null}
]
