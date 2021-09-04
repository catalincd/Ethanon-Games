class Transition
{
	Timer@ timer = Timer(TRANSITION_TIME);
	bool transitioning = false;
	bool ascending = true;
	bool reverted = false;
	uint corner = 4;
	string fill = "sprites/square.png";

	void start()
	{
		timer.reset(TRANSITION_TIME);
		timer.setFilter(smoothEnd);
		ascending = true;
		transitioning = true;
		corner = rand(1,4);
		reverted = (rand(1,100) % 2 == 0);
	}
	
	bool loadScene()
	{
		return (transitioning && ascending && timer.isOver());
	}
	
	void update()
	{
		if(transitioning)
		{
			timer.update();
			
			if(corner == 1) draw(vector2(-1.0f, -1.0f), vector2(0.0f, 1.0f), vector2(0.0f, 0.0f), 0, 270);
			if(corner == 2) draw(vector2(GetScreenSize().x + 1.0f, -1.0f), vector2(0.0f, 0.0f), vector2(1.0f, 0.0f), 0, 270);
			if(corner == 3) draw(GetScreenSize() - vector2(-1.0f, -1.0f), vector2(1.0f, 1.0f), vector2(1.0f, 0.0f), 270, 0);
			if(corner == 4) draw(vector2(-1.0f, GetScreenSize().y + 1.0f), vector2(0.0f, 1.0f), vector2(1.0f, 1.0f), 270, 0);
			
			if(loadScene())
			{
				ascending = false;
				corner = (corner + 1) % 4 + 1;
				//reverted = (rand(1,100) % 2 == 0);
				timer.reset(TRANSITION_TIME);
				timer.setFilter(smoothBeginning);
				g_sceneManager.setNextScene();
			}
			
		}
	}
	
	
	
	void draw(vector2 pos, vector2 origin1, vector2 origin2, uint start, uint end)
	{
		float length = GetScreenSize().length() * 1.1f;
		vector2 size = vector2(length, length);
		vector2 originPos = pos;
		vector2 origin = reverted? origin2 : origin1;
		SetSpriteOrigin(fill, origin);
		
		
		float bias = timer.getBias();
		bias = ascending? bias : 1.0f - bias;
		
		uint nstart = reverted? end:start;
		uint nend = reverted? start:end;
		
		float angle = interpolate(nstart, nend, bias);
		
		DrawShapedSprite(fill, originPos, size, 0xFF000000, angle);
	}
}

Transition g_transition;

uint TRANSITION_TIME = 750;