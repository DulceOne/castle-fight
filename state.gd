extends Node;

var state: GameState;
var resource =  preload("res://resources/barraks.tres");

func _ready():
	state = GameState.new();
	for barrak in resource.barraks:
		if barrak: state.barraks.append(barrak);
