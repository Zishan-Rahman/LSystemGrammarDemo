extends Node

# Basic: https://youtu.be/feNVBEPXAcE?t=77 (L = +)
# Choices: http://paulbourke.net/fractals/lsys/
# Deterministic: https://www1.biologie.uni-hamburg.de/b-online/e28_3/lsys.html#D0L-system

@export_enum("basic", "choices", "deterministic") var choices: String = "choices"
@export var axiom: String
@onready var string: String
@onready var timer = $Timer
@onready var line = $Line2D
@onready var label = $TextLabel
@onready var rules: Array[Dictionary]

func set_values():
	if choices == "basic":
		rules = [
			{
				"from": "F",
				"to": "F+F"
			}
		]
		axiom = "F+"
	elif choices == "choices":
		rules = [
			{
				"from": "F",
				"to": "F+F−F−FF+F+F−F"
			}
		]
		axiom = "F+F+F+F"
	elif choices == "deterministic":
		rules = [
			{
				"from": "a",
				"to": "ab"
			},
			{
				"from": "b",
				"to": "a"
			}
		]
		axiom = "b"

func _ready():
	set_values()
	string = axiom
	label.size.x = get_viewport().size.x
	label.text = string
	timer.start()

func get_new_replacement(character: String) -> String:
	for rule in rules:
		if rule["from"] == character:
			return rule["to"]
	return ""

func _on_Timer_timeout():
	var new_string = ""
	for character in string:
		new_string += get_new_replacement(character)
	string = new_string
	label.text = string
	print(len(string))
