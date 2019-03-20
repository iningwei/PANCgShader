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
				float4 tangent:TANGENT;//vector orthogonal to the surface normal
				float3 normal:NORMAL;//surface normal vector(in object coordinates,usually normalized to unit length)
				float4 texcoord0:TEXCOORD0;//0th set of texture coordinates(a.k.a. "UV", between 0 and 1)
				float4 texcoord1:TEXCOORD1;//1st set of tex. coors.
				float4 texcoord2:TEXCOORD2;//2nd set of tex. coors.
				float4 texcoord3:TEXCOORD3;//3rd set of tex. coors.
				fixed4 color:COLOR;//color(usually constant)
			};


			struct vertexOutput{
				float4 pos:SV_POSITION;							
			    float4 col:TEXCOORD0;
			};


            vertexOutput vert (vertexInput input)
            {                			   
			   vertexOutput output;
			   output.pos=UnityObjectToClipPos(input.vertex);
			   //output.col=input.texcoord0;
			    
				//other possibilities to play with:
				//output.col=input.vertex;
				//output.col=input.tangent;
				//output.col=float4(input.normal,1.0);
				output.col=float4((input.normal+float3(1.0,1.0,1.0))*0.5,1.0);//basicly normal value is between -1 and 1,here map the value to 0 and 1,which can fit color range
				//output.col=input.texcoord1;
				//output.col=input.color;
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
