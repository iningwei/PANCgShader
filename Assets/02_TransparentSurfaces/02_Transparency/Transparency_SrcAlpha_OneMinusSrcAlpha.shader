// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'
//https://www.cnblogs.com/kane0526/p/9845765.html

Shader "My/Transparency/SrcAlpha_OneMinusSrcAlpha"
{ 
	 Properties{
	 	 _Color("Color",Color)=(1,1,1,1)
	 }
    SubShader
    {		
		Tags{"Queue"="Transparent"}
	
        Pass
        {						
			ZWrite Off
			Blend SrcAlpha OneMinusSrcAlpha
		
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
						
			fixed4 _Color;

			struct vertexInput{
				float4 vertex:POSITION;	 
			};

			struct vertexOutput{
				float4 pos:SV_POSITION;							
			    float4 posInObjSpace:TEXCOORD0;
			};

            vertexOutput vert (vertexInput input)
            {                			   
			   vertexOutput output;
			   output.pos=UnityObjectToClipPos(input.vertex);
			   output.posInObjSpace=input.vertex;			   
			   return output;
            }

            fixed4 frag (vertexOutput input) : COLOR
            {
				return float4(_Color.r,_Color.g,_Color.b,0.3);
            }			
            ENDCG
        }				 
    }
}
