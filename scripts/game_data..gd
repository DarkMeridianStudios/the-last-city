extends Node
# Autoload singleton — stores player character data between scenes
# Add this as Autoload in Project Settings with name "GameData"

var player_name = "Aldric"
var player_trait = "RUTHLESS"

func get_trait_modifier(stat: String) -> float:
	match player_trait:
		"RUTHLESS":
			if stat == "efficiency":
				return 1.2
			return 1.0
		"COMPASSIONATE":
			if stat == "population_loss":
				return 0.7
			return 1.0
		"CUNNING":
			if stat == "intrigue_options":
				return 1.5
			return 1.0
		_:
			return 1.0
