class Bouncer
{

	private vector2 m_currentBounceScale;
	private vector2 m_bounceScaleA;
	private vector2 m_bounceScaleB;
	private uint m_bounceStride;
	private uint m_elapsedTime;
	

	Bouncer(const vector2 &in scaleA, const vector2 &in scaleB, const uint stride = 300)
	{
		m_bounceScaleA = scaleA;
		m_bounceScaleB = scaleB;
		m_bounceStride = stride;
		m_currentBounceScale = m_bounceScaleA;
	}
	
	vector2 getBounceScale()
	{
		return m_currentBounceScale;
	}

	void update()
	{
		m_elapsedTime += g_timeManager.getLastFrameElapsedTime();
		
		if (m_bounceScaleA == V2_ONE && m_bounceScaleB == V2_ONE)
		{
			m_currentBounceScale = V2_ONE;
			return;
		}

		const bool invert = (((m_elapsedTime / m_bounceStride) % 2) == 1);
		float bias = float(m_elapsedTime % m_bounceStride) / float(m_bounceStride);
		bias = invert ? 1.0f - bias : bias;
		m_currentBounceScale = interpolate(m_bounceScaleA, m_bounceScaleB, smoothEnd(bias));
	}
}

class FloatBouncer
{

	private float m_currentBounceScale;
	private float m_bounceScaleA;
	private float m_bounceScaleB;
	private uint m_bounceStride;
	private uint m_elapsedTime;
	

	FloatBouncer(const float &in scaleA, const float &in scaleB, const uint stride = 300)
	{
		m_bounceScaleA = scaleA;
		m_bounceScaleB = scaleB;
		m_bounceStride = stride;
		m_currentBounceScale = m_bounceScaleA;
	}
	
	float getBounceScale()
	{
		return m_currentBounceScale;
	}

	void update()
	{
		m_elapsedTime += g_timeManager.getLastFrameElapsedTime();
		
		if (m_bounceScaleA == 1.0f && m_bounceScaleB == 1.0f)
		{
			m_currentBounceScale = 1.0f;
			return;
		}

		const bool invert = (((m_elapsedTime / m_bounceStride) % 2) == 1);
		float bias = float(m_elapsedTime % m_bounceStride) / float(m_bounceStride);
		bias = invert ? 1.0f - bias : bias;
		m_currentBounceScale = interpolate(m_bounceScaleA, m_bounceScaleB, smoothEnd(bias));
	}
}