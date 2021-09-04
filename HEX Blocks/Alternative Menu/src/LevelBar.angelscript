class LevelBar
{
	
	uint alpha,blackk,whitee,op;
	vector2 strokeSize, strokePos, fillSize2, fillPos, fillSize, levelTextPos;
	string level_string;
	uint CURRENT_LEVEL;
	float levelBias;
	
	void create()
	{
	
		CURRENT_LEVEL = scoreToLevel(CURRENT_TOTAL_XP);
		level_string = "LEVEL "+CURRENT_LEVEL;
		levelBias = float(CURRENT_TOTAL_XP-levelToScore(CURRENT_LEVEL))/float(levelToScore(CURRENT_LEVEL+1)-levelToScore(CURRENT_LEVEL));
		strokeSize = vector2(500,50)*GetScale();
		strokePos = vector2(SCREEN_SIZE_X2, 700*GetScale());
		levelTextPos = strokePos - (ComputeTextBoxSize(comforta30, level_string)/2*GetScale());
		fillPos = strokePos - vector2(243, 18)*GetScale();
		fillSize = vector2(0, 36)*GetScale();
		fillSize2 = vector2(486, 36)*GetScale();
		levelBias = 0.8;
		setSpriteOrigin("sprites/stroke.png", vector2(0.5, 0.5));
	}
	
	void draw(float bias, float m_scale, float offsetx, bool q)
	{
		vector2 offset = vector2(offsetx,0);
		
		if(q && abs(offsetx)>3)
			bias = offsetx/(150*GetScale());
		
		fillPos = strokePos - vector2(243, 18)*GetScale()*m_scale;
		fillSize = vector2(486*levelBias, 36)*GetScale();
		levelTextPos = strokePos - (ComputeTextBoxSize(comforta30, level_string)/2*GetScale()*m_scale);
	
	
		alpha = uint(255.0f*bias);
		blackk = ARGB(alpha, 0,0,0);
		whitee = ARGB(alpha, 255,255,255);
		op = ARGB(uint(100*float(alpha)/255),255,255,255);
		
		DrawShapedSprite("sprites/stroke.png", strokePos+offset, strokeSize*m_scale, blackk);
		DrawShapedSprite("sprites/grey.png", fillPos+offset, fillSize2*m_scale, op);
		DrawShapedSprite("sprites/grey.png", fillPos+offset, fillSize*m_scale, whitee);
		DrawText(levelTextPos+offset, level_string, comforta30, blackk, GetScale()*m_scale);
	}
}

LevelBar g_levelBar;