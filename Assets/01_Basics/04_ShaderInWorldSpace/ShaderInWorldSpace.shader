// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "My/ShaderInWorldSpace"
{ 
    SubShader
    {         
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
									
			struct vertexInput{
				float4 vertex:POSITION;
			};


			struct vertexOutput{
				float4 pos:SV_POSITION;							
			    float4 posWorldSpace:TEXCOORD0;
			};


            vertexOutput vert (vertexInput input)
            {                			   
			   vertexOutput output;
			   output.pos=UnityObjectToClipPos(input.vertex);
			   output.posWorldSpace=mul(unity_ObjectToWorld,input.vertex);
			   
			   return output;
            }

            fixed4 frag (vertexOutput input) : COLOR
            {
				//computes the distance between the fragment positiion and the origin.
				//note:the 4th coordinate should always be 1 for points
				float dis=distance(input.posWorldSpace,float4(0.0,0.0,0.0,1.0));
			
				if(dis<5.0)
				{
					return float4(0.0,1.0,0.0,1.0);//color near origin
				}
				else
				{
					return float4(0.4,0.1,0.1,1.0);//color far from origin			
				}			             
            }
            ENDCG
        }
    }
}
