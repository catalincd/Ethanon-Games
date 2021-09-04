class Flicker
{
	uint frames = 0;
	uint stride;
	
	Flicker(){}
	
	Flicker(uint str = 0)
	{
		frames = 0;
		stride = str;
	}
	
	void create()
	{
		frames = 0;
	}
	
	void update()
	{
		frames++;
	}
	
	bool going()
	{
		return ((frames / stride) % 2 ==0);
	}
	
}