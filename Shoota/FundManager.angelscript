class FundManager
{

	void init()
	{
		loadFunds();
	}

	void saveFunds()
	{
		g_dataManager.saveFunds();
	}
	
	void loadFunds()
	{
		g_dataManager.loadFunds();
	}
	
	void addRankup(uint reward)
	{
		FUNDS += reward;
		saveFunds();
	}
	
	void addSave(uint reward = 0)
	{
		FUNDS += reward;
		FUNDS += getMissionReward(getRank());
		saveFunds();
	}
	
	void buy(uint cost)
	{
		FUNDS -= cost;
		saveFunds();
	}
	
	bool afford(uint cost)
	{
		return cost <= FUNDS;
	}
}

void buyItem(uint cost)
{
	g_fundManager.buy(cost);
}

bool afford(uint cost)
{
	return g_fundManager.afford(cost);
}


uint FUNDS = 0;

FundManager g_fundManager;




uint getMissionReward(uint rank)
{
	return (100 * getRankTier(rank)) + (rank-1) * 50;
}


void DrawFunds(uint num, vector2 pos, float scale = 1.0f, float yOrigin = 0.0f, uint textColor = green, uint wt = white)
{
	DrawText(""+num+" ", sans128, pos, textColor, vector2(1.0f, yOrigin), scale);
	SetSpriteOrigin("sprites/bill.png", vector2(0.0f, yOrigin));
	DrawShapedSprite("sprites/bill.png", pos, BILL * scale, wt);
}

void DrawFundsMenu(uint num, vector2 pos, float scale = 1.0f, float yOrigin = 0.0f, uint textColor = green, uint wt = white)
{
	vector2 size = DrawSizeText(""+num+" ", sans128, pos, textColor, vector2(0.0f, yOrigin), scale);
	vector2 billPos = vector2(pos.x + size.x + PX_5,pos.y);
	SetSpriteOrigin("sprites/bill.png", vector2(0.0f, yOrigin));
	DrawShapedSprite("sprites/bill.png", billPos, BILL * scale, wt);
}

void DrawFunds(string str, vector2 pos, float scale = 1.0f, float yOrigin = 0.0f, uint textColor = green)
{
	DrawText(str, sans128, pos, textColor, vector2(1.0f, yOrigin), scale);
	SetSpriteOrigin("sprites/bill.png", vector2(0.0f, yOrigin));
	DrawShapedSprite("sprites/bill.png", pos, BILL * scale, white);
}

void DrawFundsVertical(uint num, vector2 pos, float scale = 1.0f, uint textColor = green)
{
	DrawText(""+num+" ", sans128, pos, textColor, vector2(0.0f, 0.0f), scale);
	SetSpriteOrigin("sprites/bill.png", vector2(0.0f, 1.0f));
	DrawShapedSprite("sprites/bill.png", pos, BILL * scale, white);
}

void DrawFundsOrigin(string str, vector2 pos, float scale = 1.0f, vector2 origin = V2_HALF, uint textColor = green)
{
	vector2 textSize = ComputeTextBoxSize(sans128, str) * scale * GetScale();
	vector2 spriteSize = BILL * scale;
	
	float totalSizeX = (textSize.x + spriteSize.x) * origin.x;
	
	vector2 relPos = vector2(pos.x + (textSize.x - totalSizeX), pos.y);

	DrawText(str, sans128, relPos, textColor, vector2(1.0f, origin.y), scale);
	SetSpriteOrigin("sprites/bill.png", vector2(0.0f, origin.y));
	DrawShapedSprite("sprites/bill.png", relPos, BILL * scale, white);
}
