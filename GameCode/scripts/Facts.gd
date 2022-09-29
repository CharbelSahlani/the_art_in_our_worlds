extends Node2D
"""
This script will be responsible for the facts
the structure that I a, choosing will be 
id to have facts id to track the shown facts
or I could remove the fact from the dictionary
"""

export var facts = [
	#1
	{
		"question": "How many planets in our solar systems have no moons?",
		"answer":2,
		"image":null,
		"hints":{
			"1":"1",
			"2":"2",
			"3": "0"
		}
	},
	#2
	{
		"question": "What happens to a star if it passes too close to a blackhole?",
		"answer":3,
		"image":null,
		"hints":{
			"1":"It will be sucked in",
			"2":"It will pushed away",
			"3":"It will be torn apart"
		}
	},	
	#3
	{
		"question": "Which one is the hottest planet in our solar system?",
		"answer":1,
		"image":null,
		"hints":{
			"1":"Venus",
			"2":"Saturn",
			"3":"Mars"
		}
	},
	#4
	{
		"question": "How old is our solar system?",
		"answer":2,
		"image":null,
		"hints":{
			"1":"4.37 billion years",
			"2":"4.57 billion years",
			"3":"4.38 billion years"
		}
	},	
	#5
	{
		"question": "Where is the Olympus Mons (highest mountain discovered) located ?",
		"answer":3,
		"image":null,
		"hints":{
			"1":"Jupiter",
			"2":"Venus",
			"3":"Mars"
		}
	},
	#6
	{
		"question": "What is the defenition of a light-year?",
		"answer":1,
		"image":null,
		"hints":{
			"1":"The distance covered by light in a single year",
			"2":"The average distance from the sun to the earth",
			"3":"The amount of time it takes light from the sun to reach Mars"
		}
	},	
	#7
	{
		"question": "How wide is the Milky Way galaxy?",
		"answer":2,
		"image":null,
		"hints":{
			"1":"1.63 billion squared Km wide",
			"2":"105,700 light-years wide",
			"3":"206,900 light-years wide"
		}
	},	
	#8
	{
		"question": "How much does the Sun weigh compared to Earth?",
		"answer":3,
		"image":null,
		"hints":{
			"1":"360,780 times more than Earth",
			"2":"20,000 times more than Earth",
			"3":"330,000 times more than Earth"
		}
	},	
	#9
	{
		"question": "What happend to the footprints left on the moon?",
		"answer":1,
		"image":null,
		"hints":{
			"1":"They still exist, because there's no wind",
			"2":"They disappeared",
			"3":"What footprints? We never landed on the moon"
		}
	},
	#10
	{
		"question": "How much would a person weigh on the moon?",
		"answer":2,
		"image":null,
		"hints":{
			"1":"37% more",
			"2":"38% less",
			"3":"36% less"
		}
	},	
	#11
	{
		"question": "How many moons are orbiting Jupiter?",
		"answer":3,
		"image":null,
		"hints":{
			"1":"1",
			"2":"56",
			"3":"79"
		}
	},	
	#12
	{
		"question": "How long is a day on Mars?",
		"answer":1,
		"image":null,
		"hints":{
			"1":"24 hours 39 minutes and 35 seconds long",
			"2":"22 hours 31 minutes and 57 seconds long",
			"3":"28 hours 52 minutes and 18 seconds long"
		}
	},	
	#13
	{
		"question": "Which of the planets in our solar system is not named after a God?",
		"answer":2,
		"image":null,
		"hints":{
			"1":"Neptune",
			"2":"Earth",
			"3":"Uranus"
		}
	},	
	#14
	{
		"question": "How big is Pluto?",
		"answer":3,
		"image":null,
		"hints":{
			"1":"Bigger than Earth",
			"2":"Bigger than Mars",
			"3":"Smaller than the USA"
		}
	},	
	#15
	{
		"question": "Which planet has the most volcanos in our solar system?",
		"answer":1,
		"image":null,
		"hints":{
			"1":"Venus",
			"2":"Mercury",
			"3":"Neptune"
		}
	},	
	#16
	{
		"question": "What causes Uranus's blue glow?",
		"answer":2,
		"image":null,
		"hints":{
			"1":"The light wavelength coming from the sun",
			"2":"The gases in it's atmosphere",
			"3":"The shiny blue stars that surround it"
		}
	},
	#17
	{
		"question": "Which are the 4 planets that are known as gas giants?",
		"answer":3,
		"image":null,
		"hints":{
			"1":"Earth, Mercury, Uranus & Neptune",
			"2":"Jupiter, Mars, Neptune & Saturn",
			"3":"Jupiter, Saturn, Uranus & Neptune"
		}
	},
	#18
	{
		"question": "How many moons does Uranus have?",
		"answer":1,
		"image":null,
		"hints":{
			"1":"27",
			"2":"33",
			"3":"46"
		}
	},	
	#19
	{
		"question": "How many stars are there in space?",
		"answer":2,
		"image":null,
		"hints":{
			"1":"Less than there are grains of sand in the world",
			"2":"More than there are grains of sand in the world",
			"3":"Approximately equal to the grains of sand in the world"
		}
	},	
	#20
	{
		"question": "How many years does Neptune take to make one orbit of the Sun?",
		"answer":3,
		"image":null,
		"hints":{
			"1":"128 Earth years",
			"2":"226 Earth years",
			"3":"165 Earth years"
		}
	},	
	#21
	{
		"question": "How many hours long is a day on Pluto?",
		"answer":1,
		"image":null,
		"hints":{
			"1":"153.6 hours long",
			"2":"53.8 hours long",
			"3":"196.8 hours long"
		}
	},	
	#22
	{
		"question": "Any free-moving liquid in outer space will form itself into what shape?",
		"answer":2,
		"image":null,
		"hints":{
			"1":"Square",
			"2":"Circle",
			"3":"Triangle"
		}
	},	
	#23
	{
		"question": "What is the name of the only British satellite to be launched using a britich rocket?",
		"answer":3,
		"image":null,
		"hints":{
			"1":"The Dark Arrow",
			"2":"The Black Sparrow",
			"3":"The Black Arrow"
		}
	},	
	#23
	{
		"question": "How much time does it take for the light to travel from the Sun to the Earth?",
		"answer":1,
		"image":null,
		"hints":{
			"1":"Less than 10 min",
			"2":"Less than 5 min",
			"3":"Less than 3 min"
		}
	},	
	#24
	{
		"question": "How many thunderstorms are happening on Earth at any given moment?",
		"answer":2,
		"image":null,
		"hints":{
			"1":"at least 10,000 thunderstorms",
			"2":"at least 2,000 thunderstorms",
			"3":"at most 1,000 thunderstorms"
		}
	},	
	#25
	{
		"question": "How is the Earth's rotation affected with time?",
		"answer":3,
		"image":null,
		"hints":{
			"1":"It's not affected",
			"2":"It's speeding",
			"3":"It's slowing"
		}
	},	
	#26	
	{
		"question": "How many miles away is Outer Space?",
		"answer":1,
		"image":null,
		"hints":{
			"1":"62 miles",
			"2":"69 miles",
			"3":"81 miles"
		}
	},	
	#27	
	{
		"question": "How many main types of galaxies are there?",
		"answer":2,
		"image":null,
		"hints":{
			"1":"8",
			"2":"3",
			"3":"6"
		}
	},	
	#28	
	{
		"question": "Using the naked eye, how many different galaxies can you see from earth?",
		"answer":3,
		"image":null,
		"hints":{
			"1":"Between 1 and 3",
			"2":"Between 8 and 12",
			"3":"Between 3 and 7"
		}
	},	
	#29	
	{
		"question": "In what year was the first Supernovae outside our galaxy observed?",
		"answer":1,
		"image":null,
		"hints":{
			"1":"1885",
			"2":"1956",
			"3":"1920"
		}
	},	
	#30	
	{
		"question": "On which planet does it snow metal and rains sulfuric acid?",
		"answer":2,
		"image":null,
		"hints":{
			"1":"Saturn",
			"2":"Venus",
			"3":"Neptune"
		}
	},	
	#31	
	{
		"question": "What was the first commercial soft drink to be consumed in Space?",
		"answer":3,
		"image":null,
		"hints":{
			"1":"Pepsi",
			"2":"La Croix",
			"3":"Coca-Cola"
		}
	},	
	#32	
	{
		"question": "How many centimeters could astronauts grow when in Space?",
		"answer":1,
		"image":null,
		"hints":{
			"1":"2 cm",
			"2":"5 cm",
			"3":"4 cm"
		}
	},	
	#33	
	{
		"question": "What was the first artificial satellite in space called?",
		"answer":2,
		"image":null,
		"hints":{
			"1":"Kepler",
			"2":"Sputnik",
			"3":"Apollo"
		}
	},	
	#34	
	{
		"question": "How many centimeters is the Moon moving away each year?",
		"answer":3,
		"image":null,
		"hints":{
			"1":"9 cm",
			"2":"5 cm",
			"3":"4 cm"
		}
	},	
	#35	
	{
		"question": "Pluto was named after whom?",
		"answer":1,
		"image":null,
		"hints":{
			"1":"The Roman god of the underworld",
			"2":"The Disney dog",
			"3":"The Norse god of thunder"
		}
	},	
	#37	
	{
		"question": "Which is the only planet that could float on water?",
		"answer":2,
		"image":null,
		"hints":{
			"1":"Earth",
			"2":"Saturn",
			"3":"Jupiter"
		}
	},	
	#38	
	{
		"question": "What was Uranus originally called?",
		"answer":3,
		"image":null,
		"hints":{
			"1":"Kramer's star",
			"2":"Jerry's star",
			"3":"George's star"
		}
	},	
	#39	
	{
		"question": "What color is the sunset on Mars?",
		"answer":1,
		"image":null,
		"hints":{
			"1":"Blue",
			"2":"Red",
			"3":"Orange"
		}
	},	
	#40	
	{
		"question": "How much mpre does the Earth weigh compared to the moon?",
		"answer":2,
		"image":null,
		"hints":{
			"1":"90 times more",
			"2":"81 times more",
			"3":"82 times more"
		}
	},	
	#41	
	{
		"question": "What was the first living mammal to go into Space?",
		"answer":3,
		"image":null,
		"hints":{
			"1":"A cat",
			"2":"A chimpanzee",
			"3":"A dog"
		}
	},	
	#42	
	{
		"question": "What does the word astronaut mean in its origins?",
		"answer":1,
		"image":null,
		"hints":{
			"1":"Star Sailor",
			"2":"Star Trek",
			"3":"Star Warrior"
		}
	},	
	#43	
	{
		"question": "How many days did the astronaut Gennady Padalka spend in Space?",
		"answer":2,
		"image":null,
		"hints":{
			"1":"798 days",
			"2":"879 days",
			"3":"978 days"
		}
	},	
	#44	
	{
		"question": "Which planet has no atmosphere?",
		"answer":3,
		"image":null,
		"hints":{
			"1":"Saturn",
			"2":"Earth",
			"3":"Mercury"
		}
	},	
	#45	
	{
		"question": "In which country is the Milky-Way known as the Silver River?",
		"answer":1,
		"image":null,
		"hints":{
			"1":"China",
			"2":"Russia",
			"3":"Germany"
		}
	},	
	#46	
	{
		"question": "What is happenning to Jupiter's red spot?",
		"answer":2,
		"image":null,
		"hints":{
			"1":"It's expanding",
			"2":"It's shriking",
			"3":"Nothing is happening to it"
		}
	},	
	#47	
	{
		"question": "How many days on Earth are the equivalent of one day on Mercury?",
		"answer":2,
		"image":null,
		"hints":{
			"1":"10 days",
			"2":"11 days",
			"3":"58 days"
		}
	},	
	#48	
	{
		"question": "How much time does it take for the light to travel from the Moon to Earth?",
		"answer":3,
		"image":null,
		"hints":{
			"1":"2 seconds",
			"2":"1.7 seconds",
			"3":"1.3 seconds"
		}
	},	
	#49	
	{
		"question": "How many recognized constellations are there in our night sky?",
		"answer":1,
		"image":null,
		"hints":{
			"1":"88",
			"2":"92",
			"3":"103"
		}
	},	
	#50	
	{
		"question": "In what year did the International Astronomical Union reclassified Pluto as a dwarf planet?",
		"answer":2,
		"image":null,
		"hints":{
			"1":"1988",
			"2":"2006",
			"3":"1994"
		}
	},
	
	
]
