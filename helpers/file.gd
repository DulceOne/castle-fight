extends Object

static func load_json(path: String):
	var json = JSON.new();
	var file = FileAccess.open(path, FileAccess.READ);
	if not file:
		print("File not found:", path);
		return false;

	var content = file.get_as_text();
	file.close();
	return json.parse_string(content);
