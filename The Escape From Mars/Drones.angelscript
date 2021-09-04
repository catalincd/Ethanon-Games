bool drone = false;
int drones = 0;

float AngleFromDirection(vector2 dir)
{
float toreturn;
toreturn = radianToDegree(getAngle(dir));
return toreturn;
}
/*
vector2 characterPos(200, 300);
vector2 potOfGoldPos(500, 800);

vector2 point, normal;
ETHEntity@ firstEntityFound = GetClosestContact(characterPos, potOfGoldPos, point, normal);

if (firstEntityFound !is null)
{
    if (firstEntityFound.GetEntityName() == "potOfGold.ent")
        print("The character sees the pot of gold!");
    else
        print("Something is in front of our view! The character can't see the pot of gold!");
}
else
{
    print("Nothing was found!");
}
*/



float GetAngleD(vector2 p0,vector2 p1, vector2 p2) {
   float   a = pow(p1.x-p0.x,2) + pow(p1.y-p0.y,2);
   float   b = pow(p1.x-p2.x,2) + pow(p1.y-p2.y,2);
   float   c = pow(p2.x-p0.x,2) + pow(p2.y-p0.y,2);
  
  return acos( (a+b-c) / sqrt(4*a*b) );
}
void ETHConstructorCallback_drone1p2(ETHEntity@ thisEntity)
{
thisEntity.SetUInt("nr", 1);
thisEntity.SetUInt("lastfire", 1);
}
bool d1p1a=false;
void ETHCallback_drone1p1(ETHEntity@thisEntity)
{
vector2 direction;
ETHEntity@ turret = SeekEntity("drone1p2.ent");
turret.SetPosition(thisEntity.GetPosition());
//SeekEntity("");
}
//ETHEntity@ asteroid1=null;
void ETHCallback_drone1p2(ETHEntity@ thisEntity)
{

vector2 dir(0, -1);
vector2 dir2(0, -1);
vector2 dir3(0, -1);
float angle=0.0f;
float angle2=0.0f;
angle=radianToDegree(GetAngle(vector2(thisEntity.GetPosition().x, thisEntity.GetPosition().y), thisEntity.GetPositionXY(),SeekEntity("asteroide.ent").GetPositionXY()));
//print(""+vector2ToString(SeekEntity("asteroide.ent").GetPositionXY()));
dir3=rotate(dir3, degreeToRadian(angle2));
if(angle2 == AngleFromDirection(dir3))
print("ESTE!");

if(thisEntity.GetAngle()>angle)
thisEntity.AddToAngle(UnitsPerSecond(-200));
if(thisEntity.GetAngle()<angle)
thisEntity.AddToAngle(UnitsPerSecond(200));
if(thisEntity.GetUInt("nr")%2==0)
dir=rotate(dir, degreeToRadian(thisEntity.GetAngle()+30));
else
dir=rotate(dir, degreeToRadian(thisEntity.GetAngle()-30));
dir2=rotate(dir2, degreeToRadian(thisEntity.GetAngle()));
if(GetTime()-thisEntity.GetUInt("lastfire")>=500)
{
ETHEntity@ missile=null;
thisEntity.AddToUInt("nr", 1);
AddEntity("missile.ent", thisEntity.GetPosition()+vector3(dir*35, 0), missile);
if(missile !is null)
{
missile.SetAngle(thisEntity.GetAngle());
missile.SetVector2("direction", dir2);
}
thisEntity.SetUInt("lastfire", GetTime());
}
}


void ETHPreSolveContactCallback_drone1p1(
ETHEntity@ thisEntity, 
ETHEntity@ other, 
vector2 contactPointA, 
vector2 contactPointB, 
vector2 contactNormal)
{
if(other.GetEntityName()=="drone1p2.ent")
DisableContact();
}