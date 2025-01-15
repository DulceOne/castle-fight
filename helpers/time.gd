extends Node;

static func time_to_ms(time: Dictionary):
	return (time.hour * 3600 + time.minute * 60 + time.second) * 1000;
