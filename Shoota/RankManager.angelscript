class RankManager
{
	uint currentExp;
	string[] ranks;
	
	void getRankup()
	{
		
	}
	
	void saveRankup()
	{
		
	}
	
	void loadSprites()
	{
		fillRanks();
		for(uint i=1;i<16;i++)
		{
			string spr = getSpriteFromRank(i);
			LoadSprite(spr);
			SetSpriteOrigin(spr, V2_ZERO);
		}
	}
	
	void fillRanks()
	{
		ranks.resize(0);
		for(uint i=0;i<16;i++)
			ranks.insertLast("sprites/ranks/rank"+i+".png");
	}
	
	string getSpriteFromRank(uint i)
	{
		return ranks[i];
	}
	
	void DrawRank(uint id, vector2 pos, vector2 size, vector2 origin = V2_HALF)
	{
		
		vector2 relSquarePos = pos - size * origin;
		vector2 rankSize = size * 0.8;
		
		vector2 rankPos = relSquarePos + size*0.1f;
		
		DrawShapedSprite("sprites/square.png", relSquarePos, size, AQUA_BLUE);
		DrawShapedSprite(getSpriteFromRank(id), rankPos, rankSize, white);
	}
	
	void DrawRankOp(uint id, vector2 pos, vector2 size, vector2 origin = V2_HALF, uint wt = white, uint aq = AQUA_BLUE)
	{
		
		vector2 relSquarePos = pos - size * origin;
		vector2 rankSize = size * 0.8;
		
		vector2 rankPos = relSquarePos + size*0.1f;
		
		DrawShapedSprite("sprites/square.png", relSquarePos, size, aq);
		DrawShapedSprite(getSpriteFromRank(id), rankPos, rankSize, wt);
	}
}

uint getRankTier(uint rank)
{
	if(rank < 7) return 1;
	if(rank < 10) return 2;
	if(rank < 13) return 3;
	if(rank < 16) return 4;
	
	return 1;
}

float getMissionBias(uint rank)
{
	if(rank == 1) return 1.0f;
	if(rank == 2) return 1.5f;
	if(rank == 3) return 2.0f;
	if(rank == 4) return 2.5f;

	return 1.0f;
}

string getRankName(uint rank)
{
	if(rank == 2) return "Corporal";
	if(rank == 3) return "Sergeant";
	if(rank == 4) return "Staff Sergeant";
	if(rank == 5) return "Master Sergeant";
	if(rank == 6) return "Warrant Officer";
	if(rank == 7) return "Second Lieutenant";
	if(rank == 8) return "First Lieutenant";
	if(rank == 9) return "Captain";
	if(rank == 10) return "Major";
	if(rank == 11) return "Lieutenant Colonel";
	if(rank == 12) return "Colonel";
	if(rank == 13) return "Brigadier";
	if(rank == 14) return "General";
	if(rank == 15) return "Marshall";
	
	return "Private";
}

uint getMissionDuration(uint rank)
{
	return MINUTE * getMissionBias(getRankTier(rank));
}

string getMissionDurationString(uint rank)
{
	return g_timer.getTimeString(getMissionDuration(rank));
}

float getRankBias()
{
	return (float(getRank()) / 15.0f);
}


void DrawRank(uint id, vector2 pos, vector2 size, vector2 origin = V2_HALF)
{
	g_rank.DrawRank(id, pos, size, origin);
}

RankManager g_rank;