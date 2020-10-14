using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

//[ExecuteInEditMode]
public class TestCommandBuffer : MonoBehaviour
{
    public Shader s;

    void Start()
    {
        CommandBuffer cb = new CommandBuffer();
        cb.DrawRenderer(GetComponent<Renderer>(), new Material(s));

        //不透明物体渲染完后执行
        Camera.main.AddCommandBuffer(CameraEvent.AfterForwardOpaque, cb);
    }

 
}
