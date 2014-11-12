using UnityEngine;
using System.Collections;

public class LearnUnity_Shader : MonoBehaviour {

    public GameObject ShaderObject;

    private Material _shaderMaterial;
	// Use this for initialization
	void Start () {
        if (null == ShaderObject)
        {
            Debug.LogError("Null ShaderObject");
        }
        else
        {
            _shaderMaterial = ShaderObject.renderer.material;
        }
	}

    private float _blendValue = 0;
    private float _currClickTime = 0;
	// Update is called once per frame
	void Update () {

        if (Input.GetMouseButtonDown(0)||Input.GetMouseButtonDown(1)) 
        {
            _currClickTime = Time.time;
        }
        if (Input.GetMouseButton(0))
        {
            _blendValue = Mathf.Lerp(0, 1, Time.time - _currClickTime);
            Debug.Log(_blendValue);
            _shaderMaterial.SetFloat("_Blend", _blendValue);
            //执行切换 0 -1 
        }
        else if (Input.GetMouseButton(1))
        {
            _blendValue = Mathf.Lerp(1, 0, Time.time - _currClickTime);
            Debug.Log(_blendValue);
            _shaderMaterial.SetFloat("_Blend", _blendValue);
            //执行切换 1 -0
        }
	}
}
