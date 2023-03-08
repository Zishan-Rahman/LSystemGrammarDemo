extends Node

# Basic: https://youtu.be/feNVBEPXAcE?t=77 (L = +)
# Choices: http://paulbourke.net/fractals/lsys/

@export_enum("basic", "choices", "deterministic") var choices: String
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

func _on_Timer_timeout():
	for rule in rules:
		string = string.replace(rule["from"], rule["to"])
	label.text = string
	print(len(string))
