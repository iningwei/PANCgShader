﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "My/ShaderInWorldSpace"
{ 
    SubShader//Unity chooses the subshader that fits the GPU best
    {         
        Pass//shader can have multiple passes
        {
            CGPROGRAM//begins the part in Unity's cg
            #pragma vertex vert//specify the vert function as the vertex shader
            #pragma fragment frag//specify the frag function as the fragment shader
			
			
			//There are some predefined input_struct in UnityCG.cginc,such as appdata_base、appdata_tan、appdata_full、appdata_img
			struct vertexInput{
				float4 vertex:POSITION;//in object coordinates,i.e. local or model coordinates				 
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
            ENDCG//here ends the part in cg
        }
    }
}
