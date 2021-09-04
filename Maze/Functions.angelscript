

void randomize(vector2[]& v)
{
	uint len = v.length();
	vector2[] old = v;
	for(uint i=0;i<len;i++)
	{
		uint newId = rand(0, old.length()-1);
		v[i] = old[newId];
		old.removeAt(newId);
	}
}

bool find(uint a, uint[] v)
{
	for(uint i=0;i<v.length();i++)
	{
		if(v[i] == a)
			return true;
	}
	
	return false;
}

uint[] getArrayFromString(string str)
{
	string[] splitted = split(str, ",");
	uint[] arr;
	for(uint i=0;i<splitted.length();i++)
	{
		arr.insertLast(parseUInt(splitted[i]));
	}
	return arr;
}

string getStringFromArray(uint[] arr)
{
	string str = ""+arr[0];
	for(uint i=1;i<arr.length();i++)
	{
		str += "," + arr[i];
	}
	return str;
}

float[] getFloatArrayFromString(string str)
{
	string[] splitted = split(str, ",");
	float[] arr;
	for(uint i=0;i<splitted.length();i++)
	{
		arr.insertLast(parseFloat(splitted[i]));
	}
	return arr;
}

string getStringFromFloatArray(float[] arr)
{
	string str = ""+arr[0];
	for(uint i=1;i<arr.length();i++)
	{
		str += "," + arr[i];
	}
	return str;
}

void randomize(spawn[]& v)
{
	uint len = v.length();
	spawn[] old = v;
	for(uint i=0;i<len;i++)
	{
		uint newId = rand(0, old.length()-1);
		v[i] = old[newId];
		old.removeAt(newId);
	}
}

void print(uint[] arr)
{
	string str = ""+arr[0];
	for(uint i=1;i<arr.length();i++)str+=" "+arr[i];
	print(str);
}


vector2 rotate(const vector2 &in p, const float angleRad)
{
	return vector2(
		p.x * cos(angleRad) + p.y * sin(angleRad),
	  - p.x * sin(angleRad) + p.y * cos(angleRad));
}

vector2 getVector2Deg(float angleDeg)
{
	return getVector2(degreeToRadian(angleDeg));
}

vector2 getVector2(float angleRad)
{
	return vector2(sin(angleRad), cos(angleRad));
}

float distance(ETHEntity@ a, ETHEntity@ b)
{
	return distance(a.GetPositionXY(), b.GetPositionXY());
}

float getAngle(vector2 P1, vector2 P2, vector2 P3)
{
	return atan2(P3.y - P1.y, P3.x - P1.x) - atan2(P2.y - P1.y, P2.x - P1.x);
}

float mod(float a, float b)
{
	return (a - float(uint(a/b))*b);
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

float getLength(vector2 v)
{
	return sqrt(v.x*v.x + v.y*v.y);
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

uint randOf(uint[] mArray)
{
	return mArray[rand(0, mArray.length()-1)];
}

