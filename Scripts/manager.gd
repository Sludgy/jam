extends Node

var budget: int = 10000

# MOP = 0, FTB = 1, WOOP = 2, YPEE = 3
var stocks = [
	{"id": "MOP", "name": "Moins Pauvre", "history": [90], "shorted": 0, "shorted_count": 0, "delisted": false, "growth": 1.02},
	{"id": "FTB", "name": "FRANKS TREADMILLS AND BALLISTICS LLC", "history": [130], "shorted": 0, "shorted_count": 0, "delisted": false, "growth": 1.01},
	{"id": "WOOP", "name": "Wellness Foods", "history": [40], "shorted": 0, "shorted_count": 0, "delisted": false, "growth": 1.05},
	{"id": "YPEE", "name": "Yippee!", "history": [120], "shorted": 0, "shorted_count": 0, "delisted": false, "growth": 1.04},
]

var calls = [
	{"id": 0, "caller": "YPEE", "dialog": "People have been clamoring on about search engine this. Search engine that. Is it worth looking into?", "read": false, "options": ["Fuck the middleman. If you build it they will come.", "Can’t hurt. Everyone needs a phonebook right?"], "choice": null, "effect": ["FTB", "YPEE"]},
	{"id": 0, "caller": "YPEE", "dialog": "Computer mice are a plague. People won't even know how to type in a generation if we keep going like this! Should we get rid of them?", "read": false, "options": ["You’re right. They’ll be illiterate at this rate.", "But… I’m using a mouse."], "choice": null, "effect": ["MOP", "YPEE"]},
	{"id": 0, "caller": "YPEE", "dialog": "God, do developers even have any passion these days? Only 40 hours of unpaid overtime and they start whinging about forming an union. Sorry it's been a really bad week, I should just ignore it.", "read": false, "options": ["I know a couple fellas with a whole lotta passion. When's the next union meeting?", "Let them cry, what's the worst that can happen?"], "choice": null, "effect": ["YPEE", "WOOP"]},
	{"id": 0, "caller": "YPEE", "dialog": "Seems like people are kinda upset about our land clearing for server farms in national parks again… Should we… like. Apologise?", "read": false, "options": ["I know at least three rat conservatories you could donate to. Kids love rats.", "It’s wood. It’ll grow back."], "choice": null, "effect": ["YPEE", "WOOP"]},
	{"id": 0, "caller": "YPEE", "dialog": "Some no-name, backwater, lard-gargling hobby-hackers ‘found’ a minor flaw in our firewall system and wants payment for it. It’s barely a flaw. Actually, I’d even call it a feature! This is blackmail isn’t it?", "read": false, "options": ["If a thief broke into my house. And then told me how to fix MY door. How’d ya think i’d react?", "Where there's smoke there's fire. I’d write’em a cheque, maybe even a contract."], "choice": null, "effect": ["FTB", "YPEE"]},
	{"id": 0, "caller": "YPEE", "dialog": "You remember that little data breach we had a month ago? A couple million passwords. Big hullabaloo over nothing right?", "read": false, "options": ["Lighting never strikes twice. Forget about it.", "I pay a guy to remember my passwords. Maybe you should do something similar."], "choice": null, "effect": ["FTB", "YPEE"]},
	{"id": 0, "caller": "YPEE", "dialog": "It’s Wednesday. You know what that means. You. Me. Golf", "read": false, "options": ["Say less. ", "Don’t you have like, other friends?"], "choice": null, "effect": ["YPEE", "FTB"]},
	{"id": 0, "caller": "WOOP", "dialog": "We're running low on meat for our meat based products. We could fill them out with alternatives but would the customers notice?", "read": false, "options": ["Sawdust. No difference.", "I’d leave the hot dogs out of it. Please."], "choice": null, "effect": ["FTB", "WOOP"]},   
	{"id": 0, "caller": "WOOP", "dialog": "This heating process for milk just seems so unnecessary. And time consuming as well. We're a NATURAL food company and our customers want REAL food.", "read": false, "options": ["Raw milk, childhood favourite of mine.", "I don’t fuck with baby food."], "choice": null, "effect": ["YPEE", "WOOP"]},
	{"id": 0, "caller": "WOOP", "dialog": "On every street those Girl Scouts are undercutting us. I’ve been baking up a smear campaign for awhile now, but. Would the public respond well to that you think?", "read": false, "options": ["Can’t make cookies without breaking a few eggs. That’s just basic economics", "Competition is healthy, that's what they taught me in Boy Scouts."], "choice": null, "effect": ["MOP", "WOOP"]},
	{"id": 0, "caller": "WOOP", "dialog": "I saw the most tragic documentary last night and didn’t realise how sad we made those cute little orangutans from using palm oil all the time. It’s time we found alternatives.", "read": false, "options": ["They can rip a grown man to shreds y’know. It’s best we leave those monkeys alone.", "They’re smart creatures. Our common ancestor. They’ll figure it out."], "choice": null, "effect": ["MOP", "WOOP"]},
	{"id": 0, "caller": "WOOP", "dialog": "A5 Wagyu, A1 woohoo. If the difference is just some white lines couldn’t we draw them on somehow?", "read": false, "options": ["It’s all going down the same hole I say.", "It’s disrespectful to the cows. They’re the ones who’ve earned it after all"], "choice": null, "effect": ["FTB", "WOOP"]},
	{"id": 0, "caller": "WOOP", "dialog": "Did you realise we keep our freezers on the ENTIRE day? What a tremendous waste, why not just when we're awake?", "read": false, "options": ["Freezers… I… Get what you’re saying. That’s a great point in fact.", "Freezers… Might work differently than how you think…Maybe…"], "choice": null, "effect": ["YPEE", "WOOP"]},
	{"id": 0, "caller": "FTB", "dialog": "Ever since the war all the youth care about these days is goddam ethics. Where are the kids that have an honest to god love of good old mass arms manufacturing? Shiet.", "read": false, "options": ["Kids love games. Games need money. We have money. I’m sure we could work things out.", "The kids yearn for industry, the public does not. They’ll come around eventually."], "choice": null, "effect": ["FTB", "MOP"]},
	{"id": 0, "caller": "FTB", "dialog": "The investors are saying we spend too much on flags. I’ll shove those flags so far up their asses they’ll be seeing stars, all 50 of ‘em. Would you say flags are a waste son?", "read": false, "options": ["They’re ornamental. Inefficient. Those words, and this company don’t mix", "Of course not, what else is the moon good fo"], "choice": null, "effect": ["FTB", "WOOP"]},
	{"id": 0, "caller": "FTB", "dialog": "The government is threatening to cut the contracts this quarter. I reckon we stir up some trouble overseas, I’ve got 3 men, a radio, and a lots of ammo ready to go", "read": false, "options": ["Let's kick back and enjoy the show", "Slow down cowboy, violence is never the answer! Ghandi said that I’m pretty sure"], "choice": null, "effect": ["FTB", "WOOP"]},
	{"id": 0, "caller": "FTB", "dialog": "If I hear about one more public protest against hollow points, just shoot me where I stand. Hm. They don't expect us to stop, right?", "read": false, "options": ["You can ‘say’ you’ll stop producing them, that’ll shut them up.", "Oh course not, don’t they have tweezers?"], "choice": null, "effect": ["FTB", "MOP"]},
	{"id": 0, "caller": "FTB", "dialog": "These bigwig politicians keep barking up my tree, making regulations for what I can and can't do, it's affecting business. These Commies should be taken care of", "read": false, "options": ["It would be a shame if something were to happen to them.", "Best not to cause a scene, they control the budget after all"], "choice": null, "effect": ["FTB", "YPEE"]},
	{"id": 0, "caller": "FTB", "dialog": "The youngins are protesting our line of missiles, they’re saying it's “unnecessary” and “evil” or something like that. I think a fresh coat of paint is in order, what do you think son", "read": false, "options": ["Call it something patriotic… like, ‘The Patriot’!... They can't hate that! They can't hate freedom!", "The brand is blowing stuff up! The kids just don't get it."], "choice": null, "effect": ["FTB", "MOP"]},
	{"id": 0, "caller": "MOP", "dialog": "The rabbits we used for fur are apparently endangered now. If they don’t fuck like rabbits. Then what is the fucking point?  Do we keep hunting the rabbits? We need more fur", "read": false, "options": ["I hear the animal shelters have a few lost rabbits", "Maybe another furry animal… like… a pig?"], "choice": null, "effect": ["MOP", "WOOP"]},
	{"id": 0, "caller": "MOP", "dialog": "Why do I bother hiring bumbling idiots, when a machine could do the same and won’t waste my time asking for a raise!? Customers love machines, right?", "read": false, "options": ["Absolutely! They don't complain and they don't need breaks, what's not to love", "You’ll spend more on teaching people how to use those damn things."], "choice": null, "effect": ["YPEE", "MOP"]},
	{"id": 0, "caller": "MOP", "dialog": "How do you keep production costs low? You make things smaller, use less materials… Where you ask? Pockets.", "read": false, "options": ["No pockets? Where are they gonna hold their cash? In their hands? They’re TINY!", "Less pockets. More Bags"], "choice": null, "effect": ["FTB", "MOP"]},
	{"id": 0, "caller": "MOP", "dialog": "The customers are trying to boycott our line of sealskin boots! What a joke! Should I just wait until it blows over?", "read": false, "options": ["If the seals didn't want to be boots, they’d say so! That's what I would do", "Don’t worry about it, they’ll forget… eventually…"], "choice": null, "effect": ["MOP", "FTB"]},
	{"id": 0, "caller": "MOP", "dialog": "I’m thinking of a new clothing line where we sell a single piece of string for $500 each, and call it a high fashion. Do you think the customers are dumb enough to buy it?", "read": false, "options": ["People will buy anything for thousands if you call it a statement piece, trust me", "Nobody would be stupid enough to fall for that… I think…"], "choice": null, "effect": ["MOP", "YPEE"]},
	{"id": 0, "caller": "MOP", "dialog": "Can you believe the GAUL these garment workers have to ask for a $1 raise?! I’m already paying them $3 an hour, is that not enough?! They’re threatening to tear holes in the jeans! This is blackmail, right? We can't give in", "read": false, "options": ["If they want to be rich so bad, they should work harder and have been born rich", "We can't let anything happen to our precious, precious jeans."], "choice": null, "effect": ["MOP", "WOOP"]},
]
