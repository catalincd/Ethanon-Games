class SoundManager
{
	bool changing = false;
	bool up = false;
	InterpolationTimer@ m_timer = InterpolationTimer(300);
	string play = "soundfx/"+1+".wav";
	
	void onCreated()
	{
		
		LoadMusic(play);
		LoopSample(play, true);
		//PlaySample(play);
		SetSampleVolume(play, 0);
		changing = true;
		up = true;
		m_timer.reset(750);
	}
	
	void gameOver()
	{
		changing = true;
		up = false;
		m_timer.reset(500);
	}
	
	void onUpdate()
	{
		if(changing)
		{
			m_timer.update();
			
			SetSampleVolume(play, up? m_timer.getBias():1-m_timer.getBias());
			if(m_timer.isOver())
				changing = false;
		}
	}

}


SoundManager g_soundManager;