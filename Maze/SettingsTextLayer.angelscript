class SettingsTextLayer : Layer
{
	
	uint backButton;bool backing = false;
	

	SettingsTextLayer()
	{
		
	}
	
	void init()
	{
		Layer::init();
		backButton = insertElement(Text("SAVE AND EXIT", f128, GetScreenSize() * vector2(0.5f, 0.8f)));
	}
	
	void create()
	{
		Layer::create();
		backing = false;
		Element@ x = e(backButton);x.scale = GetScale();x.setFadeIn(BasicFadeIn(x));x.fadeIn.setDelay(50);x.setFadeOut(BasicFadeOut(x));
	}
	
	void fadeOut(uint lateItem)
	{
		Element@ itm = e(lateItem);itm.fadeOut.setDelay(100);
	
		Element@ x = e(backButton);x.fadeOut.begin();
	}
	
	void update()
	{
		Layer::update();
		
		Element@ bb = e(backButton);
		if(bb.isHit() && !backing)
		{
			setScene(MainMenuScene);
			backing = true;
			fadeOut(backButton);
		}
	}
}