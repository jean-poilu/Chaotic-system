//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 sampled_color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	sampled_color.a *= 0.5;
	
	gl_FragColor = sampled_color;
}
