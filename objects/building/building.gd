extends BuildingBase;
const MeshHelper = preload("res://helpers/mesh.gd");
const TimeHelper = preload("res://helpers/time.gd");
var resource = load("res://resources/units.tres");

func _process(delta: float):
	_draw_cooldown();
	if unit_resource and spawn_position: spawn(unit_resource, spawn_position);

func make(build: BuildingResource, position: Vector3):
	var mesh_instance: MeshInstance3D = $MeshInstance3D;
	if !mesh_instance: return;
	current_build = build;
	var scale = build.build_model_scale;
	mesh_instance.set_mesh(MeshHelper.instantiate_mesh(build.model).mesh);
	mesh_instance.set_scale(Vector3(scale, scale, scale));
	self.add_child(mesh_instance);
	self.position = position;
	unit_resource = populate_unit(build.units[0]);
	spawn_position = get_spawn_position(mesh_instance, self.position);
	last_spawn_time = TimeHelper.time_to_ms(Time.get_time_dict_from_system());
	spawn(unit_resource, spawn_position);

func populate_unit(id: String):
	#TODO Performance loss here
	"""
	Resolution:
		- maping unit resource to key value data type
		- use embeded resources in the tres file
	"""
	var unit = null;
	if resource:
		for u in resource.units:
			if u.id == id: unit = u;
	return unit;

func spawn(unit: UnitResource, position: Vector3):
	if spawn_count >= 1: return;
	cooldown = unit.cooldown;
	var current_time = TimeHelper.time_to_ms(Time.get_time_dict_from_system());
	if ((last_spawn_time + (cooldown * 1000)) - current_time) > 0: return;

	var node: UnitInstance = preload("res://objects/unit/unit.tscn").instantiate();
	node.make(unit, position);
	self.get_parent().add_child(node);

	last_spawn_time = TimeHelper.time_to_ms(Time.get_time_dict_from_system());
	spawn_count += 1;

func get_spawn_position(build_mesh: MeshInstance3D, position: Vector3):
	build_mesh_size = MeshHelper.get_scaled_size(build_mesh);
	return Vector3(position.x + (build_mesh_size.x / 2) + 5, position.y, position.z);

func _draw_cooldown(): #Move cooldown to separate node like nameplate
	if !current_build: return;

	var current_time_in_ms = TimeHelper.time_to_ms(Time.get_time_dict_from_system());
	var coolwn_in_sec = (current_time_in_ms - last_spawn_time) / 1000;
	if !cooldown_instance:
		cooldown_instance = Label3D.new();
		cooldown_instance.modulate = Color(0.001, 0.188, 0.139);
		self.add_child(cooldown_instance);

	cooldown_instance.font_size = 14 * global_transform.origin.z;
	cooldown_instance.position = to_local(Vector3(self.position.x, build_mesh_size.y + 1, self.position.z))
	cooldown_instance.rotation = camera.global_transform.basis.get_euler();
	cooldown_instance.text = str(max(0, cooldown - coolwn_in_sec));
