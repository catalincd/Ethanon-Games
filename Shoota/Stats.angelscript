class Stats
{
	vector2 topLeft;
	vector2 sizeLine;
	vector2 sizeSprite;
	vector2 spritePos;
	vector2 spriteSize;
	vector2 buyTextPos;
	vector2 buyPos;
	vector2 buyTopPos;
	vector2 buySize;
	
	float xTextLeft;
	float xTextRight;
	float xFundsLeft;
	
	float yTextUp;
	float yTextTop;
	float yTextBottom;
	float yTextMid;
	
	void create()
	{
		topLeft = vector2(0, SS_75.y);
		sizeLine = vector2(GetScreenSize().x, PX_10);
		sizeSprite = vector2(GetScreenSize().x, SS_25.y);
		
		spritePos = vector2(PX_200, GetScreenSize().y * 0.875f);
		spriteSize = V2_200 * 1.5;
		
		xTextLeft = GetScreenSize().x - PX_150;
		xFundsLeft = GetScreenSize().x - PX_150 - (PX_100 * 0.75);
		xTextRight = SS_50.x * 0.8;
		
		buyPos = vector2(GetScreenSize().x, SS_75.y);
		buySize = vector2(275, 80) * GetScale();
		buyTopPos = buyPos - buySize;
		buyTextPos = buyPos - (vector2(PX_32 * 1.35, -PX_10 * 0.8));
		
		yTextUp = GetScreenSize().y * 0.80f;
		yTextTop = GetScreenSize().y * 0.850f;
		yTextMid = GetScreenSize().y * 0.900f;
		yTextBottom = GetScreenSize().y * 0.950f;
		
	}
	
	
	void draw(Item@ item, bool owned, bool main)
	{
		DrawShapedSprite("sprites/square.png", topLeft, sizeSprite, LIGHT_GREY);
		DrawShapedSprite("sprites/square.png", topLeft, sizeLine, owned? DEEP_ORANGE : AQUA_BLUE);
		
		DrawShapedSprite(item.name, spritePos, spriteSize, white);
		
		if(owned)
			drawOwned(item, main);
		else
			drawBuy(item, main);
	}
	
	
	void drawOwned(Item@ item, bool main)
	{
		//HP
		DrawText("HP", sans64, vector2(xTextRight, yTextTop), green, vector2(0.0f, 0.5f), 1.0f);
		DrawText(""+getHP(item), sans64, vector2(xTextLeft, yTextTop), red, vector2(1.0f, 0.5f), 1.0f);
		
		//DAMAGE
		DrawText("DAMAGE", sans64, vector2(xTextRight, yTextMid), green, vector2(0.0f, 0.5f), 1.0f);
		DrawText(""+getDamage(item), sans64, vector2(xTextLeft, yTextMid), red, vector2(1.0f, 0.5f), 1.0f);
		
		//DAMAGE DEALT
		
		
		//FIRERATE
		if(!main)
		{
			DrawText("FIRE RATE", sans64, vector2(xTextRight, yTextBottom), green, vector2(0.0f, 0.5f), 1.0f);
			DrawText(""+getFireRate(item)+" RPM", sans64, vector2(xTextLeft, yTextBottom), red, vector2(1.0f, 0.5f), 1.0f);
		}
	}
	
	void drawBuy(Item@ item, bool main)
	{
		//HP
		DrawText("HP", sans64, vector2(xTextRight, yTextTop), green, vector2(0.0f, 0.5f), 1.0f);
		DrawText(""+getHP(item), sans64, vector2(xTextLeft, yTextTop), red, vector2(1.0f, 0.5f), 1.0f);
		
		//DAMAGE
		DrawText("DAMAGE", sans64, vector2(xTextRight, yTextMid), green, vector2(0.0f, 0.5f), 1.0f);
		DrawText(""+getDamage(item), sans64, vector2(xTextLeft, yTextMid), red, vector2(1.0f, 0.5f), 1.0f);
		
		//COST
		DrawText("COST", sans64, vector2(xTextRight, yTextUp), green, vector2(0.0f, 0.5f), 1.0f);
		uint fundsColor = afford(item.costPlaying)? AQUA_BLUE : black;
		DrawFunds(item.costPlaying, vector2(xFundsLeft, yTextUp), 0.5f, 0.5f, fundsColor);
		
		//FIRERATE
		if(!main)
		{
			DrawText("FIRE RATE", sans64, vector2(xTextRight, yTextBottom), green, vector2(0.0f, 0.5f), 1.0f);
			DrawText(""+getFireRate(item)+" RPM", sans64, vector2(xTextLeft, yTextBottom), red, vector2(1.0f, 0.5f), 1.0f);
		}
		if(afford(item.costPlaying))
			drawBuyButton(item);
	}
	
	
	void drawBuyButton(Item@ itm)
	{
		DrawShapedSprite("sprites/buy.png", buyPos, buySize, white);
		DrawText("BUY", sans128, buyTextPos, DEEP_ORANGE, V2_ONE, 0.75);
		if(GetInputHandle().GetTouchState(0) == KS_HIT)
		{
			vector2 touchPos = GetInputHandle().GetTouchPos(0);
			if(isPointInRect(touchPos, buyTopPos, buyPos))
			{
				g_market.buy();
			}
		}
	}
}


Stats g_stats;

void drawStats(uint t, bool owned, bool main)
{
	if(t != 999)
	{
		g_stats.draw(getItem(t+1), owned, main);
	}
}