uniform sampler2D tDiffuse;
uniform float v;
uniform float r;
uniform float whole;
varying vec2 vUv;


void main() {
    const float PI = 3.14159265359;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
    vUv = uv;
}