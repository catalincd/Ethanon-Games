class BackgroundEffector : GameObject
{
	string getTag()
	{
		return "Background";
	}
	
	FloatColor color1;
	FloatColor color2;

	void create()
	{
		color1 = FloatColor(COL(GetColorFromIdx(CURRENT_COLOR))/5);
	}
	
	void update()
	{
		//SetBackgroundColor(color1.getUInt());
	}
	
	void resume()
	{
	
	}
}


BackgroundEffector g_backgroundEffector;