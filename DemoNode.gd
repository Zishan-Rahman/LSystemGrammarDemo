extends Node

# Basic: https://youtu.be/feNVBEPXAcE?t=77 (L = +)
# Choices: http://paulbourke.net/fractals/lsys/
# Deterministic: https://www1.biologie.uni-hamburg.de/b-online/e28_3/lsys.html#D0L-system

## Allows you to decide which ruleset to use. See the script file for the sources of said rulesets.
@export_enum("basic", "choices", "deterministic") var choices: String = "choices"
var axiom: String
@onready var string: String
@onready var timer = $Timer
@onready var label = $TextLabel
@onready var rules: Array[Dictionary]

func set_values() -> void:
	match choices:
		"basic":
			rules = [
				{
					"from": "F",
					"to": "F+F"
				}
			]
			axiom = "F+"
		"choices":
			rules = [
				{
					"from": "F",
					"to": "F+F−F−FF+F+F−F"
				}
			]
			axiom = "F+F+F+F"
		"deterministic":
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

func _ready() -> void:
	set_values()
	string = axiom
	label.size.x = get_viewport().size.x
	label.text = string
	print(len(string))
	timer.start()

# Thanks to Alexander Gillberg (Codat) for inspiration
# https://youtu.be/eY9XkJERiG0
# Code adapted with his permission
func get_new_replacement(character: String) -> String:
	for rule in rules:
		if rule["from"] == character:
			return rule["to"]
	return ""

func _on_Timer_timeout() -> void:
	# Thanks to Alexander Gillberg (Codat) for inspiration
	# https://youtu.be/eY9XkJERiG0
	# Code adapted with his permission
	var new_string: String = ""
	for character in string:
		new_string += get_new_replacement(character)
	string = new_string
	label.text = string
	print(len(string))
