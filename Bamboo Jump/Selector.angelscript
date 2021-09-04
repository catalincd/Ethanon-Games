class Selector
{

	circle@[] circles;
	
	vector2 circleSize = V2_256;
	vector2 validCircleSize = V2_256;
	vector2 arrSize = V2_256;
	vector2 arrPos = V2_256;
	vector2 xTextPos = V2_256;
	bool validTouch = false;
	
	bool transitioning = false;
	
	vector2 topY;
	vector2 downY;

	uint touchTime;
	int currentSelected;
	
	float initialOffset;
	float nextOffset;
	
	float offset;
	float initOffset;
	
	vector2 initTouchPos;
	
	vector2 gradientSize;
	vector2 leftGradient;
	vector2 rightGradient;
	
	Timer@ transitionTimer = Timer(300);

	void create()
	{
		loadCharacters();
		circles.resize(0);
		
		
		
		float y = GetScreenSize().y * 0.2f;
		float x = 256 * GetScale();
		
		for(uint i=0;i<characters.length();i++)
		{
			circle@ newCirc = circle(characters[i], vector2(x * i,y));
			circles.insertLast(newCirc);
		}
	
		validCircleSize = vector2(256*GetScale(), 69420);
		
		circleSize = V2_256 / 2;
		arrSize = V2_256 * vector2(0.5f, 0.35f);
		arrPos = GetScreenSize() * vector2(0.5f, 0.3f);
		xTextPos = GetScreenSize() * vector2(0.5f, 0.1f);
		
		topY = y - circleSize.y * 2.0f;
		downY = y + circleSize.y * 1.1f;
		
		///preference
		offset = 0;
		
		transitionTo(PREF_CHAR);
		
		initOffset = GetScreenSize().x / 2;
		
		setSpriteOrigin("sprites/arrow_down.png", V2_HALF);
		setSpriteOrigin("sprites/gradient.png", vector2(0.5f, 0.0f));
		
		gradientSize = vector2(GetScreenSize().y * 0.3f, GetScreenSize().x * 0.2f);
		leftGradient = vector2(0.0f, GetScreenSize().y * 0.2f);
		rightGradient = vector2(GetScreenSize().x, GetScreenSize().y * 0.2f);
	}
	
	void update()
	{
	
		checkTouch();
	
		for(uint i=0;i<characters.length();i++)
		{
			circles[i].draw(vector2(offset + initOffset, 0), circleSize);
		}
		
		if(GetInputHandle().GetTouchState(0) != KS_DOWN)
		{
			//rollBack();
		}
		else if(!validTouch)
		{
			//rollBack();
		}
		
		DrawShapedSprite("sprites/arrow_down.png", arrPos, arrSize, mainColor, 180);
		
		DrawShapedSprite("sprites/gradient.png", leftGradient, gradientSize, backColor, 90);
		DrawShapedSprite("sprites/gradient.png", rightGradient, gradientSize, backColor, 270);
		
	
		if(offset > 0)offset = 0;
			float maxLen = -1.0f * (characters.length() - 1) * validCircleSize.x;
		if(offset < maxLen)
			offset = maxLen;
		
		
		float currentPos = offset - (int(offset / validCircleSize.x) * validCircleSize.x);
		currentSelected = abs((offset - (validCircleSize.x / 2)) / validCircleSize.x);
		
		
		string name = circles[currentSelected].spriteName;
		CURRENT_SPRITE_NAME = circles[currentSelected].nSpriteName;
		
		PREF_CHAR = uint(currentSelected);
		
		float xScale = 1.5f;
		
		vector2 textPos = xTextPos - (ComputeTextBoxSize("Verdana64.fnt", name) * xScale * GetScale() * 0.5f);
		
		
		DrawText(textPos, ""+name, "Verdana64.fnt", mainColor, GetScale() * xScale);
	}
	
	void rollBack()
	{
		float currentPos = offset - (int(offset / circleSize.x) * circleSize.x);
		
		
		if(abs(currentPos) > 10.0f && abs(currentPos - circleSize.x) > 10.0f)
		{
			int dir = currentPos > (circleSize.x / 2) ? -1 : 1;
			offset += UnitsPerSecond(200) * dir;
		}
	}
	
	void checkTouch()
	{
		KEY_STATE touchState = GetInputHandle().GetTouchState(0);
		vector2 touchPos = GetInputHandle().GetTouchPos(0);
		
		if(touchState == KS_HIT)
		{
			if(touchPos.y > topY.y && touchPos.y < downY.y)
			{
				validTouch = true;
				transitioning = false;
				touchTime = GetTime();
				initTouchPos = touchPos;
			}
		}
		
		if(touchState == KS_DOWN)
		{	
			if(validTouch)
				offset += GetInputHandle().GetTouchMove(0).x * GetScale();
				
			if(offset > 0)offset = 0;
			float maxLen = -1.0f * (characters.length() - 1) * validCircleSize.x;
			if(offset < maxLen)
			offset = maxLen;
		}
		
		if(touchState == KS_RELEASE)
		{
			if(validTouch)
			{
				if(GetTime() - touchTime < 150)
				{
					if(initTouchPos.x < GetScreenSize().x * 0.5f)
					{
						transitionTo(currentSelected - 1);
					}
					else
					{
						transitionTo(currentSelected + 1);
					}
				}
				else
				{
					int currentIdx = getCurrentCleanIdx();
					float lastOffset = getOffset(currentIdx);
					float nextOffset = getOffset(currentIdx+1);
					
					if(abs(offset - lastOffset) < abs(offset - nextOffset))
					{
						transitionTo(currentIdx);
					}
					else
					{
						transitionTo(currentIdx+1);
					}
				}
			}
		
			validTouch = false;
		}
		
		if(transitioning)
		{
			transitionTimer.update();
			offset = interpolate(initialOffset, nextOffset, transitionTimer.getBias());
		}
	}
	
	int getCurrentCleanIdx()
	{
		return abs(offset / validCircleSize.x);
	}
	
	float getOffset(int idx)
	{
		return idx * validCircleSize.x * -1;
	}
	
	void transitionTo(int idx)
	{
		if(idx > -1 && idx < int(characters.length()))
		{
			transitioning = true;
			transitionTimer.reset(300);
			initialOffset = offset;
			nextOffset = getOffset(idx);
		}
	}
	
	void goToTouchPos()
	{
		
	}
	
	
	void resume()
	{

	}

}


Selector g_selector;

class circle
{
	string spriteName;
	string nSpriteName;
	vector2 pos;
	float offsetHeight;
	vector2 hS;
	
	circle(string nm, vector2 p)
	{
		spriteName = nm;
		nSpriteName = getEntity(nm);
		pos = p;
		offsetHeight = 150.0f * GetScale();
		hS = GetScreenSize()/2;
	}
	
	void draw(vector2 offset, vector2 size)
	{
		vector2 finalPos = pos + offset;
		float sizeFix = getSize(finalPos.x / GetScreenSize().x);
		
		
		float offsetFix = graph17(abs(finalPos.x - hS.x)/hS.x) * offsetHeight;
		DrawShapedSprite(nSpriteName, finalPos - vector2(0, offsetFix), size * sizeFix, white);
	}
}


float lim = 0.4;

float graph17(float bias)
{
	return pow(bias, 3.0f);
	//return bias;
}

float getSize(float bias)
{
	if(bias < 0.3f || bias > 0.7f)
		return 1.0f;
	return ((1.0f - (abs(0.5f - bias) / 0.2f)) * 0.8f + 1.0f);
}

uint white = 0xFFFFFFFF;
uint orange = 0xFFFF8700;
uint mainColor = 0xFF2A99EE;

string[] characters = {"bear", "buffalo", "chick", "chicken", "cow", "crocodile", "dog", "duck", "elephant", "frog", "giraffe", "goat",
						"gorilla", "hippo", "horse", "monkey", "moose", "narwhal", "owl", "panda", "parrot", "penguin", "pig", "rabbit",
						"rhino", "sloth", "snake", "walrus", "whale", "zebra"};


string getEntity(string c)
{
	return "entities/"+c+".png";
}

void loadCharacters()
{
	for(uint i=0;i<characters.length();i++)
	{
		string q = getEntity(characters[i]);
		LoadSprite(q);
		SetSpriteOrigin(q, V2_HALF);
	}
}