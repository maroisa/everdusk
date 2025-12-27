extends Node2D

onready var tilemap = $TileMap

# --- Generation Settings ---
export var level_width = 200
export var border_thickness = 10  # How many tiles wide the walls are
export var border_wall_height = 10 
export var base_height = 15
export var height_variance = 5
export var smoothness = 30.0

# --- Enemy Settings ---
export(Array, PackedScene) var enemy_scenes 
export var enemy_spawn_chance = 0.1 

var noise = OpenSimplexNoise.new()

func _ready():
	randomize()
	generate_level()

func generate_level():
	noise.seed = randi()
	noise.period = smoothness
	
	for x in range(level_width):
		# 1. Get noise height
		var noise_val = noise.get_noise_1d(x)
		var y_floor = int(base_height + (noise_val * height_variance))
		
		# 2. Add Thick Side Borders
		# Check if 'x' is within the thickness range at the start or end
		var is_left_border = x < border_thickness
		var is_right_border = x >= level_width - border_thickness
		
		if is_left_border or is_right_border:
			# Draw a wall from the floor up to the border height
			for y_wall in range(y_floor - border_wall_height, y_floor):
				tilemap.set_cell(x, y_wall, 0)
		
		# 3. Place Floor and Fill Ground
		tilemap.set_cell(x, y_floor, 0)
		for y_fill in range(y_floor + 1, base_height + height_variance + 10):
			tilemap.set_cell(x, y_fill, 0)
			
		# 4. Random Enemy Spawn
		# Ensure enemies don't spawn inside the thick walls
		var is_inside_playable_area = x >= border_thickness and x < level_width - border_thickness
		
		if is_inside_playable_area:
			if randf() < enemy_spawn_chance:
				spawn_random_enemy(x, y_floor)

	tilemap.update_bitmask_region()

func spawn_random_enemy(x, y):
	if enemy_scenes.size() > 0:
		var random_index = randi() % enemy_scenes.size()
		var selected_enemy_scene = enemy_scenes[random_index]
		
		if selected_enemy_scene:
			var enemy = selected_enemy_scene.instance()
			var pos = tilemap.map_to_world(Vector2(x, y))
			
			# Align to center and floor
			pos.x += tilemap.cell_size.x / 2
			enemy.position = pos
			add_child(enemy)
