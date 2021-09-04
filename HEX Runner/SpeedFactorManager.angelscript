class SpeedFactorManager : GameObject
{

	float speed = 450.0f;
	float targetSpeed = 750.0f;
	float bias = 0;

	string getTag()
	{
		return "Speeder";
	}
	
	void create()
	{
		bias = 0;
	}
	
	void update()
	{
		bias = smoothBothSides(min(1, GetScoreF() / 250000.0f));
	}
	
	void resume()
	{
	
	}
	
	float getSpeedFactor()
	{
		return bias;
	}
	
	float getSpeed()
	{
		return interpolate(speed, targetSpeed, getSpeedFactor());
	}
}

SpeedFactorManager g_speedFactorManager;


