class ExperienceManager : GameObject
{
	uint currentEXP;
	uint lastGameExp;
	bool ended = false;
	
	void init()
	{
		g_dataManager.loadExp();
		currentEXP = 0;
		lastGameExp = 0;
		ended = false;
	}	
	
	uint getLastGameExp()
	{
		return lastGameExp;
	}

	void create()
	{
		currentEXP = 0;
		lastGameExp = 0;
		ended = false;
	}
	
	void update()
	{
		if(!ended)
			lastGameExp = currentEXP;
	}
	
	void Draw(vector2 pos, float scale = 1.0f, uint color = AQUA_BLUE)
	{
		DrawRank(getRank(), pos, V2_200*scale, vector2(1.0f, 0.5f));
		DrawText(getString(), text128, pos, red, vector2(0.0f, 0.0f), 0.625 * scale);
		DrawText("  "+getLastGameExp(), text128, pos, color, vector2(0.0f, 1.0f), 0.625 * scale);
	}
	
	void DrawMainMenu2(vector2 pos, float scale = 1.0f, uint color = AQUA_BLUE)
	{
		uint rank = getRank();
		DrawRank(rank, pos, V2_200*scale, vector2(0.0f, 1.0f));
		vector2 textPos = pos + vector2(0, PX_100);
		vector2 fundsPos = pos + vector2(0, PX_220);
		DrawText(getStringMenu(), sans128, textPos, red, vector2(0.0f, 0.0f), 0.625 * scale);
		string str = ""+getRankName(rank)+" ("+AssembleColorCode(black)+rank+AssembleColorCode(white)+"/15)";
		DrawText(str, sans128, textPos, color, vector2(0.0f, 1.0f), 0.625 * scale);
		DrawFundsMenu(FUNDS, fundsPos, 0.625f, 0.5f);
	}
	
	void DrawMainMenu(vector2 pos, float scale = 1.0f, uint color = AQUA_BLUE)
	{
		uint rank = getRank();
		DrawRank(rank, pos, V2_200*scale, vector2(0.5f, 1.0f));
		vector2 textPos = pos + vector2(0, PX_100);
		vector2 fundsPos = pos + vector2(0, PX_220);
		DrawText(getStringMenu(), sans128, textPos, red, vector2(0.5f, 0.0f), 0.625 * scale);
		string str = ""+getRankName(rank)+" ("+AssembleColorCode(black)+rank+AssembleColorCode(white)+"/15)";
		DrawText(str, sans128, textPos, color, vector2(0.5f, 1.0f), 0.625 * scale);
		DrawFundsOrigin(""+FUNDS+" ", fundsPos, 0.625f, V2_HALF);
	}
	
	void resume()
	{

	}
	
	string getString()
	{
		return ("  " + getExp());
	}
	
	string getStringMenu()
	{
		return ("EXP "+AssembleColorCode(black)+getMenuExp()+AssembleColorCode(white)+ getFinalString());
	}
	
	string getFinalString()
	{
		return getRank() > 14? "" : "/200";
	}
	
	uint getMenuExp()
	{
		return getRank() > 14? EXP - 2600 : getExp();
	}
	
	uint getExp()
	{
		return currentEXP + getActualExp();
	}
	
	void add(uint i)
	{
		currentEXP += i;
	}
	
	void save()
	{
		uint rankNow = getRank();
		EXP += currentEXP;
		uint newRank = getRank();
		
		if(newRank != rankNow)
			RANK_UP = true;
			
		g_dataManager.saveRankup();
		
		currentEXP = 0;
		g_dataManager.saveExp();
		ended = true;
	}
	
	uint getRank()
	{
		return getRank(EXP);
	}
	
	uint getActualExp()
	{
		return EXP % 200;
	}
	
	uint getRank(uint q)
	{
		return min((q / 200) + 1, 15);
	}

	string getTag(){ return "EXP"; }
}

uint getRank()
{
	return g_exp.getRank();
}

ExperienceManager g_exp;