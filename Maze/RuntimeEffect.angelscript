class RuntimeEffect
{
	vector2 pos, posI;
	vector2 size, sizeI;
	vector2 origin, originI;
	Color color, colorI;
	float angle, angleI;
	float scale, scaleI;
	bool defaultEffect = false;
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
	}
	
	RuntimeEffect(){}
	
	RuntimeEffect(Element@ element)
	{
		pos = posI = element.pos;
		size = sizeI = element.size;
		origin = originI = element.origin;
		color = colorI = element.color;
		angle = angleI = element.angle;
		scale = scaleI = element.scale;
		@e = element;
	}
	
	void update(){}
}

class DefaultEffect : RuntimeEffect
{
	DefaultEffect()
	{
		defaultEffect = true;
	}
	DefaultEffect(Element@ e)
	{
		super(e);
		defaultEffect = true;
	}

	void update()
	{
		
	}
}

class BasicTap : RuntimeEffect
{
	BasicTap(){}
	BasicTap(Element@ e)
	{
		super(e);
	}
	
	void update()
	{
		Color c = colorI;
		bool down = e.isDown();
		e.color = (down? Color(darkGrey.getUInt() & c.getUInt()) : c);
		e.scale = (down? scaleI * 0.8f : scaleI);
	}
}

class ColorTap : RuntimeEffect
{
	ColorTap(){}
	ColorTap(Element@ e)
	{
		super(e);
	}
	
	void update()
	{
		Color c = colorI;
		e.color = (e.isDown()? Color(darkGrey.getUInt() & c.getUInt()) : c);
	}
}


class BasicBounce : RuntimeEffect
{
	FloatBouncer@ bouncer;
	bool upScale;
	float addScale = 0.2f;

	BasicBounce()
	{
		@bouncer = FloatBouncer(0.0f, 1.0f, A_NORMAL);
		upScale = true;
		addScale = 0.2f;
	}
	BasicBounce(Element@ e, bool _upScale = true, float _addScale = 0.1f)
	{
		super(e);
		@bouncer = FloatBouncer(0.0f, 1.0f, A_NORMAL);
		upScale = _upScale;
		addScale = _addScale;
	}
	
	void update()
	{
		bouncer.update();
		float add = bouncer.getBounceScale() * addScale;
		if(!upScale) add *= -1;
		e.scale = scaleI + add;
	}
}

class OpacityBounce : RuntimeEffect
{
	FloatBouncer@ bouncer;
	float addScale = 0.2f;

	OpacityBounce()
	{
		@bouncer = FloatBouncer(0.0f, 1.0f, A_SLOW);
		bouncer.setFilter(@smoothBothSides);
		addScale = 0.1f;
	}
	OpacityBounce(Element@ e, float _addScale = 0.1f)
	{
		super(e);
		@bouncer = FloatBouncer(0.0f, 1.0f, A_SLOW);
		bouncer.setFilter(@smoothBothSides);
		addScale = _addScale;
	}
	
	void update()
	{
		bouncer.update();
		float a = bouncer.getBounceScale();
		e.color.setAlpha(a);
	}
}

class Cursor : RuntimeEffect
{
	Cursor(){}
	Cursor(Element@ e)
	{
		super(e);
	}
	
	void update()
	{
		e.angle = radianToDegree(getAngle(normalize(e.pos - GetInputHandle().GetCursorPos())));
		e.color = (green);
		e.updatePolygon();
		e.polygon.debugDraw();
	}
}

