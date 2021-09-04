interface GameObject
{
	void create();
	void update();
	void resume();
	string getTag();
}


class GameObjectManager
{
	GameObject@[] objects;

	void init()
	{
		objects.resize(0);
		objects.insertLast(o_jumper);
		objects.insertLast(o_camera);
		objects.insertLast(o_world);
		
		objects.insertLast(o_trap);
		objects.insertLast(o_gameOver);
		

	}

	void create()
	{
		init();
		for(uint i=0;i<objects.length();i++)
		{
			objects[i].create();
		}
	}
	
	void update()
	{
		for(uint i=0;i<objects.length();i++)
		{
			objects[i].update();
		}
	}
	
	void resume()
	{
		for(uint i=0;i<objects.length();i++)
		{
			objects[i].resume();
		}
	}
}

GameObjectManager Objects;