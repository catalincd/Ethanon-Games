class PositionRandomizer
{
	float angle = 0;
	float radiusAddLimit;
	float radiusToAdd;
	vector2 posOffset = 0;
	float radiusLimit;

	void create(float ratio1, float ratio2, float limit)
	{
		radiusAddLimit = ratio1;
		radiusToAdd = ratio2;
		radiusLimit = limit;
		posOffset = V2_ZERO;
	}
	
	vector2 getOffset()
	{
		return posOffset;
	}

	void update()
	{
		angle += radiusAddLimit*randF(-1,1);
		posOffset += rotate(UnitsPerSecond(20)*radiusToAdd, angle);
		if(getLength(posOffset)>radiusLimit)
		{
			posOffset -= rotate(UnitsPerSecond(20)*radiusToAdd, angle);
			angle = float((uint(angle)+150+rand(60))%360);
		}
	}
}



float UnitsPerSecondValue(float f)
{
	return UnitsPerSecond(f*60);
}