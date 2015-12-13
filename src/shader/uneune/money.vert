varying vec2 vUv;

// three.js経由でもらった値

void main() {
    //PIは定義されていないようなので自分で定義する
    const float PI = 3.14159265359;
    float waveNum = 0.5;

    // 頂点位置の出力
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
    // 頂点のUV座標をフラグメントシェーダ―に送る
//    vUv = vec2(u, v);
    vUv = uv;

}