varying vec2 v_vTexcoord;
varying vec4 v_vColour;
const float blurSize = 1.0/512.0;
uniform float intensity;

uniform float Time;
uniform vec2 Texel;

//Modify the following three consts to change the wave effect to your liking
const float xSpeed = 0.002;
const float xFreq = 7.50;
const float xSize = 0.5;

void main()
{
	vec4 sum = vec4(0);
	int j;
	int i;

	// take nine samples, with the distance blurSize between them
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x - 4.0*blurSize, v_vTexcoord.y)) * 0.05;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x - 3.0*blurSize, v_vTexcoord.y)) * 0.09;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x - 2.0*blurSize, v_vTexcoord.y)) * 0.12;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x - blurSize, v_vTexcoord.y)) * 0.15;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y)) * 0.16;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x + blurSize, v_vTexcoord.y)) * 0.15;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x + 2.0*blurSize, v_vTexcoord.y)) * 0.12;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x + 3.0*blurSize, v_vTexcoord.y)) * 0.09;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x + 4.0*blurSize, v_vTexcoord.y)) * 0.05;

	// take nine samples, with the distance blurSize between them
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - 4.0*blurSize)) * 0.05;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - 3.0*blurSize)) * 0.09;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - 2.0*blurSize)) * 0.12;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - blurSize)) * 0.15;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y)) * 0.16;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + blurSize)) * 0.15;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + 2.0*blurSize)) * 0.12;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + 3.0*blurSize)) * 0.09;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + 4.0*blurSize)) * 0.05;
   
	float xWave = sin(Time*xSpeed + v_vTexcoord.y*xFreq) * (xSize*Texel.x);
   
	vec4 sampled_color = sum * intensity + texture2D(gm_BaseTexture, v_vTexcoord+ vec2(xWave, 0.0));
	sampled_color.r = 0.0;
	sampled_color.b = 0.0;
	sampled_color.g = 1.0;

	//increase blur with intensity!
	gl_FragColor = sampled_color;
}