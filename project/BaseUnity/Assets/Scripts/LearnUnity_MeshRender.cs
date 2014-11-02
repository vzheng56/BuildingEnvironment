using UnityEngine;
using System.Collections;

public class LearnUnity_MeshRender : MonoBehaviour {

    public MeshRenderer CurrenMeshRender;

	// Use this for initialization
	void Start () {
	
	}

    bool hourseEnable = true;
	// Update is called once per frame
	void Update () {

        if (Input.GetKeyDown(KeyCode.E))
        {
            hourseEnable = !hourseEnable;
            CurrenMeshRender.enabled = hourseEnable;
        }
	
	}
}
