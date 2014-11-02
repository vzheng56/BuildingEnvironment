using UnityEngine;
using System.Collections;

public class LearnUnity_GameObject : MonoBehaviour {

    public GameObject CurrentObject;
    private GameObject _findGameObject;
	// Use this for initialization
	void Start () {
        _findGameObject = GameObject.Find("ABC");
        Debug.Log(CurrentObject);
        LearnUnity_GameObject.FindMyObject("");
        this.FindMyObject("", true);
	}
	
	// Update is called once per frame
	void Update () {
	
	}

    GameObject FindMyObject(string objName,bool flag)
{
    return null;
}

   static GameObject FindMyObject(string objName)
    {
        if (GameObject.Find(objName) == null)
        {
            return null;
        }

        else
            return GameObject.Find(objName);
    }
}
