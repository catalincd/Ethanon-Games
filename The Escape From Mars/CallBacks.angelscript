#include "eth_util.angelscript"
#include "Collide.angelscript"
#include "FrameTimer.angelscript"

float allPositionsAdderValue=1;

void ETHCallback_indicator(ETHEntity@ thisEntity)
{
thisEntity.AddToAngle(UnitsPerSecond(200));
}




void AddColoredEntity(string name, vector3 pos, float angle, uint color)
{
AddEntity(name, pos, angle);
SeekEntity(name).SetColor(color);
}




FrameTimer lightingT;

void ETHCallback_lightning(ETHEntity@ thisEntity)
{
thisEntity.SetFrame(lightingT.update(0, 7, 50));
}

FrameTimer voxT;

void ETHConstructorCallback_vox(ETHEntity@ thisEntity)
{
thisEntity.SetColor(vector3(0.1,0.3,1));
thisEntity.Scale(0.7);
}
void ETHCallback_vox(ETHEntity@ thisEntity)
{
thisEntity.SetFrame(voxT.update(0, 15, 50));
if(thisEntity.GetFrame()>=15)
DeleteEntity(thisEntity);
}

void ETHCallback_explosion4(ETHEntity@ thisEntity)
{
thisEntity.SetFrame(thisEntity.GetInt("frame"));

if(GetTime()-thisEntity.GetInt("last")>=20){
thisEntity.AddToInt("frame", 1);thisEntity.SetInt("last", GetTime());
if(thisEntity.GetInt("frame")>=32)
DeleteEntity(thisEntity);
}
}

float Angle(vector2 dir)
{
return (radianToDegree(getAngle(dir)));
}



void ETHConstructorCallback_base1t(ETHEntity@ thisEntity){
thisEntity.SetInt("lastfire", rand(5000));
}
void ETHCallback_base1t(ETHEntity@ thisEntity)
{
if(thisEntity.GetInt("hp")<=0)
{
money+=50;
DeleteEntity(thisEntity);

}
vector2 posA=mainpos;
vector2 posB=thisEntity.GetPositionXY();
vector2 dir(0,-1);
dir=rotate(dir, degreeToRadian(thisEntity.GetAngle()));
if(GetTime()-thisEntity.GetInt("lastfire")>=3000)
{
ETHEntity@ missile=null;
AddEntity("b1tm.ent", thisEntity.GetPosition()+vector3(dir*70, 0), missile);
if(missile !is null)
{
missile.SetVector2("direction", dir);
missile.SetAngle(thisEntity.GetAngle());
}
thisEntity.SetInt("lastfire", GetTime());
}

if(posA.x>posB.x){
thisEntity.SetAngle(GetAngle(posB, posA, vector2(posA.x-20, posA.y))+260);}
else 
if(posA.x<posB.x){
thisEntity.SetAngle(GetAngle(posA, posB, vector2(posB.x+20, posB.y))+260);}	
}

int vectoradd=1;
void ETHCallback_base2(ETHEntity@ thisEntity)
{

if(thisEntity.GetPosition().x>900)
vectoradd=-1;
if(thisEntity.GetPosition().x<50)
vectoradd=1;
thisEntity.AddToPositionX(UnitsPerSecond(200)*vectoradd);
if(SeekEntity("base2t.ent")!is null)
SeekEntity("base2t.ent").SetPosition(thisEntity.GetPosition());
}


void ETHCallback_base2t(ETHEntity@ thisEntity)
{
if(thisEntity.GetInt("hp")<=0)
{
money+=50;
DeleteEntity(thisEntity);

}
vector2 posA=mainpos;
vector2 posB=thisEntity.GetPositionXY();
vector2 dir(0,-1);
dir=rotate(dir, degreeToRadian(thisEntity.GetAngle()-90));
if(GetTime()-thisEntity.GetInt("lastfire")>=3000)
{
ETHEntity@ missile=null;
AddEntity("b2tm.ent", thisEntity.GetPosition()+vector3(dir*90, 0), missile);
if(missile !is null)
{
missile.SetVector2("direction", dir);
missile.SetAngle(thisEntity.GetAngle()-90);
}
thisEntity.SetInt("lastfire", GetTime());
}

if(posA.x>posB.x){
thisEntity.SetAngle(GetAngle(posB, posA, vector2(posA.x-20, posA.y))+350);}
else 
if(posA.x<posB.x){
thisEntity.SetAngle(GetAngle(posA, posB, vector2(posB.x+20, posB.y))+350);}	
}


int last=5;
int frame=1;
int  update( int first, int lastf, int stride){
if(GetTime()-last>stride){
last=GetTime();
frame++;
}
if(frame>=lastf){
frame=first;}
return frame;
}



void ETHCallback_loading8(ETHEntity@ thisEntity){
int tframe=update(1, 20, 50);
thisEntity.SetFrame(tframe);
}


int fframe=1;
int fstride=100;
int flast=5;


void ETHConstructorCallback_fulger(ETHEntity@ thisEntity){
	if(ddamage){
	thisEntity.SetInt("damage", -30);}
	else
	{thisEntity.SetInt("damage", -25);}
	
	
}

void ETHCallback_fulger(ETHEntity@ missile)
{	if(GetTime()-flast>fstride){
	fframe+=1;
	flast=GetTime();
	}
	if(fframe>=3){
	fframe=1;
	}
	missile.SetFrame(fframe);
	vector2 direct;
	direct=missile.GetVector2("direction");
	missileid=missile.GetID();
	if(missile.GetPosition().x<0.0f) {
	missile.SetUInt("destruida", 1);
	}
	if(missile.GetPosition().x>GetScreenSize().x){
	missile.SetUInt("destruida", 1);}
	if(missile.GetFloat("speed")!=DT_NODATA){speed = missile.GetFloat("speed");}
	else speed=UnitsPerSecond(480);
	if(missile !is null){
	//missile.AddToPositionXY(allPositionsAdderValue*dir* speed* 3);}
	
	missile.AddToPositionXY(allPositionsAdderValue*direct*speed);}
		
	// remove míssil se sair da tela ou for destruido
	if (missile.GetUInt("destruida") != 0)
	{
		AddEntity("explosion.ent", missile.GetPosition(), 0);
		@missile= DeleteEntity(missile);
			
		
	}
	
	//missile.Scale(missile.GetVector2("direction")*2);
	
}

void ETHBeginContactCallback_fulger(
	ETHEntity@ missile,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{	ETHPhysicsController@ controller = other.GetPhysicsController();
	if(other.GetEntityName()!="spaceship.ent" && other.GetEntityName()!="missile.ent"){
	PlaySample("soundfx/impact.wav");
	missile.SetUInt("destruida", 1);
	other.AddToInt("hp", missile.GetInt("damage"));
	
	vector2 forta= controller.GetLinearVelocity();
	if(other.GetEntityName()=="asteroide.ent"){
	
	controller.SetLinearVelocity(vector2(missile.GetVector2("direction")*0.9));
	
}
}
}


void ETHConstructorCallback_missile6(ETHEntity@ thisEntity){
	if(ddamage){
	thisEntity.SetInt("damage", -30);}
	else
	{thisEntity.SetInt("damage", -25);}
	//thisEntity.Scale(0.15);
	
	
}
int lastchangef=0;
int f2frame=0;
void ETHCallback_missile6(ETHEntity@ missile)
{	/*if(GetTime()-lastchangef>60)
	{f2frame++;
	lastchangef=GetTime();}
	if(f2frame>1)
	{f2frame=0;}
	missile.SetFrame(f2frame);*/
	vector2 direct;
	direct=missile.GetVector2("direction");
	missileid=missile.GetID();
	if(missile.GetPosition().x<0.0f) {
	missile.SetUInt("destruida", 1);
	}
	if(missile.GetPosition().x>GetScreenSize().x){
	missile.SetUInt("destruida", 1);}
	if(missile.GetFloat("speed")!=DT_NODATA){speed = missile.GetFloat("speed");}
	else speed=UnitsPerSecond(480);
	if(missile !is null){
	//missile.AddToPositionXY(allPositionsAdderValue*dir* speed* 3);}
	
	missile.AddToPositionXY(allPositionsAdderValue*direct*speed);}
		
	// remove míssil se sair da tela ou for destruido
	if (missile.GetUInt("destruida") != 0)
	{
		AddEntity("explosionM6.ent", missile.GetPosition());
		@missile= DeleteEntity(missile);
			
		
	}
	
	//missile.Scale(missile.GetVector2("direction")*2);
	
}

void ETHBeginContactCallback_missile6(
	ETHEntity@ missile,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{	ETHPhysicsController@ controller = other.GetPhysicsController();
	if(other.GetEntityName()!="spaceship.ent" && other.GetEntityName()!="missile6.ent"){
	PlaySample("soundfx/impact.wav");
	missile.SetUInt("destruida", 1);
	other.AddToInt("hp", missile.GetInt("damage"));
	
	vector2 forta= controller.GetLinearVelocity();
	if(other.GetEntityName()=="asteroide.ent"){
	
	controller.SetLinearVelocity(vector2(missile.GetVector2("direction")*0.9));
	
}
}
}




void ETHPreSolveContactCallback_missile(
ETHEntity@ thisEntity, 
ETHEntity@ other, 
vector2 contactPointA, 
vector2 contactPointB, 
vector2 contactNormal)
{
if(other.GetEntityName()=="spaceship.ent")
DisableContact();
}
vector2 getKeyboardDirections()
{
	ETHInput @input = GetInputHandle();
	vector2 dir(0, 0);

	if (input.GetKeyState(K_LEFT)==KS_HIT)
		dir.x +=-1;

	if (input.GetKeyState(K_RIGHT)==KS_HIT)
		dir.x += 1;

	if (input.GetKeyState(K_UP)==KS_HIT)
		dir.y +=-1;

	if (input.GetKeyState(K_DOWN)==KS_HIT)
		dir.y += 1;

	return dir;
}




void ETHConstructorCallback_player(ETHEntity@ thisEntity)
{
	thisEntity.SetUInt("direction", 0);

	FrameTimer frameTimer;
	thisEntity.SetObject("frameTimer", @frameTimer);
}

void ETHCallback_player(ETHEntity@ thisEntity)
{	if(level==1){
	SetCameraPos(vector2(0, thisEntity.GetPosition().y-GetScreenSize().y/2));}
	FrameTimer@ frameTimer;
	thisEntity.GetObject("frameTimer", @frameTimer);
	const float speed = 3;
	frameTimer.update(0, 3, 150);
	vector2 direction(0,0);
	vector2 moveDirection(0, 0);
	ETHInput@ input = GetInputHandle();
	ETHPhysicsController@ controller = thisEntity.GetPhysicsController();
	moveDirection = normalize(getKeyboardDirections());
	moveDirection *= speed;
	if (moveDirection.x != 0 or moveDirection.y != 0)
	{
		thisEntity.SetVector2("lastDirection", moveDirection);
	}
	
	if (input.KeyDown(K_LEFT))
	{
		thisEntity.SetUInt("direction", 1);
		direction.x -= 1;
		
	}
	if (input.KeyDown(K_DOWN))
	{
		thisEntity.SetUInt("direction", 0);
		direction.y += 1;
		
	}
	if (input.KeyDown(K_UP))
	{
		thisEntity.SetUInt("direction", 3);
		direction.y -= 1;
		
	}

	if (input.KeyDown(K_RIGHT))
	{
		thisEntity.SetUInt("direction", 2);
		direction.x += 1;
		
	}
	
	uint frame = 0;
	if (direction != vector2(0,0))
		frame = frameTimer.getCurrentFrame();

	thisEntity.SetFrame(frame, thisEntity.GetUInt("direction"));
	thisEntity.AddToPositionXY(allPositionsAdderValue*normalize(direction)*2);
	
}


int l1last=1;
int l1stride=100;
int l1frame;
void ETHCallback_loading1(ETHEntity@ thisEntity)
{
	if(GetTime()-l1last>l1stride){
	l1frame+=1;
	l1last=GetTime();
	}
	if(l1frame>4){
	l1frame=1;
	}
	thisEntity.SetFrame(l1frame);
	
	
}
int l2last=1;
int l2stride=1;
int l2frame;
void ETHCallback_loading2(ETHEntity@ thisEntity)
{
	if(GetTime()-l2last>l2stride){
	l2frame+=1;
	l2last=GetTime();
	}
	if(l2frame>=60){
	l2frame=1;
	}
	thisEntity.SetFrame(l2frame);
	
}



int l4last=1;
int l4stride=1;
int l4frame;
void ETHCallback_loading4(ETHEntity@ thisEntity)
{
	if(GetTime()-l4last>l4stride){
	l4frame+=1;
	l4last=GetTime();
	}
	if(l4frame>=20){
	l4frame=1;
	}
	thisEntity.SetFrame(l4frame);
	
	
}
int l5last=1;
int l5stride=1;
int l5frame;
void ETHCallback_loading5(ETHEntity@ thisEntity)
{
	if(GetTime()-l5last>l5stride){
	l5frame+=1;
	l5last=GetTime();
	}
	if(l5frame>=35){
	l5frame=1;
	}
	thisEntity.SetFrame(l5frame);

	
	
}

int l6last=1;
int l6stride=20;
int l6frame;
void ETHCallback_loading6(ETHEntity@ thisEntity)
{
	if(GetTime()-l6last>l6stride){
	l6frame+=1;
	l6last=GetTime();
	}
	if(l6frame>=12){
	l6frame=1;
	}
	thisEntity.SetFrame(l6frame);
	
	
}

int l7last=1;
int l7stride=50;
int l7frame;
void ETHCallback_loading7(ETHEntity@ thisEntity)
{
	if(GetTime()-l7last>l7stride){
	l7frame+=1;
	l7last=GetTime();
	}
	if(l7frame>=25){
	l7frame=1;
	}
	thisEntity.SetFrame(l7frame);
	
	
}







	float frame1=0;

void ETHCallback_planeta1(ETHEntity@ thisEntity)
{
	
	thisEntity.SetFrame(frame1);
	frame1+=0.1;
	if(frame1>16){
	frame1=0;}
	
}

	float frame2=0;

void ETHCallback_planeta2(ETHEntity@ thisEntity)
{
	
	thisEntity.SetFrame(frame2);
	frame2+=0.1;
	if(frame2>16){
	frame2=0;}
	
}



vector2 rotate(const vector2 &in p, const float angleRad)
{
	return vector2(
		p.x * cos(angleRad) + p.y * sin(angleRad),
	  - p.x * sin(angleRad) + p.y * cos(angleRad));
}



int elapsedtime;
int frame3=0;
int stride3=200;
int lastx;
float astspeed=UnitsPerSecond(50.0f);
void ETHConstructorCallback_asteroide(ETHEntity@ asteroide){
lastx=GetTime();
asteroide.SetFloat("speed", 10);
asteroide.SetFloat("stride", 1);
asteroide.SetInt("hp", 30);
asteroide.SetVector2("dir", vector2(randF(1), randF(1)));
}


void ETHCallback_asteroide(ETHEntity@ asteroide)
{	
	//linearMotion(asteroide, false, 0, 360);	
	//blinkColor(asteroide, vector3(1, 1, 1), vector3(1, 1, 0.8), 300);
	asteroide.AddToPositionXY(asteroide.GetVector2("dir")*astspeed);
if(GetTime()-lastx>stride3){
frame3+=1;
lastx=GetTime();
}

if(frame3>16){
frame3=1;}
asteroide.SetFrame(frame3);
	if(asteroide.GetPosition().x<0){
	asteroide.SetPosition(vector3(GetScreenSize().x, asteroide.GetPosition().y, asteroide.GetPosition().z));}
	if(asteroide.GetPosition().x>GetScreenSize().x){
	asteroide.SetPosition(vector3(0, asteroide.GetPosition().y, asteroide.GetPosition().z));}
	
	// remove asteroide se for destruido
	if (asteroide.GetInt("hp") <= 0)
	{
		AddEntity("asteroid_explosion.ent", asteroide.GetPosition());
		PlaySample("soundfx/explosion.mp3");
		AddEntity("coin.ent", asteroide.GetPosition());
		money+=10;
		DeleteEntity(asteroide);
		
	}
}

void ETHConstructorCallback_asteroide2(ETHEntity@ asteroide){
asteroide.SetInt("hp", 150);}
int frame4=0;
int stride4=250;
int last4=2;
void ETHCallback_asteroide2(ETHEntity@ asteroide)
{	//asteroide.AddToPositionXY(allPositionsAdderValue*vector2(0,UnitsPerSecond(300.0f)));
	if(GetTime()-last4>stride4){
	frame4+=1;
	last4=GetTime();
	}

	if(frame4>16){
	frame4=1;}
	asteroide.SetFrame(frame4);
	if (asteroide.GetInt("hp") <= 0)
	{
		AddEntity("asteroid_explosion.ent", asteroide.GetPosition());
		AddEntity("coin.ent", asteroide.GetPosition());
		money+=50;
		DeleteEntity(asteroide);
		
	}
	/*if(asteroide.GetPosition().x<0){
	asteroide.SetPosition(vector3(GetScreenSize().x, asteroide.GetPosition().y, asteroide.GetPosition().z));}
	if(asteroide.GetPosition().x>GetScreenSize().x){
	asteroide.SetPosition(vector3(0, asteroide.GetPosition().y, asteroide.GetPosition().z));}
	if (asteroide.GetPosition().y>GetScreenSize().y+100)
	{
		AddEntity("asteroide2.ent", vector3(asteroide.GetPosition().x,-100,0));
		DeleteEntity(asteroide);	
		
		
	}*/
}
void ETHBeginContactCallback_asteroide2(
	ETHEntity@ thisEntity,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{
AddEntity("explosion.ent", thisEntity.GetPosition(), 0);
}



void ETHConstructorCallback_missileR(ETHEntity@ thisEntity){
	if(ddamage){
	thisEntity.SetInt("damage", -200);}
	else
	{thisEntity.SetInt("damage", -100);}
	
	thisEntity.SetInt("res", 3);
}

void ETHCallback_missileR(ETHEntity@ missile)
{	vector2 direct;
	direct=missile.GetVector2("direction");
	missileid=missile.GetID();
	if(missile.GetPosition().x<0.0f) {
	missile.SetUInt("destruida", 1);
	}
	if(missile.GetPosition().x>GetScreenSize().x){
	missile.SetUInt("destruida", 1);}
	if(missile.GetFloat("speed")!=DT_NODATA){speed = missile.GetFloat("speed");}
	else speed=UnitsPerSecond(480);
	if(missile !is null){
	//missile.AddToPositionXY(allPositionsAdderValue*dir* speed* 3);}
	
	missile.AddToPositionXY(allPositionsAdderValue*direct*speed);}
		
	// remove míssil se sair da tela ou for destruido
	if (missile.GetUInt("destruida") != 0 || missile.GetInt("res")<=0)
	{
		AddEntity("explosion.ent", missile.GetPosition(), 0);
		@missile= DeleteEntity(missile);
			
		
	}
	
	//missile.Scale(missile.GetVector2("direction")*2);
	
}

void ETHBeginContactCallback_missileR(
	ETHEntity@ missile,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{	ETHPhysicsController@ controller = other.GetPhysicsController();

	if(other.GetEntityName()!="spaceship.ent" && other.GetEntityName()!="missile.ent"){
	PlaySample("soundfx/impact.wav");
	//missile.SetUInt("destruida", 1);
	missile.AddToInt("res", -1);
	other.AddToInt("hp", missile.GetInt("damage"));
}
}






void ETHConstructorCallback_missileS6(ETHEntity@ thisEntity){
	if(ddamage){
	thisEntity.SetInt("damage", -30);}
	else
	{thisEntity.SetInt("damage", -15);}
	
}

void ETHCallback_missileS6(ETHEntity@ missile)
{	vector2 direct;
	direct=missile.GetVector2("direction");
	missileid=missile.GetID();
	if(missile.GetPosition().x<0.0f) {
	missile.SetUInt("destruida", 1);
	}
	if(missile.GetPosition().x>GetScreenSize().x){
	missile.SetUInt("destruida", 1);}
	if(missile.GetFloat("speed")!=DT_NODATA){speed = missile.GetFloat("speed");}
	else speed=UnitsPerSecond(500);
	if(missile !is null){
	//missile.AddToPositionXY(allPositionsAdderValue*dir* speed* 3);}
	
	missile.AddToPositionXY(allPositionsAdderValue*direct*speed);}
		
	// remove míssil se sair da tela ou for destruido
	if (missile.GetUInt("destruida") != 0)
	{
		AddEntity("explosion.ent", missile.GetPosition());
		@missile= DeleteEntity(missile);
			
		
	}
	
	//missile.Scale(missile.GetVector2("direction")*2);
	
}

void ETHBeginContactCallback_missileS6(
	ETHEntity@ missile,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{	ETHPhysicsController@ controller = other.GetPhysicsController();

	if(other.GetEntityName()!="spaceship6.ent" && other.GetEntityName()!="missileS6.ent"){
	PlaySample("soundfx/impact.wav");
	//missile.SetUInt("destruida", 1);
	missile.SetUInt("destruida", 1);
	other.AddToInt("hp", missile.GetInt("damage"));
}
}





void ETHConstructorCallback_missileRa(ETHEntity@ thisEntity){
if(ddamage){
	thisEntity.SetInt("damage", -60);}
	else
	{thisEntity.SetInt("damage", -30);}
	thisEntity.SetInt("res", 2);
}

void ETHCallback_missileRa(ETHEntity@ missile)
{	vector2 direct;
	direct=missile.GetVector2("direction");
	missileid=missile.GetID();
	if(missile.GetPosition().x<0.0f) {
	missile.SetUInt("destruida", 1);
	}
	if(missile.GetPosition().x>GetScreenSize().x){
	missile.SetUInt("destruida", 1);}
	if(missile.GetFloat("speed")!=DT_NODATA){speed = missile.GetFloat("speed");}
	else speed=UnitsPerSecond(480);
	if(missile !is null){
	//missile.AddToPositionXY(allPositionsAdderValue*dir* speed* 3);}
	if(missile.GetUInt("rl")!=0){
	missile.SetUInt("rl", 0);
	rl+=20;
	}
	missile.AddToPositionXY(allPositionsAdderValue*direct*speed);}
		
	// remove míssil se sair da tela ou for destruido
	if (missile.GetUInt("destruida") != 0 || missile.GetInt("res")<=0)
	{
		AddEntity("explosion.ent", missile.GetPosition());
		@missile= DeleteEntity(missile);
			
		
	}
	
	
	
}

void ETHBeginContactCallback_missileRa(
	ETHEntity@ missile,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{	ETHPhysicsController@ controller = other.GetPhysicsController();

	if(other.GetEntityName()!="spaceship.ent" && other.GetEntityName()!="missile.ent"){
	PlaySample("soundfx/impact.wav");
	//missile.SetUInt("destruida", 1);
	missile.AddToInt("res", -3);
	other.AddToInt("hp", missile.GetInt("damage"));
}
}




void ETHConstructorCallback_missile(ETHEntity@ thisEntity){
if(ddamage){
	thisEntity.SetInt("damage", -20);}
	else
	thisEntity.SetInt("damage", -10);
}

void ETHCallback_missile(ETHEntity@ missile)
{	vector2 direct;
	direct=missile.GetVector2("direction");
	missileid=missile.GetID();
	if(missile.GetPosition().x<0.0f) {
	missile.SetUInt("destruida", 1);
	}
	if(missile.GetPosition().x>GetScreenSize().x){
	missile.SetUInt("destruida", 1);}
	if(missile.GetFloat("speed")!=DT_NODATA){speed = missile.GetFloat("speed");}
	else speed=UnitsPerSecond(480);
	if(missile !is null){
	//missile.AddToPositionXY(allPositionsAdderValue*dir* speed* 3);}
	
	missile.AddToPositionXY(allPositionsAdderValue*direct*speed);}
		
	// remove míssil se sair da tela ou for destruido
	if (missile.GetUInt("destruida") != 0 )
	{
		AddEntity("explosion.ent", missile.GetPosition());
		@missile= DeleteEntity(missile);
			
		
	}
	
	
	
}

void ETHBeginContactCallback_missile(
	ETHEntity@ missile,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{	ETHPhysicsController@ controller = other.GetPhysicsController();
	if(other.GetEntityName()!="spaceship.ent" && other.GetEntityName()!="missile.ent" && other.GetEntityName()!="drone1p1.ent" && other.GetEntityName()!="drone1p2.ent"){
	PlaySample("soundfx/impact.wav");
	missile.SetUInt("destruida", 1);
	other.AddToInt("hp", missile.GetInt("damage"));
	
	vector2 forta= controller.GetLinearVelocity();
	if(other.GetEntityName()=="asteroide.ent"){
	
	controller.SetLinearVelocity(vector2(missile.GetVector2("direction")*0.9));
	
}

if(other.GetEntityName()=="asteroide2.ent"){
controller.SetLinearVelocity(vector2(missile.GetVector2("direction")*0.5));}}}


void ETHConstructorCallback_missilex(ETHEntity@ thisEntity){
thisEntity.SetInt("damage", -10);
}

void ETHCallback_missilex(ETHEntity@ missile)
{	vector2 direct;
	direct=missile.GetVector2("direction");
	missileid=missile.GetID();
	if(missile.GetPosition().x<0.0f) {
	missile.SetUInt("destruida", 1);
	}
	if(missile.GetPosition().x>GetScreenSize().x){
	missile.SetUInt("destruida", 1);}
	if(missile.GetFloat("speed")!=DT_NODATA){speed = missile.GetFloat("speed");}
	else speed=UnitsPerSecond(480);
	if(missile !is null){
	missile.AddToPositionXY(allPositionsAdderValue*direct*speed);}
	if (missile.GetUInt("destruida") != 0 )
	{
		AddEntity("explosion.ent", missile.GetPosition());
		@missile= DeleteEntity(missile);
			
		
	}
	
	
	
}

void ETHBeginContactCallback_missilex(
	ETHEntity@ missile,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{	
	//other.AddToInt("hp", -30);
	//other.SetInt("hp", other.GetInt("hp")-30);
	PlaySample("soundfx/impact.wav");
	missile.SetUInt("destruida", 1);
	
}


void ETHConstructorCallback_b1tm(ETHEntity@ thisEntity){
thisEntity.SetInt("damage", -5);
}

void ETHCallback_b1tm(ETHEntity@ missile)
{	vector2 direct;
	direct=missile.GetVector2("direction");
	missileid=missile.GetID();
	if(missile.GetPosition().x<0.0f) {
	missile.SetUInt("destruida", 1);
	}
	if(missile.GetPosition().x>GetScreenSize().x){
	missile.SetUInt("destruida", 1);}
	if(missile.GetFloat("speed")!=DT_NODATA){speed = missile.GetFloat("speed");}
	else speed=UnitsPerSecond(480);
	if(missile !is null){
	missile.AddToPositionXY(allPositionsAdderValue*direct*speed);}
	if (missile.GetUInt("destruida") != 0 )
	{
		AddEntity("explosion.ent", missile.GetPosition());
		@missile= DeleteEntity(missile);
			
		
	}
	
	
	
}

void ETHBeginContactCallback_b1tm(
	ETHEntity@ missile,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{	
	//other.AddToInt("hp", -30);
	//other.SetInt("hp", other.GetInt("hp")-30);
	PlaySample("soundfx/impact.wav");
	if(other.GetEntityName()!="base1t.ent")
	missile.SetUInt("destruida", 1);
	
}


void ETHCallback_b2tm(ETHEntity@ missile)
{	vector2 direct;
	direct=missile.GetVector2("direction");
	missileid=missile.GetID();
	if(missile.GetPosition().x<0.0f) {
	missile.SetUInt("destruida", 1);
	}
	if(missile.GetPosition().x>GetScreenSize().x){
	missile.SetUInt("destruida", 1);}
	if(missile.GetFloat("speed")!=DT_NODATA){speed = missile.GetFloat("speed");}
	else speed=UnitsPerSecond(480);
	if(missile !is null){
	missile.AddToPositionXY(allPositionsAdderValue*direct*speed);}
	if (missile.GetUInt("destruida") != 0 )
	{
		AddEntity("explosion.ent", missile.GetPosition());
		@missile= DeleteEntity(missile);
			
		
	}
	
	
	
}

void ETHBeginContactCallback_b2tm(
	ETHEntity@ missile,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{	
	//other.AddToInt("hp", -30);
	//other.SetInt("hp", other.GetInt("hp")-30);
	PlaySample("soundfx/impact.wav");
	if(other.GetEntityName()!="base2t.ent")
	missile.SetUInt("destruida", 1);
	
}


void ETHConstructorCallback_oznmissile(ETHEntity@ thisEntity){
thisEntity.SetInt("damage", -10);
}

void ETHCallback_oznmissile(ETHEntity@ missile)
{	vector2 direct;
	direct=missile.GetVector2("direction");
	missileid=missile.GetID();
	if(missile.GetPosition().x<0.0f) {
	missile.SetUInt("destruida", 1);
	}
	if(missile.GetPosition().x>GetScreenSize().x){
	missile.SetUInt("destruida", 1);}
	if(missile.GetFloat("speed")!=DT_NODATA){speed = missile.GetFloat("speed");}
	else speed=UnitsPerSecond(480);
	if(missile !is null){
	missile.AddToPositionXY(allPositionsAdderValue*direct*speed);}
	if (missile.GetUInt("destruida") != 0 )
	{
		AddEntity("explosion.ent", missile.GetPosition());
		@missile= DeleteEntity(missile);
			
		
	}
	
	
	
}

void ETHBeginContactCallback_oznmissile(
	ETHEntity@ missile,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{	
	//other.AddToInt("hp", -30);
	//other.SetInt("hp", other.GetInt("hp")-30);
	PlaySample("soundfx/impact.wav");
	missile.SetUInt("destruida", 1);
	
}


void ETHCallback_missile4(ETHEntity@ missile)
{	vector2 direct;
	direct=missile.GetVector2("direction");

	
	if(missile.GetPosition().x>GetScreenSize().x){
	missile.SetUInt("destruida", 1);}
	speed = UnitsPerSecond(160.0f);
	if(missile !is null){
	missile.AddToPositionXY(allPositionsAdderValue*direct*speed*3);}
		
	// remove míssil se sair da tela ou for destruido
	if (missile.GetUInt("destruida") != 0 )
	{
		AddEntity("explosion.ent", missile.GetPosition());
		@missile= DeleteEntity(missile);
			
		
	}
	
}
void ETHBeginContactCallback_missile4(
	ETHEntity@ missile,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{	PlaySample("soundfx/impact.wav");
	if(other.GetEntityName()!="spaceship.ent"){
	missile.SetUInt("destruida", 1);
	other.AddToInt("hp", -10);
	ETHPhysicsController@ controller = other.GetPhysicsController();vector2 forta= controller.GetLinearVelocity();
	if(other.GetEntityName()=="asteroide.ent"){
	
	controller.SetLinearVelocity(vector2(missile.GetVector2("direction")*0.9));
	
}

if(other.GetEntityName()=="asteroide2.ent"){
controller.SetLinearVelocity(vector2(missile.GetVector2("direction")*0.5));}}
	
}







void ETHCallback_missile5(ETHEntity@ missile){
missile.AddToPositionXY(allPositionsAdderValue*vector2(0.0f,UnitsPerSecond(400.0f)));}


void ETHBeginContactCallback_missile5(
	ETHEntity@ missile, 
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{	

	DeleteEntity(missile);
	if(other.GetEntityName()=="asteroide.ent"){

	other.SetUInt("destruida", 1);}
	if(other.GetEntityName()=="spaceship.ent"){
	hp=hp-20;}
	
}



void ETHCallback_missile3(ETHEntity@ missile)
{	
	
	missile.AddToPositionXY(allPositionsAdderValue*vector2(0.0f,UnitsPerSecond(400.0f)));
	
	// remove míssil se sair da tela ou for destruido
	if ( missile.GetUInt("destruida") != 0)
	{
		AddEntity("explosion.ent", missile.GetPosition());
		DeleteEntity(missile);		
	}
}

void ETHBeginContactCallback_missile3(
ETHEntity@ missile,
ETHEntity@ other,
vector2 contactPointA,
vector2 contactPointB,
vector2 contactNormal){
missile.SetUInt("destruida", 1);
PlaySample("soundfx/impact.wav");
}















/*void ETHBeginContactCallback_nave2(
	ETHEntity@ enemy,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{

if(other.GetID()==missileid){
hp1-=10;}

}*/

void ETHCallback_nave2(ETHEntity@ nave)
{
ndirection=vector2(0.0f,-1.0f);
ndirection = rotate(ndirection, degreeToRadian(nave.GetAngle()));
nave.AddToPositionXY(allPositionsAdderValue*ndirection*UnitsPerSecond(200));

if(nave.GetPosition().x<-40){nave.SetPosition(vector3(nave.GetPosition().x*-1+100,nave.GetPosition().y-700, 0));}

}


void ETHCallback_laser(ETHEntity@ laser){
laser.SetAngle(0);
if(laser.GetPosition().y-mainpos.y<70 && laser.GetPosition().y-mainpos.y>-70){
laser.SetUInt("move", 1);
}
if(laser.GetUInt("move")!=0){
laser.AddToPositionX(UnitsPerSecond(800));}
if(laser.GetPosition().x>=512){
DeleteEntity(laser);
}
}

void ETHConstructorCallback_shoterR(ETHEntity@ thisEntity)
{
thisEntity.SetInt("hp", 100);
}
void ETHConstructorCallback_shoterL(ETHEntity@ thisEntity)
{
thisEntity.SetInt("hp", 100);
}
int ltt=1;
void ETHCallback_shoterR(ETHEntity@ thisEntity)
{
if(thisEntity.GetInt("hp")<=0){
DeleteEntity(thisEntity);
money+=50;}
ETHEntity@ missile=null;
ETHEntity@ other;
float dist=distance(vector2(naveposx, naveposy), thisEntity.GetPositionXY());
if(thisEntity.GetPosition().y-naveposy<70 && thisEntity.GetPosition().y-naveposy>-70 && GetTime()-ltt>=1000 && dist<=470)
{
ltt=GetTime();
AddEntity("missilex.ent", thisEntity.GetPosition()+vector3(25, 0, 0), missile);
}
if(missile !is null)
{
missile.SetVector2("direction", vector2(1, 0));
missile.SetAngle(-90);
}
}


void ETHCallback_shoterL(ETHEntity@ thisEntity)
{
if(thisEntity.GetInt("hp")<=0){
DeleteEntity(thisEntity);
money+=50;}
ETHEntity@ missile=null;
ETHEntity@ other;
float dist=distance(vector2(naveposx, naveposy), thisEntity.GetPositionXY());
if(thisEntity.GetPosition().y-naveposy<70 && thisEntity.GetPosition().y-naveposy>-70 && GetTime()-ltt>=1000 && dist<=470)
{
ltt=GetTime();
AddEntity("missilex.ent", thisEntity.GetPosition()+vector3(-25, 0, 0), missile);
}
if(missile !is null)
{
missile.SetVector2("direction", vector2(-1, 0));
missile.SetAngle(90);
}
}

void ETHConstructorCallback_shooter2l(ETHEntity@ thisEntity)
{
thisEntity.SetInt("hp", 60);
thisEntity.SetInt("lastfire", 1);
}

void ETHConstructorCallback_shooter2r(ETHEntity@ thisEntity)
{
thisEntity.SetInt("hp", 60);
thisEntity.SetInt("lastfire", 1);
}

void ETHCallback_shooter2l(ETHEntity@ thisEntity)
{
if(thisEntity.GetInt("hp")<=0){
DeleteEntity(thisEntity);
money+=50;}
ETHEntity@ missile=null;
ETHEntity@ other;
float dist=distance(vector2(naveposx, naveposy), thisEntity.GetPositionXY());
if(thisEntity.GetPosition().y-naveposy<70 && thisEntity.GetPosition().y-naveposy>-70 && GetTime()-thisEntity.GetInt("lastfire")>=700 && dist<=470)
{
thisEntity.SetInt("lastfire", GetTime());
AddEntity("missilex.ent", thisEntity.GetPosition()+vector3(50, 0, 0), missile);
}
if(missile !is null)
{
missile.SetVector2("direction", vector2(1, 0));
missile.SetAngle(-90);
}
}


void ETHCallback_shooter2r(ETHEntity@ thisEntity)
{
if(thisEntity.GetInt("hp")<=0){
DeleteEntity(thisEntity);
money+=70;}
ETHEntity@ missile=null;
ETHEntity@ other;
float dist=distance(vector2(naveposx, naveposy), thisEntity.GetPositionXY());
if(thisEntity.GetPosition().y-naveposy<70 && thisEntity.GetPosition().y-naveposy>-70 && GetTime()-thisEntity.GetInt("lastfire")>=700 && dist<=470)
{
thisEntity.SetInt("lastfire", GetTime());
AddEntity("missilex.ent", thisEntity.GetPosition()+vector3(-50, 0, 0), missile);
}
if(missile !is null)
{
missile.SetVector2("direction", vector2(-1, 0));
missile.SetAngle(90);
}
}