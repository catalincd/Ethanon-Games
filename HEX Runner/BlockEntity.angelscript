class BlockEntity
{
	float x,y,angle;
	uint data;
	
	BlockEntity(float _x, float _y, float _a, uint _d)
	{
		x = _x;
		y = _y;
		angle = _a;
		data = _d;
	}
	BlockEntity(vector2 v, float _a, uint _d)
	{
		x = v.x;
		y = v.y;
		angle = _a;
		data = _d;
	}
	BlockEntity(){}
}