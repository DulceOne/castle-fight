extends Node;

var state: GameState;
var resource = preload("res://resources/buildings.tres");

func _ready():
	state = GameState.new();
	for building in resource.buildings:
		if building: state.buildings.append(building);
	
