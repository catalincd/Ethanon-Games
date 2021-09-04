class Timer : GameObject
{

	//bool precision = false;
	bool gameStopped = false;
	uint m_elapsed;
	uint m_gameElapsed;
	uint target;
	
	string getTag()
	{
		return "Timer";
	}	
	
	void create()
	{
		gameStopped = false;
		m_elapsed = 0;
		m_gameElapsed = 0;
	}
	
	void update()
	{
		m_elapsed += GetLastFrameElapsedTime();
		if(!gameStopped)
			m_gameElapsed += GetLastFrameElapsedTime();
	
	}
	
	void resume()
	{
	
	}
	
	uint getRemainingUntil(uint time)
	{
		return max(0, int(time) - int(m_gameElapsed));
	}
	
	
	string getTimeString(uint elapsed, bool precision = false)
	{
		string str = "";
		bool minn = elapsed / 1000 >= 60;
		if(minn)
			str = ""+(elapsed / 60000)+":";
		uint q = ((elapsed / 1000) % 60);
		string xq = ""+q;
		if(xq.length()==1 && minn)
			str += "0"+xq;
		else str += xq;
		
		if(precision)
		{
			str += ".";
			uint t = (elapsed%100);
			string xt = ""+t;
			while(xt.length()<2) xt+="0";
			str+=xt;
		}
		return str;
	}
}

Timer g_timer;

uint getTime()
{
	return g_timer.m_gameElapsed;
}

uint getTimeAbsolute()
{
	return g_timer.m_elapsed;
}
