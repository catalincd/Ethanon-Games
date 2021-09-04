class UIBar : GameObject
{

	vector2 textPos;
	vector2 textPosRight;
	vector2 bulletPos;
	vector2 bulletTextPos;
	vector2 spriteSizes;
	vector2 gradientPos;
	vector2 bulletSize;
	vector2 fadePos;
	vector2 bpsPos;
	vector2 bpsTextPos;
	vector2 hpPos;
	vector2 hpTextPos;
	vector2 expPos;
	vector2 rewardPos;
	float timeScaleBias = 0;

	void create()
	{
		textPos = vector2(24,24) * GetScale();
		bulletTextPos = vector2(GetScreenSize().x - textPos.x*2.5f, textPos.y);
		fadePos = bulletTextPos - vector2(PX_128, 0);
		bulletPos = vector2(GetScreenSize().x+PX_5, -PX_2);
		spriteSizes = vector2(GetScreenSize().x, PX_48 * 2);
		gradientPos = vector2(0, spriteSizes.y);
		textPosRight = bulletTextPos - vector2(PX_256,0);
		bpsPos = vector2(PX_64, textPos.y + PX_32);
		bpsTextPos = bpsPos + vector2(PX_48, 0);
		
		hpPos = vector2(PX_220, textPos.y + PX_32);
		hpTextPos = hpPos + vector2(PX_48, 0);
		
		expPos = vector2(hpPos.x + PX_200 + PX_10,hpPos.y);
		
		rewardPos = vector2(SS_50.x, PX_32 + PX_15);
		//textPosRight = vector2(GetScreenSize().x/2, bulletTextPos.y);
	}

	void setBias()
	{
		timeScaleBias = 1.0f;
	}

	
	void update()
	{
		timeScaleBias -= UnitsPerSecond(2.0f);
		timeScaleBias = max(min(1.0f, timeScaleBias), 0.0f);
	
		if(GetInputHandle().GetKeyState(K_G)==KS_HIT)setBias();
		
		DrawSprites();
		DrawText(""+g_gameSuccess.getTimeString(), text64, textPosRight, interpolateColor(AQUA_BLUE, red, timeScaleBias * 0.8), vector2(1.0f, 0.0f), interpolate(1.0f, 1.5f, timeScaleBias));
		DrawText(g_bulletPoint.getBulletString(), text64, bulletTextPos, AQUA_BLUE, vector2(1.0f, 0.0f), g_bulletPoint.getTextScale());
		DrawShapedSprite("sprites/bullet_spr.png", bulletPos, V2_96*g_bulletPoint.getTextScale(), white);
		//DrawGauge(bpsPos, 0.3, 0.4);
		g_bps.draw(bpsPos);
		g_bps.drawText(bpsTextPos);
		
		g_hp.draw(hpPos);
		g_hp.drawText(hpTextPos);
		//DrawRank(7, vector2(SS_50.x, hpPos.y), 80*GetScale());
		g_exp.Draw(expPos, 0.4);
		
		
		DrawFundsVertical(getReward(), rewardPos, 0.35f);
		
	}
	
	void drawFadingText(int dec)
	{
		string decr = ""+dec+" ";
		DrawFadingText(750, decr, text64, fadePos, red, vector2(1.0f, 0.0f), 1.0f);
	}

	void resume()
	{

	}

	void DrawSprites()
	{
		DrawShapedSprite("sprites/square.png", V2_ZERO, spriteSizes, white);
		DrawShapedSprite("sprites/gradient.png", gradientPos, spriteSizes, white);
	}

	string getTag(){ return "BulletPoint";}

}

UIBar g_uiBar;