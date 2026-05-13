uniform float u_Time;
uniform vec2 u_Resolution;
varying vec2 v_TexCoord;
uniform sampler2D u_Tex0;

void main() {
    vec2 uv = v_TexCoord;
    float time = u_Time * 0.5;
    
    // Simulação de gotas caindo
    float rain = fract(sin(uv.x * 50.0 + time * 0.1) * 43758.5453 + uv.y);
    vec4 texColor = texture2D(u_Tex0, uv);
    
    // Aplica um leve distúrbio na textura para parecer chuva
    if (rain < 0.05) {
        texColor += vec4(0.1, 0.1, 0.1, 0.0);
    }

    gl_FragColor = texColor;
}