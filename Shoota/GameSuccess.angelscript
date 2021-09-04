class GameSuccess : GameObject
{
	InterpolationTimer@ mainTimer = InterpolationTimer(5000); 
	InterpolationTimer@ backTimer = InterpolationTimer(750); 
	InterpolationTimer@ textTimer = InterpolationTimer(750); 
	
	uint gameSuccessTime;
	uint target;
	uint lastSec = 12;
	uint enemies = 0;
	vector2 textPos = 0;
	uint damage = 0;
	uint reward = 0;
	bool exploded = false;
	EndText@[] texts;

	void create()
	{
		target = MINUTE * getMissionBias(getRankTier(getRank()));
		gameSuccessTime = 0;
		mainTimer.reset(7500);
		backTimer.reset(1250);
		textTimer.reset(750);
		exploded = false;
		enemies = 0;
		damage = 0;
		reward = 0;
	}
	
	void incEnemies()
	{
		enemies++;
	}
	
	void incReward(uint rew)
	{
		reward += rew;
	}
	
	void incDamage(uint dmg)
	{
		damage += dmg;
	}
	
	uint getReward()
	{
		return reward;
	}
	
	void initTexts()
	{
		textPos = vector2(SS_50.x, SS_25.y);
	
		texts.resize(0);
		texts.insertLast(EndText("+"+g_exp.getLastGameExp()+" EXP", vector2(SS_25.x,SS_50.y + PX_128), green, 500));
		texts.insertLast(EndText(" "+enemies+" ENEMIES DESTROYED", vector2(SS_25.x,SS_50.y + PX_192), green, 700));
		texts.insertLast(EndText(" "+damage+" DAMAGE DEALT", vector2(SS_25.x,SS_50.y + PX_256), green, 900));
		texts.insertLast(EndText(" "+reward+"$ ENEMIES DESTROYED", vector2(SS_25.x,SS_50.y + PX_100 * 3.2), green, 1100));
		texts.insertLast(EndText(" "+getMissionReward(getRank())+"$ MISSION REWARD", vector2(SS_25.x,SS_50.y + PX_100 * 3.84), green, 1300));
	}
	
	void update()
	{
		if(GetInputHandle().GetKeyState(K_1) == KS_HIT)
		{
			GAME_SUCCESS = true;
			gameSuccessTime = getTimeAbsolute();
			g_exp.save();
			initTexts();
		}
		
		uint rem = g_timer.getRemainingUntil(target);
		uint sec = rem / 1000;
		if(sec < 11)
		{
			if(lastSec != sec)
			{
				lastSec = sec;
				g_uiBar.setBias();
			}
		}
		
		if(sec < 1 && !exploded)
		{
			exploded = true;
			g_enemyManager.explodeAll();
		}
		
		if(rem == 0 && !GAME_SUCCESS && !GAME_OVER)
		{
			GAME_SUCCESS = true;
			gameSuccessTime = getTimeAbsolute();
			g_fundManager.addSave(reward);
			initTexts();
			g_exp.save();
			
		}
		
	
		if(GAME_SUCCESS)
		{
			mainTimer.update();
			
			if(mainTimer.getElapsed() > 0)
			{
				backTimer.update();
				uint op = 255.0f * backTimer.getBias();
				uint color = ARGB(op,0,0,0);
				DrawShapedSprite("sprites/square.png", V2_ZERO, GetScreenSize(), color);
				
				if(mainTimer.getElapsed() > 750)
				{
					textTimer.update();
					for(uint i=0;i<texts.length();i++)
						texts[i].Draw();
					uint op = 255.0f * textTimer.getBias();
					uint color = ARGB(op,20,255,40);
					DrawText("MISSION SUCCESSFUL", text128, textPos, color, V2_HALF, 0.75f);
					
				}
				
				
				if(getTimeAbsolute() - gameSuccessTime > 5000)
				{
					g_sceneManager.setCurrentScene(MainMenuScene());
					g_sceneManager.transitionBack();
				
				}
				
			}
			
		}
	}
	
	void resume()
	{
	
	}
	
	string getTimeString()
	{
		return g_timer.getTimeString(g_timer.getRemainingUntil(target));
	}

	string getTag(){ return "Success"; }
}

uint getReward()
{
	return g_gameSuccess.getReward();
}


uint END_TEXT_ANIM = 300;

class EndText
{
	string text;
	uint color;
	uint delay;
	vector2 pos;
	InterpolationTimer@ timer;
	
	EndText(){}
	EndText(string t, vector2 p, uint col, uint del)
	{
		text = t;
		color = col;
		delay = del;
		pos = p;
		@timer = InterpolationTimer(END_TEXT_ANIM, true, delay);
	}
	
	void Draw()
	{
		timer.update();
		float bias = timer.getUnfilteredBias();
		float scaleBias = getScaleBias(bias);
		//float newColor = interpolateColor(FADE_WHITE, color,getColorBias(bias));
		DrawText(text, sans64, pos, color, vector2(0.0f, 0.5f), scaleBias);
	}
	
}

float topAnimBias = 0.3f;
float topAnimSecondBias = 0.7f;
float topScale = 2.0f;

float getScaleBias(float v)
{
	if(v < topAnimBias)
		return interpolate(0, topScale, v / topAnimBias);
	else
		return interpolate(topScale, 1.0f, (v - topAnimBias) / topAnimSecondBias);
}


float getColorBias(float v)
{
	return max(0.0f, min(1.0f, v / topAnimBias));
}

GameSuccess g_gameSuccess;
