extends TextureRect

@export_file("*.tscn") var game : String

# Called when the node enters the scene tree for the first time.
func _ready():
	ResourceLoader.load_threaded_request(game, "PackedScene")


func _on_button_pressed():
	SceneTransition.change_scene_to_file(game)


func _on_rich_text_label_meta_clicked(meta):
	OS.shell_open(meta)


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))
	Sfx.click()
