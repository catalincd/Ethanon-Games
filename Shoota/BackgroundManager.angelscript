class BackgroundManager : GameObject
{
	ETHEntity@ background;
	float colorBias = 0.0f;
	float maxBias = 0.8f;
	float biasRatio = 0.2f;
	float decreaseSpeed = 0.6f;
	string[] backgrounds;
	Background[] backs;
	Background currentBackground;

	void init()
	{
		backgrounds.resize(0);
		backgrounds.insertLast("entities/map_hexagon.png");
		backgrounds.insertLast("entities/map_circuit.png");
		backgrounds.insertLast("entities/map_clockwork.png");
		
		backs.resize(0);
		backs.insertLast(Background(COL(COLOR_HEXAGON), V3_ONE));
		backs.insertLast(Background(COL(COLOR_CIRCUIT), V3_ONE));
		backs.insertLast(Background(COL(COLOR_CLOCKWORK), COL(BACK_CLOCKWORK)));
	}

	void loadAllBackgrounds()
	{
		for(uint i=0;i<backgrounds.length();i++)
			LoadSprite(backgrounds[i]);
	}
	
	
	void create()
	{
		SetBackgroundColor(white);
		AddEntity("background.ent", vector3(GetScreenSize()/2, -5.0f), @background);
		init();
		uint id = rand(0, backgrounds.length()-1);
		id = 1;
		//id = 2;
		string thisBack = backgrounds[id];
		LoadSprite(thisBack);
		background.SetSprite(thisBack);	
		background.SetColor(V3_ZERO);
		
		currentBackground = backs[id];
	}
	
	
	void update()
	{
	
	
		currentBackground.update();
		background.SetColor(currentBackground.getColor());
		//background.SetColor(V3_RED);
		
		//SetBackgroundColor(COL(currentBackground.getBackgroundColor()));
	
		vector3 lightPos = vector3(GetInputHandle().GetCursorPos(), 0);
		if(!g_ui.windowUp)
			if(GetInputHandle().GetTouchState(0) == KS_HIT)
			{
				AddEntity("click.ent", vector3(GetInputHandle().GetTouchPos(0), 10), 0);
			}
	}
	
	void shoot()
	{
		//colorBias += biasRatio;
	}
	
	void resume()
	{
		SetBackgroundColor(ARGB(255,200,200,200));
	}
	string getTag()
	{
		return "Background";
	}
}

uint COLOR_CLOCKWORK = 0xFF998537; uint BACK_CLOCKWORK = 0xFFEBCCFF;
uint COLOR_CIRCUIT = 0xFF1B60A1; uint BACK_CIRCUIT = 0xFFEBCCFF;
uint COLOR_HEXAGON = 0xFFD3111F;

BackgroundManager g_backgroundManager;