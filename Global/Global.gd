extends Node

var RNG : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	RNG.randomize()

