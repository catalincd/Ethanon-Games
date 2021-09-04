class Wheel
{
	ColorBlock[] blocks;
	float angle = 180;
	float size_bias = 0;
	vector2 center;
	vector2 size;
	float radius;
	vector2 touchPos;
	float touchAngle;
	float touchAngleBefore;
	float targetAngle;
	float startingAngle;
	bool retrieving = false;
	bool checked = false;
	bool locking = true;
	bool transitionin = false;
	vector2 arrowPos;
	vector2 arrowSize;
	vector2 currentTouchPos;
	float angleOffset = 45;
	uint ARROW_COLOR = white;
	uint lastItemUnlocked;
	uint timeForTouch = 200;
	uint touchTime;
	
	InterpolationTimer@ timer = InterpolationTimer(300);
	

	void create()
	{
		lastItemUnlocked = UNLOCKED_COLORS;
		onCreate();
		center = vector2(GetScreenSize().x/2, GetScreenSize().y*0.6);
		arrowPos = center - vector2(0, 384)*GetScale();
		arrowSize = vector2(72,64)*GetScale();
		radius = GetScale()*256.0f;
		size = 1.25*vector2(64,64)*GetScale();
		retrieving = false;
		checked = false;
		timer.reset(300);
		transitionin = false;
	}
	
	
	void update()
	{
		onUpdate();
		updateAngle();
		draw();
		
		//CURRENT_COLOR = getColor();
	}
	
	uint getItemIdx()
	{
		uint f = (uint(angle+180+(angleOffset/2))%360) / angleOffset;
		return f;
	}
	
	uint getItemIdx(float xangle)
	{
		uint f = (uint(xangle+180+(angleOffset/2))%360) / angleOffset;
		return f;
	}
	
	uint getColor()
	{
		return GetColorFromIdx(getItemIdx());
	}
	
	bool touchChecked(vector2 touch)
	{
		bool inside = distance(center, touch) > radius*0.75;
		bool outside = distance(center, touch) < radius + (size.x*1.5);
		return inside&&outside;
	}
	
	void updateAngle()
	{
		ETHInput@ input = GetInputHandle();
		const KEY_STATE touchState = input.GetTouchState(0);
		if (touchState == KS_HIT)
		{
			touchPos = input.GetTouchPos(0);
			if(touchChecked(touchPos))
			{
				touchAngleBefore = angle;
				touchAngle = radianToDegree(getAngle(normalize(center-touchPos)));
				retrieving = false;
				checked = true;
				touchTime = GetTime();
			}
			
		}
		else if (touchState == KS_DOWN)
		{
			if(checked)
			{
				currentTouchPos = input.GetTouchPos(0);
				angle = touchAngleBefore + (-touchAngle + radianToDegree(getAngle(normalize(center-currentTouchPos))));
			}
		}
		if (touchState == KS_RELEASE)
		{
			if(checked)
			{
				retrieving = true;
				startingAngle = angle;
				if(GetTime() - touchTime > timeForTouch || true)
				{
					uint newIdx = uint(angle/angleOffset);
					float offset = angle - newIdx*angleOffset;
					if(offset > angleOffset / 2)
					{
						targetAngle = (newIdx*angleOffset + angleOffset);
						if(locking)
							if(getItemIdx(targetAngle) > lastItemUnlocked)
							{
								targetAngle = lastItemUnlocked * angleOffset + 180;
								if(abs(targetAngle - startingAngle) > 180)
									targetAngle -= 360;
								
							}
					}
					else
					{
						targetAngle = (newIdx*angleOffset);
						if(locking)
							if(getItemIdx(targetAngle) > lastItemUnlocked)
							{
								targetAngle = lastItemUnlocked * angleOffset + 180;
								if(abs(targetAngle - startingAngle) > 180)
									targetAngle -= 360;
							}
						
					}
				}
				else
				{
					//float touchAngleN = radianToDegree(getAngle(normalize(currentTouchPos-center)));
					float touchAngleN = radianToDegree(getAngle(currentTouchPos,center,center+vector2(0,1)));
					uint item = getItemIdx(touchAngleN);
					if(item > lastItemUnlocked)
					{
						retrieving = false;
					}
					else
					{
						targetAngle = item * angleOffset;
					}
					
				}
				timer.reset(600 * (abs(targetAngle - startingAngle) / angleOffset));
			}
			checked = false;
		}
		if(retrieving)
		{
			timer.update();
			angle = interpolate(startingAngle, targetAngle, timer.getBias());
			if(timer.isOver())
			{
				retrieving = false;
			}
		}
		if(!retrieving)
		{
			while(angle > 360) angle %= 360;
			while(angle < 0) angle += 360;
		}
	}
	
	void draw()
	{
		for(uint i=0;i<blocks.length();i++)
		{
			blocks[i].draw(size, center, angle, radius);
		}
		DrawShapedSprite("sprites/arrow_down.png", arrowPos, arrowSize, ARROW_COLOR);
	//	drawCenterBlock();
	}
	
	
	void resume()
	{
		checked = false;
	}
	
	
	void onCreate()
	{
		//fill blocks
		//set angle
	}
	
	void onUpdate()
	{
		
	}
}





class ColorBlock
{
	string spriteName;
	uint color = white;
	uint idx;
	bool locked;
	float offset;
	
	ColorBlock()
	{
		locked = false;
		spriteName = "entities/block_64.png";
	}
	ColorBlock(uint t, float&in _offset = 45)
	{
		offset = _offset;
		locked = false;
		idx = t;
		spriteName = "entities/block_64.png";
	}
	
	ColorBlock(uint t, string name, float&in _offset = 45)
	{
		offset = _offset;
		locked = false;
		idx = t;
		spriteName = name;
	}
	void draw(vector2 size, vector2 center, float angle, float radius)
	{
		float finalAngle = (idx*-1*offset + angle);
		uint finalColor = locked? grey2:color;
		vector2 finalPos = center + rotateAround(degreeToRadian(finalAngle), radius);
		DrawShapedSprite(spriteName, finalPos, size*getAngledScale(finalAngle), finalColor, finalAngle+180);
	}
	
	void drawBlock(vector2 pos, vector2 size, float scale = 1.0f)
	{
		uint finalColor = locked? grey2:color;
		
		DrawShapedSprite("sprites/block_spr.png", pos, size * 0.5f * scale, GetColorFromIdx(CURRENT_COLOR), 0.0f);	
		if(spriteName != "")
			DrawShapedSprite(spriteName, pos, size * scale, finalColor, 0.0f);		
	}
	
	void draw(vector2 pos, vector2 size, float scale = 1.0f)
	{
		uint finalColor = locked? grey2:color;
		DrawShapedSprite(spriteName, pos, size * scale, finalColor, 0.0f);		
	}
}