

float damage=100;
float maxDamage=100;
float fnitro=100;
float maxNitro=100;
void ETHConstructorCallback_spaceship(ETHEntity@ thisEntity){
thisEntity.SetInt("hp", hpp);
}
void ETHConstructorCallback_spaceship2(ETHEntity@ thisEntity){
thisEntity.SetInt("hp", hpp);}
void ETHConstructorCallback_spaceship3(ETHEntity@ thisEntity){
thisEntity.SetInt("hp",hpp);}
void ETHConstructorCallback_spaceship4(ETHEntity@ thisEntity){
thisEntity.SetInt("hp",hpp);}
void ETHConstructorCallback_spaceship5(ETHEntity@ thisEntity){
thisEntity.SetInt("hp",hpp);
thisEntity.SetUInt("fire",1);
}
void ETHConstructorCallback_spaceship6(ETHEntity@ thisEntity){
thisEntity.SetInt("hp",hpp);
}
void upadteGameOver()
{
DrawText(vector2(300,100), "Game Over", "Verdana64_shadow.fnt", 0xFF0000FF);
Button@ g_Exit;
	@g_Exit = Button("sprites/exit.png", vector2(934,660));
	
	g_Exit.putButton();
	if (g_Exit.isPressed()){
	level=1;
	LoadScene("scenes/start.esc", "createStartScene", "updateStartScene", "Loads");}

DrawText(vector2(300,200), "You survived in the space "+days+" days.", "Verdana30_shadow.fnt", 0xFF0000FF);
}
bool hastostart=false;
bool hastofire=false;
bool hasStarted=false;
bool toaddangle=false;
int ozninterval=500;
int ozntime=0;
int oznlastfire=0;
int angleto=0;

void ETHConstructorCallback_ozn(ETHEntity@ thisEntity)
{thisEntity.SetInt("hp", 110);}
void ETHCallback_ozn(ETHEntity@ thisEntity)
{
ETHEntity@ missile=null;
if(thisEntity.GetInt("hp")<=0)
{
AddEntity("ozne.ent", thisEntity.GetPosition());
money+=150;
DeleteEntity(thisEntity);

}
if(distance(thisEntity.GetPositionXY(), mainpos)<=400 && !hastofire)
{
hasStarted=true;
hastofire=true;
}
if(hasStarted)
{
ozntime=GetTime();
toaddangle=true;
hasStarted=false;
}
if(angleto<=150)
{angleto=250;}
if(toaddangle)
{
if(angleto<=450){
angleto=(GetTime()-ozntime)/100;}
thisEntity.AddToAngle(UnitsPerSecond(-angleto));
}
if(angleto>=250)
{hastostart=true;}
vector2 mdir=normalize(thisEntity.GetPositionXY()-mainpos);
if(hastostart && GetTime()-oznlastfire>=ozninterval)
{
oznlastfire=GetTime();
//print(vector2ToString(Only(mdir)));
//print(""+GetAngle(thisEntity.GetPositionXY()-vector2(0, 30),thisEntity.GetPositionXY(), Only(mdir)*150));

AddEntity("oznmissile.ent", thisEntity.GetPosition()+vector3(normalize(mdir)*-150, 0), missile);

if(missile !is null){

//missile.SetAngle(GetAngle(thisEntity.GetPositionXY()-vector2(0, 30),thisEntity.GetPositionXY(), normalize(mdir)*150));
missile.SetVector2("direction", mdir*-1);}
}
}

CameraManager@ c_ship;


int rl2=100;
void ETHCallback_spaceship(ETHEntity@ thisEntity)
{ 	

		

	naveposx=thisEntity.GetPosition().x;
	naveposy=thisEntity.GetPosition().y;mainpos=thisEntity.GetPositionXY();
	ETHInput@ input = GetInputHandle();
	float ang=thisEntity.GetAngle(); 
	lpos=thisEntity.GetPosition();
	float angleSpeed;
	if(!nitro){
	speed = UnitsPerSecond(180.0f);
	 angleSpeed = UnitsPerSecond(120.0f);}
	else
	{speed = UnitsPerSecond(180.0f)*1.5;
	angleSpeed = UnitsPerSecond(120.0f)*1.5;}
	vector2 direct;
	direction=vector2(0.0f,-1.0f);
	direct=vector2(0.0f,-1.0f);
	
	if (input.KeyDown(K_RIGHT))
	{
		thisEntity.AddToAngle(-angleSpeed);
		fnitro-=0.045;
	}

	if (input.KeyDown(K_LEFT))
	{
		thisEntity.AddToAngle(angleSpeed);
		fnitro-=0.045;
	}
	
	if(level == 3 or level == 7 or level == 8)
{
if(thisEntity.GetPositionY()<0)
thisEntity.SetPositionY(768);
if(thisEntity.GetPositionY()>768)
thisEntity.SetPositionY(0);
}
	direction = rotate(direction, degreeToRadian(thisEntity.GetAngle()));

	thisEntity.SetVector2("direction", direction);
	thisEntity.SetVector2("direction", direction);
maindir = direction;
	direct = rotate(direct, degreeToRadian(thisEntity.GetAngle()+angle));
	maindir = direction;
	if (input.KeyDown(K_UP))
	{	if(!IsSamplePlaying("soundfx/boostb.mp3")){PlaySample("soundfx/boostb.mp3");}
		thisEntity.AddToPositionXY(allPositionsAdderValue*direction * speed);
		fnitro-=0.09;
	}
	if (input.KeyDown(K_DOWN))
	{	if(!IsSamplePlaying("soundfx/boostb.mp3")){PlaySample("soundfx/boostb.mp3");}
		thisEntity.AddToPositionXY(allPositionsAdderValue*direction *-speed*1.3);
		fnitro-=0.09;
	}
	//SeekEntity("shotexplosion.ent").SetPosition(thisEntity.GetPosition()+vector3(direction*95,0));
	ETHEntity @shot = SeekEntity("shotexplosion.ent");
		if(shot !is null){shot.SetPosition(thisEntity.GetPosition()+vector3(direction*95,0));}
	
	if (input.GetKeyState(K_SPACE) == KS_HIT)
	{	
		
		if(rl2==100){
		//Incetineste(0.5);
		if(ddamage)
		damage-=20;
		AddEntity("shotexplosion.ent", thisEntity.GetPosition()+vector3(direction*95,0),shot);
		PlaySample("soundfx/railgun.mp3");
		thisEntity.SetUInt("tofire", 1);
		
		lastpress=GetTime();}
	
		rl2=0;
	}

	if(thisEntity.GetUInt("tofire")==1){
	if(GetTime()-lastpress>=1200){
	//Incetineste(1);
	ETHEntity @missile = null;
	AddEntity("missileR.ent", thisEntity.GetPosition()+vector3(direction*95,0), missile);
	thisEntity.SetPositionXY(thisEntity.GetPositionXY()-direction*10);
	if (missile !is null)
		{
	
			missile.SetVector2("direction", direction);
			missile.SetFloat("speed", UnitsPerSecond(1200));
			missile.SetAngle(ang);
			
		}
	thisEntity.SetUInt("tofire", 0);
	}}
	float y=thisEntity.GetPositionXY().y - GetScreenSize().y / 2;
	if(level != 3 and level != 7 and level!=8){SetCameraPos(vector2(0.0f,y));}
	if(thisEntity.GetPosition().x<0.0f){
	thisEntity.SetPosition(vector3(GetScreenSize().x,thisEntity.GetPosition().y, 0.0f));}
	
	if(thisEntity.GetPosition().x>GetScreenSize().x){
	thisEntity.SetPosition(vector3(0.0f,thisEntity.GetPosition().y, 0.0f));}
	
	if(nv1==1){
	AddEntity("spaceship2.ent", vector3(thisEntity.GetPosition().x, thisEntity.GetPosition().y+100, 0), 0);DeleteEntity(thisEntity);}
	if(nv1==2){
	AddEntity("spaceship3.ent", vector3(thisEntity.GetPosition().x, thisEntity.GetPosition().y+100, 0), 0);DeleteEntity(thisEntity);}
	if(nv1==3){
	AddEntity("spaceship4.ent", vector3(thisEntity.GetPosition().x, thisEntity.GetPosition().y+100, 0), 0);DeleteEntity(thisEntity);}
	if(nv1==5){
	AddEntity("spaceship5.ent", vector3(thisEntity.GetPosition().x, thisEntity.GetPosition().y+100, 0));
	DeleteEntity(thisEntity);
	}
	if(nv1==6){
	AddEntity("spaceship6.ent", vector3(thisEntity.GetPosition().x, thisEntity.GetPosition().y+100, 0));
	DeleteEntity(thisEntity);
	}
	
	if(input.GetKeyState(K_L)==KS_HIT){
	thisEntity.SetUInt("light", 1);
	AddEntity("light.ent", thisEntity.GetPosition());}
	if(input.GetKeyState(K_K)==KS_HIT && thisEntity.GetUInt("light")!=1){
	thisEntity.SetUInt("light", 0);
	DeleteEntity(SeekEntity("light.ent"));}
	if(thisEntity.GetUInt("light")==1){
	SeekEntity("light.ent").SetPosition(thisEntity.GetPosition());
	
	
}




/*
ETHEntity @ot;
if(CollideDynamic(thisEntity))
{ShakeCamera(GetCameraPos(), 20);}*/

ETHEntityArray entities;
GetEntitiesAroundEntity(thisEntity, entities);
for (uint i = 0; i < entities.size(); i++){
	if(entities[i].GetEntityName()=="urmaritor.ent" || entities[i].GetEntityName()=="enemy3.ent" || entities[i].GetEntityName()=="enemy2.ent"){
		vector2 posA=thisEntity.GetPositionXY();
		vector2 posB=entities[i].GetPositionXY();
		entities[i].SetVector2("pos" ,posA);
		if(distance(posB, posA)>300){
			vector2 movingDirection = normalize(posB - posA);
			entities[i].AddToPositionXY(allPositionsAdderValue*movingDirection*-6);
			entities[i].SetVector2("dir", movingDirection);}
		
	}
}






if(hpp<=0){
if(!armor && gob2)
{
money=0;level=1;
got1=GetTime();
gob1=true;
gob2=false;

}
else {armor=false;hpp=100;}}
}

vector2 randV2(int v)
{
vector2 V2(rand(v-5, v+5), rand(v-5, v+5));
return V2;
}


void ETHBeginContactCallback_spaceship(
	ETHEntity@ ship,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{



if(other.GetEntityName()=="lightning.ent"){
hpp-=30;
AddEntity("vox.ent", vector3(contactPointA, 0), 0);
ship.SetPositionXY(ship.GetVector2("direction")*-80);}

if(other.GetEntityName()=="enemy6.ent")
{
other.SetUInt("destroy", 1);
hpp-=30;
}



if(other.GetEntityName()=="b2tm.ent"){
hpp-=12;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="b1tm.ent"){
hpp-=5;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="b1tm.ent"){
hpp-=5;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="oznmissile.ent"){
hpp-=3;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="missilex.ent"){
hpp-=10;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="fulger.ent"){hpp-=15;
other.SetUInt("destruida", 1);}

if(other.GetEntityName()=="missile3.ent"){
other.SetUInt("destruida", 1);

hpp-=10;}
if(other.GetEntityName()=="asteroide.ent"){

other.SetUInt("destruida", 1);
other.SetInt("hp", 0);
hpp-=10;}
if(other.GetEntityName()=="asteroide2.ent"){

other.SetUInt("destruida", 1);
hpp-=20;}
if(other.GetEntityName()=="laser.ent"){
hpp-=30;}
}

void ETHCallback_spaceship2(ETHEntity@ thisEntity)
{ 	

	if(level == 3 or level == 7 or level == 8)
{
if(thisEntity.GetPositionY()<0)
thisEntity.SetPositionY(768);
if(thisEntity.GetPositionY()>768)
thisEntity.SetPositionY(0);
}
	naveposx=thisEntity.GetPosition().x;
	naveposy=thisEntity.GetPosition().y;mainpos=thisEntity.GetPositionXY();
	ETHInput@ input = GetInputHandle();
	float ang=thisEntity.GetAngle(); 
	lpos=thisEntity.GetPosition();
	float speed2, angleSpeed2;
	if(!nitro){
	 speed2 = UnitsPerSecond(280.0f);
	 angleSpeed2 = UnitsPerSecond(170.0f);}
	 else
	 {speed2 = UnitsPerSecond(280.0f)*1.5;
	 angleSpeed2 = UnitsPerSecond(170.0f)*1.5;}
	
	direction=vector2(0.0f,-1.0f);
	if(rl<-100){rl=100;}
	if (input.KeyDown(K_RIGHT))
	{
		thisEntity.AddToAngle(-angleSpeed2);
		fnitro-=0.055;
	}

	if (input.KeyDown(K_LEFT))
	{
		thisEntity.AddToAngle(angleSpeed2);
		fnitro-=0.055;
	}
	
	
	direction = rotate(direction, degreeToRadian(thisEntity.GetAngle()));
	thisEntity.SetVector2("direction", direction);
maindir = direction;
	
	if (input.KeyDown(K_UP))
	{	if(!IsSamplePlaying("soundfx/boostb.mp3")){PlaySample("soundfx/boostb.mp3");}
		thisEntity.AddToPositionXY(allPositionsAdderValue*direction * speed2);
		fnitro-=0.15;
	}
	if (input.KeyDown(K_DOWN))
	{	if(!IsSamplePlaying("soundfx/boostb.mp3")){PlaySample("soundfx/boostb.mp3");}
		thisEntity.AddToPositionXY(allPositionsAdderValue*direction *-speed2*0.7);
		fnitro-=0.15;
	}
	
	if(200-rl<100){
	rl-=(GetTime()-lastpress)/1000;
	}
	if (input.GetKeyState(K_SPACE) == KS_HIT)
	{	
		if(200-rl>10){
		ETHEntity@ missile=null;
		lastpress=GetTime();
		if(ddamage)
		damage-=10;
		AddEntity("missileRa.ent", thisEntity.GetPosition()+vector3(direction*120, 0), missile);
		thisEntity.SetPositionXY(thisEntity.GetPositionXY()-direction*6);
		if (missile !is null)
		{
	
			missile.SetVector2("direction", direction);
			missile.SetAngle(ang);
			missile.SetUInt("rl", 1);
			
		}
	}
	}	
	float y=thisEntity.GetPositionXY().y - GetScreenSize().y / 2;
	if(level != 3 and level != 7 and level!=8){if(level != 3 and level != 7 and level!=8){SetCameraPos(vector2(0.0f,y));}}
	if(thisEntity.GetPosition().x<0.0f){
	thisEntity.SetPosition(vector3(GetScreenSize().x,thisEntity.GetPosition().y, 0.0f));}
	
	
	if(thisEntity.GetPosition().x>GetScreenSize().x){
	thisEntity.SetPosition(vector3(0.0f,thisEntity.GetPosition().y, 0.0f));}
	if(input.GetKeyState(K_L)==KS_HIT){
	thisEntity.SetUInt("light", 1);}
	if(input.GetKeyState(K_K)==KS_HIT){
	thisEntity.SetUInt("light", 0);}
	if(thisEntity.GetUInt("light")==1){
	AddLight(thisEntity.GetPosition() + vector3(0, 0, 32), vector3(0.26f,0.26f,0.26f), 500, true);
}
ETHEntityArray entities;
GetEntitiesAroundEntity(thisEntity, entities);
for (uint i = 0; i < entities.size(); i++){
	if(entities[i].GetEntityName()=="urmaritor.ent" || entities[i].GetEntityName()=="enemy3.ent" || entities[i].GetEntityName()=="enemy2.ent"){
		vector2 posA=thisEntity.GetPositionXY();
		vector2 posB=entities[i].GetPositionXY();
		entities[i].SetVector2("pos" ,posA);
		if(distance(posB, posA)>300){
			vector2 movingDirection = normalize(posB - posA);
			entities[i].AddToPositionXY(allPositionsAdderValue*movingDirection*-6);
			entities[i].SetVector2("dir", movingDirection);}
		
	}
}
if(hpp<=0){
if(!armor && gob2)
{
money=0;level=1;
got1=GetTime();
gob1=true;
gob2=false;

}

else armor=false;hpp=200;
}
}

void ETHBeginContactCallback_spaceship2(
	ETHEntity@ ship,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{


if(other.GetEntityName()=="lightning.ent"){
hpp-=30;
AddEntity("vox.ent", vector3(contactPointA, 0), 0);
ship.SetPositionXY(ship.GetVector2("direction")*-80);}

if(other.GetEntityName()=="enemy6.ent")
{
other.SetUInt("destroy", 1);
hpp-=30;
}

if(other.GetEntityName()=="b2tm.ent"){
hpp-=12;

other.SetUInt("destruida", 1);
}


if(other.GetEntityName()=="b1tm.ent"){
hpp-=5;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="b1tm.ent"){
hpp-=5;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="oznmissile.ent"){
hpp-=3;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="missilex.ent"){
hpp-=10;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="fulger.ent"){hpp-=15;
other.SetUInt("destruida", 1);}

if(other.GetEntityName()=="missile3.ent"){
other.SetUInt("destruida", 1);

hpp-=10;}
if(other.GetEntityName()=="asteroide.ent"){

other.SetUInt("destruida", 1);
other.SetInt("hp", 0);
hpp-=10;}
if(other.GetEntityName()=="asteroide2.ent"){

other.SetUInt("destruida", 1);
hpp-=20;}
if(other.GetEntityName()=="laser.ent"){
hpp-=30;}
}






void ETHCallback_spaceship6(ETHEntity@ thisEntity)
{ 	

if(level == 3 or level == 7 or level == 8)
{
if(thisEntity.GetPositionY()<0)
thisEntity.SetPositionY(768);
if(thisEntity.GetPositionY()>768)
thisEntity.SetPositionY(0);
}	
	naveposx=thisEntity.GetPosition().x;
	naveposy=thisEntity.GetPosition().y;mainpos=thisEntity.GetPositionXY();
	ETHInput@ input = GetInputHandle();
	float ang=thisEntity.GetAngle(); 
	lpos=thisEntity.GetPosition();
	float speed2, angleSpeed2;
	if(!nitro){
	 speed2 = UnitsPerSecond(280.0f);
	 angleSpeed2 = UnitsPerSecond(170.0f);}
	 else
	 {speed2 = UnitsPerSecond(280.0f)*1.7;
	 angleSpeed2 = UnitsPerSecond(170.0f)*1.7;}
	
	direction=vector2(0.0f,-1.0f);
	if (input.KeyDown(K_RIGHT))
	{
		thisEntity.AddToAngle(-angleSpeed2);
		fnitro-=0.01;
	}

	if (input.KeyDown(K_LEFT))
	{
		thisEntity.AddToAngle(angleSpeed2);
		fnitro-=0.01;
	}
	
	
	direction = rotate(direction, degreeToRadian(thisEntity.GetAngle()));
	thisEntity.SetVector2("direction", direction);
maindir = direction;
	
	if (input.KeyDown(K_UP))
	{	if(!IsSamplePlaying("soundfx/boostb.mp3")){PlaySample("soundfx/boostb.mp3");}
		thisEntity.AddToPositionXY(allPositionsAdderValue*direction * speed2);
		fnitro-=0.05;
	}
	if (input.KeyDown(K_DOWN))
	{	if(!IsSamplePlaying("soundfx/boostb.mp3")){PlaySample("soundfx/boostb.mp3");}
		thisEntity.AddToPositionXY(allPositionsAdderValue*direction *-speed2*0.7);
		fnitro-=0.05;
	}
	
	if(200-rl<100){
	rl-=(GetTime()-lastpress)/1000;
	}
	if (input.GetKeyState(K_SPACE) == KS_HIT)
	{	
		
		ETHEntity@ missile=null;
		if(ddamage)
		damage-=5;
		AddEntity("missileS6.ent", thisEntity.GetPosition()+vector3(direction*100, 0), missile);
		thisEntity.SetPositionXY(thisEntity.GetPositionXY()-direction*6);
		if (missile !is null)
		{
	
			missile.SetVector2("direction", direction);
			missile.SetAngle(ang);
				
		}
	
	}	
	float y=thisEntity.GetPositionXY().y - GetScreenSize().y / 2;
	if(level != 3 and level != 7 and level!=8){if(level != 3 and level != 7 and level!=8){SetCameraPos(vector2(0.0f,y));}}
	if(thisEntity.GetPosition().x<0.0f){
	thisEntity.SetPosition(vector3(GetScreenSize().x,thisEntity.GetPosition().y, 0.0f));}
	
	
	if(thisEntity.GetPosition().x>GetScreenSize().x){
	thisEntity.SetPosition(vector3(0.0f,thisEntity.GetPosition().y, 0.0f));}
	if(input.GetKeyState(K_L)==KS_HIT){
	thisEntity.SetUInt("light", 1);}
	if(input.GetKeyState(K_K)==KS_HIT){
	thisEntity.SetUInt("light", 0);}
	if(thisEntity.GetUInt("light")==1){
	AddLight(thisEntity.GetPosition() + vector3(0, 0, 32), vector3(0.26f,0.26f,0.26f), 500, true);
}
ETHEntityArray entities;
GetEntitiesAroundEntity(thisEntity, entities);
for (uint i = 0; i < entities.size(); i++){
	if(entities[i].GetEntityName()=="urmaritor.ent" || entities[i].GetEntityName()=="enemy3.ent" || entities[i].GetEntityName()=="enemy2.ent"){
		vector2 posA=thisEntity.GetPositionXY();
		vector2 posB=entities[i].GetPositionXY();
		entities[i].SetVector2("pos" ,posA);
		if(distance(posB, posA)>300){
			vector2 movingDirection = normalize(posB - posA);
			entities[i].AddToPositionXY(allPositionsAdderValue*movingDirection*-6);
			entities[i].SetVector2("dir", movingDirection);}
		
	}
}
if(hpp<=0){
if(!armor && gob2)
{
money=0;level=1;
got1=GetTime();
gob1=true;
gob2=false;

}

else armor=false;hpp=200;
}
}


void ETHPreSolveContactCallback_spaceship6(
	ETHEntity@ ship,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{
if(other.GetEntityName()=="missileS6.ent")
DisableContact();
}

void ETHBeginContactCallback_spaceship6(
	ETHEntity@ ship,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{


if(other.GetEntityName()=="lightning.ent"){
hpp-=30;
AddEntity("vox.ent", vector3(contactPointA, 0), 0);
ship.SetPositionXY(ship.GetVector2("direction")*-80);}

if(other.GetEntityName()=="enemy6.ent")
{
other.SetUInt("destroy", 1);
hpp-=30;
}

if(other.GetEntityName()=="b2tm.ent"){
hpp-=12;

other.SetUInt("destruida", 1);
}


if(other.GetEntityName()=="b1tm.ent"){
hpp-=5;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="b1tm.ent"){
hpp-=5;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="oznmissile.ent"){
hpp-=3;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="missilex.ent"){
hpp-=10;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="fulger.ent"){hpp-=15;
other.SetUInt("destruida", 1);}

if(other.GetEntityName()=="missile3.ent"){
other.SetUInt("destruida", 1);

hpp-=10;}
if(other.GetEntityName()=="asteroide.ent"){

other.SetUInt("destruida", 1);
other.SetInt("hp", 0);
hpp-=10;}
if(other.GetEntityName()=="asteroide2.ent"){

other.SetUInt("destruida", 1);
hpp-=20;}
if(other.GetEntityName()=="laser.ent"){
hpp-=30;}
}






void ETHCallback_spaceship3(ETHEntity@ thisEntity){
if(level == 3 or level == 7 or level == 8)
{
if(thisEntity.GetPositionY()<0)
thisEntity.SetPositionY(768);
if(thisEntity.GetPositionY()>768)
thisEntity.SetPositionY(0);
}	
	float aae=0.5;
	naveposx=thisEntity.GetPosition().x;
	naveposy=thisEntity.GetPosition().y;mainpos=thisEntity.GetPositionXY();
	ETHInput@ input = GetInputHandle();
	float ang=thisEntity.GetAngle(); 
	lpos=thisEntity.GetPosition();
	float angleSpeed;
	if(!nitro){
	speed = UnitsPerSecond(160.0f);
	angleSpeed = UnitsPerSecond(120.0f);}
	else{
	speed = UnitsPerSecond(160.0f)*1.5;
	angleSpeed = UnitsPerSecond(120.0f)*1.5;}
	
	vector2 direct;
	direction=vector2(0.0f,-1.0f);
	direct=vector2(0.0f,-1.0f);
	
	if (input.KeyDown(K_RIGHT))
	{
		thisEntity.AddToAngle(-angleSpeed);
		fnitro-=0.03;
	}

	if (input.KeyDown(K_LEFT))
	{
		thisEntity.AddToAngle(angleSpeed);
			fnitro-=0.03;
	}
	
	if(par%2==0){
	angle=27;
	aae=0.5;}
	if(par%2!=0){
	angle=-27;
	aae=-0.5;
	}
	direction = rotate(direction, degreeToRadian(thisEntity.GetAngle()));
	thisEntity.SetVector2("direction", direction);
maindir = direction;
	direct = rotate(direct, degreeToRadian(thisEntity.GetAngle()+angle));
	if (input.KeyDown(K_UP))
	{	if(!IsSamplePlaying("soundfx/boostb.mp3")){PlaySample("soundfx/boostb.mp3");}
		thisEntity.AddToPositionXY(allPositionsAdderValue*direction * speed);
		fnitro-=0.06;
	}
	if (input.KeyDown(K_DOWN))
	{	if(!IsSamplePlaying("soundfx/boostb.mp3")){PlaySample("soundfx/boostb.mp3");}
		thisEntity.AddToPositionXY(allPositionsAdderValue*direction *-speed*1.3);
			fnitro-=0.06;
	}
	
	
	if (input.GetKeyState(K_SPACE) == KS_HIT)
	{
		par+=1;
		ETHEntity @missile = null;
		if(ddamage)
		damage-=2;
		thisEntity.SetAngle(thisEntity.GetAngle()+aae);
		AddEntity("missile6.ent", thisEntity.GetPosition()+vector3(direct.x*90, direct.y*90,0), missile);
		PlaySample("soundfx/fire.wav");
		
		if (missile !is null)
		{
	
			missile.SetVector2("direction", direction);
			missile.SetAngle(ang);
			
		}
	}
		
	float y=thisEntity.GetPositionXY().y - GetScreenSize().y / 2;
	if(level != 3 and level != 7 and level!=8){SetCameraPos(vector2(0.0f,y));}
	if(thisEntity.GetPosition().x<0.0f){
	thisEntity.SetPosition(vector3(GetScreenSize().x,thisEntity.GetPosition().y, 0.0f));}
	
	if(thisEntity.GetPosition().x>GetScreenSize().x){
	thisEntity.SetPosition(vector3(0.0f,thisEntity.GetPosition().y, 0.0f));}
	
	
	
	
	
	if(input.GetKeyState(K_L)==KS_HIT){
	thisEntity.SetUInt("light", 1);}
	if(input.GetKeyState(K_K)==KS_HIT){
	thisEntity.SetUInt("light", 0);}
	if(thisEntity.GetUInt("light")==1){
	AddLight(thisEntity.GetPosition() + vector3(0, 0, 32), vector3(0.26f,0.2f,0.26f), 300, true);
}
ETHEntityArray entities;
GetEntitiesAroundEntity(thisEntity, entities);
for (uint i = 0; i < entities.size(); i++){
	if(entities[i].GetEntityName()=="urmaritor.ent" || entities[i].GetEntityName()=="enemy3.ent" || entities[i].GetEntityName()=="enemy2.ent"){
		vector2 posA=thisEntity.GetPositionXY();
		vector2 posB=entities[i].GetPositionXY();
		entities[i].SetVector2("pos" ,posA);
		if(distance(posB, posA)>300){
			vector2 movingDirection = normalize(posB - posA);
			entities[i].AddToPositionXY(allPositionsAdderValue*movingDirection*-6);
			entities[i].SetVector2("dir", movingDirection);}
		
	}
}

if(hpp<=0){
if(!armor && gob2)
{
money=0;level=1;
got1=GetTime();
gob1=true;
gob2=false;

}
else armor=false;hpp=350;
}
}

void ETHBeginContactCallback_spaceship3(
	ETHEntity@ ship,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{


if(other.GetEntityName()=="lightning.ent"){
hpp-=30;
AddEntity("vox.ent", vector3(contactPointA, 0), 0);
ship.SetPositionXY(ship.GetVector2("direction")*-80);}

if(other.GetEntityName()=="enemy6.ent")
{
other.SetUInt("destroy", 1);
hpp-=30;
}

if(other.GetEntityName()=="b2tm.ent"){
hpp-=12;

other.SetUInt("destruida", 1);
}



if(other.GetEntityName()=="b1tm.ent"){
hpp-=5;

other.SetUInt("destruida", 1);
}



if(other.GetEntityName()=="missilex.ent"){
hpp-=10;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="oznmissile.ent"){
hpp-=3;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="fulger.ent"){hpp-=15;
other.SetUInt("destruida", 1);}

if(other.GetEntityName()=="missile3.ent"){
other.SetUInt("destruida", 1);

hpp-=10;}
if(other.GetEntityName()=="asteroide.ent"){

other.SetUInt("destruida", 1);
other.SetInt("hp", 0);
hpp-=10;}
if(other.GetEntityName()=="asteroide2.ent"){

other.SetUInt("destruida", 1);
hpp-=20;}
if(other.GetEntityName()=="laser.ent"){
hpp-=30;}
}






void ETHCallback_spaceship4(ETHEntity@ thisEntity){
 if(level == 3 or level == 7 or level == 8)
{
if(thisEntity.GetPositionY()<0)
thisEntity.SetPositionY(768);
if(thisEntity.GetPositionY()>768)
thisEntity.SetPositionY(0);
}   
	naveposx=thisEntity.GetPosition().x;
	naveposy=thisEntity.GetPosition().y;mainpos=thisEntity.GetPositionXY();
	ETHInput@ input = GetInputHandle();
	float ang=thisEntity.GetAngle(); 
	lpos=thisEntity.GetPosition();
	float angleSpeed;
	if(!nitro){
	speed = UnitsPerSecond(160.0f);
	 angleSpeed = UnitsPerSecond(120.0f);}
	 else{
	speed = UnitsPerSecond(160.0f)*1.5;
	angleSpeed = UnitsPerSecond(120.0f)*1.5;}
	 
	vector2 direct;
	direction=vector2(0.0f,-1.0f);
	direct=vector2(0.0f,-1.0f);
	
	if (input.KeyDown(K_RIGHT))
	{
		thisEntity.AddToAngle(-angleSpeed);
			fnitro-=0.04;
	}

	if (input.KeyDown(K_LEFT))
	{
		thisEntity.AddToAngle(angleSpeed);
			fnitro-=0.04;
	}
	
	if(par%2==0){
	angle=140;}
	if(par%2!=0){
	angle=-140;}
	direction = rotate(direction, degreeToRadian(thisEntity.GetAngle()));
	thisEntity.SetVector2("direction", direction);
maindir = direction;
	direct = rotate(direct, degreeToRadian(thisEntity.GetAngle()+angle));
	if (input.KeyDown(K_UP))
	{	if(!IsSamplePlaying("soundfx/boostb.mp3")){PlaySample("soundfx/boostb.mp3");}
		thisEntity.AddToPositionXY(allPositionsAdderValue*direction * speed);
			fnitro-=0.09;
	}
	if (input.KeyDown(K_DOWN))
	{	if(!IsSamplePlaying("soundfx/boostb.mp3")){PlaySample("soundfx/boostb.mp3");}
		thisEntity.AddToPositionXY(allPositionsAdderValue*direction *-speed*1.3);
			fnitro-=0.09;
	}
	
	
	if (input.GetKeyState(K_SPACE) == KS_HIT)
	{
		par+=1;
		if(ddamage)
		damage-=4;
		ETHEntity @missile = null;
		
		AddEntity("fulger.ent", thisEntity.GetPosition()+vector3(direct.x*-80,direct.y*-80,0), missile);
		PlaySample("soundfx/fire.wav");
		
		if (missile !is null)
		{
	
			missile.SetVector2("direction", direction);
			missile.SetAngle(ang+90);
			
		}
	}
		
	float y=thisEntity.GetPositionXY().y - GetScreenSize().y / 2;
	if(level != 3 and level != 7 and level!=8){SetCameraPos(vector2(0.0f,y));}
	if(thisEntity.GetPosition().x<0.0f){
	thisEntity.SetPosition(vector3(GetScreenSize().x,thisEntity.GetPosition().y, 0.0f));}
	
	if(thisEntity.GetPosition().x>GetScreenSize().x){
	thisEntity.SetPosition(vector3(0.0f,thisEntity.GetPosition().y, 0.0f));}
	
	
	
	if(input.GetKeyState(K_L)==KS_HIT){
	thisEntity.SetUInt("light", 1);}
	if(input.GetKeyState(K_K)==KS_HIT){
	thisEntity.SetUInt("light", 0);}
	if(thisEntity.GetUInt("light")==1){
	AddLight(thisEntity.GetPosition() + vector3(0, 0, 32), vector3(0.26f,0.2f,0.26f), 300, true);
}
ETHEntityArray entities;
GetEntitiesAroundEntity(thisEntity, entities);
for (uint i = 0; i < entities.size(); i++){
	if(entities[i].GetEntityName()=="urmaritor.ent" || entities[i].GetEntityName()=="enemy3.ent" || entities[i].GetEntityName()=="enemy2.ent"){
		vector2 posA=thisEntity.GetPositionXY();
		vector2 posB=entities[i].GetPositionXY();
		entities[i].SetVector2("pos" ,posA);
		if(distance(posB, posA)>300){
			vector2 movingDirection = normalize(posB - posA);
			entities[i].AddToPositionXY(allPositionsAdderValue*movingDirection*-6);
			entities[i].SetVector2("dir", movingDirection);}
		
	}
}
if(hpp<=0){
if(!armor && gob2)
{
money=0;level=1;
got1=GetTime();
gob1=true;
gob2=false;

}
else armor=false;hpp=400;
}
}

void ETHBeginContactCallback_spaceship4(
	ETHEntity@ ship,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{


if(other.GetEntityName()=="lightning.ent"){
hpp-=30;
AddEntity("vox.ent", vector3(contactPointA, 0), 0);
ship.SetPositionXY(ship.GetVector2("direction")*-80);}

if(other.GetEntityName()=="enemy6.ent")
{
other.SetUInt("destroy", 1);
hpp-=30;
}

if(other.GetEntityName()=="b2tm.ent"){
hpp-=12;

other.SetUInt("destruida", 1);
}


if(other.GetEntityName()=="b1tm.ent"){
hpp-=5;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="missilex.ent"){
hpp-=10;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="oznmissile.ent"){
hpp-=3;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="fulger.ent"){hpp-=15;
other.SetUInt("destruida", 1);}

if(other.GetEntityName()=="missile3.ent"){
other.SetUInt("destruida", 1);

hpp-=10;}
if(other.GetEntityName()=="asteroide.ent"){

other.SetUInt("destruida", 1);
other.SetInt("hp", 0);
hpp-=10;}
if(other.GetEntityName()=="asteroide2.ent"){

other.SetUInt("destruida", 1);
hpp-=20;}
if(other.GetEntityName()=="laser.ent"){
hpp-=30;}
}


void ETHCallback_spaceship5(ETHEntity@ thisEntity)
{ 	
		
if(level == 3 or level == 7 or level == 8)
{
if(thisEntity.GetPositionY()<0)
thisEntity.SetPositionY(768);
if(thisEntity.GetPositionY()>768)
thisEntity.SetPositionY(0);
}	
	naveposx=thisEntity.GetPosition().x;
	naveposy=thisEntity.GetPosition().y;mainpos=thisEntity.GetPositionXY();
	ETHInput@ input = GetInputHandle();
	float ang=thisEntity.GetAngle(); 
	lpos=thisEntity.GetPosition();
	float angleSpeed;
	if(!nitro){
	speed = UnitsPerSecond(160.0f);
	angleSpeed = UnitsPerSecond(120.0f);}
	else{
	speed = UnitsPerSecond(160.0f)*1.5;
	angleSpeed = UnitsPerSecond(120.0f)*1.5;}
	vector2 direct;
	direction=vector2(0.0f,-1.0f);
	direct=vector2(0.0f,-1.0f);
	vector2 direct1=vector2(0.0f,-1.0f);
	if (input.KeyDown(K_RIGHT) || input.KeyDown(K_D))
	{
		thisEntity.AddToAngle(-angleSpeed);
		fnitro-=0.09;
	}

	if (input.KeyDown(K_LEFT) || input.KeyDown(K_A))
	{
		thisEntity.AddToAngle(angleSpeed);
			fnitro-=0.09;
	}
	
	if(par%2==0){
	angle=110;}
	if(par%2!=0){
	angle=-110;}
	int angle1;
	if(par%2==0){
	angle1=150;}
	if(par%2!=0){
	angle1=-150;}
	direction = rotate(direction, degreeToRadian(thisEntity.GetAngle()));
	thisEntity.SetVector2("direction", direction);
maindir = direction;
	direct = rotate(direct, degreeToRadian(thisEntity.GetAngle()+angle));
	direct1 = rotate(direct1, degreeToRadian(thisEntity.GetAngle()+angle1));
	vector3 t1=thisEntity.GetPosition()+vector3(direct1.x*-110,direct1.y*-110,0);
	vector3 t2=thisEntity.GetPosition()+vector3(direct.x*-90,direct.y*-90,0);
	vector3 tt;
	if(thisEntity.GetUInt("fire")==1){tt=t1;}
	if(thisEntity.GetUInt("fire")==2){tt=t2;}
	if (input.KeyDown(K_UP) || input.KeyDown(K_W))
	{	if(!IsSamplePlaying("soundfx/boostb.mp3")){PlaySample("soundfx/boostb.mp3");}
		thisEntity.AddToPositionXY(allPositionsAdderValue*direction * speed);
		fnitro-=0.2;
	}
	if (input.KeyDown(K_DOWN) || input.KeyDown(K_S))
	{	if(!IsSamplePlaying("soundfx/boostb.mp3")){PlaySample("soundfx/boostb.mp3");}
		thisEntity.AddToPositionXY(allPositionsAdderValue*direction *-speed*0.7);
		fnitro-=0.2;
	}
	
	if(input.GetKeyState(K_1)==KS_HIT){thisEntity.SetUInt("fire", 1);}
	if(input.GetKeyState(K_2)==KS_HIT){thisEntity.SetUInt("fire", 2);}
	if (input.GetKeyState(K_SPACE) == KS_HIT)
	{
		par+=1;
		if(ddamage)
		damage-=4;
		ETHEntity @missile = null;
		//AddEntity("missile.ent", thisEntity.GetPosition()+vector3(direction.x*65, direction.y*65, 0), missile);
		AddEntity("missile4.ent", tt, missile);
		
		PlaySample("soundfx/fire.wav");
		
		if (missile !is null)
		{
	
			missile.SetVector2("direction", direction);
			
		}
	}
		
	float y=thisEntity.GetPositionXY().y - GetScreenSize().y / 2;
	if(level != 3 and level != 7 and level!=8){SetCameraPos(vector2(0.0f,y));}
	if(thisEntity.GetPosition().x<0.0f){
	thisEntity.SetPosition(vector3(GetScreenSize().x,thisEntity.GetPosition().y, 0.0f));}
	
	if(thisEntity.GetPosition().x>GetScreenSize().x){
	thisEntity.SetPosition(vector3(0.0f,thisEntity.GetPosition().y, 0.0f));}
	
	
	if(input.GetKeyState(K_L)==KS_HIT){
	thisEntity.SetUInt("light", 1);
	AddEntity("light.ent", thisEntity.GetPosition());}
	if(input.GetKeyState(K_K)==KS_HIT && thisEntity.GetUInt("light")!=1){
	thisEntity.SetUInt("light", 0);
	DeleteEntity(SeekEntity("light.ent"));}
	if(thisEntity.GetUInt("light")==1){
	SeekEntity("light.ent").SetPosition(thisEntity.GetPosition());
	
	
}



ETHEntityArray entities;
GetEntitiesAroundEntity(thisEntity, entities);
for (uint i = 0; i < entities.size(); i++){
	if(entities[i].GetEntityName()=="urmaritor.ent" || entities[i].GetEntityName()=="enemy3.ent" || entities[i].GetEntityName()=="enemy2.ent"){
		vector2 posA=thisEntity.GetPositionXY();
		vector2 posB=entities[i].GetPositionXY();
		entities[i].SetVector2("pos" ,posA);
		if(distance(posB, posA)>300){
			vector2 movingDirection = normalize(posB - posA);
			entities[i].AddToPositionXY(allPositionsAdderValue*movingDirection*-6);
			entities[i].SetVector2("dir", movingDirection);}
		
	}
}






if(hpp<=0){
if(!armor && gob2)
{
money=0;level=1;
got1=GetTime();
gob1=true;
gob2=false;

}
else {hpp=500;armor=false;}
}
}

void ETHBeginContactCallback_spaceship5(
	ETHEntity@ ship,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{


if(other.GetEntityName()=="lightning.ent"){
hpp-=30;
AddEntity("vox.ent", vector3(contactPointA, 0), 0);
ship.SetPositionXY(ship.GetVector2("direction")*-80);}

if(other.GetEntityName()=="enemy6.ent")
{
other.SetUInt("destroy", 1);
hpp-=30;
}

if(other.GetEntityName()=="b2tm.ent"){
hpp-=12;

other.SetUInt("destruida", 1);
}



if(other.GetEntityName()=="b1tm.ent"){
hpp-=5;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="missilex.ent"){
hpp-=10;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="oznmissile.ent"){
hpp-=3;

other.SetUInt("destruida", 1);
}

if(other.GetEntityName()=="fulger.ent"){hpp-=15;
other.SetUInt("destruida", 1);}

if(other.GetEntityName()=="missile3.ent"){
other.SetUInt("destruida", 1);

hpp-=10;}
if(other.GetEntityName()=="asteroide.ent"){

other.SetUInt("destruida", 1);
other.SetInt("hp", 0);
hpp-=10;}
if(other.GetEntityName()=="asteroide2.ent"){

other.SetUInt("destruida", 1);
hpp-=20;}
if(other.GetEntityName()=="laser.ent"){
hpp-=30;}
}


void ETHConstructorCallback_enemy1(ETHEntity@ enemy){
enemy.SetInt("hp", 50);
}

void ETHBeginContactCallback_enemy1(
	ETHEntity@ enemy,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{



}
int lastfire;
void ETHCallback_enemy1(ETHEntity@ enemy)
{

ETHEntity@ missile=null;

if(GetTime()-lastfire>=2000){
lastfire=GetTime();
AddEntity("missile3.ent", enemy.GetPosition()+vector3(0,60,0), missile);
nl1=1;

if(missile !is null){missile.SetInt("damage", -10);}
}


if(enemy.GetPosition().x<200){true1=1;}
if(enemy.GetPosition().x>600){true1=-1;}
enemy.AddToPositionXY(allPositionsAdderValue*vector2(UnitsPerSecond(300)*true1, 0));
if(enemy.GetInt("hp")<=0){
DrawNotification("Enemy down!","Verdana20_shadow.fnt",GetTime(), 3000);

AddEntity("explosion3.ent", enemy.GetPosition());
PlaySample("soundfx/explosion2.wav");
DeleteEntity(enemy);
money+=40;
}
}

void ETHConstructorCallback_urmaritor(ETHEntity@ thisEntity)
{
thisEntity.SetInt("hp", 30);
}

int lastfiref=1;
void ETHCallback_urmaritor(ETHEntity@ thisEntity){
ETHEntity@ missile=null;
vector2 dir (-1, 0);
	//vector2 posA=thisEntity.GetVector2("pos");
	vector2 posA=mainpos;
	vector2 posB=thisEntity.GetPositionXY();
	if(thisEntity.GetInt("hp")<=0){
	AddEntity("explosion3.ent", thisEntity.GetPosition());
	PlaySample("soundfx/explosion2.wav");
	/*timpdeincetinire1=2000;
	timpdeincetinire2=GetTime();
	Incetineste(0.7);
	deincetinit=true;*/
	DeleteEntity(thisEntity);
	money+=20;}
	//DrawText(vector2(0,200), ""+GetAngle(posB, posA, vector2(posA.x-20, posA.y))+260, "Verdana30_shadow.fnt", ARGB(255,255,255,255));
	if(posA.x>posB.x){
	thisEntity.SetAngle(GetAngle(posB, posA, vector2(posA.x-20, posA.y))+260);}
	else 
	if(posA.x<posB.x){
	thisEntity.SetAngle(GetAngle(posA, posB, vector2(posB.x+20, posB.y))+260);}	
	dir=rotate(dir, degreeToRadian(thisEntity.GetAngle()-90));
if(GetTime()-lastfiref>=2000){
lastfiref=GetTime();
AddEntity("missilex.ent", thisEntity.GetPosition()+vector3(dir*85,0), missile);

if(missile !is null){
missile.SetAngle(thisEntity.GetAngle());
missile.SetVector2("direction", dir);}
}
}


void ETHConstructorCallback_enemy3(ETHEntity@ thisEntity)
{
thisEntity.SetInt("hp", 20);
thisEntity.SetUInt("lastfiref", 0);
thisEntity.SetUInt("tof", rand(12));
}
int xtof=rand(12);
void ETHCallback_enemy3(ETHEntity@ thisEntity){
ETHEntity@ missile=null;
thisEntity.SetUInt("tof", rand(12));
vector2 dir (-1, 0);
	vector2 posA=thisEntity.GetVector2("pos");
	vector2 posB=thisEntity.GetPositionXY();
	if(thisEntity.GetInt("hp")<=0){
	AddEntity("explosion.ent", thisEntity.GetPosition());
	DeleteEntity(thisEntity);
	money+=10;}

		if(posA.x>posB.x){
	thisEntity.SetAngle(GetAngle(posB, posA, vector2(posA.x-20, posA.y))+260);}
	else 
	if(posA.x<posB.x){
	thisEntity.SetAngle(GetAngle(posA, posB, vector2(posB.x+20, posB.y))+260);}	
	dir=rotate(dir, degreeToRadian(thisEntity.GetAngle()-90));
if( GetTime()-thisEntity.GetUInt("lastfiref")>=1500 && thisEntity.GetUInt("tof")%11==0){
thisEntity.SetUInt("lastfiref", GetTime());
thisEntity.SetUInt("tof", rand(12));
AddEntity("missilex.ent", thisEntity.GetPosition()+vector3(dir*35,0), missile);

if(missile !is null){
missile.SetAngle(thisEntity.GetAngle());
missile.SetVector2("direction", dir);}
}
}void ETHConstructorCallback_enemy2(ETHEntity@ thisEntity)
{
thisEntity.SetInt("hp", 80);
thisEntity.SetUInt("lastfiref", 0);
thisEntity.SetUInt("tof", rand(12));
}

void ETHCallback_enemy2(ETHEntity@ thisEntity){
ETHEntity@ missile=null;
thisEntity.SetUInt("tof", rand(12));
vector2 dir (0, -1);
	vector2 posA=thisEntity.GetVector2("pos");
	vector2 posB=thisEntity.GetPositionXY();
	if(thisEntity.GetInt("hp")<=0){
	AddEntity("explosion.ent", thisEntity.GetPosition());
	DeleteEntity(thisEntity);
	money+=50;}
	
	if(posA.x>posB.x){
	thisEntity.SetUInt("angle" ,GetAngle(posB, posA, vector2(posA.x-20, posA.y))+260);}
	else 
	{
	thisEntity.SetUInt("angle" ,GetAngle(posB, posA, vector2(posA.x-20, posA.y))+260);}	
	dir=rotate(dir, degreeToRadian(thisEntity.GetAngle()));
if( GetTime()-thisEntity.GetUInt("lastfiref")>=1500 && thisEntity.GetUInt("tof")%11==0){
thisEntity.SetUInt("lastfiref", GetTime());
thisEntity.SetUInt("tof", rand(12));
AddEntity("missilex.ent", thisEntity.GetPosition()+vector3(dir*50,0), missile);
if(missile !is null){
missile.SetAngle(thisEntity.GetAngle());
missile.SetVector2("direction", dir);}
}
thisEntity.SetAngle(thisEntity.GetUInt("angle"));

}