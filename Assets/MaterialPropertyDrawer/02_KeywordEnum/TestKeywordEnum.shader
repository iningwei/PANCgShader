// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Pan/MaterialPropertyDrawer/TestKeywordEnum" {
Properties
    {
        [KeywordEnum(None, Add, Multiply)] _Overlay ("Overlay mode", Float) = 0
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile _OVERLAY_NONE _OVERLAY_ADD _OVERLAY_MULTIPLY

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = fixed4(1, 1, 1, 1);
                #if _OVERLAY_NONE
                    col = fixed4(1, 0, 0, 1);
                #elif _OVERLAY_ADD
                    col = fixed4(0, 1, 0, 1);
                #elif _OVERLAY_MULTIPLY
                    col = fixed4(0, 0, 1, 1);
                #endif
                return col;
            }
            ENDCG
        }
    }
}