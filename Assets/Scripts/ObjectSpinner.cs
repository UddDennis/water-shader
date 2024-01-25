using UnityEngine;

public class ObjectSpinner : MonoBehaviour
{
    public float rotationSpeed = 100f;

    private bool isMousePressed = false;
    private Vector3 lastMousePosition;

    void Update()
    {
        if (Input.GetMouseButtonDown(2)) // Check for middle mouse button press
        {
            isMousePressed = true;
            lastMousePosition = Input.mousePosition;
        }
        else if (Input.GetMouseButtonUp(2)) // Check for middle mouse button release
        {
            isMousePressed = false;
        }

        if (isMousePressed)
        {
            // Calculate the mouse movement
            Vector3 mouseDelta = Input.mousePosition - lastMousePosition;

            // Rotate the object based on mouse movement
            Vector3 rotationAxis = Vector3.Cross(mouseDelta.normalized, Vector3.forward);
            transform.Rotate(rotationAxis, rotationSpeed * mouseDelta.magnitude * Time.deltaTime, Space.World);

            // Update the last mouse position
            lastMousePosition = Input.mousePosition;
        }
    }
}