class Timer : GameObject
{

	bool precision = false;
	uint m_elapsed;
	
	string getTag()
	{
		return "Timer";
	}
	
	
	
	void create()
	{
		m_elapsed = 0;
	}
	
	void update()
	{
		if(!GAME_OVER && !g_pauseManager.pause)
			m_elapsed += GetLastFrameElapsedTime();
	}
	
	void resume()
	{
	
	}
	
	string getTimeString()
	{
		string str = "";
		bool minn = m_elapsed / 1000 >= 60;
		if(minn)
			str = ""+(m_elapsed / 60000)+":";
		uint q = ((m_elapsed / 1000) % 60);
		string xq = ""+q;
		if(xq.length()==1 && minn)
			str += "0"+xq;
		else str += xq;
		
		if(precision)
		{
			str += ".";
			uint t = (m_elapsed%100);
			string xt = ""+t;
			while(xt.length()<2) xt+="0";
			str+=xt;
		}
		return str;
	}
}

Timer g_timer;