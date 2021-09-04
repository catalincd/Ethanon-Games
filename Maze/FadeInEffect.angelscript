class FadeInEffect
{
	vector2 pos, posI;
	vector2 size, sizeI;
	vector2 origin, originI;
	Color color, colorI;
	float angle, angleI;
	float scale, scaleI;
	bool defaultEffect = false;
	Timer@ timer;
	Element@ e;
	
	
	void setElement(Element@ element)
	{
		pos = posI = element.pos;
		size = sizeI = element.size;
		origin = originI = element.origin;
		color = colorI = element.color;
		angle = angleI = element.angle;
		scale = scaleI = element.scale;
		@e = element;
		@timer = Timer(A_NORMAL);
	}
	
	FadeInEffect()
	{
		@timer = Timer(A_NORMAL);
	}
	
	FadeInEffect(Element@ element)
	{
		pos = posI = element.pos;
		size = sizeI = element.size;
		origin = originI = element.origin;
		color = colorI = element.color;
		angle = angleI = element.angle;
		scale = scaleI = element.scale;
		@e = element;
		@timer = Timer(A_NORMAL);
	}
	
	void update(){}
	
	void setDelay(uint delay)
	{
		timer.setDelay(delay);
	}
	
	bool isOver()
	{
		return timer.isOver();
	}
	
	void reset()
	{
		timer.reset();
	}
}


class DefaultFadeIn : FadeInEffect
{
	DefaultFadeIn()
	{
		defaultEffect = true;
	}
	
	DefaultFadeIn(Element@ e)
	{
		super(e);
		defaultEffect = true;
	}

	void update()
	{
		
	}
	
	bool isOver() override
	{
		return true;
	}
}

class ScaleFadeIn : FadeInEffect
{
	ScaleFadeIn()
	{
		super();
	}
	
	ScaleFadeIn(Element@ e)
	{
		super(e);
	}

	void update()
	{	
		timer.update();
		e.scale = scaleI * timer.getBias();
	}
}

class OpacityFadeIn : FadeInEffect
{
	OpacityFadeIn()
	{
		super();
	}
	
	OpacityFadeIn(Element@ e)
	{
		super(e);
	}

	void update()
	{	
		timer.update();
		e.color.setAlpha(timer.getBias());
	}
}

class BasicFadeIn : FadeInEffect
{
	BasicFadeIn()
	{
		super();
	}
	
	BasicFadeIn(Element@ e)
	{
		super(e);
	}
	
	BasicFadeIn(Element@ e, uint _delay)
	{
		super(e);
		setDelay(_delay);
	}

	void update()
	{	
		timer.update();
		e.color.setAlpha(timer.getBias());
		e.scale = scaleI * timer.getBias();
	}
}

