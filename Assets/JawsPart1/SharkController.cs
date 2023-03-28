using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SharkController : MonoBehaviour
{
    Rigidbody sharkRb;
    float speed = 4f;
    // Start is called before the first frame update
    void Start()
    {
        sharkRb = GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.D)) 
        {
            sharkRb.velocity = transform.right * speed;
        }
        if (Input.GetKeyDown(KeyCode.A))
        {
            sharkRb.velocity = -transform.right * speed;
        }
    }
}
