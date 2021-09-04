vector2 rotate(const vector2 &in p, const float angleRad)
{
	return vector2(
		p.x * cos(angleRad) + p.y * sin(angleRad),
	  - p.x * sin(angleRad) + p.y * cos(angleRad));
}

float pythagoras(float x, float y)
{
	return sqrt(x*x+y*y);
}

bool close(float a, float b)
{
	return abs(a-b)<5.0f;
}

bool close(vector2 a, vector2 b)
{
	return (close(a.x, b.x) && close(a.y, b.y));
}

vector2 rotateAround(const float angleRad, const float radius)
{
	return vector2(sin(angleRad), cos(angleRad))*radius;
}

vector2 rotateAroundRev(const float angleRad, const float radius)
{
	return vector2(cos(angleRad), sin(angleRad))*radius;
}

float absoluteAngle(float q)
{
	if(q > 0) return q;
	return 360+q;
}

vector2 stringToVector2(string q)
{
	uint comma = q.find(",");
	uint len = q.length();
	float x = parseFloat(q.substr(1, comma-1));
	float y = parseFloat(q.substr(comma+1, len-1));
	return vector2(x,y);
}

string[] split(string str, const string c)
{
	string[] v;
	uint pos;
	while ((pos = str.find(c)) != NPOS)
	{
		v.insertLast(str.substr(0, pos));
		str = str.substr(pos + c.length(), NPOS);
	}
	v.insertLast(str);
	return v;
}

bool parseBoolFromUInt(string str)
{
	return parseUInt(str)>0;
}

BlockEntity stringToEntity(string q)
{
	uint len = q.length()-1;
	q = q.substr(1,len);
	string[] arr = split(q, ",");
	float x = parseFloat(arr[0]);
	float y = parseFloat(arr[1]);
	float a = parseFloat(arr[2]);
	uint d = parseUInt(arr[3]);
	return BlockEntity(x,y,a,d);
}