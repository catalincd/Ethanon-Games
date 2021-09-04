class LoadingScene : Scene
{

	string[] names;
	string[] backs;
	vector2[] origins;
	float[] volumes;
	vector2 loadingPos;
	vector2 spritePos;
	vector2 percentPos;
	vector2 argumentPos;
	uint idx = 0;
	uint soundIdx = 0;
	uint maxIdx;
	uint textColor;
	uint pixels = 0;
	uint time = 0;

	LoadingScene()
	{
		super("empty");
		init();
	}
	
	
	void init()
	{
		
		
		
		
		g_loader.fill();
		g_backgroundManager.init();
		g_soundManager.fill();
		names.resize(0);
		origins.resize(0);
		names = g_loader.sprites;
		origins = g_loader.origins;
		volumes = g_soundManager.volume;
		backs = g_backgroundManager.backgrounds;
		
		for(uint i=1;i<16;i++)
		{	
			names.insertLast("sprites/ranks/rank"+i+".png");
			origins.insertLast(V2_ZERO);
		}
		
		//for(uint i=0;i<backs.length();i++)
		//{	
		//	names.insertLast(backs[i]);
		//	origins.insertLast(V2_HALF);
		//}
		
		
		soundIdx = names.length();
		maxIdx = soundIdx + volumes.length();
		
		
		for(uint i=0;i<volumes.length();i++)
		{
			names.insertLast(g_soundManager.effects[i]);
		}
		
		
	}
	
	void onCreated()
	{
		runOnInitFuction();
		SetBackgroundColor(white);
		idx = 0;
		pixels = 0;
		time = GetTime();
		loadingPos = vector2(GetScreenSize().x * 0.5f, GetScreenSize().y * 0.3f);
		argumentPos = vector2(GetScreenSize().x * 0.5f, GetScreenSize().y * 0.85f);
		percentPos = vector2(GetScreenSize().x * 0.5f, GetScreenSize().y * 0.5f);
		spritePos = vector2(GetScreenSize().x * 0.5f, GetScreenSize().y * 0.8f);
		
		textColor = black;
		
	}
	
	float getPercentF(uint idx)
	{
		return float(idx) / float(maxIdx);
	}
	
	uint getPercent(uint idx)
	{
		return uint(getPercentF(idx) * 100.f);
	}
	
	uint getPixels(string spr)
	{
		vector2 v =  GetSpriteSize(spr);
		return uint(v.x * v.y);
	}
	
	float getPercentPix()
	{
		return uint(float(pixels) / float(11238485) * 100.0f);
	}
	
	void onUpdate()
	{
		DrawText("LOADING..", sans128, loadingPos, textColor, V2_HALF);
		DrawText(""+getPercent(idx)+"%", sans64, percentPos, textColor, V2_HALF);
	//	DrawText("Pixels loaded:"+pixels, sans64, argumentPos, textColor, V2_HALF);
		
		string name = names[idx];
		
		DrawText(name, sans64, spritePos, textColor, V2_HALF);
		
		load(idx, name);
		idx++;
		if(idx == maxIdx)
		{
			print(pixels);
			print("LOAD TIME: "+(GetTime() - time));
			g_sceneManager.setCurrentScene(MainMenuScene());
		}
	}
	
	
	
	void load(uint idx, string name)
	{
		if(sprite(idx))
		{
			LoadSprite(name);
			pixels += getPixels(name);
			SetSpriteOrigin(name, origins[idx]);
		}
		else
		{
			LoadSoundEffect(name);
			SetSampleVolume(name, volumes[idx-soundIdx]);
		}
		
		
	}
	
	bool sprite(uint id)
	{
		return id < soundIdx;
	}
	
	
	void onResume() override
	{
	
	}
}