class ScoreManager
{
	uint currentScore = 0;
	uint highScore = 0;


	void draw()
	{
		if(currentScore != 0)
		{
			DrawText("SCORE: "+currentScore, "Verdana64.fnt", GetScreenSize() * vector2(0.5f, 0.55f), mainColor);
		}
		
		if(highScore != 0)
		{
			DrawText("HIGHSCORE: "+highScore, "Verdana64.fnt", GetScreenSize() * vector2(0.5f, 0.625f), mainColor);
		}	
	}
	
	void addNewScore(uint new)
	{
		currentScore = new;
		if(highScore < currentScore)
		{
			highScore = currentScore;
			save();
		}
	}
	
	void load()
	{
		highScore = parseUInt(dataBase.get("highScore"));
	}
	
	void save()
	{
		dataBase.set("highScore", ""+highScore);
		dataBase.save();
	}
}


ScoreManager scoreManager;



void DrawText(string text, string font, vector2 pos, vector2 size, uint color = white, vector2 origin = V2_HALF, float scale = 1.0f, float angle = 0.0f)
{
	vector2 nSize = size * scale;
	vector2 relPos = pos - (nSize * origin);
	DrawText(relPos, text, font, color, scale);
}

void DrawText(string text, string font, vector2 pos, uint color = white, vector2 origin = V2_HALF, float scale = 1.0f)
{
	float newScale = scale * GetScale();
	vector2 size = ComputeTextBoxSize(font, text) * newScale;
	vector2 relPos = pos - (size * origin);
	DrawText(relPos, text, font, color, newScale);
}