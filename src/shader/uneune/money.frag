varying vec2 vUv;
uniform sampler2D texture;
uniform float angle;

void main() {
//    vec4 textureColor = texture2D(texture, gl_FragCoord.xy);
     gl_FragColor = texture2D(texture, vUv);

}