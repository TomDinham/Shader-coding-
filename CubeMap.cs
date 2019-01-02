using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class CubeMap : ScriptableWizard
{
    public Transform RenderPos; // creating a transform variable
    public Cubemap cubeMap; // creating a cubmap variable

   void OnWizardUpdate()
    {
        if(RenderPos != null && cubeMap != null) // if there is a rederposition and a cubemap
        {
            isValid = true;
        }
        else
        {
            isValid = false;
        }
    }

    void OnWizardCreate()
    {
        GameObject CubeCam = new GameObject("CubeCam", typeof(Camera)); // create a camera
        CubeCam.transform.position = RenderPos.transform.position; // set the cameras position to the same as the transforms render position
        CubeCam.transform.rotation = Quaternion.identity;//set the rotation to the same as the reder position
        CubeCam.GetComponent<Camera>().RenderToCubemap(cubeMap);//render the camera to a cube map so it will capture images that can be used as a cube map
        DestroyImmediate(CubeCam);// destroy the camera as soon as its done
    }

    [MenuItem("Edit/Render Cubmap")]//create a menu option
    static void RenderCubemap()
    {
        ScriptableWizard.DisplayWizard("Render Cubemap", typeof(CubeMap), "Render!");//set the option name and set the fuctionality to the cubemap script
    }

}
