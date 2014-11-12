using UnityEngine;
using System.Collections;

public class LearnUnity_Sound : MonoBehaviour {

    public AudioClip MyAudioClip;

    private AudioSource _currentAudioSouce;
	// Use this for initialization
	void Start () {
        // 两种方式
        _currentAudioSouce = GetComponent<AudioSource>();
       // GetComponent<AudioSource>().clip = MyAudioClip;
        _currentAudioSouce.clip = MyAudioClip;
        _currentAudioSouce.Play();
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
