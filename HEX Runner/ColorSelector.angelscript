class ColorWheel : Wheel
{
	

	void onCreate()
	{
		angle = 180 + 45*CURRENT_COLOR;
		blocks.resize(0);
		for(uint i=0;i<6;i++)
		{
			ColorBlock new = ColorBlock(i);
			blocks.insertLast(new);
		}
		blocks.insertLast(ColorBlock(6, "entities/block_64.png"));
		blocks.insertLast(ColorBlock(7, "entities/block_64.png"));
		
		for(uint i=0;i<8;i++)
		{
			if(i>UNLOCKED_COLORS)
				blocks[i].locked = true;
		}
		
		uint newColor = getAtualColor();
		if(newColor != 21)
			CURRENT_COLOR = newColor;
			
		
	}
	
	uint getAtualColor()
	{
		uint item = getItemIdx();
		if(blocks[item].locked)
			return 21;
		return item;
	}
	
	void onUpdate()
	{
		uint newColor = getAtualColor();
		if(newColor != 21)
			CURRENT_COLOR = newColor;
			
		ARROW_COLOR = GetColorFromIdx(CURRENT_COLOR);
		for(uint t=0;t<blocks.length();t++)
		{
			blocks[t].color = GetColorFromIdx(t);
		}
	}
}

ColorWheel g_colorWheel;



class OverlayWheel : Wheel
{

	uint lastItem;
	float yBuyPos;
	float textPosX;
	float buyPosX;
	TextButton@ buy;
	bool ownedCurrent = true;
	vector2 blockSize;
	vector2 blockPos;
	vector2 coinPos;

	void onCreate()
	{
		locking = true;
		
		lastItemUnlocked = UNLOCKED_OVERLAYS;
		angleOffset = 60;
		angle = 180 + angleOffset*CURRENT_OVERLAY;
		blocks.resize(0);
		blocks.insertLast(ColorBlock(0, "entities/block_64.png", 60));
		blocks.insertLast(ColorBlock(1, "sprites/overlays/broken_cube.png", 60));
		blocks.insertLast(ColorBlock(2, "sprites/overlays/wolverine_cube.png", 60));
		blocks.insertLast(ColorBlock(3, "sprites/overlays/stripe_cube.png", 60));
		blocks.insertLast(ColorBlock(4, "sprites/overlays/star_cube.png", 60));
		blocks.insertLast(ColorBlock(5, "sprites/overlays/crybaby_cube.png", 60));
		
		if(RATIO)
		yBuyPos = GetScreenSize().y * 0.20;
		else
		yBuyPos = GetScreenSize().y * 0.88;
		textPosX = 120 * GetScale();
		buyPosX = 600 * GetScale();
		lastItem = getItemIdx();
		
		@buy = TextButton(vector2(buyPosX ,yBuyPos), "BUY", "Verdana64.fnt", GetColorFromIdx(CURRENT_COLOR), vector2(1.0f, 0.5f));
		buy.setScale(0.6f);
		
		execNewItem();
		
		blockSize = 45 * GetScale() * 0.42f;
		blockPos = vector2(120*GetScale(), GetScreenSize().y * 0.6f - 384*GetScale());
		coinPos = vector2(150*GetScale(), GetScreenSize().y * 0.6f - 384*GetScale());
	}
	
	string getOverlay()
	{
		return GetOverlayNameFromIdx(getItemIdx());
	}
	
	void onUpdate()
	{
		uint item = getItemIdx();
		
		ARROW_COLOR = white;
		
		
		if(item != lastItem)
		{
			lastItem = item;
			execNewItem();
		}
		drawItemShopping();
		
	}
	
	void execNewItem()
	{
		ownedCurrent = g_overlay.ownedItem(lastItem);
		if(ownedCurrent)
			CURRENT_OVERLAY = lastItem;
	}
	
	void drawItemShopping()
	{
		vector2 textPos = vector2(textPosX,yBuyPos);
		uint col = GetColorFromIdx(CURRENT_COLOR);
		
		DrawShapedSprite("sprites/square.png", blockPos, blockSize, GetColorFromIdx(CURRENT_COLOR), 45);
		DrawText(""+TOTAL_BOOST_COINS, "Verdana64.fnt", coinPos, vector2(0.0f, 0.5f), col, 0.6f);
		
		
		if(ownedCurrent)
		{
			DrawText("AVAILABLE", "Verdana64.fnt", textPos, vector2(0.0f, 0.5f), col, 0.6f);
		}
		else
		{
			DrawText("COST: "+getOverlayCost(lastItem), "Verdana64.fnt", textPos, vector2(0.0f, 0.5f), col, 0.6f);
			if(afford(lastItem))
			{
				buy.setColor(col);
				buy.update();
				if(buy.isPressed())
				{
					g_overlay.buy(lastItem);
					buy.setPressed(false);
					execNewItem();
				}
			}
		}
	
	}
}

OverlayWheel g_overlayWheel;




float getAngledScale(float angle)
{
	//if(true)return 1;

	while(angle > 360) angle %= 360;
	while(angle < 0) angle += 360;

	if(angle < 135.0f || angle > 225.0f) return 1.0f;
	
	return 1 + 0.5*((45.0f-abs(180.0f-angle))/45.0f);
}



