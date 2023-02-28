extends Spatial

export var spawn_object = preload("res://Coin.tscn")
export var spawn_number = 1000
var random = RandomNumberGenerator.new()

func _ready():
	spawn()

func getRandomPosition(size) -> Vector3:
	random.randomize()
	var x = random.randf_range(-abs(size/2), abs(size/2))
	var z = random.randf_range(-abs(size/2), abs(size/2))
	var y = random.randf_range(0, 100)
	return Vector3(x,y,z)

func spawn():
	for i in spawn_number:
		var obj = spawn_object.instance()
		obj.translation = getRandomPosition(50)
		add_child(obj)
