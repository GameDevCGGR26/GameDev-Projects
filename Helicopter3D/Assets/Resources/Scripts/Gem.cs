using UnityEngine;
using System.Collections;

public class Gem : MonoBehaviour
{

	// Use this for initialization
	void Start()
	{

	}

	// Update is called once per frame
	void Update()
	{

		// despawn Gem if it goes past the left edge of the screen
		if (transform.position.x < -25)
		{
			Destroy(gameObject);
		}
		else
		{

			// ensure Gem moves at the same rate as the skyscrapers do
			transform.Translate(-SkyscraperSpawner.speed * Time.deltaTime, 0, 0, Space.World);
		}

		// infinitely rotate this Gem about the Y axis in world space
		transform.Rotate(0, 5f, 0, Space.World);
	}

	void OnTriggerEnter(Collider other)
	{

		// trigger Gem pickup function if a helicopter collides with this
		other.transform.parent.GetComponent<HeliController>().PickupGem();
		Destroy(gameObject);
	}
}
