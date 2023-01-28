extends Node

# https://youtu.be/feNVBEPXAcE?t=77

const F = "F"
const R = "R"
const L = "L" # may be used later

export (String) var axiom
onready var string: String

var rules = [
	{
		"from": F,
		"to": (F + R + F)
	}
]

func _ready():
	string = axiom
	print(axiom)
	$Timer.start()

func _on_Timer_timeout():
	for rule in rules:
		string = string.replace(rule["from"], rule["to"])
	print(string)
