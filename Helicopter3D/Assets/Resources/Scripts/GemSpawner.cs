using UnityEngine;
using System.Collections;

public class GemSpawner : MonoBehaviour
{

	public GameObject[] prefabs;

	// Use this for initialization
	void Start()
	{

		// infinite Gem spawning function, asynchronous
		StartCoroutine(SpawnGem());
	}

	// Update is called once per frame
	void Update()
	{

	}

	IEnumerator SpawnGem()
	{
		while (true)
		{

			// number of Gem we could spawn vertically
			int gemsThisRow = Random.Range(1, 2);

			// instantiate all Gem in this row separated by some random amount of space
			for (int i = 0; i < gemsThisRow; i++)
			{
				Instantiate(prefabs[Random.Range(0, prefabs.Length)], new Vector3(26, Random.Range(-10, 10), 10), Quaternion.identity);
			}

			// pause 1-5 seconds until the next Gem spawns
			yield return new WaitForSeconds(Random.Range(5, 10));
		}
	}
}
