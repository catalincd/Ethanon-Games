class Camera : GameObject
{
	
	vector2 currentPos;
	vector2 currentOffset;
	vector2 screenOffset;
	
	uint shakeStride = 750;
	float amplitude = 20;
	
	bool shaking = false;
	bool didntSet = true;
	uint shakeElapsed = 0;
	
	float maxAcceptableOffset = 100;
	
	ETHEntity@ background;
	
	vector2 halfScreen = GetScreenSize() / 2;
	float yOffset;
	
	string[] backgrounds = {"Castles", "ColorDesert", "ColorForest", "ColorGrass", "Desert", "Empty", "Forest"};

	void create()
	{
		
	
		currentPos = V2_ZERO;
		currentOffset = V2_ZERO;
		
		screenOffset = GetScreenSize() * vector2(0.5f, 0.65f);
		
		maxAcceptableOffset = 100 * GetScale();
		
		amplitude = 40 * GetScale();
		
		shakeElapsed = 0;
		shaking = false;
		
		didntSet = true;
		
		AddEntity("background.ent", vector3(GetScreenSize().x/2, 0, 0), @background);
		
		string newBack = "entities/background";
		newBack += backgrounds[rand(0, backgrounds.length() - 1)];
		newBack += ".png";
		
		background.SetSprite(newBack);
		
		background.Scale(1.1f);
		
		halfScreen = GetScreenSize() / 2;
	}
	
	
	void update()
	{
		
		
		
		if(shaking)
		{
			shakeElapsed += GetLastFrameElapsedTime();
			float shakeBias = float(shakeElapsed) / float(shakeStride);
			shakeBias = shakeSmooth(min(1.0f, shakeBias));
			
			
			currentOffset = vector2(randF(-1.0f, 1.0f), randF(-1.0f, 1.0f)) * amplitude * shakeBias;
			
			if(shakeElapsed > 2000 && didntSet)
			{
				didntSet = false;
				g_sceneManager.setScene(MainMenuScene());
			}
		}
		else 
		if(!GAME_OVER)
		{	
		
			float charPos = o_jumper.GetPositionXY().y;
			float supposedCameraPos = charPos - screenOffset.y;
			
			
			float dif = currentPos.y - supposedCameraPos;
			if(dif > maxAcceptableOffset)
			{
				currentPos.y = supposedCameraPos + maxAcceptableOffset;
				
			}
		}
		
		
		SetCameraPos(vector2(0, currentPos.y) + currentOffset);
		
		
		if(!GAME_OVER)
		{
			yOffset = ((GetCameraPos().y) / GetScale()) / -100;
			if(yOffset > V2_256.x * 1.5f)
				yOffset = V2_256.x * 1.5f;
			
		}
		background.SetPositionXY(GetCameraPos() + vector2(halfScreen.x, GetScreenSize().y + yOffset));
		//print(currentPos);
	}
	
	
	void shake()
	{
		shaking = true;
		shakeElapsed = 0;
		
	}
	
	
	void resume()
	{
		SetBackgroundColor(backColor);
	}
	
	string getTag()
	{
		return "Camera";
	}
}


Camera o_camera;


float shakeSmooth(float v, float top = 0.12f)
{
	if(v < top)
	{
		return v / top;
	}
	else return (1.0f - ((v - top) / (1.0f - top)));
}


void print(vector2 v)
{
	print(vector2ToString(v));
}