class World : GameObject
{
	ETHEntity@ background;
	
	

	void create()
	{
		SetBackgroundColor(backColor);
		
		
		ETHEntity@ platform;
		AddEntity("platform.ent", vector3(GetScreenSize().x/2, 9999, 0), @platform);
		platform.SetFloat("y", outerScreen3.y);
		
		
		
	}
	
	
	void update()
	{
		setBack();
	}
	
	
	void setBack()
	{
		
	}
	
	
	void resume()
	{
		SetBackgroundColor(backColor);
	}
	
	string getTag()
	{
		return "World";
	}
}

const uint backColor = 0xFFCFEFFC;

World o_world;