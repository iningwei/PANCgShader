// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Pan/MaterialPropertyDrawer/TestToggle"
{
    Properties
    {
        [Toggle] _Invert ("Invert?", Float) = 0
		 
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile __ _INVERT_ON

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
                fixed4 col = fixed4(1, 0, 0, 0);
                #ifdef _INVERT_ON
                col = fixed4(0, 1, 0, 0);
                #endif
                return col;
            }
            ENDCG
        }
    }
}