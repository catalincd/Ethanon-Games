#include "Button.angelscript"
#include "SettingsManager.angelscript"
#include "Setting.angelscript"
#include "Menu.angelscript"

bool GAME_OVER = false;
bool debugging = false;
bool debugging_filters = false;
uint idleChangeId = 0;

class GameScene : Scene
{

	ETHEntity@ TRANS = null;
	ETHEntityArray allEnt;
	ETHEntity@ block = null;
	ETHInput@ input = GetInputHandle();
	
	int lastAdd = 0;
	int count = 1;
	uint sq = 1;
	uint gameTime = 0;
	uint ads = 0;
	uint PauseTime = 0;
	uint LoadTime = 0;
	vector2 SPR_SIZE = vector2(g_scale.SCREEN_SIZE_X,70*GetScale());
	vector2 SPR_POS = vector2(g_scale.SCREEN_SIZE_X,g_scale.SCREEN_SIZE_Y);
	vector2 SPR_POS2 = vector2(g_scale.SCREEN_SIZE_X,70*GetScale());
	float limit = g_scale.SCREEN_SIZE_Y+200*GetScale();
	bool saved = false;
	bool stopped = false;
	float xPos = g_scale.SCREEN_SIZE_X - (GetScale()*15);
	bool idle = true;
	bool idleSwitch = false;
	bool settings = false;
	uint idleTime = 0;
	bool playAgain = false;
	InterpolationTimer@ idleTimer = InterpolationTimer(300);
	Battery@ g_battery;
	
	
	GameScene()
	{
		const string sceneName = "empty";
		super(sceneName);
	}
	
	void onResume()
	{
		//g_setOrigin.resetAllOrigins();
		//SetBackgroundColor(PRIM.getUInt());
		//g_loader.load();
		//execPause();
	}

	void onCreated()
	{
		//g_scale.create();
		g_scoreManager.create();
		g_gTimeManager.create();
		g_menu.create();
		g_creator.create();
		g_block.add();
		g_block.create();
		g_layer.create();
		g_settingsManager.create();
		
		
		@block = g_block.entity;
		@g_battery = Battery();
		g_timeManager.setFactor(0.0f);
		GAME_OVER = false;
		LoadTime = 0;
		SetBackgroundColor(greyDark);
		//SetEmissiveColor(vector3(1,1,1));
	}
	
	
	

	void onUpdate()
	{
		
		//DrawText();
		
		g_layer.update();
		
		if(settings)
		{
			
		}
		
		
		if(windows)
		{
			//DrawText(vector2(0,0), ""+camToScore(), "Verdana30.fnt", white, GetScale());
		}
		
		
		if(idle)
		{
			g_menu.update(1-idleTimer.getUnfilteredBias());
			g_layer.set(idleTimer.getUnfilteredBias());
			if(idleChangeId == 0)
			{
				g_timeManager.setFactor(idleTimer.getUnfilteredBias());
				SetBackgroundColor(COL(interpolate(greyDarkV3,blackV3,idleTimer.getUnfilteredBias())));
			}
			
			if(!idleSwitch)
			{
				if(g_menu.starting())
				{
					idleSwitch = true;
					idleTime = GetTime();
					idleTimer.reset(300);					
				}
			}
			else
			{
				idleTimer.update();
				if(idleTimer.isOver())
				{
					idleTimer.reset(300);
					idle = false;
					idleSwitch = false;
					g_layer.set(1);
				}
			}
			
			
		}
		
		
		
	
		if(GetInputHandle().GetKeyState(K_CTRL)==KS_HIT)
			debugging_filters = !debugging_filters;
		if(GetInputHandle().GetKeyState(K_SPACE)==KS_HIT)
		{
			sq++;
			print("TIME_SCALE:"+max(0.5f,float(sq%2)));
			g_timeManager.setFactor(max(0.5f,float(sq%2)));
		}
		g_block.update();
		if(abs(camToInt()-lastAdd)<3)
		{
			lastAdd -= g_creator.create(lastAdd, allEnt);
			ads++;
		}
		delete();
	}
	
	
	
	
	string GetTimeString()
	{
		string ret = "";
		
		uint mins = LoadTime / 60000;
		if(mins!=0) ret+=mins+":";
		uint seconds = (LoadTime % 60000)/1000;
		
		uint milli = ((LoadTime % 60000)%1000)/10; 
		
		return (ret+seconds+"."+milli);
		
	}
	
	float GetTimeFloat()
	{
		return float(LoadTime)/60000.0;
	}
	

	void delete()
	{
		const uint t = allEnt.Size();
		
		for(uint i=0;i<t;i++)
		{
			if(allEnt[i].GetPositionY()>GetCameraPos().y+limit)
			{
				DeleteEntity(allEnt[i]);
			}
		}
		allEnt.RemoveDeadEntities();
	}
	
	
	int camToInt()
	{
		return (int(GetCameraPos().y)/(70*GetScale())-1);
	}
	
	int camToScore()
	{
		return (int(GetCameraPos().y*-100/(7*GetScale()))-1);
	}
	
	uint camToScoreU()
	{
		return max(0, camToScore());
	}
}