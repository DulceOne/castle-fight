extends Node;

static func instantiate_mesh(model: String):
	var mesh = load(model);
	if mesh and mesh is Mesh:
		var mesh_instance = MeshInstance3D.new();
		mesh_instance.mesh = mesh;
		return mesh_instance;

static func get_scaled_size(mesh: MeshInstance3D):
	var size = mesh.get_aabb().size;
	var scale = mesh.global_transform.basis.get_scale();
	return size * scale;
