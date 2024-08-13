@tool
extends TextureButton

@export var author_image: Texture2D:
	set(new):
		author_image = new
		if $ClipMask/AuthorImage:
			$ClipMask/AuthorImage.texture = new
@export_color_no_alpha var background_color: Color:
	set(new):
		background_color = new
		if $ClipMask/Background:
			$ClipMask/Background.color = new
@export var author_name: String:
	set(new):
		author_name = new
		if $AuthorName:
			$AuthorName.text = new
@export var link: String

func _ready():
	$ClipMask/AuthorImage.texture = author_image
	$ClipMask/Background.color = background_color
	$AuthorName.text = author_name
	self.pressed.connect(func():
		Global.click()
		OS.shell_open(link)
	)
