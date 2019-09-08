Shader "My/MinimalShader"
{ 
    SubShader//Unity会从所有的SubShader中选择一个最适合GPU的来进行运算
    {         
        Pass//每个SubShader可以拥有多个Pass
        {
            CGPROGRAM//标识符，指定从这里开始Unity的cg
            #pragma vertex vert//指定vertex shader的函数名称为vert
            #pragma fragment frag//指定fragment shader的函数为frag

            float4 vert (float4 vertexPos:POSITION):SV_POSITION
            {                
			    return UnityObjectToClipPos( vertexPos);		//老版本使用mul()函数，现在已经统一改成UnityObjectToClipPos()了
				//这里根据顶点的位置，通过语义SV_POSITION，返回值为一个可供frag函数使用的参数
            }

            fixed4 frag (void) : COLOR//void 值不使用任何参数
            {
               return float4(1.0,0.0,0.0,1.0);//通过语义COLOR指定返回的是颜色。这里会对所有可视区域设置不透明的红色
            }
            ENDCG//结束标志
        }
    }
}
