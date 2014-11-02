using UnityEngine;
using System.Collections;

public class LearnUnity_Panents : MonoBehaviour {

    public GameObject Object1;
    public GameObject Object2;

    //Transform  是管理 父子关系的

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {

        if (Input.GetKeyDown(KeyCode.A))
        {
            Object1.GetComponent<Transform>().parent=null;
            Object2.GetComponent<Transform>().parent = Object1.GetComponent<Transform>();
        }

        if (Input.GetKeyDown(KeyCode.B))
        {
            Debug.Log("AAA");
            Object2.GetComponent<Transform>().parent = null;
            Object1.transform.parent = Object2.transform;
        }

        if (Input.GetKeyDown(KeyCode.C))
        {
            Object1.transform.parent = null;
            Object2.transform.parent = null;
        }
	}
}
