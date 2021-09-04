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
		angle+=randF(-radiusAddLimit,radiusAddLimit);
		posOffset+=rotate(radiusToAdd, angle);
		if(getLength(posOffset)>radiusLimit)
			angle = float((uint(angle)+180)%360);
	}
}