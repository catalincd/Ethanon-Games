class HPGauge : GameObject
{
	uint maxHp = 10;
	uint currentHp = 10;
	float currentBias = 0;
	float ascendingSpeed = 0.4f;
	float descendingSpeed = 0.275f;

	
	
	void create()
	{
		currentBias = 0;
	}
	
	void update()
	{
		float targetBias = getInstantBias();
		if(!g_timer.gameStopped)
			if(abs(targetBias - currentBias) > 0.008f)
			{
				if(targetBias > currentBias)
					currentBias += UnitsPerSecond(ascendingSpeed);
				else
					currentBias -= UnitsPerSecond(descendingSpeed);
			}
	}
	
	float getInstantBias()
	{
		return float(currentHp) / float(maxHp);
	}
	
	float getBias()
	{
		return currentBias;
	}
	
	void setCurrentHp(uint q)
	{
		currentHp = q;
	}
	
	void set(uint hp)
	{
		maxHp = hp;
		currentHp = hp;
		currentBias = 1.0f;
	}
	
	void draw(vector2 position)
	{
		float bias = getBias();
		DrawHp(position, bias, getCurrentColor());
	}
	
	uint getCurrentColor()
	{
		float bias = getBias();
		return interpolateColor(red,AQUA_BLUE,bias);
		//return red;
	}
	
	void drawText(vector2 position)
	{
		string txt = ""+currentHp;
		//uint txtColor = getCurrentColor();
		DrawText(txt, text64, position, red, vector2(0.0f, 0.0f), 0.5f);
		
		DrawText("HP", text64, position, AQUA_BLUE, vector2(0.0f, 1.0f), 0.5f);
	}
	
	void resume(){}
	
	string getTag(){ return "HP"; }
}

HPGauge g_hp;

void DrawHp(vector2 pos, float bias, uint color)
{	
	DrawGauge(pos, bias, 0.4, red, color);
}