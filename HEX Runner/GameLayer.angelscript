class GameLayer : GameObject
{

	vector2 m_overlaySpriteSize;
	vector2 scorePosition;
	vector2 timePosition;
	vector2 barSize;
	vector2 barPos;
	vector2 contourPos;
	vector2 coinPos;
	vector2 coinTextPos;
	vector2 contourSize;
	float opacity = 0;
	float BIAS = 0.5;
	vector2 tenPx = 10;
	vector2 blockSize = 10;
	vector2 spriteSize = 32;
	vector2 spritePos = 32;
	

	string getTag()
	{
		return "GameLayer";
	}
	
	void create()
	{
		m_overlaySpriteSize = vector2(720, 100) * GetScale();
		SetSpriteOrigin("sprites/overlay_bottom.png", V2_ONE);
		
		scorePosition = vector2(15,15) * GetScale();
		spriteSize = vector2(24,24) * GetScale();
		timePosition = vector2(GetScreenSize().x - scorePosition.x, scorePosition.y); 
		
		barSize = vector2(GetScreenSize().x/2-10*GetScale(), 20*GetScale());
		contourPos = vector2(GetScreenSize().x/4, 15*GetScale());
		barPos = contourPos + vector2(5,5)*GetScale();
		contourSize = vector2(360, 30) * GetScale();
		opacity = 0;
		
		spritePos = GetScreenSize() - scorePosition;
		
		tenPx = vector2(0, -15) * GetScale();
		blockSize = 20 * GetScale();
		
		coinPos = vector2(scorePosition.x,GetScreenSize().y - scorePosition.y);
		coinTextPos = coinPos + vector2(32.5*GetScale(),0);
		coinPos -= vector2(0, 15*GetScale());
	}
	
	void update()
	{
		
	
		DrawShapedSprite("sprites/overlay_top.png", V2_ZERO, m_overlaySpriteSize, GetBackgroundColor());
		DrawShapedSprite("sprites/overlay_bottom.png", GetScreenSize(), m_overlaySpriteSize, GetBackgroundColor());
		
		//score
		uint score = GetScore();
		DrawText(scorePosition, ""+score, "Verdana30.fnt", COLOR_WHITE, GetScale());
		//time
		string time = g_timer.getTimeString();
		DrawText(time, "Verdana30.fnt", timePosition, vector2(1,0));
		//coins
		DrawText(""+BOOST_COINS, "Verdana30.fnt", coinTextPos, vector2(0,1));
		DrawShapedSprite("sprites/square.png", coinPos, blockSize, GetColorFromIdx(CURRENT_COLOR), 45);
		//
		
		DrawShapedSprite("sprites/pause.png", spritePos, spriteSize, white);
		if(BIAS > 0)
			opacity += UnitsPerSecond(2.0f);
		else
			opacity -= UnitsPerSecond(2.0f);
			
			
		opacity = max(0, min(opacity, 1));
		
		uint color = ARGB(uint(255.0f * opacity),255,255,255);
		vector2 actualBarSize = vector2(barSize.x * BIAS, barSize.y);
		
		//DrawShapedSprite("sprites/square.png", barPos, actualBarSize, color);
		//DrawShapedSprite("sprites/contour.png", contourPos, contourSize, color);
		//DrawShapedSprite("sprites/contour.png", barPos, contourSize, color);
		
	}
	
	void resume()
	{
	
	}
}

GameLayer g_gameLayer;