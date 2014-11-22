using UnityEngine;
using System.Collections;

public class LearnUnity_Resources : MonoBehaviour {

	// Use this for initialization
	void Start () {

        string path ="file://"+ Application.dataPath + "/StreamingAssets/";
        StartCoroutine(LoadMainGameObject(path + "myWebMode.unity3d"));
	}
	
	// Update is called once per frame
	void Update () {
	
	}

    private IEnumerator LoadMainGameObject(string path)
    {
        WWW bundle = new WWW(path);

        yield return bundle;

        //加载到游戏中
        yield return Instantiate(bundle.assetBundle.mainAsset);

        bundle.assetBundle.Unload(false);
    }
}
