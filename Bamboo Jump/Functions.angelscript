vector2 getCirclePosition(vector2 center, float angle, float radius)
{
	float __x = radius*cos(angle);
	float __y = radius*sin(angle)*-1;
	return center+vector2(__x, __y);
}

vector2 getSquarePosition2(vector2 center, float angle, float radius)
{
	float __x = radius*cos(angle);
	float __y = radius*sin(angle)*-1;
	return center+vector2(__x, __y);
}

void LimitMin(float &in q, float lim)
{
	if(q<lim)
		q = lim;
}



void LimitMax(float &in q, float lim)
{
	if(q>lim)
		q = lim;
}

/*
void addTime(uint milli)
{
	g_timeManager.add(milli/1000);
	dataBase.saveTime();
}*/

string timeString(float x)
{
	uint minutes = uint(x);
	uint hours = minutes/60;
	minutes%=60;
	
	return ""+hours+" HOURS  "+minutes+" MIN";
}

vector2 getSquarePosition(vector2 center, float angle, float radius)
{
	float __x, __y;
	float angle2;
	if(angle > 315 || angle <= 45)
	{	
		angle2 = degreeToRadian(angle);
		__y = center.y-radius;
		__x = center.x-radius*tan(angle2);
	}
	
	if(angle > 45 && angle <= 135)
	{
		angle2 = degreeToRadian(90-angle);
		__y = center.y+radius*tan(angle2);
		__x = center.x+radius;
	}
	
	if(angle > 135 && angle <= 225)
	{
		angle2 = degreeToRadian(angle);
		__y = center.y+radius;
		__x = center.x+radius*tan(angle2);
	}
	
	if(angle > 225 && angle <= 315)
	{
		angle2 = degreeToRadian(90-angle);
		__y = center.y+radius*tan(angle2)*-1;
		__x = center.x-radius;
	}
	return vector2(__x, __y);
}


float getScale() { return 1/GetScale();}
vector2 getScreenSize() { return GetScreenSize()*getScale();}

void drawText(vector2 v2, string str1, string str2, uint ui1, const float tscale = 1.0)
{
	DrawText(v2, str1, str2, ui1, GetScale()*tscale);
}

void drawSprite(string _name, vector2 _position, const float sscale = 1.0, const uint colorx = white)
{
	DrawShapedSprite(_name, _position, GetSpriteFrameSize(_name)*GetScale()*sscale, colorx);
}


float round(float _in, int tenPow)
{
	float aux = _in * pow(10, tenPow);
	return float(int(aux))/pow(10, tenPow);
}

vector3 round(vector3 _in, int tenPow)
{
	return vector3(round(_in.x, tenPow),round(_in.y, tenPow),round(_in.z, tenPow));
}

void AddEntity(string name, vector3 pos, ETHEntity@ en, string newName)
{
	AddEntity(name, pos, 0, @en, newName, 1);
}

uint scoreToLevel(uint score)
{
	return uint(sqrt(float(score)/10000.0));
}

uint levelToScore(uint level)
{
	return level*level*10000;
}

vector2 rotate(float radius, float angle)
{
	return vector2(sin(angle),cos(angle))*radius;
}

vector2 rotateNormal(float angle)
{
	return vector2(sin(angle),cos(angle));
}

float getLength(vector2 v)
{
	return sqrt(v.x*v.x + v.y*v.y);
}