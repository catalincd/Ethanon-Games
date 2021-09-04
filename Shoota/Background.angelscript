class Background
{
	vector3 spriteColor;
	vector3 backgroundColor;
	vector3[] interpolationColors;
	uint stride;
	uint current = 0;
	float rate = 0.2f;
	uint len;
	InterpolationTimer@ timer = InterpolationTimer(1500);
	
	Background(){}

	Background(vector3 col, vector3 bCol, vector3[] intCol = defaultArray, uint str = 1500, float r = 0.2f)
	{
		spriteColor = col;
		backgroundColor = bCol;
		interpolationColors = intCol;
		len = interpolationColors.length()-1;
		current = rand(0, len);
		rate = r;
		stride = str;
		uint q = getRandStride();
		timer.reset(q);
	}
	
	float getRandFactor()
	{
		return (1.0f + randF(-rate, rate));
	}
	
	uint getRandStride()
	{
		return uint(float(stride) * getRandFactor());
	}
	
	void update()
	{
		timer.update();
		if(timer.isOver())
		{
			current++;
			//print(vector3ToString(interpolationColors[current]));
			if(current > len)
				current = 0;
			timer.reset(getRandStride());
		}
		
	}
	
	vector3 getBackgroundColor()
	{
		vector3 inv = negative(getColor());
		
		return interpolate(backgroundColor, inv, 0.1f);
	}
	
	vector3 getColor()
	{
		uint next = current<len? current+1:0;
		vector3 currentCol = interpolate(interpolationColors[current], interpolationColors[next], timer.getBias());
		vector3 finalColor = interpolate(spriteColor, currentCol, 0.35f);
		return finalColor;
	}
}


vector3[] defaultArray = {V3_ONE, vector3(1.0f, 0.8f, 0.8f), vector3(0.8f, 1.0f, 0.8f), vector3(0.8f, 0.8f, 1.0f)};