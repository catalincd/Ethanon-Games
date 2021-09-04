class Menu
{
	uint idx = 0;
	InterpolationTimer@ m_timer = InterpolationTimer(300);
	bool ascend = false;
	bool changing = false;
	bool tutorial = false;
	uint changingTo;
	MenuScore score;
	
	void create()
	{
		ascend = false;
		changing = false;
		
		score.create();
		
		checkTut();
	}
	
	void checkTut()
	{
		uint qq = parseUInt(GetStringFromFile(GetExternalStorageDirectory() +"tutorial.enml"));
		if(qq==0)
		{
			tutorial = true;
			SaveStringToFile(GetStringFromFile(GetExternalStorageDirectory() +"tutorial.enml"), "1");
		}
		else tutorial = false;
	}
	
	bool starting()
	{
		if(idx!=0)
			return false;
		else if(GetInputHandle().GetTouchState(0)==KS_HIT)
		{
			return g_textManager.getTouchId(GetInputHandle().GetTouchPos(0))==0;
		}
		return false;
	}
	
	void updateScores()
	{
		score.updateScores();
	}
	
	void updateMainMenu(float bias)
	{
		uint color = ARGB(bias,whiteF);
		g_textManager.drawColored(0, color);
		g_textManager.drawColored(1, color);
		g_textManager.drawColored(2, color);
		
		if(tutorial)
		{
			DrawShapedSprite("sprites/arrows.png", vector2(0,0), g_scale.SCREEN_SIZE, color);
			DrawCenteredText(vector2(g_scale.SCREEN_SIZE_X2,100*GetScale()), "TILT YOUR DEVICE TO CONTROL THE MOTION", "Verdana20.fnt", color);
		}
		else 
		score.update(color);
	}
	
	void updateSettings(float bias)
	{
		g_settingsManager.update(bias);
	}
	
	void update(float bias)
	{
		float currentBias = bias * (ascend? m_timer.getBias() : 1-m_timer.getBias());
		if(idx == 0)
		{
			updateMainMenu(currentBias);
		}
		if(idx == 1)
		{
			updateSettings(currentBias);
		}
		
		if(!changing)
		{
			if(idx==0)
				if(GetInputHandle().GetTouchState(0)==KS_HIT)
				{
					uint id = g_textManager.getTouchId(GetInputHandle().GetTouchPos(0));
					if(id==2)
						openSupport();
					else
					if(id!=0)
					{
						changingTo = id;
						changing = true;
						ascend = false;
					}
				}
			if(idx==1)
				if(g_settingsManager.back())
				{
					changingTo = 0;
					changing = true;
					ascend = false;
				}
		}
		else
		{
			m_timer.update();
			if(m_timer.isOver() && ascend)
			{
				m_timer.reset();
				changing = false;
				ascend = false;
			}
			if(m_timer.isOver() && !ascend)
			{
				m_timer.reset();
				ascend = true;
				idx = changingTo;
			}
		}

	}
}



class MenuScore
{
	Text@ m_best;
	Text@ m_current;
	Text@ m_average;
	Text@ m_averagetxt;
	Text@ m_besttxt;
	
	void create()
	{
		@m_current = Text(vector2(350*GetScale(), g_scale.SCREEN_SIZE_Y2-112*GetScale()), "", "Verdana20.fnt", white, 1, vector2(1, 0.5));
		@m_best = Text(vector2(350*GetScale(), g_scale.SCREEN_SIZE_Y2), "", "Verdana20.fnt", white, 1, vector2(1, 0.5));
		@m_besttxt = Text(vector2(100*GetScale(), g_scale.SCREEN_SIZE_Y2), "BEST", "Verdana20.fnt", white, 1, vector2(0, 0.5));
		@m_average = Text(vector2(350*GetScale(), g_scale.SCREEN_SIZE_Y2+75*GetScale()), "", "Verdana20.fnt", white,1, vector2(1, 0.5));
		@m_averagetxt = Text(vector2(100*GetScale(), g_scale.SCREEN_SIZE_Y2+75*GetScale()), "AVERAGE", "Verdana20.fnt", white,1, vector2(0, 0.5));
		updateScores();
	}
	
	void update(uint color)
	{
		m_current.drawColored(color);
		m_best.drawColored(color);
		m_besttxt.drawColored(color);
		m_average.drawColored(color);
		m_averagetxt.drawColored(color);
		
	}
	
	void updateScores()
	{
		resize(g_scoreManager.best, g_scoreManager.current, g_scoreManager.avg);
	}
	
	void resize(uint best, uint current, uint avg)
	{
		m_best.resize(""+best);
		m_current.resize(""+current);
		m_average.resize(""+ avg);
	}
}


void openSupport()
{
	string url = "https://docs.google.com/forms/d/e/1FAIpQLSehfXE5r8Lzlpm-bQnE45QJkTl46YksRxEwa43xN9toVPuoDg/viewform";
	ForwardCommand("open_url "+url);
}

Menu g_menu;