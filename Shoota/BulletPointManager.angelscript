class BulletPointManager : GameObject
{

	int bulletPoints;
	float textScale = 1.0f;

	void create()
	{
		bulletPoints = 0;
		textScale = 1.0f;
	}


	void update()
	{
		textScale -= UnitsPerSecond(1.0f);
		textScale = max(1.0f, textScale);
	}

	void resume()
	{

	}

	int getBulletPoints()
	{
		return bulletPoints;
	}

	void add(int i)
	{
		bulletPoints += i;
		g_exp.add(i / 2);
		textScale = 1.5f;
		//print("YE" + i);
	}

	float getTextScale()
	{
		return textScale;
	}

	void decrease(int i)
	{
		if(i != 0)
		{
			bulletPoints -= i;
			g_uiBar.drawFadingText(i);
		}
	}

	string getBulletString()
	{
		return (""+bulletPoints+" ");
	}

	void drawText()
	{

	}

	string getTag(){ return "BulletPoint";}

}

BulletPointManager g_bulletPoint;