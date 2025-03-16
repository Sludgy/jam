extends Node

var budget: int = 0

var stocks = [
	{"id": "MOP", "name": "Moins Pauvre", "history": [90], "shorted": 0, "shorted_count": null, "delisted": false, "growth": 1.02},
	{"id": "FTB", "name": "FRANKS TREADMILLS AND BALLISTICS LLC", "history": [130], "shorted": 0, "shorted_count": null, "delisted": false, "growth": 1.01},
	{"id": "WOOP", "name": "Wellness Foods", "history": [40], "shorted": 0, "shorted_count": null, "delisted": false, "growth": 1.05},
	{"id": "YPEE", "name": "Yippee!", "history": [120], "shorted": 0, "shorted_count": null, "delisted": false, "growth": 1.04},
]

var calls = [
	{"id": 0, "caller": "YPEE", "dialog": "People have been clamoring on about search engine this. Search engine that. Is it worth looking into?", "read": false, "options": ["Can’t hurt. Everyone needs a phonebook right?", "Fuck the middleman. If you build it they will come."], "choice": null, "effect": ["YPEE", "FTB"]},
	{"id": 0, "caller": "YPEE", "dialog": "Computer mice are a plague. People wont even know how to type in a generation if we keep going like this!", "read": false, "options": ["You’re right. They’ll be illiterate at this rate.", "But… I’m using a mouse."], "choice": null, "effect": ["WOOP", "YPEE"]},
	{"id": 0, "caller": "YPEE", "dialog": "God, do developers even have any passion these days? Only 40 hours of unpaid overtime and they start whinging about forming an union. Sorry I just had a bad week, i’ll forget about it.", "read": false, "options": ["I know a couple fellas with a whole lotta passion. When's the next union meeting?", "Let them cry, what's the worst that can happen?"], "choice": null, "effect": ["YPEE", "MOP"]},
	{"id": 0, "caller": "YPEE", "dialog": "Some no-name, backwater, lard-gargling hobby-hackers ‘found’ a minor flaw in our security system and are asking for payment. It’s barely a flaw. Actually, I think it's a feature!", "read": false, "options": ["If a thief broke into my house. And then told me how to fix MY door. How’d ya think i’d react?", "Where there's smoke there's fire. Write’em a contract"], "choice": null, "effect": ["FTB", "YPEE"]},{"id": 0, "caller": "YPEE", "dialog": "People have been clamoring on about search engine this. Search engine that. Is it worth looking into?", "read": false, "options": ["Can’t hurt. Everyone needs a phonebook right?", "Fuck the middleman. If you build it they will come."], "choice": null, "effect": ["YPEE", "FTB"]},
	{"id": 0, "caller": "YPEE", "dialog": "Computer mice are a plague. People wont even know how to type in a generation if we keep going like this!", "read": false, "options": ["You’re right. They’ll be illiterate at this rate.", "But… I’m using a mouse."], "choice": null, "effect": ["WOOP", "YPEE"]},
	{"id": 0, "caller": "YPEE", "dialog": "God, do developers even have any passion these days? Only 40 hours of unpaid overtime and they start whinging about forming an union. Sorry it's been a really bad week, I should just ignore it..", "read": false, "options": ["Let them cry, what's the worst that can happen?", "I know a couple fellas with a whole lotta passion. When's the next union meeting?"], "choice": null, "effect": ["YPEE", "MOP"]},
	{"id": 0, "caller": "YPEE", "dialog": "Some no-name, backwater, lard-gargling hobby-hackers ‘found’ a minor flaw in our security system and are asking for payment. It’s barely a flaw. Actually, I think it's a feature!", "read": false, "options": ["If a thief broke into my house. And then told me how to fix MY door. How’d ya think i’d react?", "Where there's smoke there's fire. Write’em a contract"], "choice": null, "effect": ["FTB", "YPEE"]},
]
