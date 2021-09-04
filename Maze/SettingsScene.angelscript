class SettingsSceneClass : Scene
{

	FloatBouncer@ backgroundBouncer;
	SettingsPage@ page;
	uint runs = 0;
	

	SettingsSceneClass()
	{
		super("empty");
		init();
	}
	
	void init()
	{
		@backgroundBouncer = FloatBouncer(0.0f, 1.0f, A_SLOW * 7);
		backgroundBouncer.setFilter(defaultFilter);
		
		@page = SettingsPage();
		page.init();
	}
	
	void create()
	{	
		
		page.create();
	}
	
	void update()
	{
		
		page.update();
		
		backgroundBouncer.update();
		SetBackgroundColor((interpolate(whiteGrey, lightGrey, backgroundBouncer.getBounceScale())).getUInt());
	}
	
	
	void resume()
	{
		
	}
}

SettingsSceneClass SettingsScene;

