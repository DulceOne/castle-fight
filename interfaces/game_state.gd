extends Node

class_name GameState;
var selected_build = null;
var selected_build_mesh = null;
var currency = 0;
var chees = 0;
var castle_hp = 100;
var buildings: Array[Building] = [];
var raycast_intersect: Dictionary;
var income_cooldown: int;
var income: int;
