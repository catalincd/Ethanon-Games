class MainMenuScene : Scene
{

	MainMenuScene()
	{
		const string sceneName = "empty";
		super(sceneName);
	}
	
	uint idx = 0;
	float initOffset = 0;
	InterpolationTimer@ timer = InterpolationTimer(200);
	float dir = 0;
	
	void onCreated()
	{	
		SetBackgroundColor(white);
		buddy.create();
		mainMenu.create();
		ratings.create();
		dir = 0;
		g_touchManager.create();
	}
	
	void onUpdate()
	{	
		if(idx==0)
			updateMain();
		if(idx==1)
			updateRatings();
		
	}
	
	void updateRatings()
	{
		buddy.draw();
		ratings.update();
		if(g_touchManager.previousPage())
		{
			g_touchManager.reset();
			idx = 0;
			buddy.setNewPosition(vector2(360,350));
			dir = 1;
		}
	}
	
	void updateMain()
	{
		buddy.draw();
		g_touchManager.update();
		timer.update();
		initOffset = (1-timer.getBias())*150*dir;
		mainMenu.update(g_touchManager.getOffset(), g_touchManager.buttonTouch(), g_touchManager.getTouchPos()+initOffset);
		//buddy.setPositionOffset(vector2(g_touchManager.getOffset()*0.5,0));
		
		if(g_touchManager.nextPage())
		{
			g_touchManager.reset();
			g_touchManager.limitRight = true;
			idx = 1;
			ratings.reset();
			buddy.setNewPosition(vector2(500,350));
		}
		if(g_touchManager.previousPage())
		{
			print("YO");
		}
	}
	
}