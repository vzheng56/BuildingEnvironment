using UnityEngine;
using System.Collections;

public class Test : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
        Debug.Log(Input.GetAxis("MeKey"));
        if (1==Input.GetAxis("MeKey"))
        {
            Debug.Log("ASAS");
        }
	
	}
}
