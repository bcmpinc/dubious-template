shader_type canvas_item;

void fragment() {
	vec2 pos = 2.0 * UV - 1.0;
	if (dot(pos,pos) > 1.0) {
		discard;
	}
}

