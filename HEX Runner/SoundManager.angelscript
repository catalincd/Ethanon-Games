class SoundManager
{

	string[] sounds;
	string[] music;

	SoundManager()
	{
		
	}
	
	void create()
	{
		//SetGlobalVolume(0);
		createSounds();
		loadSounds();
	}
	
	void createSounds()
	{
		SetGlobalVolume(ENABLE_SOUND? 1.0f : 0.0f);
		sounds.insertLast("soundfx/slide.wav");
		sounds.insertLast("soundfx/explodemax.wav");
		sounds.insertLast("soundfx/foom2.wav");
		//sounds.insertLast("soundfx/explode.wav");
		//sounds.insertLast("soundfx/explodemini.wav");
	}
	
	void loadSounds()
	{
		for(uint t=0;t<sounds.length();t++)
			LoadSoundEffect(sounds[t]);
		for(uint t=0;t<music.length();t++)
			LoadMusic(music[t]);
	}
	
	void playSound(uint idx)
	{
		PlaySample(sounds[idx]);
	}
	
	
}

SoundManager g_soundManager;