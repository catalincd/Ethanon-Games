

float interpolate(const float a, const float b, const float bias)
{
	return a + ((b - a) * bias);
}

vector2 interpolate(const vector2 &in a, const vector2 &in b, const float bias)
{
	return a + ((b - a) * bias);
}

vector3 interpolate(const vector3 &in a, const vector3 &in b, const float bias)
{
	return a + ((b - a) * bias);
}

class Timer
{
	Timer(const uint _millisecs, const uint _delay = 0, const bool dontPause = true)
	{
		reset(_millisecs);
		@m_filter = @smoothEnd;
		m_dontPause = dontPause;
		m_delay = _delay;
	}
	
	void update()
	{
		if (m_dontPause)
			m_elapsedTime += GetLastFrameElapsedTime();
		else
			m_elapsedTime += GetLastFrameElapsedTime();
			//m_elapsedTime += g_timeManager.getLastFrameElapsedTime();
	}
	
	uint getElapsedAbsolute()
	{
		return uint(max(0, int(m_elapsedTime) - int(m_delay)));
	}

	float getBias() const
	{
		return (!isOver()) ? m_filter(min(max(float(getElapsedAbsolute()) / float(m_time), 0.0f), 1.0f)) : 1.0f;
	}

	float getUnfilteredBias() const
	{
		return (!isOver()) ? (min(max(float(getElapsedAbsolute()) / float(m_time), 0.0f), 1.0f)) : 1.0f;
	}
	
	void reset()
	{
		reset(m_time);
	}
	
	void reset(const uint _millisecs)
	{
		m_time = _millisecs;
		m_elapsedTime = 0;
	}
	
	void setDelay(uint _delay)
	{
		m_delay = _delay;
	}

	bool isOver() const
	{
		return (getElapsedAbsolute() > m_time);
	}

	void setFilter(Filter@ filter)
	{
		@m_filter = @filter;
	}

	uint m_delay;
	uint m_elapsedTime;
	uint m_time;
	Filter@ m_filter;
	bool m_dontPause;
}

class PositionInterpolator : Timer
{
	private vector2 m_a;
	private vector2 m_b;

	PositionInterpolator()
	{
		super(0, 0, false);
	}

	PositionInterpolator(const vector2 &in _a, const vector2 &in _b, const uint _millisecs, const bool dontPause = false)
	{
		super(_millisecs,0, dontPause);
		reset(_a, _b, _millisecs);
	}

	void reset(const vector2 &in _a, const vector2 &in _b, const uint _millisecs)
	{
		Timer::reset(_millisecs);
		m_a = _a;
		m_b = _b;
	}

	void forcePointA(const vector2 &in a)
	{
		m_a = a;
	}

	void forcePointB(const vector2 &in b)
	{
		m_b = b;
	}

	vector2 getCurrentPos() const
	{
		if (m_elapsedTime > m_time)
		{
			return m_b;
		}
		else
		{
			const float bias = getBias();
			return interpolate(m_a, m_b, bias);
		}
	}
}
