//https://www.jianshu.com/p/71b269906eae
// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

Shader "My/BlurImg"
{
    Properties
    {
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_BlurSize("BlurSize",Range(0,10))=2
        _Color ("Tint", Color) = (1,1,1,1)

        _StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
        _StencilOp ("Stencil Operation", Float) = 0
        _StencilWriteMask ("Stencil Write Mask", Float) = 255
        _StencilReadMask ("Stencil Read Mask", Float) = 255

        _ColorMask ("Color Mask", Float) = 15

        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
    }

    SubShader
    {
        Tags
        {
            "Queue"="Transparent"
            "IgnoreProjector"="True"
            "RenderType"="Transparent"
            "PreviewType"="Plane"
            "CanUseSpriteAtlas"="True"
        }

        Stencil
        {
            Ref [_Stencil]
            Comp [_StencilComp]
            Pass [_StencilOp]
            ReadMask [_StencilReadMask]
            WriteMask [_StencilWriteMask]
        }

        Cull Off
        Lighting Off
        ZWrite Off
        ZTest [unity_GUIZTestMode]
        Blend SrcAlpha OneMinusSrcAlpha
        ColorMask [_ColorMask]

        Pass
        {
            Name "Default"
        CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 2.0

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            #pragma multi_compile __ UNITY_UI_CLIP_RECT
            #pragma multi_compile __ UNITY_UI_ALPHACLIP

            struct appdata_t
            {
                float4 vertex   : POSITION;
                float4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float4 vertex   : SV_POSITION;
                fixed4 color    : COLOR;
                float2 texcoord  : TEXCOORD0;
                float4 worldPosition : TEXCOORD1;
                UNITY_VERTEX_OUTPUT_STEREO
            };

            sampler2D _MainTex;
			float _BlurSize;			
            fixed4 _Color;
            fixed4 _TextureSampleAdd;
            float4 _ClipRect;
            float4 _MainTex_ST;

            v2f vert(appdata_t v)
            {
                v2f OUT;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
                OUT.worldPosition = v.vertex;
                OUT.vertex = UnityObjectToClipPos(OUT.worldPosition);

                OUT.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);

                OUT.color = v.color * _Color;
                return OUT;
            }

            fixed4 frag(v2f IN) : SV_Target
            {
                //half4 color = (tex2D(_MainTex, IN.texcoord) + _TextureSampleAdd) * IN.color;
				//注释上述默认ugui img用的代码，使用下述毛玻璃效果代码
				float depth=_BlurSize*0.0005;
				half4 sum=half4(0.0h,0.0h,0.0h,0.0h);
				sum+=tex2D(_MainTex,float2(IN.texcoord.x-5.0*depth,IN.texcoord.y+5.0*depth))*0.025;
				sum+=tex2D(_MainTex,float2(IN.texcoord.x+5.0*depth,IN.texcoord.y-5.0*depth))*0.025;
				sum+=tex2D(_MainTex,float2(IN.texcoord.x-4.0*depth,IN.texcoord.y+4.0*depth))*0.05;
				sum+=tex2D(_MainTex,float2(IN.texcoord.x+4.0*depth,IN.texcoord.y-4.0*depth))*0.05;
				sum+=tex2D(_MainTex,float2(IN.texcoord.x-3.0*depth,IN.texcoord.y+3.0*depth))*0.09;
				sum+=tex2D(_MainTex,float2(IN.texcoord.x+3.0*depth,IN.texcoord.y-3.0*depth))*0.09;
				sum+=tex2D(_MainTex,float2(IN.texcoord.x-2.0*depth,IN.texcoord.y+2.0*depth))*0.12;
				sum+=tex2D(_MainTex,float2(IN.texcoord.x+2.0*depth,IN.texcoord.y-2.0*depth))*0.12;
				sum+=tex2D(_MainTex,float2(IN.texcoord.x-1.0*depth,IN.texcoord.y+1.0*depth))*0.15;
				sum+=tex2D(_MainTex,float2(IN.texcoord.x+1.0*depth,IN.texcoord.y-1.0*depth))*0.15;
				
				sum+=tex2D(_MainTex,IN.texcoord-5.0*depth)*0.025;
				sum+=tex2D(_MainTex,IN.texcoord-4.0*depth)*0.05;
				sum+=tex2D(_MainTex,IN.texcoord-3.0*depth)*0.09;
				sum+=tex2D(_MainTex,IN.texcoord-2.0*depth)*0.12;
				sum+=tex2D(_MainTex,IN.texcoord-1.0*depth)*0.15;
				sum+=tex2D(_MainTex,IN.texcoord)*0.16;
				sum+=tex2D(_MainTex,IN.texcoord+5.0*depth)*0.15;
				sum+=tex2D(_MainTex,IN.texcoord+4.0*depth)*0.12;
				sum+=tex2D(_MainTex,IN.texcoord+3.0*depth)*0.09;
				sum+=tex2D(_MainTex,IN.texcoord+2.0*depth)*0.05;
				sum+=tex2D(_MainTex,IN.texcoord+1.0*depth)*0.025;
				sum=sum/2;
				half4 color=(sum+_TextureSampleAdd)*IN.color;
				
				
				
                #ifdef UNITY_UI_CLIP_RECT
                color.a *= UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);
                #endif

                #ifdef UNITY_UI_ALPHACLIP
                clip (color.a - 0.001);
                #endif

                return color;
            }
        ENDCG
        }
    }
}
