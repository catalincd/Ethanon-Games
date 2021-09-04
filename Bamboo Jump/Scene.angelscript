class Scene
{
	string m_sceneName;
	vector2 m_bucketSize;
	
	Scene(string _sceneName, vector2 _bucketSize = V2_1536)
	{
		m_sceneName = _sceneName;
		m_bucketSize = _bucketSize;
	}
	
	void create(){}
	void update(){}
	void resume(){}
}

const string CREATE = "onCreate";
const string UPDATE = "onUpdate";
const string RESUME = "onResume";