class Input
{
	bool TouchHit()
	{
		return GetInputHandle().GetTouchState(0) == KS_HIT;
	}
	
	bool TouchDown()
	{
		return GetInputHandle().GetTouchState(0) == KS_DOWN;
	}
	
	vector2 TouchPos()
	{
		return GetInputHandle().GetTouchPos(0);
	}
	
	vector3 Acceleration()
	{
		return GetInputHandle().GetAccelerometerData();
	}
}

Input input;