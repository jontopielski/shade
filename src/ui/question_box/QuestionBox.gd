extends CanvasLayer

signal finished
signal yes_responded
signal no_responded

const READ_RATE = 0.015

onready var textbox = get_node("TextBox")
onready var speaker = get_node("TextBox/Margin/HBox/HBox/VBox/Speaker")
onready var body = get_node("TextBox/Margin/HBox/HBox/VBox/VBox/Body")
onready var portrait = get_node("TextBox/Margin/HBox/Patch/Center/Portrait")
onready var portrait_container = get_node("TextBox/Margin/HBox/Patch")
onready var ticker = get_node("TextBox/Margin/HBox/HBox/Margin/Ticker")
onready var tween = get_node("Tween")
onready var options = get_node("TextBox/Margin/HBox/HBox/VBox/VBox/Options")
onready var selection_one_texture = get_node("TextBox/Margin/HBox/HBox/VBox/VBox/Options/OptionOne/SelectionContainer/SelectionOneTexture")
onready var selection_two_texture = get_node("TextBox/Margin/HBox/HBox/VBox/VBox/Options/OptionTwo/SelectionContainer/SelectionTwoTexture")

onready var fsm = FSM.new(self, $States, $States/Ready, true)

var initial_text = ""
var question_text = ""
var yes_response = ""
var no_response = ""
var option_selection = 0

func _ready():
	reset_textbox()

func _process(delta):
	fsm.run_machine(delta)

func set_question(_initial_text, _question_text, _yes_response, _no_response):
	initial_text = _initial_text
	question_text = _question_text
	yes_response = _yes_response
	no_response = _no_response

func set_speaker(_speaker):
	speaker.text = _speaker
	if speaker.text == "":
		speaker.hide()
	else:
		if !speaker.text.ends_with(":"):
			speaker.text += ":"
		speaker.show()

func set_portrait(_portrait):
	portrait.texture = _portrait
	if _portrait:
		portrait_container.show()
	else:
		portrait_container.hide()

func reset_textbox():
	textbox.hide()
	ticker.hide()
	options.hide()
	body.text = ""

func reset_question_box_state():
	initial_text = ""
	question_text = ""
	yes_response = ""
	no_response = ""
	option_selection = 0
