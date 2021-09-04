class OverlaySelector 
{
	float currentOffset = 0.0f;
	ColorBlock[] blocks;
	float yPos = 500;
	float blockOffset = 200;
	float marginOffset = 200;
	float maxDistance = 200;
	float halfScreenX = 200;
	vector2 blockSize;
	vector2 arrowPos;
	vector2 arrowSize;
	bool moving = false;
	bool touched = false;
	bool transitionin = false;
	InterpolationTimer@ transitionTimer = InterpolationTimer(300);
	
	uint touchTime;
	uint touchFrames;
	
	vector2 initTouchPos;
	
	float touchLimitLeft;
	float touchLimitRight;
	
	float target;
	float initial;
	float touchError;
	float touchTop;
	float touchBottom;
	
	float marginLeft;
	float marginRight;
	
	vector2 gradientSize;
	vector2 gradientPosLeft;
	vector2 gradientPosRight;
	
	void create()
	{
	
		initBlocks();
		
		yPos = 600 * GetScale();
		blockOffset = 200 * GetScale();
		marginOffset = 160 * GetScale();
		blockSize = 1.25*vector2(64,64)*GetScale();
		
		currentOffset = getOffset(CURRENT_OVERLAY);
		
		touchError = blockSize.y;
		touchTop = yPos - touchError;
		touchBottom = yPos + touchError;
		
		arrowPos = vector2(GetScreenSize().x/2, GetScreenSize().y*0.6) - vector2(0, 384)*GetScale();
		arrowSize = vector2(72,64)*GetScale();
		moving = false;
		transitionin = false;
		touched = false;
		
		maxDistance = GetScreenSize().x / 6;
		halfScreenX = GetScreenSize().x / 2;
		
		marginLeft = halfScreenX - marginOffset;
		marginRight = marginLeft - (blockOffset * (blocks.length() - 1));
		
		touchLimitLeft = halfScreenX - (maxDistance / 2);
		touchLimitRight = halfScreenX + (maxDistance / 2);
		
		//SetSpriteOrigin("sprites/gradient.png", vector2(0.5f, 0.0f));
		
		gradientSize = blockSize * 2.5f;
		gradientPosLeft = vector2(0, yPos);
		gradientPosRight = vector2(GetScreenSize().x, yPos);
	}
	
	void initBlocks()
	{
		blocks.resize(0);
		
		for(uint i=0;i<OVERLAYS_NUM;i++)
		{
			blocks.insertLast(ColorBlock(i, GetOverlayNameFromIdx(i), 60));
		}
	}
	
	void draw()
	{
		for(uint i=0;i<blocks.length();i++)
		{
			vector2 pos = vector2(blockOffset * i + currentOffset + marginOffset, yPos);
		
			blocks[i].drawBlock(pos, blockSize, getScale(1.0f, 1.7f, pos.x, halfScreenX, maxDistance));
		}
		
		CURRENT_OVERLAY = getCurrent();
		
		//DrawText(V2_ZERO, ""+getOffset(), "Verdana30.fnt", white);
		
		DrawShapedSprite("sprites/arrow_down.png", arrowPos, arrowSize, white);
		
		DrawShapedSprite("sprites/gradient.png", gradientPosLeft, gradientSize, black, 90);
		DrawShapedSprite("sprites/gradient.png", gradientPosRight, gradientSize, black, 270);
		
	}
	
	uint getCurrent()
	{
		return uint(abs(currentOffset - blockOffset - blockOffset / 2) / blockOffset);
	}
	
	float getOffset(uint idxx)
	{
		return -1*(blockOffset * (idxx) - blockOffset);
	}
	
	float getOffset()
	{
		return getOffset(getCurrent());
	}
	
	void transitionToNext()
	{
		transitionin = true;
		initial = currentOffset;
		target = 1 * getOffset(getCurrent());
		transitionTimer.reset(300);
		
	}
	
	void transitionTo()
	{
		uint current = getCurrent();
		
		if(initTouchPos.x < touchLimitLeft && current != 0)
		{
			transitionin = true;
			initial = currentOffset;
			target = 1 * getOffset(current - 1);
			transitionTimer.reset(300);
		}
		
		if(initTouchPos.x > touchLimitRight && current != blocks.length()-1)
		{
			transitionin = true;
			initial = currentOffset;
			target = 1 * getOffset(current + 1);
			transitionTimer.reset(300);
		}
		
	}
	
	void limit()
	{
		if(currentOffset > marginLeft)
			currentOffset = marginLeft;
		if(currentOffset < marginRight)
			currentOffset = marginRight;
	}
	
	void updateTouch()
	{
		KEY_STATE touchState = GetInputHandle().GetTouchState(0);
		vector2 touchPos = GetInputHandle().GetTouchPos(0);
		
		if(touchState == KS_HIT)
		{
			moving = (touchPos.y < touchBottom && touchPos.y > touchTop);
			transitionin = false;
			touched = true;
			touchTime = GetTime();
			initTouchPos = touchPos;
		}
		if(touchState == KS_DOWN)
		{
			
			if(moving)
				currentOffset += GetInputHandle().GetTouchMove(0).x * GetScale();
		}
		if(touchState == KS_RELEASE)
		{
			if(moving)
			{
				if(GetTime() - touchTime > 150)
				{
					if(touched)
					{ 
						transitionToNext();
					}
				}
				else
				{
					transitionTo();
				}
			}
			touched = false;
			moving = false;
			
		}
		
		if(transitionin)
		{
			transitionTimer.update();
			currentOffset = interpolate(initial, target, transitionTimer.getBias());
			//print(initial);
			if(transitionTimer.isOver())
			{
				transitionin = false;
			}
		}
		
		limit();
	}
	
	void update()
	{
		updateTouch();
		draw();
	}
	
	
}

float getScale(float initScale, float maxScale, float currentPosX, float linePosX, float maxPosX)
{
	float bias = min(1.0f, abs(currentPosX - linePosX) / maxPosX);
	return interpolate(maxScale, initScale, bias);
}

OverlaySelector overlaySelector;