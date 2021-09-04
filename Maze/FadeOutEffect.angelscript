class FadeOutEffect
{
	vector2 pos, posI;
	vector2 size, sizeI;
	vector2 origin, originI;
	Color color, colorI;
	float angle, angleI;
	float scale, scaleI;
	bool defaultEffect = false;
	bool began = false;
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
		began = false;
	}
	
	FadeOutEffect(){}
	
	FadeOutEffect(Element@ element)
	{
		pos = posI = element.pos;
		size = sizeI = element.size;
		origin = originI = element.origin;
		color = colorI = element.color;
		angle = angleI = element.angle;
		scale = scaleI = element.scale;
		@e = element;
		@timer = Timer(A_NORMAL);
		timer.setFilter(@smoothBeginning);
		began = false;
	}
	
	void update(){}
	
	
	void setDelay(uint delay)
	{
		timer.setDelay(delay);
	}
	
	void begin()
	{
		began = true;
		timer.reset();
	}
	
	void begin(uint x)
	{
		setDelay(x);
		begin();
	}
	
	bool hasBegun()
	{
		return began;
	}
	
	void reset()
	{
		began = false;
		timer.m_elapsedTime = 0;
	}
}


class DefaultFadeOut : FadeOutEffect
{
	DefaultFadeOut()
	{
		defaultEffect = true;
	}
	
	DefaultFadeOut(Element@ e)
	{
		super(e);
		defaultEffect = true;
	}

	void update()
	{
		
	}
}


class ScaleFadeOut : FadeOutEffect
{
	ScaleFadeOut()
	{
		super();
	}
	
	ScaleFadeOut(Element@ e)
	{
		super(e);
	}

	void update()
	{	
		if(began)
		{
			timer.update();
			e.scale = scaleI * (1.0f - timer.getBias());
		}
	}
}

class OpacityFadeOut : FadeOutEffect
{
	float alphaI;

	OpacityFadeOut()
	{
		super();
		alphaI = colorI.getAlpha();
	}
	
	OpacityFadeOut(Element@ e)
	{
		super(e);
		alphaI = colorI.getAlpha();
	}

	void update()
	{	
		if(began)
		{
			timer.update();
			e.color.setAlpha(alphaI * (1.0f - timer.getBias()));
		}
	}
}

class BasicFadeOut : FadeOutEffect
{
	float alphaI;
	
	BasicFadeOut()
	{
		super();
		alphaI = colorI.getAlpha();
	}
	
	BasicFadeOut(Element@ e)
	{
		super(e);
		alphaI = colorI.getAlpha();
	}

	void update()
	{	
		if(began)
		{
			timer.update();
			float newBias = 1.0f - timer.getBias();
			e.color.setAlpha(alphaI * (newBias));
			e.scale = scaleI * (newBias);
		}
		//DrawText(vector2(0,0), ""+timer.getBias() + (began? "BEGAN":"NO"), "Verdana30.fnt", black.getUInt());
	}
}
