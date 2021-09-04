class SoundManager : GameObject
{
	string getTag(){ return "SoundManager"; }
	
	string[] effects;
	float[] volume;
	uint[] lastSamplePlay;
	uint SOUND_STRIDE = 75;
	
	void insert(string name, float vol = 1.0f)
	{
		effects.insertLast(name);
		volume.insertLast(vol);
		lastSamplePlay.insertLast(0);
	}
	
	void fill()
	{
		effects.resize(0);
		volume.resize(0);
		lastSamplePlay.resize(0);
		insert("soundfx/shoot1.mp3");
		insert("soundfx/shoot2.mp3", 0.5);
		insert("soundfx/shot1.wav", 0.4f);
		insert("soundfx/shot2.wav", 0.9f);
		insert("soundfx/shot3.wav", 0.75f);
		insert("soundfx/shot4.wav");
		insert("soundfx/shot5.wav", 0.5f);
		insert("soundfx/shot6.wav", 0.5f);
		insert("soundfx/shot7.wav", 0.5f);
		insert("soundfx/cannon_03.ogg", 0.7);
		insert("soundfx/explosion.mp3", 0.3);
		insert("soundfx/select.wav", 0.3);
		insert("soundfx/deselect.wav", 0.3);
	}
	
	void load()
	{
		fill();
		for(uint t=0;t<effects.length();t++)
		{
			LoadSoundEffect(effects[t]);
			SetSampleVolume(effects[t], volume[t]);
		}
	}
	
	void playRandomized(uint id, float offset = 0.2f)
	{
		if(!GAME_SUCCESS)
		if(getTimeAbsolute() - lastSamplePlay[id] > SOUND_STRIDE)
		{
			SetSampleSpeed(effects[id], randF(1.0f - offset, 1.0f));
			PlaySample(effects[id]);
			lastSamplePlay[id] = getTimeAbsolute();
		}
	}
	
	void play(uint id)
	{
		playRandomized(id, 0);
	}
	
	void playNormal(uint id)
	{
		PlaySample(effects[id]);
	}
	
	void create()
	{
		
	}
	
	void update()
	{
	
	}
	
	void resume()
	{
	
	}
}

SoundManager g_soundManager;


void playNormal(uint id)
{
	g_soundManager.playNormal(id);
}

void play(uint id)
{
	g_soundManager.play(id);
}

void playRandomized(uint id, float offset = 0.2f)
{
	g_soundManager.playRandomized(id, offset);
}