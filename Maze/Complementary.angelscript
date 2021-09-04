class ColorWheel
{
	Color[] colors;
	
	//float angle = 60.0f;
	
	ColorWheel()
	{
		initColors();
	}
	
	void initColors()
	{
		colors.resize(0);
		colors.insertLast(red);
		colors.insertLast(orange);
		colors.insertLast(yellow);
		colors.insertLast(green);
		colors.insertLast(blue);
		colors.insertLast(magenta);
		colors.insertLast(red);
	}
	
	Color getColor(float angle)
	{
		float ratio = angle / 60.0f;
		float bias = (angle - (uint(ratio) * 60.f)) / 60.0f;

		uint first = uint(ratio);
		uint next = first+1;
		
		return interpolate(colors[first], colors[next], bias);
	}
	
	
	void create()
	{
	
	}
	
	void update()
	{
	
	}
	
	void resume()
	{
	
	}
}

ColorWheel g_colorWheel;

Color getColor(float angle)
{
	return g_colorWheel.getColor(angle);
}
