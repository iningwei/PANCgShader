﻿Shader "My/RGBCube"
{ 
    SubShader//Unity chooses the subshader that fits the GPU best
    {         
        Pass//shader can have multiple passes
        {
            CGPROGRAM//begins the part in Unity's cg
            #pragma vertex vert//specify the vert function as the vertex shader
            #pragma fragment frag//specify the frag function as the fragment shader

			struct vertexOutput{
				float4 pos:SV_POSITION;
				
				//TEXCOORD0,TEXCOORD1,TEXCOORD2,etc,can be used for all kinds of parameters
				//nointerpolation can make sure fragment shader receives one exact,non-interpolated value by vertex shader
				//nointerpolation  float4 col:TEXCOORD0;
			    float4 col:TEXCOORD0;
			};


            vertexOutput vert (float4 vertexPos:POSITION)
            {                			   
			   vertexOutput output;
			   output.pos=UnityObjectToClipPos(vertexPos);
			   output.col=vertexPos+float4(0.5,0.5,0.5,0);
			   //for the coordinates of the cube are between -0.5 and 0.5,
			   //by plus 0.5,the result is between 0 and 1
			   return output;
            }

            fixed4 frag (vertexOutput input) : COLOR
            {
               return input.col;
            }
            ENDCG//here ends the part in cg
        }
    }
}
