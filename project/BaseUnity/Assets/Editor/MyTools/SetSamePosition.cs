using UnityEngine;
using UnityEditor;
using System.Collections;
// CopyComponents - by Michael L. Croswell for Colorado Game Coders, LLC
// March 2010

public class SetSamePosition : ScriptableWizard
{
    public GameObject toIndeyObject;
    public GameObject tagetObject;

    [MenuItem("MyTools/SetSamePosition")]

    static void CreateWizard()
    {
        ScriptableWizard.DisplayWizard("Set Same Position",typeof(SetSamePosition), "StartSet");
    }

    void OnWizardCreate()
    {
         toIndeyObject.transform.position= tagetObject.transform.position;
    string msg = "ok";
      EditorUtility.DisplayDialog("Game Object Facts", msg, "OK", "");
    }
}
