extends Node

var budget: int = 0

var stocks = [
	{"id": "MOP", "name": "Moins Pauvre", "history": [100], "shorted": 0, "shorted_count": null, "delisted": false, "growth": 1.02},
	{"id": "FTB", "name": "FRANKS TREADMILLS AND BALLISTICS LLC", "history": [130], "shorted": 0, "shorted_count": null, "delisted": false, "growth": 1.01},
	{"id": "WOOP", "name": "Wellness Foods", "history": [100], "shorted": 0, "shorted_count": null, "delisted": false, "growth": 1.04},
	{"id": "YPEE", "name": "Yippee!", "history": [40], "shorted": 0, "shorted_count": null, "delisted": false, "growth": 1.05},
]

var calls = [
	{"id": 0, "caller": "MOP", "dialog": "We gotta cut the meat products, fill them out. Will the customers notice?", "read": false, "options": ["Tofu. No difference.", "I don't fuck with baby food."], "choice": null, "effect": ["MOP", "FTB"]}
]
