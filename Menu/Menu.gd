extends TextureRect

@export_file("*.tscn") var game : String

# Called when the node enters the scene tree for the first time.
func _ready():
	ResourceLoader.load_threaded_request(game, "PackedScene")


func _on_button_pressed():
	SceneTransition.change_scene_to_file(game)


func _on_rich_text_label_meta_clicked(meta):
	OS.shell_open(meta)


func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(1, linear_to_db(value))


func _on_h_slider_2_value_changed(value):
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
	Sfx.click()

