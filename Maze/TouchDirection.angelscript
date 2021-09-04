class TouchDetector
{

	bool disabled = false;
	bool showing = false;
	vector2 initPos;
	float opacity = 0;
	Timer@ opacityTimer;
	
	float maxRadius;
	float maxArrowRadius;
	vector2 circleSize;
	vector2 tapSize;
	
	vector2 currentDir;
	float currentRatio;
	
	float radius = 10;
	
	vector2 posTop;
	vector2 posBottom;
	vector2 posLeft;
	vector2 posRight;
	
	vector2 arrowSize;
	
	vector2 fixedCirclePos;
	
	void create()
	{
		@opacityTimer = Timer(A_NORMAL, A_NORMAL * 2.5f);
		
		float R = (LAYOUT == 2? 0.65f : 1.0f);
		
		maxRadius = 87 * GetScale() * TOUCH_SCALE * 0.75f * R;
		circleSize = 256 * GetScale() * TOUCH_SCALE * 0.75f * R;
		tapSize = 64 * GetScale() * TOUCH_SCALE * 0.75f * R;
		
		fixedCirclePos = GetScreenSize() * vector2(0.5f, 0.85f);
		
		if(LAYOUT == 2)
			fixedCirclePos += GetScreenSize() * vector2(0.0f, 0.02f);
		
		setSpriteOrigin("sprites/circle.png", V2_HALF);
		setSpriteOrigin("sprites/tap.png", V2_HALF);
		setSpriteOrigin("sprites/arrow.png", vector2(0.5f, 1.0f));
		
		radius = 10 * GetScale();
		
		float arrowScale = 1.15f;
		
		if(LAYOUT == 1)arrowScale = 1.1f;
		if(LAYOUT == 2)arrowScale = 0.8f;
		
		
		
		arrowSize = vector2(61, 76) * GetScale() * TOUCH_SCALE * arrowScale;
		maxArrowRadius = (arrowSize.y + radius) * 2.0f;
		
		
		
		posTop = fixedCirclePos + vector2(0.0f, -1.0f) * radius;
		posBottom = fixedCirclePos + vector2(0.0f, 1.0f) * radius;
		posLeft = fixedCirclePos + vector2(-1.0f, 0.0f) * radius;
		posRight = fixedCirclePos + vector2(1.0f, 0.0f) * radius;
	
		reset();
		
		currentDir = V2_ZERO;
	}
	
	void reset()
	{
		disabled = false;
		showing = false;
		opacityTimer.reset();
	}
	
	void enable()
	{
		disabled = false;
		showing = false;
		opacityTimer.reset();
	}
	
	
	void update()
	{
		if(!Alert.showing)
			if(TOUCH_CONTROLS)
				if(TOUCH_FIXED)
					updateFixed();
				else
					updatePivot();
			else
				updateArrows();
	}
	
	void updateArrows()
	{
		bool top,bottom,left,right;
		top = bottom = left = right = false;
		
		currentDir = V2_ZERO;
		currentRatio = 1.0f;
	
		if(!disabled)
		{
		
			opacityTimer.update();
				
			uint thisColor = Color(opacityTimer.getBias(), ballColor.getVector3()).getUInt();
		
			if(GetInputHandle().GetTouchState(0) == KS_DOWN)
			{
				vector2 touchPos = GetInputHandle().GetTouchPos(0);
				if(distance(touchPos, fixedCirclePos) < maxArrowRadius)
				{
					float angle = radianToDegree(getAngle(normalize(fixedCirclePos - touchPos)));
					//DrawText(V2_ZERO, ""+angle, "Verdana30.fnt", black.getUInt());
					
					if(0.0f < angle && angle <= 45.0f || angle > 315.0f)top = true;
					if(225.0f < angle && angle <= 315.0f)right = true;
					if(135.0f < angle && angle <= 225.0f)bottom = true;
					if(45.0f < angle && angle <= 135.0f)left = true;
						
				}
			}
			
			DrawShapedSprite("sprites/arrow.png", posTop, arrowSize * (top? 0.9f:1.0f), thisColor, 0.0f);
			DrawShapedSprite("sprites/arrow.png", posBottom, arrowSize * (bottom? 0.9f:1.0f), thisColor, 180.0f);
			DrawShapedSprite("sprites/arrow.png", posLeft, arrowSize * (left? 0.9f:1.0f), thisColor, 90.0f);
			DrawShapedSprite("sprites/arrow.png", posRight, arrowSize * (right? 0.9f:1.0f), thisColor, 270.0f);
			
			
			
			if(top) currentDir += vector2(0.0f, -1.0f);
			if(bottom) currentDir += vector2(0.0f, 1.0f);
			if(left) currentDir += vector2(-1.0f, 0.0f);
			if(right) currentDir += vector2(1.0f, 0.0f);
		}
		
	}
	
	void updateFixed()
	{
	
		if(!disabled)
			opacityTimer.update();
		
		uint thisColor = Color(opacityTimer.getBias(), ballColor.getVector3()).getUInt();
		
		DrawShapedSprite("sprites/circle.png", fixedCirclePos, circleSize, thisColor);
		
		KEY_STATE touchState = GetInputHandle().GetTouchState(0);
		vector2 touchPos = GetInputHandle().GetTouchPos(0);
		vector2 currentPos;

		if(touchState == KS_HIT)
		{
			disabled = false;
			showing = true;
			currentPos = touchPos;
		}
		else
		if(touchState == KS_DOWN)
		{
			showing = !disabled;
			currentPos = touchPos;
		}
		else
		if(touchState == KS_RELEASE)
		{
			showing = false;
		}
		
		if(showing)
		{
			currentDir = normalize(currentPos - fixedCirclePos);
			vector2 normal = getNormal(fixedCirclePos, currentPos);
			currentRatio = distance(fixedCirclePos, normal) / maxRadius;
			DrawShapedSprite("sprites/tap.png", normal, tapSize, thisColor);
		}
		else
		{
			currentDir = V2_ZERO;
		}

	}
	
	void updatePivot()
	{
		KEY_STATE touchState = GetInputHandle().GetTouchState(0);
		vector2 touchPos = GetInputHandle().GetTouchPos(0);
		vector2 currentPos;

		if(touchState == KS_HIT)
		{
			disabled = false;
			showing = true;
			initPos = touchPos;
			currentPos = touchPos;
		}
		else
		if(touchState == KS_DOWN)
		{
			showing = !disabled;
			currentPos = touchPos;
		}
		else
		if(touchState == KS_RELEASE)
		{
			reset();
		}
		
		if(showing)
		{
			currentDir = normalize(currentPos - initPos);
			vector2 normal = getNormal(initPos, currentPos);
			draw(initPos, normal);
			currentRatio = distance(initPos, normal) / maxRadius;
		}
		else
		{
			currentDir = V2_ZERO;
		}
	}
	
	vector2 getNormal(vector2 init, vector2 current)
	{
		if(distance(init, current) > maxRadius)
		{
			return (init + (currentDir * maxRadius));
		}
		else
		{
			return current;
		}
	}
	
	void disable()
	{
		disabled = true;
		opacity = 0;
		opacityTimer.reset(A_NORMAL);
	}

	
	void draw(vector2 init, vector2 current)
	{
		DrawShapedSprite("sprites/circle.png", init, circleSize, ballColor.getUInt());
		
		DrawShapedSprite("sprites/tap.png", current, tapSize, ballColor.getUInt());
	}
	
	vector2 getDirection()
	{
		return currentDir * currentRatio;
	}

	void resume()
	{
		reset();
	}

}

TouchDetector g_tap;