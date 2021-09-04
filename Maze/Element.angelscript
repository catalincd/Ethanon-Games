class Element
{
	uint id;
	vector2 pos;
	vector2 size;
	vector2 origin;
	Color color;
	float angle;
	float scale;
	Polygon polygon;
	RuntimeEffect@ effect;
	FadeInEffect@ fadeIn;
	FadeOutEffect@ fadeOut;
	
	void create()
	{
		@effect = DefaultEffect(this);
		@fadeIn = DefaultFadeIn(this);
		@fadeOut = DefaultFadeOut(this);
		updatePolygon();
	}
	
	void update()
	{	
	
		if(fadeIn !is null)
		fadeIn.update();
		if(fadeOut !is null)
		fadeOut.update();
		
		if(fadeIn.isOver() && !fadeOut.hasBegun())
			if(effect !is null)
				effect.update();
			
	}
	
	void updatePolygon()
	{
		vector2 absoluteOrigin = pos;
		vector2 absoluteSize = size * scale;
		float newAngle = degreeToRadian(angle);
		
		vector2 topLeft = pos - (origin * absoluteSize);
		vector2 bottomRight = topLeft + absoluteSize;
		vector2 topRight = vector2(bottomRight.x, topLeft.y);
		vector2 bottomLeft = vector2(topLeft.x, bottomRight.y);
		
		topLeft = rotateAroundOrigin(topLeft, absoluteOrigin, newAngle);
		bottomRight = rotateAroundOrigin(bottomRight, absoluteOrigin, newAngle);
		topRight = rotateAroundOrigin(topRight, absoluteOrigin, newAngle);
		bottomLeft = rotateAroundOrigin(bottomLeft, absoluteOrigin, newAngle);
		
		polygon.reset();
		polygon.insert(topLeft);
		polygon.insert(topRight);
		polygon.insert(bottomRight);
		polygon.insert(bottomLeft);
	}
	
	void reset()
	{
		fadeIn.reset();
		fadeOut.reset();
	}
	
	bool isHit()
	{
		if(input.TouchHit())
		{
			return isPointInThisElement(input.TouchPos());
		}
			
		return false;
	}
	
	bool isDown()
	{
		if(input.TouchDown())
		{
			return isPointInThisElement(input.TouchPos());
		}
	
		return false;
	}
	
	bool isPointInThisElement(vector2 p)
	{
		return isPointInElement(p, this);
	}
	
	void setEffect(RuntimeEffect@ e)
	{
		@effect = e;
		effect.setElement(this);
		updatePolygon();
	}
	
	void setFadeIn(FadeInEffect@ e)
	{
		@fadeIn = e;
		fadeIn.setElement(this);
		updatePolygon();
	}
	
	void setFadeOut(FadeOutEffect@ e)
	{
		@fadeOut = e;
		fadeOut.setElement(this);
		updatePolygon();
	}
}


bool isPointInElement(vector2 p, Element element)
{
	return element.polygon.isPointInPolygon(p);
}

