class TouchManager
{
	ETHInput@ input = GetInputHandle();
	uint touchTime;
	vector2 initTouchPos;
	vector2 lastTouchPos;
	float maxOffset;
	bool normalTouch = false;
	bool returning = false;
	bool going = false;
	float dir;
	bool hit = false;
	uint stride = 1000;
	//float unitPer100MS;
	InterpolationTimer@ timer;
	float offsetX = 0;
	float prevOffsetX;
	bool next = false;
	bool prev = false;
	float factor = 1;
	bool limitLeft = false;
	bool limitRight = false;

	bool nextPage()
	{
		return next;
	}
	
	bool previousPage()
	{
		return prev;
	}

	bool buttonTouch()
	{
		return normalTouch;
	}
	
	vector2 getTouchPos()
	{
		return initTouchPos;
	}
	
	float getOffset()
	{
		return offsetX;
	}
	
	void reset()
	{
		next = false;
		prev = false;
		hit = false;
		going = false;
		returning = false;
		limitLeft = false;
		limitRight = false;
		offsetX = 0;
	}
	
	void create()
	{
		maxOffset = 3;
		@timer = InterpolationTimer(200);
		//unitPer100MS = UnitsPerSecond(1000)*GetScale();
	}
	
	void update()
	{
		normalTouch = false;
		if(input.GetTouchState(0)==KS_HIT)
		{
			hit = true;
			touchTime = GetTime();
			initTouchPos = input.GetTouchPos(0);
		}
		
		if(input.GetTouchState(0)==KS_DOWN && hit)
		{
			lastTouchPos = input.GetTouchPos(0);
			offsetX = (input.GetTouchPos(0)-initTouchPos).x;
			if(offsetX/GetScale()>150)
				if(limitRight)
				{
					hit = false;
					returning = true;
					prevOffsetX = offsetX;
					timer.reset(150+uint(abs(offsetX/GetScale())/2));
				}
				else
					next = true;
			if(offsetX/GetScale()<-150)
				if(limitLeft)
				{
					hit = false;
					returning = true;
					prevOffsetX = offsetX;
					timer.reset(150+uint(abs(offsetX/GetScale())/2));
				}
				else
					prev = true;
		}
		
		
		if(input.GetTouchState(0)==KS_RELEASE && !next && hit)
		{
			hit = false;
			float dist = distance(initTouchPos, lastTouchPos)/GetScale();
			float distx = abs(initTouchPos.x-lastTouchPos.x)/GetScale();
			if(dist<maxOffset)
			{
				if(GetTime()-touchTime<stride)
					normalTouch = true;
			}
			else
			{
				if(distx/float(GetTime()-touchTime)>0.8)
				{
					going = true;
					dir = sign(offsetX);
				}
				else
				{
					returning = true;
					prevOffsetX = offsetX;
					timer.reset(150+uint(abs(offsetX/GetScale())/2));
				}
			}
		}			
		
		if(going)
		{
			offsetX += dir*UnitsPerSecond(600)*GetScale();
			if(offsetX/GetScale()>150)
				next = true;
			if(offsetX/GetScale()<-150)
				prev = true;
 		}
		
		if(returning)
		{
			timer.update();
			offsetX = interpolate(prevOffsetX, 0, timer.getBias());
			if(timer.isOver())
				returning = false;
		}
		
	}
}

TouchManager g_touchManager;