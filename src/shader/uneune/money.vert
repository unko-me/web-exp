varying vec2 vUv;
uniform sampler2D texture;
uniform float angle;
uniform float amp;
uniform float freq;
// three.js経由でもらった値

void main() {
    //PIは定義されていないようなので自分で定義する
    const float PI = 3.14159265359;

    float ratio = (1.0 - position.x / 512.0) * PI * freq;


    vec3 newPos = position;
    newPos.z = cos(angle + ratio) * amp + position.x;


    // 頂点位置の出力
    gl_Position = projectionMatrix * modelViewMatrix * vec4(newPos, 1.0);
    // 頂点のUV座標をフラグメントシェーダ―に送る
//    vUv = vec2(u, v);
    vUv = uv;

}