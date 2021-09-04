void DrawNotification(string name, string font, uint stime, uint ltime)
{
if(auxtime!=0){
string text = "   "+name+"   "; 
vector2 size = ComputeTextBoxSize(font, text);

vector2 pos = vector2(650, 0);
if(GetTime()-(stime+auxtime)<=ltime && GetTime()-auxtime>=stime)
{
DrawShapedSprite("sprites/notificationbg.png", pos, vector2(size.x, size.y*2), 0xFFFFFFFF);
DrawText(vector2(650, size.y/4), text, font, 0xFF707070);
}
}
}
void cursor(string sprite)
{
DrawSprite(sprite, input.GetCursorPos()-vector2(7, 7));
}
uint a=200;
uint r=200;
uint g=200;
uint b=200;
void DrawRCText(vector2 pos, string text, string font)
{
r=rand(r-10, r+10);
g=rand(g-10, g+10);
b=rand(g-10, g+10);
if(r<10 || r>255)
r=200;
if(g<10 || g>255)
g=200;
if(b<10 || b>255)
b=200;
DrawText(pos, text, font, ARGB(255, r, g, b));
}
void DrawRCText2(vector2 pos, string text, string font)
{

DrawText(pos, text, font, ARGB(255,rand(255) ,rand(255), rand(255)));
}


void ShakeCamera(uint _power)
{
SetCameraPos(vector2(rand(_power*-1,_power), rand(_power*-1,_power)));
}

class CameraManager
{
private uint stime;
private uint ltime;
private uint power;
CameraManager(uint _power, uint _stime, uint _litme)
{
power=_power;
stime=_stime;
ltime=_litme;
}

void Shake()
{
if(GetTime()-stime<=ltime && GetTime()>=stime)
SetCameraPos(vector2(rand(power*-1,power), rand(power*-1,power)));
else
SetCameraPos(vector2(0, mainpos.y-384));
}
void Shake(uint _power, uint _stime, uint _litme)
{
if(GetTime()-_stime<=_litme && GetTime()>=_stime)
SetCameraPos(vector2(rand(_power*-1,_power), rand(_power*-1,_power)));
else
SetCameraPos(vector2(0, mainpos.y-384));
}

};










void ComputeCircleSize(float rx, float ry, float r, vector2[]&in Out)
{
float x,y;
for(x=rx-r; x<=rx+r; x++)
for(y=ry-r; y<=ry+r; y++)
if (((x*x)+(y*y))<(r*r)) {
Out.insertLast(vector2(x,y));
}
}

void ComputeCircleSize2(vector2&in pos, float radius, vector2[]&in aux)
{

for(int ax=1;ax<=1024;ax++)
{
for(int ay=1;ay<=768;ay++)
if(distance(vector2(ax,ay), pos)<=radius)
{
aux.insertLast(vector2(ax,ay)+GetCameraPos());
}
}
}


void PutPixel(vector2&in pos, uint color)
{
float ax=pos.x;
float ay=pos.y;
DrawLine(vector2(ax,ay), vector2(ax+0.5,ay), color, color, 0.5);
DrawLine(vector2(ax,ay+0.5), vector2(ax,ay+0.5), color, color, 0.5);
}


