class BPS : GameObject
{
	uint[] bulletTimes;
	uint maxBPS = 8;
	float currentBias = 0;
	float ascendingSpeed = 0.4f;
	float descendingSpeed = 0.275f;

	void removePastBullets()
	{
		uint time = getTime();
		for(uint i=0;i<bulletTimes.length();i++)
		{
			if(time - bulletTimes[i] > 1000)
			{
				bulletTimes.removeAt(i);
			}
		}
	}

	void insertBullet()
	{
		bulletTimes.insertLast(getTime());
	}
	
	uint getBullets()
	{
		return bulletTimes.length();
	}
	
	void create()
	{
		bulletTimes.resize(0);
		currentBias = 0;
	}
	
	void update()
	{
		removePastBullets();
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
		return float(getBullets()) / float(maxBPS);
	}
	
	float getBulletsBias()
	{
		return currentBias;
	}
	
	float getBPSRateNum()
	{
		return float(uint(float(maxBPS) * currentBias *10.0f))/10.0f;
	}
	
	void draw(vector2 position)
	{
		float bias = getBulletsBias();
		//print(bias);
		DrawBPS(position, bias);
	}
	
	void drawText(vector2 position)
	{
		string txt = ""+getBPSRateNum();
		uint txtColor = red;
		DrawText(txt, text64, position, txtColor, vector2(0.0f, 0.0f), 0.5f);
		
		DrawText("CPS", text64, position, AQUA_BLUE, vector2(0.0f, 1.0f), 0.5f);
	}
	
	void resume(){}
	
	string getTag(){ return "BPS"; }
}

BPS g_bps;

void DrawBPS(vector2 pos, float bias)
{	
	DrawGauge(pos, bias, 0.4);
}