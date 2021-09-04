funcdef float INTERPOLATION_FILTER(const float v);



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

FloatColor interpolate(const FloatColor@ a, const FloatColor@ b, const float bias)
{
	return FloatColor(interpolate(a.getAlpha(),   b.getAlpha(),   bias),
					  interpolate(a.getVector3(), b.getVector3(), bias));
}

class InterpolationTimer
{
	InterpolationTimer(const uint _millisecs, const bool dontPause = true, uint delay = 0)
	{
		reset(_millisecs);
		@m_filter = @smoothEnd;
		m_dontPause = dontPause;
		m_delay = delay;
	}
	
	void update()
	{
		if (m_dontPause)
			m_elapsedTime += GetLastFrameElapsedTime();
		else
			m_elapsedTime += GetLastFrameElapsedTime();
	}

	float getBias() const
	{
		return (!isOver()) ? m_filter(min(max((float(m_elapsedTime) - float(m_delay))/ float(m_time), 0.0f), 1.0f)) : 1.0f;
	}

	float getUnfilteredBias() const
	{
		return (!isOver()) ? (min(max((float(m_elapsedTime) - float(m_delay))/ float(m_time), 0.0f), 1.0f)) : 1.0f;
	}
	
	uint getElapsed() const
	{
		return m_elapsedTime;
	}

	void reset(const uint _millisecs)
	{
		m_time = _millisecs;
		m_elapsedTime = 0;
	}

	bool isOver() const
	{
		return (int(m_elapsedTime) - int(m_delay) > int(m_time));
	}

	void setFilter(INTERPOLATION_FILTER@ filter)
	{
		@m_filter = @filter;
	}

	uint m_elapsedTime;
	uint m_time;
	uint m_delay;
	INTERPOLATION_FILTER@ m_filter;
	bool m_dontPause;
}

class PositionInterpolator : InterpolationTimer
{
	private vector2 m_a;
	private vector2 m_b;

	PositionInterpolator()
	{
		super(0, false);
	}

	PositionInterpolator(const vector2 &in _a, const vector2 &in _b, const uint _millisecs, const bool dontPause = false)
	{
		super(_millisecs, dontPause);
		reset(_a, _b, _millisecs);
	}

	void reset(const vector2 &in _a, const vector2 &in _b, const uint _millisecs)
	{
		InterpolationTimer::reset(_millisecs);
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
