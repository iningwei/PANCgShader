Shader "Unlit/BlurImg2"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags {  "Queue"="Transparent"
        "RenderType"="Transparent" 
        }
        LOD 100
        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;  
                float4 vertex : SV_POSITION;
                float3 worldPos:TEXCOORD1;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
               o.worldPos=mul((float4x4)unity_ObjectToWorld,v.vertex).xyz;

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
              //fixed4 col = tex2D(_MainTex, i.uv);
 
              float2 x= float2(0.2,0.5);
              float2 y= float2(0.5,0.2);
              //fixed4 col = tex2Dgrad(_MainTex, i.uv，ddx(i.uv),ddy(i.uv));
              fixed4 col = tex2Dgrad(_MainTex,  i.uv,ddx(i.worldPos),ddy(i.worldPos)); 
              return col;
            }
            ENDCG
        }
    }
}
