bool isPointInRect(const vector2 &in p, const vector2 &in pos, const vector2 &in size, const vector2 &in origin)
{	
	vector2 posRelative = vector2(pos.x - size.x * origin.x, pos.y - size.y * origin.y);
	if (p.x < posRelative.x || p.x > posRelative.x + size.x || p.y < posRelative.y || p.y > posRelative.y + size.y)
		return false;
	else
		return true;
}


bool isPointInRect(const vector2 &in p, const vector2 &in topLeft, const vector2 &in bottomRight)
{
	if(p.x < topLeft.x || p.y < topLeft.y || p.x > bottomRight.x || p.y > bottomRight.y)
		return false;
	else
		return true;
}