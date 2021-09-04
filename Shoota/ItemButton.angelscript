class ItemButton
{
	Item@ reference;
	vector2 pos;
	vector2 relPos;
	vector2 size;
	float scale;
	bool isTapped;
	uint touchTime;
	bool selected = false;
	bool enabled = true;
	vector2 offset;
	vector2 origin;
	uint id;
	uint color;
	uint greyColor;
	uint blackColor;
	uint redColor;
	int cost;
	InterpolationTimer@ timer = InterpolationTimer(200);
	
	ItemButton(){}
	
	ItemButton(uint idd, vector2 position, Item@ it)
	{
		id = idd;
		@reference = it;
		size = V2_200;
		origin = V2_HALF;
		setPosition(position);
		selected = false;
		enabled = true;
		scale = 1.0f;
		color = white;
		greyColor = DARK_GREY;
		blackColor = black;
		redColor = red;
	}

	void disable()
	{
		enabled = false;
	}
	
	void enable()
	{
		enabled = true;
	}

	void update()
	{
		if(enabled)
		{
			ETHInput@ input = GetInputHandle();
		KEY_STATE touchState = input.GetTouchState(0);
		
		if(touchState == KS_HIT)
		{
			vector2 touchPos = input.GetTouchPos(0);
			if(isPointInButton(touchPos))
			{
				offset = relPos - touchPos;
				touchTime = getTimeAbsolute();
				selected = true;
				g_itemManager.select(id);
				timer.reset(150);
			}
		}
		
		else if(touchState == KS_DOWN && selected)
		{
			vector2 touchPos = input.GetTouchPos(0);
			relPos = touchPos - offset;
			timer.update();
			scale = interpolate(1.0f, 1.25f, timer.getBias());
		}
		
		if(touchState == KS_RELEASE)
		{
			if(selected)
			{
				g_itemManager.deselect();
			}
			reset();
		}
		
		if(g_ui.windowUp)
			draw();
		}
		else
		if(g_ui.windowUp)
			drawDisabled();
	}
	
	
	void reset()
	{
		selected = false;
		offset = V2_ZERO;
		scale = 1.0f;
	}
	
	float getBias()
	{
		return timer.getBias();
	}
	
	void draw()
	{
		vector2 finalPos = relPos + offset;
		DrawShapedSprite(reference.name, finalPos, size*scale, color);
		
		if(!selected)
		{
			vector2 newFinalPos = finalPos-vector2(-PX_80, PX_80);
			string textToDraw = "" + reference.cost;
			DrawText(textToDraw, text64, newFinalPos, redColor, vector2(1.0f, 0.0f), scale*0.8);
			DrawShapedSprite("sprites/stroke.png", finalPos, size, color);
		}
	}
	
	void DrawCost()
	{
		
	}

	void drawDisabled()
	{

		vector2 finalPos = relPos + offset;
		vector2 newFinalPos = finalPos+vector2(0, PX_80);
		DrawShapedSprite(reference.name, finalPos, size*scale, greyColor);
		string textToDraw = "" + reference.cost;
		DrawText(textToDraw, text64, newFinalPos, blackColor, vector2(0.0f, 0.0f), scale);
		DrawShapedSprite("sprites/bullet_spr.png", newFinalPos, V2_64, color);
	}
	
	void setYOffset(float yOff)
	{
		relPos = pos - (size * origin) + vector2(0, yOff);
	}
	
	void setPosition(vector2 position)
	{
		pos = position;
		relPos = pos - (size * origin);
	}
	
	bool isPointInButton(const vector2 &in p) const
	{
		return (isPointInRect(p, relPos, size, origin));
	}
	
	void setColors(uint c, uint greyC, uint blk, uint rd)
	{
		color = c;
		greyColor = greyC;
		blackColor = blk;
		redColor = rd;
	}
	
	void resume()
	{
		reset();
	}
}