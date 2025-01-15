extends Node;

static func instantiate_mesh(model: String):
	var mesh = load(model);
	if mesh and mesh is Mesh:
		var mesh_instance = MeshInstance3D.new();
		mesh_instance.mesh = mesh;
		return mesh_instance;
