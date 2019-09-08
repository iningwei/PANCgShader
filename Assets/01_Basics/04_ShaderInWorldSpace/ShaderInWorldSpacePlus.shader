Shader "My/ShaderInWorldSpacePlus"
{ 
	Properties{
		_Point("a point in world space",Vector)=(0.,0.,0.,1.0)
		_DistanceNear("threshold distance",Float)=5.0
		_ColorNear("color near to point",Color)=(0.0,1.0,0.0,1.0)
		_ColorFar("color far to point",Color)=(0.4,0.1,0.1,1.0)
	}
    SubShader
    {         
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
						
			//uniforms corresponding to properties
			uniform float4 _Point;
			uniform float _DistanceNear;
			uniform float4 _ColorNear;
			uniform float4 _ColorFar;
									 
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
				float dis=distance(input.posWorldSpace,_Point);
			
				if(dis<_DistanceNear)
				{
					return _ColorNear;
				}
				else
				{
					return _ColorFar;
			
				}			             
            }
            ENDCG
        }
    }
}
