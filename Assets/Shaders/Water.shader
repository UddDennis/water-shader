Shader "Custom/Water"
{
    Properties {
        _MainTex ("Texture", 2D) = "white" {}
        _DistortionStrength ("Distortion Strength", Range(0, 100)) = 0.1
        _ClickPositionX ("Click Position X", Range(0, 1)) = 0.5
        _ClickPositionY ("Click Position Y", Range(0, 1)) = 0.5
        _Amount ("Extrusion Amount", Range(-1,1)) = 0.5
    }

    SubShader {
        Tags {"Queue"="Overlay" }
        LOD 100

        CGPROGRAM
        #pragma surface surf Lambert vertex:vert
        #pragma enable_d3d11_debug_symbols
        struct Input {
            float2 uv_MainTex;
        };

        fixed _DistortionStrength;
        float _ClickPositionX;
        float _ClickPositionY;

        float _Amount;
        void vert (inout appdata_full v) {
            v.vertex.xyz += v.normal * _Amount;
        }

        sampler2D _MainTex;
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
        }
        // void surf(Input IN, inout SurfaceOutput o) {
        //     // Sample reflection and refraction textures
        //     fixed4 refl = tex2D(_ReflectionTex, IN.uv_ReflectionTex);
        //     fixed4 refr = tex2D(_RefractionTex, IN.uv_RefractionTex);

        //     // Apply distortion based on UV coordinates
        //     float2 distortion = _DistortionStrength * (tex2D(_RefractionTex, IN.uv_RefractionTex * 1000).rg - 0.5);
        //     float displacement = tex2D(_RefractionTex, IN.uv_RefractionTex).r;

        //     IN.uv_RefractionTex += distortion;

        //     // Blend reflection and refraction based on alpha
        //     fixed4 finalColor = lerp(refl, refr, 0.5) + (0,0,230,0.4);
        //     float distanceToClick = distance(IN.uv_ReflectionTex, float2(_ClickPositionX, _ClickPositionY));
        //     float clickEffect =  smoothstep(0.01, 0.02, distanceToClick);

        //     // o.Normal.y += displacement *_DistortionStrength;
        //     o.Albedo += clickEffect*100;
        //     // Apply the final color to the output
        //     o.Albedo = finalColor.rgb * clickEffect * (0,0,1,1);
        //     o.Alpha = finalColor.a;
        //     o.Normal = finalColor.rgb ;
        // }

        ENDCG
    }
    FallBack "Diffuse"
}
