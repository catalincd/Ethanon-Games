#include "Button.angelscript"
bool debugging = true;

class GameScene : Scene
{
	ETHEntity@ ball = null;
	ETHEntity@ tray = null;
	ETHEntity@ TRANS = null;
	ETHEntityArray allEnt;
	ETHInput@ input = GetInputHandle();
	int lastAdd = 0;
	int count = 1;
	uint gameTime = 0;
	uint ads = 0;
	uint PauseTime = 0;
	uint LoadTime = 0;
	vector2 SPR_SIZE = vector2(SCREEN_SIZE_X,70*GetScale());
	vector2 SPR_POS = vector2(SCREEN_SIZE_X,SCREEN_SIZE_Y);
	vector2 SPR_POS2 = vector2(SCREEN_SIZE_X,70*GetScale());
	float limit = SCREEN_SIZE_Y+200*GetScale();
	bool saved = false;
	bool stopped = false;
	float xPos = SCREEN_SIZE_X - (GetScale()*15);
	GameScene()
	{
		const string sceneName = "empty";
		super(sceneName);
	}
	
	void onResume()
	{
		g_setOrigin.resetAllOrigins();
		SetBackgroundColor(PRIM.getUInt());
		g_loader.load();
		execPause();
	}

	void onCreated()
	{
		//execPause();
		ForwardCommand("admob hide");
		g_soundManager.onCreated();
		GAME_OVER = false;
		g_effector.setDefaultFilter();
		LoadTime = 0;
		SetGravity(vector2(0,0));
		SetBackgroundColor(PRIM.getUInt());
		//AddEntity("ball.ent", vector3(SCREEN_SIZE_2,0),@ball);
		print(g_gameManager.m_mainPlayer);
		AddEntity(g_gameManager.m_mainPlayer+".ent", vector3(SCREEN_SIZE_2,0), 0, @ball, "ball.ent", 1);
		
		//ball.SetColor(vector3(0,0,0));
		print(g_gameManager.tray);
		AddEntity(g_gameManager.tray+".ent", vector3(SCREEN_SIZE_2,0), 0,@tray, "tray", 1);
		ball.SetInt("ballId", tray.GetID());
		tray.SetObject("ball", @ball);
		setSpriteOrigin("sprites/trans.png", vector2(1,1));
		g_scoreManager.onCreate();
		//AddEntity("TRANS.ent", vector3(360,500,0),@TRANS);
		//TRANS.SetColor(COL(white));
		//TRANS.SetScale(vector2(SCREEN_SIZE_X/70, 1));
		//Add2(5,allEnt)/
	}

	void onUpdate()
	{
		g_effector.update();
		g_soundManager.onUpdate();
		g_trapManager.onUpdate(GetCameraPos().y);
	
		if(debugging){ if(input.GetKeyState(K_SPACE)==KS_HIT) { count++; SetTimeStepScale(count%2);}
		}
		if(PAUSE)
		{
			uint x2alpha = uint(max(0,100-int(float(GetTime()-PauseTime)/30)));
			uint t = (5-(GetTime()-PauseTime)/1000);
			if(t==0)
			{
				PAUSE = false; scale_factor = 1;
			}
			else
			{
			string xst = ""+(5-(GetTime()-PauseTime)/1000);
			vector2 xpos = SCREEN_SIZE_2-vector2(0,100*GetScale())-ComputeTextBoxSize(dataBase.font64, xst)/2;
			DrawText(xpos, xst, dataBase.font64, SEC.getUInt());
			DrawShapedSprite("sprites/grey.png", vector2(0,0), GetScreenSize(), ARGB(x2alpha, 255,255,255));
			}
		}
		
			DrawShapedSprite("sprites/trans.png", SPR_POS, SPR_SIZE, GetBackgroundColor());
			DrawShapedSprite("sprites/trans.png", vector2(0,0), SPR_SIZE, GetBackgroundColor(), 180);
			float offSet = 15*GetScale();
			//mid text DrawText(""+, dataBase.font30, SEC.getUInt(), vector2(SCREEN_SIZE_X2,offSet), vector2(0.5,0), GetScale());
			DrawText(""+(camToScore()*-1), dataBase.font30, SEC.getUInt(), vector2(offSet,offSet), vector2(0,0), GetScale());
			DrawText(""+GetTimeString(), dataBase.font30, SEC.getUInt(), vector2(xPos,offSet), vector2(1,0), GetScale());
		
		if(!GAME_OVER)
		{
			
			SetCameraPos(vector2(0,ball.GetPositionY()-SCREEN_SIZE_Y2));
			if(!PAUSE)
			LoadTime += GetLastFrameElapsedTime();
			
			//float ups = GetCameraPos().y/max(1, float(LoadTime/1000)*GetScale());
			//string x = "FPS:"+GetFPSRate()+"\nHeight: "+abs(camToScore())+"  \nElapsed "+GetTimeString()+"\nCAM:"+GetCameraPos().y+"\nUPS:"+ups;
			//string x2 = ""+allEnt.Size();
			//DrawText(vector2(0,0), x2, "Verdana30.fnt", black, GetScale());
			

		}
		else
		{
			if(!saved)
			{
				//CURRENT_TOTAL_TIME+=GetTimeFloat();
				GAMES_PLAYED++;
				saved = true;
				scoreAdder.toAdd = abs(camToScore());
				scoreAdder.added = false;
				g_scoreManager.updateData();
				
			}
			vector2 auxx;
			gameTime += GetLastFrameElapsedTime();
			if(gameTime<700)
			{
			float xy = 10+(700-float(gameTime))*10/700;
			vector2 add = vector2(randF(1)*xy, randF(1)*xy);
			auxx = add;
			SetCameraPos(CAM_END_POS+add);

			}
			else auxx = vector2(0,0);

			if(gameTime>2000)
			{
				if(!stopped)
				{
					stopped = true;
					g_soundManager.gameOver();
				}
			
				uint alph = min(255, uint((float(gameTime-2000)/950.0)*255.0));
			
				if(gameTime>3000)
					{
					
					g_sceneManager.setCurrentScene(StatsScene());
					//LAST_SCORE = uint(abs(camToInt()));
					FROM_GAME = true;
					DrawShapedSprite("entities/block_w.png", vector2(0,0), SCREEN_SIZE, PRIM.getUInt());

					}
				else
					DrawShapedSprite("entities/block_w.png", vector2(0,0), SCREEN_SIZE, ARGB(alph,PRIM));
			}
		}
		//down
		
		//top
		//DrawShapedSprite("sprites/trans.png", vector2(0,0), SPR_SIZE, white, 180);
		if(debugging)
		{
			GO_LEFT = input.GetKeyState(K_LEFT)==KS_DOWN;
			GO_RIGHT = input.GetKeyState(K_RIGHT)==KS_DOWN;
		}
		else
		{
			GO_LEFT = false;
			GO_RIGHT = false;
			if(input.GetTouchState(0)==KS_DOWN)
			{
				GO_LEFT = input.GetTouchPos(0).x<SCREEN_SIZE_X2;
				GO_RIGHT = !GO_LEFT;
			}
		}
		
		if(abs(camToInt()-lastAdd)<3)
		{
			lastAdd -= create(lastAdd, allEnt);
			ads++;
		}
		//g_effector.interpolateMainColors();
		delete();
		//if(GetInputHandle().GetKeyState(K_SPACE)==KS_HIT)
		//execPause();
	}
	
	
	void execPause()
	{
		scale_factor=0;
		//SetTimeStepScale(0);
		PAUSE = true;
		PauseTime = GetTime();
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
		return (int(GetCameraPos().y*100/(70*GetScale()))-1);
	}
}
