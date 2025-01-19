extends CharacterBody3D;

class_name UnitBase
const UnitStatus = preload("res://constants/unit.gd").UnitStatus;
@onready var enemy_castle = $"../EnemyCastle";
var unit_status = UnitStatus.Idle;
var unit_model = null;
var unit_resource: UnitResource;
var target: Node;
