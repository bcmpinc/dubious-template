# Scene transition helper
# Based on https://www.youtube.com/watch?v=yZQStB6nHuI
# Add it to Autoload to use it.

extends CanvasLayer

@onready var ap : AnimationPlayer = $AnimationPlayer
@onready var rect : ColorRect = $DissolveRect

# Do `await SceneTransition.animation` to wait for the animation to finish.
var animation: Signal:
	get: return ap.animation_finished

var color: Color:
	get: return rect.color
	set(value): rect.color = value
	
var _target : String

func _fade_out(): ap.play("dissolve")
func _fade_in():  ap.play_backwards("dissolve")

# Switch to the given scene. Starts loading the scene in the background while the fade-out plays.
func change_scene_to_file(target: String) -> void:
	# Background load the target scene
	ResourceLoader.load_threaded_request(target, "PackedScene")
	_target = target
	_fade_out()
	await animation
	var status = ResourceLoader.load_threaded_get_status(_target)
	if status != ResourceLoader.THREAD_LOAD_LOADED:
		ap.play("Loading")
	
# Fade out and close the game.
func quit() -> void:
	_fade_out()
	await animation
	get_tree().quit()

func _process(_delta):
	if _target.is_empty(): return
	var status = ResourceLoader.load_threaded_get_status(_target)
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		print("Switching to ", _target)
		var scene : PackedScene = ResourceLoader.load_threaded_get(_target)
		_target = ""

		if ap.current_animation == "dissolve" and ap.is_playing():
			await animation

		get_tree().change_scene_to_packed(scene)
		_fade_in.call_deferred()
