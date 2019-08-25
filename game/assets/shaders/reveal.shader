shader_type canvas_item;

//varying vec3 reveal_color;


bool close_enough(vec3 rgb, vec3 color, float tollerance) {
	float rdiff = abs(rgb.r - color.r);
	float gdiff = abs(rgb.g - color.g);
	float bdiff = abs(rgb.b - color.b);
	return rdiff <= tollerance && gdiff <= tollerance && bdiff <= tollerance;
}

vec3 get_reveal_color() {
	/*if(reveal_color != vec3(1.0,1.0,1.0)) {
		return reveal_color;
	}*/
	//original gold/yellow color
	//return vec3(1.0, 0.843, 0.0);
	//'pink'
	return vec3(0.8235, 0.5098, 0.5098);
}

void fragment() {
	//COLOR = vec4(reveal_color, 1.0);
	vec4 c = texture(TEXTURE, UV);
	//vec4 sc = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0);
	vec4 sc = texture(SCREEN_TEXTURE, SCREEN_UV);
	if(c.a > .0 && close_enough(sc.rgb, get_reveal_color(), .1)) {// sc.rgb == reveal_color) {
		COLOR = c;
	} else {
		COLOR = sc;
	}
}