using UnityEngine;

public class MouseClickInteraction : MonoBehaviour
{
    public Shader targetShader;

    void Update()
    {
        if (Input.GetMouseButtonDown(0)) // Left mouse button click
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;

            if (Physics.Raycast(ray, out hit))
            {
                // Check if the clicked object has the specified material
                Renderer renderer = hit.collider.GetComponent<Renderer>();
                if (renderer != null && renderer.material.shader == targetShader)
                {
                    // Perform actions or pass information to the shader
                    renderer.material.SetFloat("_ClickPositionX", hit.point.x);
                    renderer.material.SetFloat("_ClickPositionY", hit.point.y);
                    
                    
                    Texture2D tex = renderer.material.mainTexture as Texture2D;
                    Vector2 pixelUV = hit.textureCoord;
                    pixelUV.x *= tex.width;
                    pixelUV.y *= tex.height;
                    Debug.Log(hit.point);
                }
            }
        }
    }
}
