using UnityEngine;
using UnityEditor;
using System.Collections;
// CopyComponents - by Michael L. Croswell for Colorado Game Coders, LLC
// March 2010

public class CopyComponents : ScriptableWizard
{
    public bool copyValues = true;
    public GameObject fromObject;
    public GameObject toObject;

    [MenuItem("MyTools/Copy Components")]


    static void CreateWizard()
    {
        ScriptableWizard.DisplayWizard("Copy Components", typeof(CopyComponents), "Copy");
    }

    void OnWizardCreate()
    {
        //foreach (GameObject go in fromObject.GetFiltered(typeof(GameObject), SelectionMode.TopLevel))
        Component[] fromComps = fromObject.GetComponents(typeof(Component));
        Component[] toComps = toObject.GetComponents(typeof(Component));
        string msg = "";
        msg += "FromObject total components count is " + fromComps.Length;
        msg += "\nToObject total components count is " + toComps.Length;
        /// Blows up Unity iPhone: EditorUtility.CopySerialized(fromObject, toObject); // Source to Destination 
        /// return;
        int i = 0;
        for (i = 0; i < fromComps.Length; i++)
        {
            string t1 = fromComps[i].GetType().Name;
            string t2 = "";
            msg += "\n#" + i + " is type " + t1;
            if (i < toComps.Length)
                t2 = toComps[i].GetType().Name;
            if (t2 != t1)
            {
                //if (copyValues)
                //  toObject.AddComponent(EditorUtility.CloneComponent(fromComps[i]));
                //else
                toObject.AddComponent(fromComps[i].GetType());
                toComps = toObject.GetComponents(typeof(Component));
                if (i < toComps.Length)
                {
                    Debug.Log("toComps.Length is " + toComps.Length + " i is " + i);
                    // Not good at all: EditorUtility.CopySerialized(fromComps[i], toComps[i]); // Source to Destination      
                    toComps[i] = fromComps[i];  // Does nothing apparently. 
                    // This doesn't work it just duplicates inside fromObject: EditorUtility.CloneComponent(fromComps[i]);
                    msg += "\t Add To: Increasing toObject component count to " + toComps.Length;
                }
                else
                {
                    msg += "\t Problem: i is " + i + " but toComps is only " + toComps.Length;
                }
            }
            else
            {
                if (copyValues)
                {
                    // Doesn't make a difference: Destroy(toComps[i]);
                    //Duplicates in Source (not good either): toObject.AddComponent(EditorUtility.CloneComponent(fromComps[i]));
                    // Not good: EditorUtility.CopySerialized(fromComps[i], toComps[i]); // Source to Destination      
                    toComps[i] = fromComps[i]; //Does nothing.  
                    // Trouble here also: EditorUtility.CloneComponent(fromComps[i]);
                    msg += "\t Cloned values.";
                }
            }
        }

        EditorUtility.DisplayDialog("Game Object Facts", msg, "OK", "");

    }
}