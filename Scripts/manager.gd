extends Node

var budget: int = 0

var stocks = [
	{"name": "Stock 1", "history": [100, 80, 70, 80, 75, 70, 65, 70, 65, 60, 20, 10], "shorted": 0, "shorted_count": null, "delisted": false},
	{"name": "Stock 2", "history": [120, 60, 50, 40, 25, 30, 50, 60, 60, 70, 60, 70], "shorted": 0, "shorted_count": null, "delisted": false},
	{"name": "Stock 3", "history": [110, 100, 105, 105, 100, 90, 80, 85, 80, 75, 70, 65], "shorted": 0, "shorted_count": null, "delisted": false},
	{"name": "Stock 4", "history": [100, 120, 130, 110, 100, 90, 100, 110, 120, 120, 110, 110], "shorted": 0, "shorted_count": null, "delisted": false},
	{"name": "Stock 5", "history": [90, 85, 75, 85, 90, 95, 100, 80, 70, 75, 50, 30], "shorted": 0, "shorted_count": null, "delisted": false}
]

var calls = [
	{"id": 0, "dialog": "We gotta cut the meat products, fill them out. Will the customers notice?", "read": false, "options": [{"dialog": "Tofu. No difference."}, {"dialog": "I don't fuck with baby food."}], "choice": null}
]
