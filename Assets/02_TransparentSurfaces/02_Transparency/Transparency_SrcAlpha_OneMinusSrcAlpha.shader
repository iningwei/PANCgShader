// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "My/Transparency/SrcAlpha_OneMinusSrcAlpha"
{ 
	 
    SubShader//Unity chooses the subshader that fits the GPU best, all passes of selected subshader will be executed
    {
		
		Tags{"Queue"="Transparent"}//Default is Geometry,detail:https://docs.unity3d.com/Manual/SL-SubShaderTags.html
	
        Pass//shader can have multiple passes
        {						
			ZWrite Off//don't write to depth buffer,in order not to occlude other objects
			Blend SrcAlpha OneMinusSrcAlpha
		
            CGPROGRAM//begins the part in Unity's cg
            #pragma vertex vert//specify the vert function as the vertex shader
            #pragma fragment frag//specify the frag function as the fragment shader

			
			//There are some predefined input_struct in UnityCG.cginc,such as appdata_base、appdata_tan、appdata_full、appdata_img
			struct vertexInput{
				float4 vertex:POSITION;//in object coordinates,i.e. local or model coordinates				 
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
			
            ENDCG//here ends the part in cg
        }
		
		 
    }
}
