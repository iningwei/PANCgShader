Shader "My/Transparency/AdditiveBlending"
{
    
    SubShader
    {
        Tags { "Queue"="Transparent" }
        
        Pass
        {
            Cull Off
            ZWrite Off
            Blend SrcAlpha One
            //Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag             
            
            float4 vert (float4 vertexPos : POSITION) : SV_POSITION 
            {
                return UnityObjectToClipPos(vertexPos);
            }

            fixed4 frag (void) : SV_Target
            {
                 return float4(0.0, 1.0, 0.0, 0.2); 
            }
            ENDCG
        }
    }
}
