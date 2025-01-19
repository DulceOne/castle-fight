extends StaticBody3D;

class_name BuildingBase
@onready var camera = $"../Camera3D";
var last_spawn_time: int; #TODO need use Timer
var cooldown = 10;
var unit_resource: UnitResource;
var spawn_position: Vector3;
var build_mesh_size: Vector3;
var unit_mesh_size: Vector3;
var cooldown_instance: Label3D = null;
var current_build = null;
var spawn_count = 0;
