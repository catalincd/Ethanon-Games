class RankLayer
{
	
	InterpolationTimer@ fadeTimer = InterpolationTimer(300);
	InterpolationTimer@ slowTimer = InterpolationTimer(500);
	TextButton@ back_button;
	bool enabled = false;
	bool fadingOut = false;
	vector2 gradientPos;
	vector2 gradientSize;
	vector2 overlayPos;
	vector2 overlaySize;
	float currentOffset = 0;
	float limitBottom;
	float limitTop;
	float lastTouchMove;
	bool resuming = false;

	RankElement[] elements;

	void create()
	{
		enabled = false;
		fadingOut = false;
		initElements();
	}
	
	float minSize = 0.8;
	float maxSize = 1.2;
	
	float getScaleByPos(float yPos)
	{
		float bias = yPos / GetScreenSize().y;
		
		if(bias < 0.25f)
			return interpolate(minSize, maxSize, bias * 4.0f);
		
		if(bias > 0.70f)
			return interpolate(maxSize, minSize, (bias - 0.70f) * 4.0f);
	
		return maxSize;
	}
	
	void initElements()
	{
		elements.resize(0);

		elementSize = V2_200;
		textOffset = PX_100 * 1.5;
		vector2 initRankPos = vector2(SS_50.x, SS_75.y);
		float yOffset = GetScreenSize().y / 3;
		gradientSize = vector2(GetScreenSize().x, GetScreenSize().y*0.1f);
		gradientPos = vector2(GetScreenSize().x, GetScreenSize().y*0.9f);
		overlayPos = vector2(0, GetScreenSize().y*0.9f);
		overlaySize = vector2(GetScreenSize().x, GetScreenSize().y*0.1f);
		
		limitBottom = yOffset / 2;
		limitTop = 13.75 * yOffset;
		currentOffset = interpolate(limitBottom, limitTop, getRankBias());
		
		for(uint i=1;i<16;i++)
		{
			string sprite = g_rank.getSpriteFromRank(i);
			string name = getRankName(i);
			vector2 pos = initRankPos - vector2(0, i * yOffset);
			RankElement new = RankElement(sprite,name,i,pos, 1.25);
			elements.insertLast(new);
		}
		
		@back_button = TextButton(vector2(GetScreenSize().x/2, GetScreenSize().y*0.95), "BACK", text128, black, true);
	}
	
	void enable()
	{
		enabled = true;
		fadingOut = false;
		fadeTimer.reset(300);
		initElements();
	}
	
	void update()
	{
		
		if(enabled)
		{
			fadeTimer.update();
			
			updateOffset();
			
			
			float bias = fadeTimer.getUnfilteredBias();
			bias = fadingOut? 1.0f - bias : bias;
			draw(bias);
			back_button.update();
			if(back_button.isPressed() && !fadingOut)
			{
				back_button.setPressed(false);
				fadingOut = true;
				fadeTimer.reset(300);
			}	
			if(fadingOut)
			{
				if(fadeTimer.isOver())
					enabled = false;
			}
		}	
		
		
	}
	
	void updateOffset()
	{
		ETHInput@ input = GetInputHandle();
		
		KEY_STATE touchState = input.GetTouchState(0);
		if(touchState == KS_HIT)
		{
			slowTimer.reset(400);
			resuming = false;
		}
		if(touchState == KS_DOWN)
		{
			lastTouchMove = GetInputHandle().GetTouchMove(0).y * GetScale();
			currentOffset += lastTouchMove;
		}
		if(touchState == KS_RELEASE)
		{
			resuming = true;
		}
		
		if(resuming)
		{
			slowTimer.update();
			currentOffset += interpolate(lastTouchMove, 0, slowTimer.getBias());
			
			if(slowTimer.isOver())
				resuming = false;
		}
		
		if(currentOffset < limitBottom)
				currentOffset = limitBottom;
			if(currentOffset > limitTop)
				currentOffset = limitTop;
	}
	
	void draw(float bias)
	{
		uint op = bias * 255.0f;
		uint thisWhite = ARGB(op, 255,255,255);
		uint thisAQUA_BLUE = ARGB(op, 28, 134, 242);
		uint thisRED = ARGB(op, 255, 0, 0);
		
		DrawShapedSprite("sprites/square.png", V2_ZERO, GetScreenSize(), thisWhite);
		
		for(uint i=0;i<elements.length();i++)
		{
			elements[i].draw(currentOffset, thisWhite, thisAQUA_BLUE, thisRED);
		}
		
		DrawShapedSprite("sprites/gradient.png", V2_ZERO, gradientSize, white);
		DrawShapedSprite("sprites/gradient.png", gradientPos, gradientSize, white, 180);
		DrawShapedSprite("sprites/square.png", overlayPos, overlaySize, white, 0);
		//DrawText(V2_ZERO, ""+(currentOffset / GetScale()), sans64, black, 0.5);
	}

	

}

vector2 elementOrigin = vector2(0.5f, 0.75f);
vector2 elementSize = V2_200;
vector2 expOrigin = vector2(0.0f, 0.5f);
vector2 durOrigin = vector2(1.0f, 0.5f);
float textOffset = PX_100;

class RankElement
{
	string sprite;
	string name;
	vector2 pos;
	float scale;
	uint id;
	
	RankElement(){}
	RankElement(string spr, string nm, uint i, vector2 p, float s = 1.0f)
	{
		sprite = spr;
		name = nm;
		pos = p;
		id = i;
		scale = s;
	}
	
	void draw(float yOffset, uint color = white, uint textColor = AQUA_BLUE, uint textRed = red)
	{
		vector2 relPos = pos + vector2(0, yOffset);
		vector2 textPos = relPos + vector2(0,textOffset * scale);
		scale = g_rankLayer.getScaleByPos(relPos.y);
		//DrawShapedSprite(sprite, relPos, elementSize, color);
		g_rank.DrawRankOp(id, relPos, elementSize * scale, V2_HALF, color, textColor);
		DrawText(name, sans128, textPos, textColor, V2_HALF, 0.6 * scale);
		
		uint expN = (id-1) * 200;
		string expStr = "EXP "+AssembleColorCode(black)+"\n"+expN;
		vector2 expPos = relPos + vector2(PX_128 * scale,0);
		DrawText(expStr, sans128, expPos, textRed, expOrigin, 0.6 * scale);
		
		
		string durStr = getMissionDurationString(id);
		vector2 durPos = relPos - vector2(PX_128 * scale,0);
		DrawText(durStr, sans128, durPos, textRed, durOrigin, 0.6 * scale);
	}
}

RankLayer g_rankLayer;