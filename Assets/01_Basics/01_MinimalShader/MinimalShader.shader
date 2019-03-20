Shader "My/MinimalShader"
{ 
    SubShader//Unity chooses the subshader that fits the GPU best
    {         
        Pass//shader can have multiple passes
        {
            CGPROGRAM//begins the part in Unity's cg
            #pragma vertex vert//specify the vert function as the vertex shader
            #pragma fragment frag//specify the frag function as the fragment shader

            float4 vert (float4 vertexPos:POSITION):SV_POSITION
            {
               //return UnityObjectToClipPos(vertexPos);//older func is mul(),now is UnityObjectToClipPos()
			   return UnityObjectToClipPos(float4(1.0,0.1,1.0,1.0)*vertexPos);
            }

            fixed4 frag (void) : COLOR//void mean no need param
            {
               return float4(1.0,0.0,0.0,1.0);
            }
            ENDCG//here ends the part in cg
        }
    }
}
