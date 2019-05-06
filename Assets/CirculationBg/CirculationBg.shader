//图片的WrapMode需要设置为Repeat
Shader "My/CirculationBg"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_ScrollXSpeed("X Scroll Speed",Range(0,10))=2
		_ScrollYSpeed("Y Scroll Speed",Range(0,10))=0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

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
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
			fixed _ScrollXSpeed;
			fixed _ScrollYSpeed;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);               
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {                
				fixed2 uv=i.uv;
				 
				fixed xNew=_ScrollXSpeed*_Time;
				fixed yNew=_ScrollYSpeed*_Time;
				uv+=fixed2(xNew,yNew);
				
                fixed4 col = tex2D(_MainTex, uv);               
                return col;
            }
            ENDCG
        }
    }
}
