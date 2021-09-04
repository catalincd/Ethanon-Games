class Bouncer
{
	float bias = 0;
	int q = 1;
	float speed;
	
	
	Bouncer(uint mill)
	{
		speed = mill/1000;
	}
	
	void update()
	{
		bias+=UnitsPerSecond(speed)*q;
		if(bias>1)
			q=-1;
		if(bias<0)
			q=1;
	}
	
	float getBias()
	{
		return bias;
	}
}