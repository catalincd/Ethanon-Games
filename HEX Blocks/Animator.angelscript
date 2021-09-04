class Animator
{
	float bias = 0;
	uint m_time;
	uint m_elapsedTime;
	
	Animator(uint _mil)
	{
		reset(_mil);
	}
	
	void reset(const uint _millisecs)
	{
		m_time = _millisecs;
		m_elapsedTime = 0;
	}
	
	float getBias()
	{
		return (!isOver()) ? (min(max(float(m_elapsedTime) / float(m_time), 0.0f), 1.0f)) : 1.0f;
	}
	
	void update()
	{
		m_elapsedTime += GetLastFrameElapsedTime();
	}

	bool isOver()
	{
		return m_elapsedTime >= m_time;
	}

}