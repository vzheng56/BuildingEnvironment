using UnityEngine;
using System.Collections;

public class TestAnimations : MonoBehaviour {

    private Animator currentAnimator;
	// Use this for initialization
	void Start () {
        currentAnimator = GetComponent<Animator>();
        if (currentAnimator == null)
            Debug.LogError("Null Ani");
	}
	
	// Update is called once per frame
	void Update () {

        if (currentAnimator != null)
        {
            currentAnimator.SetFloat("dir", Input.GetAxis("Vertical"));
            currentAnimator.SetFloat("speed", Input.GetAxis("Horizontal"));
            
        }

        if (Input.GetKeyDown(KeyCode.I))
        {
            currentAnimator.SetInteger("ActionID", 0);
        }
	}
}
