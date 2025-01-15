extends Button

func make(size: int, icon: String):
	self.custom_minimum_size = Vector2(size, size)
	$Texture.texture = load(icon)
