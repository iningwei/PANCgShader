// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "My/Transparency/SrcAlpha_DstColor"
{ 
	 
    SubShader
    {		
		Tags{"Queue"="Transparent"}
	
        Pass
        {						
			ZWrite Off
			Blend SrcAlpha DstColor
		
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
						
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
				return float4(0.0,1.0,0.0,0.3);
            }
			
            ENDCG
        }				 
    }
}
