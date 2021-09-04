/*--------------------------------------------------------------------------------------
 Ethanon Engine (C) Copyright 2008-2012 Andre Santee
 http://www.asantee.net/ethanon/

	Permission is hereby granted, free of charge, to any person obtaining a copy of this
	software and associated documentation files (the "Software"), to deal in the
	Software without restriction, including without limitation the rights to use, copy,
	modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
	and to permit persons to whom the Software is furnished to do so, subject to the
	following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
	INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
	PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
	CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
	OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
______________________________________________________________________________________*/

vector2 Only(vector2 &in p)
{
vector2 toreturn;
if(p.x<1 && p.x>0)
toreturn.x=p.x;
if(p.y<1 && p.y>0)
toreturn.y=p.y;
if(p.x>=1)
toreturn.x=1;
if(p.x==0)
toreturn.x=0;
if(p.x<=-1)
toreturn.x=-1;
if(p.y>=1)
toreturn.y=1;
if(p.y==0)
toreturn.y=0;
if(p.x<=-1)
toreturn.y=-1;
return toreturn;
}

double GetAngle( vector2 a, vector2 b, vector2 c )
{
    vector2 ab (b.x - a.x, b.y - a.y) ;
    vector2 cb (b.x - c.x, b.y - c.y) ;

    float dot = (ab.x * cb.x + ab.y * cb.y); // dot product
    float cross = (ab.x * cb.y - ab.y * cb.x); // cross product

    float alpha = atan2(cross, dot);

    return floor(alpha * 180. / PI + 0.5);
}
/*
double GetAngle(vector2 &in p0, vector2 &in p1, vector2 &in p2 ){
double	a = pow(p1.x-p0.x,2) + pow(p1.y-p0.y,2);
double	b = pow(p1.x-p2.x,2) + pow(p1.y-p2.y,2);
double  c = pow(p2.x-p0.x,2) + pow(p2.y-p0.y,2);

double toreturn=radianToDegree(acos( (a+b-c) / sqrt(4*a*b) ));

return toreturn;
}*/




void DrawTextInTime(vector2 pos, string name, string font, uint argb, uint stime, uint blink)
{
string text=name.substr(0,1);
int li=1;

if(GetTime()-stime>=blink)
{
text=name.substr(0,2);
}
if(GetTime()-stime>=2*blink)
{
text=name.substr(0,3);
}
if(GetTime()-stime>=3*blink)
{
text=name.substr(0,4);
}
if(GetTime()-stime>=4*blink)
{
text=name.substr(0,5);
}
if(GetTime()-stime>=5*blink)
{
text=name.substr(0,6);
}
if(GetTime()-stime>=6*blink)
{
text=name.substr(0,7);
}
if(GetTime()-stime>=7*blink)
{
text=name.substr(0,8);
}
if(GetTime()-stime>=8*blink)
{
text=name.substr(0,9);
}
if(GetTime()-stime>=9*blink)
{
text=name.substr(0,10);
}
DrawText(pos, text, font, argb);

}

void DrawTextInBox(vector2 pos, string text, string font, uint argb){

string name=" "+text+" ";
vector2 box = ComputeTextBoxSize(font, name);
DrawShapedSprite("sprites/box.png",pos, box, 0xFFFFFFFF);
DrawText(pos, name, font, argb);
}

void DTBT(vector2 pos, string name, string font, uint argb, uint stime ,uint blink){

string text=" "+name.substr(0,1);

if(GetTime()-stime>=blink)
{
text=name.substr(0,2);
}
if(GetTime()-stime>=2*blink)
{
text=name.substr(0,3);
}
if(GetTime()-stime>=3*blink)
{
text=name.substr(0,4);
}
if(GetTime()-stime>=4*blink)
{
text=name.substr(0,5);
}
if(GetTime()-stime>=5*blink)
{
text=name.substr(0,6);
}
if(GetTime()-stime>=6*blink)
{
text=name.substr(0,7);
}
if(GetTime()-stime>=7*blink)
{
text=name.substr(0,8);
}
if(GetTime()-stime>=8*blink)
{
text=name.substr(0,9);
}
if(GetTime()-stime>=9*blink)
{
text=name.substr(0,10);
}
string x=" "+text+" ";
vector2 box = ComputeTextBoxSize(font, x);
if(GetTime()>=stime){
DrawShapedSprite("sprites/box.png",pos, box, 0xFFFFFFFF);
DrawText(pos, x, font, argb);
}
}
void limitPositionToScreen(ETHEntity@ entity)
{
	vector2 screenSize = GetScreenSize();
	vector2 pos = entity.GetPositionXY();

	if (pos.x < 0.0f)
		entity.SetPositionX(0.0f);
	if (pos.y < 0.0f)
		entity.SetPositionY(0.0f);

	if (pos.x > screenSize.x)
		entity.SetPositionX(screenSize.x);
	if (pos.y > screenSize.y)
		entity.SetPositionY(screenSize.y);
}

bool isPointInScreen(vector2 p)
{
	p -= GetCameraPos();
	if (p.x < 0 || p.y < 0 || p.x > GetScreenSize().x || p.y > GetScreenSize().y)
		return false;
	else
		return true;
}

/// Creates a string from a vector3
string vector3ToString(const vector3 v3)
{
	return "(" + v3.x + ", " + v3.y + ", " + v3.z + ")";
}

/// Creates a string from a vector2
string vector2ToString(const vector2 v2)
{
	return "(" + v2.x + ", " + v2.y + ")";
}

/// Converts a pixel format assignment to a stringInput
string formatToString(const PIXEL_FORMAT format)
{
	if (format == PF32BIT)
		return "32";
	if (format == PF16BIT)
		return "16";
	return "unknown";
}

/// Creates an array containing every entity within thisEntity's bucket and the buckets around it, including itself
void getSurroundingEntities(ETHEntity @thisEntity, ETHEntityArray @outEntities)
{
	const vector2 bucket(thisEntity.GetCurrentBucket());
	GetEntitiesFromBucket(bucket, outEntities);
	GetEntitiesFromBucket(bucket+vector2(1,0), outEntities);
	GetEntitiesFromBucket(bucket+vector2(1,1), outEntities);
	GetEntitiesFromBucket(bucket+vector2(0,1), outEntities);
	GetEntitiesFromBucket(bucket+vector2(-1,1), outEntities);
	GetEntitiesFromBucket(bucket+vector2(-1,0), outEntities);
	GetEntitiesFromBucket(bucket+vector2(-1,-1), outEntities);
	GetEntitiesFromBucket(bucket+vector2(0,-1), outEntities);
	GetEntitiesFromBucket(bucket+vector2(1,-1), outEntities);
}

/// Finds an entity named 'entityName' among all thisEntity's surrounding entities.
ETHEntity @findAmongNeighbourEntities(ETHEntity @thisEntity, const string entityName)
{
	ETHEntityArray entityArray;
	getSurroundingEntities(thisEntity, entityArray);
	uint size = entityArray.size();
	for (uint t=0; t<size; t++)
	{
		if (entityArray[t].GetEntityName() == entityName)
		{
			return @entityArray[t];
		}
	}
	return null;
}

/// Scans the screen for an entity named 'name' and returns a handle to it if found.
ETHEntity @findEntityInScreen(const string name)
{
	ETHEntityArray entities;
	GetVisibleEntities(entities);
	for (uint t=0; t<entities.size(); t++)
	{
		if (entities[t].GetEntityName() == name)
		{
			return entities[t];
		}
	}
	return null;
}

class Sphere
{
	Sphere(const vector3 _pos, const float _radius)
	{
		pos = _pos;
		radius = _radius;
	}
	vector3 pos;
	float radius;
}

bool intersectSpheres(const Sphere @a, const Sphere @b)
{
	if (distance(a.pos, b.pos) > a.radius+b.radius)
		return false;
	else
		return true;
}

class Circle
{
	Circle(const vector2 _pos, const float _radius)
	{
		pos = _pos;
		radius = _radius;
	}
	vector2 pos;
	float radius;
}

bool intersectCircles(const Circle @a, const Circle @b)
{
	if (distance(a.pos, b.pos) > a.radius+b.radius)
		return false;
	else
		return true;
}

/* 
 * stringInput class:
 * Places an input area on screen where the user can type texts
 */
class stringInput
{
	stringInput()
	{
		blinkTime = 300;
		lastBlink = 0;
		showingCarret = 1;
	}
	void PlaceInput(const string text, const vector2 pos, const string font, const uint color)
	{
		const uint time = GetTime();
		if ((time-lastBlink) > blinkTime)
		{
			showingCarret = showingCarret==0 ? 1 : 0;
			lastBlink = GetTime();
		}
	
		ETHInput @input = GetInputHandle();
		
		string lastInput = input.GetLastCharInput();
		if (lastInput != "")
		{
			ss += lastInput;
		}
		
		if (input.GetKeyState(K_BACKSPACE) == KS_DOWN || input.GetKeyState(K_LEFT) == KS_DOWN)
		{
			const uint len = ss.length();
			if (len > 0)
				ss.resize(len-1);
		}
		
		string outputString = text + ": " + ss;
		if (showingCarret==1)
			outputString += "|";
		DrawText(pos, outputString, font, color);
	}
	
	string GetString()
	{
		return ss;
	}
	
	private uint blinkTime;
	private uint lastBlink;
	private uint showingCarret;
	private string ss;
}

/* 
 * frameTimer class:
 * This object helps handling keyframe animation
 */
class frameTimer
{
	frameTimer()
	{
		m_currentFrame = m_currentFirst = m_currentLast = 0;
		m_lastTime = 0;
	}

	uint Get()
	{
		return m_currentFrame;
	}

	uint Set(const uint first, const uint last, const uint stride)
	{
		if (first != m_currentFirst || last != m_currentLast)
		{
			m_currentFrame = first;
			m_currentFirst = first;
			m_currentLast  = last;
			m_lastTime = GetTime();
			return m_currentFrame;
		}

		if (GetTime()-m_lastTime > stride)
		{
			m_currentFrame++;
			if (m_currentFrame > last)
				m_currentFrame = first;
			m_lastTime = GetTime();
		}

		return m_currentFrame;
	}

	private uint m_lastTime;
	private uint m_currentFirst;
	private uint m_currentLast;
	private uint m_currentFrame;
}
