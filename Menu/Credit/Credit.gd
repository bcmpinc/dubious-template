@tool
extends TextureButton

@export var author_image: Texture2D:
	set(new):
		author_image = new
		if $AuthorImage:
			$AuthorImage.texture = new
@export var author_name: String:
	set(new):
		author_name = new
		if $AuthorName:
			$AuthorName.text = new
@export_color_no_alpha var background_color: Color:
	set(new):
		background_color = new
		if $Background:
			$Background.color = new
@export var link: String

func _ready():
	$AuthorImage.texture = author_image
	$AuthorName.text = author_name
	$Background.color = background_color
	self.pressed.connect(func():
		Global.click()
		OS.shell_open(link)
	)
