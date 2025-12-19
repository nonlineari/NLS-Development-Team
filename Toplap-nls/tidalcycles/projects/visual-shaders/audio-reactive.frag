/*{
  "audio": true,
  "pixelRatio": 1,
  "vertexCount": 0
}*/
#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 resolution;
uniform sampler2D audio; // VEDA audio texture

void main() {
  vec2 uv = gl_FragCoord.xy / resolution.xy;
  float a = texture2D(audio, vec2(uv.x, 0.0)).r;
  float bands = texture2D(audio, vec2(uv.x, 0.25)).r
             + texture2D(audio, vec2(uv.x, 0.50)).r
             + texture2D(audio, vec2(uv.x, 0.75)).r;
  float v = smoothstep(0.2, 0.9, a + 0.5 * bands);
  vec3 col = vec3(0.2 + 0.8*v, 0.3 + 0.6*v*sin(time*0.7), 0.5 + 0.5*v*cos(time*0.3));
  gl_FragColor = vec4(col, 1.0);
}
