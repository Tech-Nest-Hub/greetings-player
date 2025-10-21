extends Node2D

var step = 0

func _ready():
	show_dialogue("Hello, Player! Welcome to this world.", ["Hi!", "Who are you?"])

func show_dialogue(text: String, choices: Array):
	$DialogueLabel.text = text
	$ChoiceButton1.text = choices[0]
	$ChoiceButton2.text = choices[1]
	$ChoiceButton1.show()
	$ChoiceButton2.show()

func _on_button_pressed():
	handle_choice(1)  # First choice

func _on_choice_button_2_pressed():
	handle_choice(2)  # Second choice

func handle_choice(choice: int):
	step += 1
	match step:
		1:
			if choice == 1:
				show_dialogue("Glad to meet you!", ["You too!", "What is this place?"])
			else:
				show_dialogue("I am just text on a screen, but I can talk to you.", ["Interesting", "Weird"])
		2:
			if choice == 1:
				show_dialogue("I’m happy we’re talking!", ["Me too!", "Okay..."])
			else:
				show_dialogue("It’s a digital world, but I feel alive here.", ["Wow", "That’s strange"])
		3:
			if choice == 1:
				show_dialogue("This is the end of our little chat. See you next time!", ["Bye", "Restart"])
			else:
				show_dialogue("I hope we meet again in this little world.", ["Bye", "Restart"])
		4:
			if choice == 2:
				step = 0
				show_dialogue("Hello, Player! Welcome to this world.", ["Hi!", "Who are you?"])
			else:
				$ChoiceButton1.hide()
				$ChoiceButton2.hide()
				$DialogueLabel.text += "\n\n[Game Over]"
