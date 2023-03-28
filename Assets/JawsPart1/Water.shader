Shader "Alexander/Water"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Tint("Colour Tint", Color) = (1,1,1,1)
        _Freq("Frequency", Range(0,5)) = 3
        _Speed("Speed", Range(0,100)) = 10
        _Amp("Amplitude",Range(0,5)) = 5
        _RampTex("Ramp Texture", 2D) = "white"{}
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf ToonRamp vertex:vert

        sampler2D _MainTex;
        sampler2D _RampTex;

        float4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten)
        {
            float diff = dot(s.Normal, lightDir);
            float h = diff * 0.5 + 0.5;
            float2 rh = h;
            float3 ramp = tex2D(_RampTex, rh).rgb;

            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
            c.a = s.Alpha;
            return c;
        }

        struct Input
        {
            float2 uv_MainTex;
            float3 vertColor;
        };
        float4 _Tint;
        float _Freq;
        float _Speed;
        float _Amp;

        struct appdata {
            float4 vertex: POSITION;
            float3 normal : NORMAL;
            float4 texcoord: TEXCOORD0;
            float4 texcoord1: TEXCOORD1;
            float4 texcoord2: TEXCOORD2;
        };
        
        void vert(inout appdata v, out Input o) {
            UNITY_INITIALIZE_OUTPUT(Input, o);
            float t = _Time * _Speed;
            float waveHeight = sin(t + v.vertex.x * _Freq) * _Amp +
                sin(t * 2 + v.vertex.x * _Freq * 2) * _Amp;
            if (waveHeight > .1)
            {
                waveHeight = _Amp;
            }
            else {
                waveHeight = -1;
            }

            v.vertex.y = v.vertex.y + waveHeight;
            v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));
            o.vertColor = waveHeight + 2;
        }

        void surf(Input IN, inout SurfaceOutput o) {
            float4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c * IN.vertColor.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
