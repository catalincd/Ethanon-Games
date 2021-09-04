class ScoreManager
{
	
	uint dec = 0;
	Text@ q_text;
	vector2 pos;
	bool locked = false;
	uint lockq,avg,best,num,current=0;

	void setCurrent()
	{
		current = getScore();
	}
	
	void set()
	{
		current = getScore();
		set(current);
	}
	
	void set(uint score)
	{
		save(score);
		g_gTimeManager.lock();
	}

	void lock()
	{
		locked = true;
		g_gTimeManager.reset();
	}
	
	void unlock()
	{
		locked = false;
		reset();
		g_gTimeManager.unlock();
	}

	void create()
	{
		read();
		//g_menu.updateScores();
		pos = vector2(g_scale.xOffset, g_scale.xOffset);
		@q_text = Text(pos, "", "Verdana30.fnt", white, 1.0f, V2_ZERO);
	}
	
	void DrawText(float bias)
	{
		uint sc = GAME_OVER? current:getScore();
		q_text.resize(""+sc);
		q_text.drawColored(ARGB(uint(bias*255), 255,255,255));
	}
	
	void reset()
	{
		current = 0;
		dec = GameScene().camToScore();
	}
	
	uint getScore()
	{
		return locked? 0:(GameScene().camToScore()-dec);
	}
	
	void read()
	{
		const string str = GetStringFromFileInPackage(GetResourceDirectory() +"data/score.enml");
		enmlFile f;
		f.parseString(str);
		avg = parseUInt(f.get("data","avg"));
		best = parseUInt(f.get("data","best"));
		num = parseUInt(f.get("data","num"));
	}
	
	void save(uint score)
	{
		//read();
		enmlEntity ent;enmlFile f2;
		highScore = best<score;
		best = max(best, score);
		ent.add("best", ""+best);
		avg = (num*avg + score) / (num + 1);
		ent.add("avg", ""+avg);
		//print(newAvg);
		ent.add("num", ""+(num+1));
		f2.addEntity("data", ent);
		string qstr = f2.generateString();
		SaveStringToFile(GetResourceDirectory() +"data/score.enml", qstr);
		g_menu.updateScores();
	}
	
	void update(uint score)
	{
		
	}
}

class GameTimeManager
{
	uint elapsed = 0;
	bool locked = false;
	string text = "";
	Text@ m_text;
	
	void create()
	{
		vector2 pos = vector2(g_scale.SCREEN_SIZE_X-g_scale.xOffset, g_scale.xOffset);
		vector2 size = vector2(-43,15)*GetScale();
		@m_text = Text(pos+size, "", "Verdana30.fnt");
	}
	
	void update(float bias)
	{
		if(!locked)
			elapsed += GetLastFrameElapsedTime();
		updateText(bias);
	}
	
	void lock()
	{
		locked = true;
	}
	
	void unlock()
	{
		locked = false;
	}
	
	void reset()
	{
		elapsed = 0;
	}
	
	void updateText(float bias)
	{
		uint seconds = elapsed / 1000;
		uint minutes = seconds / 60;
		seconds %= 60;
		string qtxt;
		if(minutes<10)qtxt+="0";
		qtxt += minutes+":";
		if(seconds<10)qtxt+="0";
		qtxt += seconds;
		m_text.resize(qtxt);
		m_text.drawColored(ARGB(uint(bias*255), 255,255,255));
	}
	
}

bool highScore = false;

GameTimeManager g_gTimeManager;
ScoreManager g_scoreManager;