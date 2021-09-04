class Timer
{
	private uint m_elapsedTime = 0;

	void update()
	{
		m_elapsedTime += GetLastFrameElapsedTime();
	}

	uint getElapsedTime() const
	{
		return m_elapsedTime;
	}
}