vector3 getAxis(vector3 accelerometer)
{
	float x2 = accelerometer.x * accelerometer.x;
	float y2 = accelerometer.y * accelerometer.y;
	float z2 = accelerometer.z * accelerometer.z;
	
	float x = radianToDegree(atan(accelerometer.x / sqrt(z2+y2)));
	float y = radianToDegree(atan(accelerometer.y / sqrt(x2+z2)));
	float z = radianToDegree(atan(accelerometer.z / sqrt(y2+x2)));
	
	return vector3(x,y,z);
}


vector3 getAxis()
{
	return getAxis(GetInputHandle().GetAccelerometerData());
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


bool close(float a, float b)
{
	return abs(a-b)<5.0f;
}

bool close(vector2 a, vector2 b)
{
	return (close(a.x, b.x) && close(a.y, b.y));
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

vector2 rotateAround(const float angleRad, const float radius)
{
	return vector2(sin(angleRad), cos(angleRad))*radius;
}

vector2 rotateAroundOrigin(vector2 p, vector2 origin, float angleRad)
{
	vector2 dir = origin - p;
	float radius = dir.length();
	float angleOriginal = getAngle(normalize(dir));
	return (origin - rotateAround(angleRad + angleOriginal, radius));	
}

vector2 rotateAroundRev(const float angleRad, const float radius)
{
	return vector2(cos(angleRad), sin(angleRad))*radius;
}