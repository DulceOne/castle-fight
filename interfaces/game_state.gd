extends Node

class_name GameState;
var selected_build = null;
var selected_build_mesh = null;
var currency = 0;
var chees = 0;
var castle_hp = 100;
var barraks: Array[Barrak] = [];
var raycast_intersect: Dictionary;
