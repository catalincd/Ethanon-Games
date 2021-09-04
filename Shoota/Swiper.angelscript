class Swiper : GameObject
{

	float sensitivity = 3.0f;
	vector2 offset;
	bool released = false;
	
	void create()
	{
	
	}
	
	void update()
	{
		released = false;
		ETHInput@ input = GetInputHandle();
		KEY_STATE touchState = input.GetTouchState(0);
		if(touchState == KS_HIT)
		{
			offset = 0;
		}
		
		if(touchState == KS_DOWN)
		{
			offset += input.GetTouchMove(0);
		}
		
		if(touchState == KS_RELEASE)
		{
			released = true;
		}
		
	}
	
	
	
	void resume(){}
	string getTag(){return "Swiper";}
}

Swiper g_swiper;

bool goSwipeUp()
{
	if(g_swiper.released)
		return triggerSwipeUp(g_swiper.offset, g_swiper.sensitivity);
	
	return false;
}

bool triggerSwipeUp(vector2 offset, float sensitivity)
{
	if(offset.y > -1)
		return false;
	float yScreenSize = GetScreenSize().y;
	float ratio = abs(offset.y) / yScreenSize;
	
	return ratio / sensitivity > 0.5f;
}
