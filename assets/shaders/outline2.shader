shader_type canvas_item;
render_mode unshaded;

uniform vec4 outline_color : hint_color;
//$sprite.material.set_shader_param("_outline", true)

void fragment() {
	COLOR = texture(TEXTURE, UV);
	
	vec4 left = texture(TEXTURE, UV + (vec2(-1.0, 0.0) * TEXTURE_PIXEL_SIZE));
	vec4 right = texture(TEXTURE, UV + (vec2(1.0, 0.0) * TEXTURE_PIXEL_SIZE));
	vec4 up = texture(TEXTURE, UV + (vec2(0.0, -1.0) * TEXTURE_PIXEL_SIZE));
	vec4 down = texture(TEXTURE, UV + (vec2(0.0, 1.0) * TEXTURE_PIXEL_SIZE));
	
	if(COLOR.a != 0.0) {
		COLOR = outline_color;
		if(left.a == 0.0) {
			left = outline_color;
			}
		if(right.a == 0.0) {
			right = outline_color;
			}
		if(up.a == 0.0) {
			up = outline_color;
			}
		if(down.a == 0.0) {
			down = outline_color;
			}
	}
}