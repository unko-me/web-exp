varying vec2 vUv;
uniform sampler2D texture;


void main() {
//    vec4 textureColor = texture2D(texture, gl_FragCoord.xy);
//    gl_FragColor = texture2D(tex, vUv);
//     gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
     gl_FragColor = texture2D(texture, vUv);

}