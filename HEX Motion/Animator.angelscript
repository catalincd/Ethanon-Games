class Animator
{
	InterpolationTimer@[] timers;
	uint m_last = 0;
	
	uint addTimer(uint _millisec)
	{
		timers.insertLast(InterpolationTimer(_millisec, false));
		return m_last++;
	}
	
	void update()
	{
		uint len = timers.length();
		for(uint t=0;t<len;t++)
				timers[t].update();
	}
	
	float getBias(uint idx)
	{
		return timers[idx].getBias();
	}
}


Animator g_animator;