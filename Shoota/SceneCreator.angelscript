class SceneCreator : GameObject
{

	void create()
	{
		//for(uint i=0;i<10;i++)
			//for(uint j=0;j<10;j++)
				//AddEntity("grass.ent", vector3(i*SF.PX_256,j*SF.PX_256,-100), 0);
	}
	
	void update()
	{
	
	}
	
	void resume()
	{
	
	}

	string getTag(){ return "SceneCreator"; }
}

SceneCreator g_sceneCreator;