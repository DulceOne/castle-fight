extends UnitBase;

class_name UnitInstance;

const MeshHelper = preload("res://helpers/mesh.gd");

func _ready():
	$Area3D.body_entered.connect(_on_body_entered)

func _physics_process(delta: float):
	movement(delta);
	animate();
	update_target();

func make(unit: UnitResource, postion: Vector3):
	var mesh_instance: MeshInstance3D = $MeshInstance3D;
	if !mesh_instance: return;
	unit_model = unit.model.instantiate();
	unit_resource = unit;
	self.add_child(unit_model);
	make_attack_collision(unit.attack_range);
	self.position = postion;
	unit_status = UnitStatus.Run;

func movement(delta: float):
	if !unit_model: return;
	if unit_status != UnitStatus.Run: return;

	var direction = (enemy_castle.position - self.position).normalized();
	self.velocity = direction * 2;
	self.move_and_slide();
	self.look_at(enemy_castle.global_transform.origin, Vector3.UP);

func animate():
	if !unit_model: return;

	if unit_status == UnitStatus.Idle:
		unit_model.get_node("AnimationPlayer").play("Idle");

	if unit_status == UnitStatus.Run:
		unit_model.get_node("AnimationPlayer").play("Running_A");

	if unit_status == UnitStatus.Battle:
		unit_model.get_node("AnimationPlayer").play("1H_Melee_Attack_Chop");
	
func update_target():
	if !target: target = enemy_castle;

func _on_body_entered(body: Node):
	if body.is_in_group("Unit"):
		self.position.z -= 0.1;
		
	if body.is_in_group("Building"):
		unit_status = UnitStatus.Battle;
		
func make_attack_collision(range: float):
	var attack_range_collision = SphereShape3D.new();
	attack_range_collision.radius = range;
	$Area3D/CollisionShape3D.shape = attack_range_collision;
