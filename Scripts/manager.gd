extends Node

var budget: int = 0

var stocks = [
	{"id": "MOP", "name": "Moins Pauvre", "history": [100], "shorted": 0, "shorted_count": null, "delisted": false},
	{"id": "FTB", "name": "FRANKS TREADMILLS AND BALLISTICS LLC", "history": [120], "shorted": 0, "shorted_count": null, "delisted": false},
	{"id": "WOO", "name": "Wellness Foods", "history": [110], "shorted": 0, "shorted_count": null, "delisted": false},
	{"id": "YPEE", "name": "Yippee!", "history": [100], "shorted": 0, "shorted_count": null, "delisted": false},
]

var calls = [
	{"id": 0, "dialog": "We gotta cut the meat products, fill them out. Will the customers notice?", "read": false, "options": [{"dialog": "Tofu. No difference."}, {"dialog": "I don't fuck with baby food."}], "choice": null}
]
