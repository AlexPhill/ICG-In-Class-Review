Shader "Alexander/OutlineShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _OutlineColor("Outline Color", Color) = (0,0,0,1)
        _Outline ("Outline Width", Range(.002,0.1)) = .005
        _myBump("Bump Texture", 2D) = "bump" {}
        _mySlider("Bump Amount", Range(0,10)) = 1
        _RampTex("Ramp Texture", 2D) = "white"{}
    }

    SubShader 
    {
        //Tags { "RenderType"="Opaque" }
        ZWrite off

        CGPROGRAM //FIRST PASS
        #pragma surface surf Lambert vertex:vert //accessing vertex shader
        struct Input
        {
            float2 uv_MainTex;
        };
        float _Outline;
        float4 _OutlineColor;

        void vert(inout appdata_full v) {
            v.vertex.xyz += v.normal * _Outline; //vertex extrusion method
        }
        sampler2D _MainTex;
        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Emission = _OutlineColor.rgb; //recieving colour of outline
        }
        ENDCG

            ZWrite on //turning on zbuffer before model is drawn, so its texture on top of outline

        CGPROGRAM //SECOND PASS
            #pragma surface surf ToonRamp //creating basic toonramp shader
            sampler2D _MainTex;
            sampler2D _myBump;
            half _mySlider;
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
            float2 uv_myBump;
            };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));
            o.Normal *= float3(_mySlider, _mySlider, 1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
