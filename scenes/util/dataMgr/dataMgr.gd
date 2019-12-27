extends Node

# GAME SAVING / LOADING

func save_game():
	var save_dict = {
		
		}
	var save_game = File.new()
	var open_result = save_game.open("user://save.dat", File.WRITE)
	save_game.store_line(to_json(save_dict))
	save_game.close()
	
func load_game():
	print("loading")
	var save_game = File.new()
	if not save_game.file_exists("user://save.dat"):
		print("file didn't exist...?")
		return # Error! We don't have a save to load.
	var read_result = save_game.open("user://save.dat", File.READ)
	print("result of file open.WRITE is  " + String(read_result))
	var data = parse_json(save_game.get_line())
	# load all the shtuff
	#player_vars.weapon = data["player_weapon"]
	var scene_name = data["scene"]
	save_game.close()
	#transitionMgr.transitionTo(scene_name)
	#goto_scene(scene_name)