class RatingScene : Scene
{

	RatingScene()
	{
		const string sceneName = "empty";
		super(sceneName);
	}
	
	void onCreated()
	{	
		SetBackgroundColor(white);
		//buddy.set();

	}
	
	void onUpdate()
	{	
		buddy.draw();
	}
}