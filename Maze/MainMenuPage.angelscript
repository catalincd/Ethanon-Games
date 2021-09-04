class MainMenuPage : Page
{

	TextButton@ startButton;
	TextButton@ casualButton;
	TextButton@ settingsButton;

	void init() override
	{
		
	}
	
	void create() override
	{
		@startButton = TextButton("START", GetScreenSize() * V2_HALF, f128, black);
		startButton.setDelay(150);
		
		@casualButton = TextButton("CASUAL", GetScreenSize() * vector2(0.5f, 0.6f), f128, black);
		casualButton.setDelay(250);
		
		@settingsButton = TextButton("SETTINGS", GetScreenSize() * vector2(0.5f, 0.7f), f128, black);
		settingsButton.setDelay(350);
	}
	
	void resetAndFade()
	{
		startButton.setDelay(200);startButton.FadeOut();
		casualButton.setDelay(200);casualButton.FadeOut();
		settingsButton.setDelay(200);settingsButton.FadeOut();
	}
	
	void update() override
	{
		startButton.update();
		casualButton.update();
		settingsButton.update();
		
		
		if(startButton.isHit())
		{
			CASUAL = false;
			resetAndFade();
			startButton.setDelay(50);
			gameScene();
		}
		
		if(casualButton.isHit())
		{
			CASUAL = true;
			resetAndFade();
			casualButton.setDelay(50);
			casualScene();
		}
		
		if(settingsButton.isHit())
		{
			resetAndFade();
			settingsButton.setDelay(50);
			settingsScene();
		}
	}
}