class MainMenuSceneClass : Scene
{

	

	MainMenuSceneClass()
	{
		super("empty");
	}
	
	
	void create() override
	{
		SetBackgroundColor(white.getUInt());
	}
	
	void update() override
	{
	
		DrawText("PRESS START", "Verdana64.fnt", GetScreenSize() / 2, black.getUInt(), V2_HALF, 2.0f);
	
		if(GetInputHandle().GetTouchState(0) == KS_HIT)
		{
			setScene(GameScene);
		}
		
		
	
	}
	
	void resume() override
	{
		SetBackgroundColor(white.getUInt());

	}
	
}

void DrawText(string text, string font, vector2 pos, uint color = white, vector2 origin = V2_HALF, float scale = 1.0f)
{
	float newScale = scale * GetScale();
	vector2 size = ComputeTextBoxSize(font, text) * newScale;
	vector2 relPos = pos - (size * origin);
	DrawText(relPos, text, font, color, newScale);
}



MainMenuSceneClass MainMenuScene;
	