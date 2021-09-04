class SettingsPage : Page
{
	
	TextButton@ backButton;

	void init() override
	{
		
	}
	
	void create() override
	{
		g_settings.create();
	
		@backButton = TextButton("SAVE AND EXIT", GetScreenSize() * vector2(0.5f, 0.95f), f128, black);
		backButton.setDelay(150);
	}
	
	void resetAndFade()
	{
		backButton.setDelay(200);backButton.FadeOut();
	}
	
	void update() override
	{
	
		g_settings.update();
		g_settings.save();
	
		backButton.update();
		
		if(backButton.isHit())
		{
			resetAndFade();
			backButton.setDelay(50);
			mainMenu();
		}
	}
}