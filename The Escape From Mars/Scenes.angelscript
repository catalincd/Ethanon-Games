#include "Button.angelscript"
file f;
int auxtime=0;
bool showfps=false;
bool showsupl=true;
bool showBars=true;
bool repkit=false;
int butauxi1=1;
int butauxi2=1;
int auxvolume=1;
string mystring="sprites/black.png";
vector2 myvector2(0,0);
void NewGame(){
SetGravity(vector2(0,0));
}
int inmoney=0;
int days=1;
int[] Dsize;
/*void SetDamgeSize()
{
for(uint j=1;j<=100;j++)
{
if(j=>18 and j<=72)
Dsize[i]=78;
else
{
if()
}
}
}*/

vector2 GetSpriteRects(string name)
{
return vector2(GetSpriteSize(name).x/GetSpriteFrameSize(name).x,GetSpriteSize(name).y/GetSpriteFrameSize(name).y);
}

/*void PixelLine(vector2 p0, vector2 p1)
{
DrawLine(p0, p1, , ,0);
}*/

void levelhc()
{
levelh.insertLast(1);
levelh.insertLast(150);
levelh.insertLast(500);
levelh.insertLast(400);
levelh.insertLast(150);
levelh.insertLast(400);
levelh.insertLast(230);
levelh.insertLast(400);
levelh.insertLast(110);
levelh.insertLast(110);

}

void falses()
{
armor=false;
ddamage=false;
nitro=false;
}



/*supplies*/


void createStartScene()
{		//SetGlobalVolume(0);
	file f1;
	//print(GetExternalStorageDirectory());
	string showfpsaS,showsuplS;
	f1.open("SavedData/showfps.kta", "r");
	f1.readString(f1.getSize(), showfpsaS);
	f1.close();
	gob1=false;
	showfps=showfpsaS=="1"? true:false;
	butauxi1=showfpsaS=="1"? 1:0;
	f1.open("SavedData/showsupl.kta", "r");
	f1.readString(f1.getSize(), showsuplS);
	f1.close();
	showsupl=showsuplS=="1"? true:false;
	butauxi2=showfpsaS=="1"? 1:0;
	LoadMusic("soundfx/menu sound.mp3");
	LoadSprite("sprites/alienware.png");
	SetSpriteOrigin("sprites/alienware.png", vector2(0.5, 0.5));
	//money=70;
butauxi1=showfpsaS=="1"? 2:1;
 butauxi2=showsuplS=="1"? 2:1;
}



void createOptionsScene(){
 
}

stringInput sinput;
CameraManager g_cam(30, 5000, 3000);
int res=1024*768;
void updateStartScene()
{	

if(GetSceneFileName()=="scenes/start.esc"){
	if (!IsSamplePlaying("soundfx/menu sound.mp3")){PlaySample("soundfx/menu sound.mp3");}}
	

	if(input.GetKeyState(K_ESC)==KS_HIT){ Exit();}	
		
		
	Button@ g_startGameButton;
	vector2 startButtonPos(vector2(200, 200));
	@g_startGameButton = Button("sprites/newgame.png", startButtonPos);
	g_startGameButton.putButton();
	if (g_startGameButton.isPressed())
	{	hpp=100;
		money=0;
		level=1;
		gob1=false;
		auxtime=GetTime();
		StopSample("soundfx/menu sound.mp3");
		LoadScene("scenes/load.esc", "prepareLoadingScene", "updateLoadingScene");
	}
//    system(std::string("start " + link).c_str());

	Button@ g_help;
	vector2 hlpos(vector2(110, 500));
	SetSpriteOrigin("sprites/help.png",vector2(0,0));
	@g_help = Button("sprites/help.png", hlpos);
	g_help.putButton();
	if (g_help.isPressed())
	{
		LoadScene("scenes/start.esc", "help", "helpupdate");
	}
	
	
	
	
	Button@ g_options;
	vector2 optionspos(vector2(210, 380));
	@g_options = Button("sprites/options.png", optionspos);
	g_options.putButton();
	if (g_options.isPressed())
	{	StopSample("soundfx/menu sound.mp3");
		LoadScene("scenes/buy.esc", "createOptionsScene", "updateOptionsScene");
	}
	Button@ g_saved;
	vector2 savpos(vector2(200, 260));
	@g_help = Button("sprites/saved.png", savpos);
	g_help.putButton();
	if (g_help.isPressed())
	{	file f1, f2, f3, f4;
		f1.open("SavedData/money.kta", "r");
		f2.open("SavedData/hp.kta", "r");
		f3.open("SavedData/level.kta", "r");
		f4.open("SavedData/ship.kta", "r");
		string moneyreadx, hpreadx, levelreadx, shipreadx;
		f1.readString(f1.getSize(), moneyreadx);
		f1.close();
		f2.readString(f2.getSize(), hpreadx);
		f2.close();
		f3.readString(f3.getSize(), levelreadx); 
		f3.close();
		f4.readString(f4.getSize(), shipreadx); 
		f4.close();
		money=parseInt(moneyreadx);
		hpp=parseFloat(hpreadx);
		level=parseInt(levelreadx);
		days=parseInt(levelreadx);
		nv1=parseInt(shipreadx);
		StopSample("soundfx/menu sound.mp3");
		savedg=true;
		gob1=false;
		auxtime=GetTime();
		LoadScene("scenes/load.esc", "prepareLoadingScene", "updateLoadingScene");
	}
	Button@ g_buy;
	vector2 buypos(vector2(200, 320));
	@g_buy = Button("sprites/buy.png", buypos);
	g_buy.putButton();
	if (g_buy.isPressed())
	{	StopSample("soundfx/menu sound.mp3");
		LoadScene("scenes/buy.esc", "createBuyScene", "updateBuyScene", "GameLoop");
	}
	
	Button@ g_about;
	vector2 aboutpos(vector2(130, 440));
	@g_about = Button("sprites/about.png", aboutpos);
	g_about.putButton();
	if (g_about.isPressed())
	{	StopSample("soundfx/menu sound.mp3");
		LoadScene("scenes/buy.esc", "createAboutScene", "updateAboutScene", "GameLoop");
	}
	Button@ g_Exit;
	@g_Exit = Button("sprites/exit.png", vector2(110,555));
	
	g_Exit.putButton();
	if (g_Exit.isPressed()){
	SaveScene("scenes/saved.esc");
	Exit();}
	

	}

void updateSuppliesScene()
{
DrawText(vector2(130, 115), "After one level, EVERY of them will end!...", "Verdana30_shadow.fnt", 0xFF00BFFF);
DrawSprite("sprites/armor2.png", vector2(100, 150));
DrawSprite("sprites/damagecopy.png", vector2(100, 250));
DrawSprite("sprites/nitro3.png", vector2(100, 350));
DrawText(vector2(130, 485), "Repair kit can be kept how much you want!", "Verdana30_shadow.fnt", 0xFF00BFFF);
DrawText(vector2(210, 185), "-Double armor: Yes", "Verdana30_shadow.fnt", 0xFF3BFF33);
DrawText(vector2(210, 285), "-Double damage: Yes", "Verdana30_shadow.fnt", 0xFFFF0033);
DrawText(vector2(210, 385), "-Nitro: No", "Verdana30_shadow.fnt", 0xFFFFFF00);
Button@ g_Exit;
vector2 exitPos(vector2(GetScreenSize().x-80,GetScreenSize().y-40));
@g_Exit = Button("sprites/exit.png", exitPos);	
g_Exit.putButton();
if (g_Exit.isPressed())
{
LoadScene("scenes/start.esc", "", "updateAboutScene");}
}


void updateAboutScene(){
Button@ g_Exit;
vector2 exitPos(vector2(GetScreenSize().x-80,GetScreenSize().y-40));
@g_Exit = Button("sprites/exit.png", exitPos);	
g_Exit.putButton();
if (g_Exit.isPressed())
{
LoadScene("scenes/start.esc", "createStartScene", "updateStartScene");}

Button@ g_supplies;
vector2 suppliesPos(170, 140);
@g_supplies = Button("sprites/supplies.png", suppliesPos);	
g_supplies.putButton();
if (g_supplies.isPressed())
{
LoadScene("scenes/start.esc", "createSuppliesScene", "updateSuppliesScene");}


	Button@ g_ship1;
	vector2 ship1pos(vector2(200, 200));
	@g_ship1 = Button("sprites/ship 1.png", ship1pos);
	g_ship1.putButton();
	if (g_ship1.isPressed())
	{	
		LoadScene("scenes/buy.esc", "ships", "ship1");
		
	}
	Button@ g_ship2;
	vector2 ship2pos(vector2(200, 260));
	@g_ship2 = Button("sprites/ship 2.png", ship2pos);
	g_ship2.putButton();
	if (g_ship2.isPressed())
	{	
		LoadScene("scenes/buy.esc", "ships", "ship2");
		
	}
	Button@ g_ship3;
	vector2 ship3pos(vector2(200, 320));
	@g_ship3 = Button("sprites/ship 3.png", ship3pos);
	g_ship3.putButton();
	if (g_ship3.isPressed())
	{	
		LoadScene("scenes/buy.esc", "ships", "ship3");
		
	}
	Button@ g_ship4;
	vector2 ship4pos(vector2(200,380));
	@g_ship4 = Button("sprites/ship 4.png", ship4pos);
	g_ship4.putButton();
	if (g_ship4.isPressed())
	{	
		LoadScene("scenes/buy.esc", "ships", "ship4");
		
	}
	Button@ g_ship5;
	vector2 ship5pos(vector2(200, 440));
	@g_ship5 = Button("sprites/ship 5.png", ship5pos);
	g_ship5.putButton();
	if (g_ship5.isPressed())
	{	
		LoadScene("scenes/buy.esc", "ships", "ship5");
		
	}
	

}
void ship1(){
Button@ g_Exit;
vector2 exitPos(vector2(GetScreenSize().x-80,GetScreenSize().y-40));
@g_Exit = Button("sprites/exit.png", exitPos);	
g_Exit.putButton();
if (g_Exit.isPressed()){
LoadScene("scenes/start.esc", "", "updateAboutScene");}string fadfads;
fadfads+="Hp: 100";
fadfads+="\nBullets: 1";
fadfads+="\nMoving Speed: 160 MPH";
fadfads+="\nRotating Speed: 1,2 Degees/second";

DrawSprite("entities/fighterspr1.png", vector2(200, 350));

DrawText(vector2(200,200), fadfads, "Verdana30_shadow.fnt", ARGB(255,0,0,255));
}


void ship2(){
Button@ g_Exit;
vector2 exitPos(vector2(GetScreenSize().x-80,GetScreenSize().y-40));
@g_Exit = Button("sprites/exit.png", exitPos);	
g_Exit.putButton();
if (g_Exit.isPressed()){
LoadScene("scenes/start.esc", "", "updateAboutScene");}string info1;
info1+="Hp: 150";
info1+="\nBullets: 1";
info1+="\nMoving Speed: 280 MPH";
info1+="\nRotating Speed: 1,7 Degees/second";
DrawSprite("entities/spce.png", vector2(200, 350));
DrawText(vector2(200,200), info1, "Verdana30_shadow.fnt", ARGB(255,0,0,255));
}
void ship3(){
Button@ g_Exit;
vector2 exitPos(vector2(GetScreenSize().x-80,GetScreenSize().y-40));
@g_Exit = Button("sprites/exit.png", exitPos);	
g_Exit.putButton();
if (g_Exit.isPressed()){
LoadScene("scenes/start.esc", "", "updateAboutScene");}string info1;
info1+="Hp: 200";
info1+="\nBullets: 2";
info1+="\nMoving Speed: 160 MPH";
info1+="\nRotating Speed: 120 Degees/second";
DrawSprite("entities/nave3.png", vector2(200, 300));

DrawText(vector2(200,200), info1, "Verdana30_shadow.fnt", ARGB(255,0,0,255));
}
void ship4(){
Button@ g_Exit;
vector2 exitPos(vector2(GetScreenSize().x-80,GetScreenSize().y-40));
@g_Exit = Button("sprites/exit.png", exitPos);	
g_Exit.putButton();
if (g_Exit.isPressed()){
LoadScene("scenes/start.esc", "", "updateAboutScene");}string info1;
info1+="Hp: 100";
info1+="\nBullets: 2";
info1+="\nMoving Speed: ? MPH";
info1+="\nRotating Speed: ? Degees/second";
DrawSprite("entities/nave4.png", vector2(200, 300));

DrawText(vector2(200,200), info1, "Verdana30_shadow.fnt", ARGB(255,0,0,255));
}
void ship5(){
Button@ g_Exit;
vector2 exitPos(vector2(GetScreenSize().x-80,GetScreenSize().y-40));
@g_Exit = Button("sprites/exit.png", exitPos);	
g_Exit.putButton();
if (g_Exit.isPressed()){
LoadScene("scenes/start.esc", "", "updateAboutScene");}string info1;
info1+="Bullets: 2";
info1+="\nMoving Speed: 160 MPH";
info1+="\nRotating Speed: 120 Degees/second";
DrawSprite("entities/spaceship.png", vector2(200, 300));
DrawText(vector2(200,200), info1, "Verdana30_shadow.fnt", ARGB(255,0,0,255));
}

void help(){




	}
void helpupdate(){

Button@ g_Exit;
vector2 exitPos(vector2(GetScreenSize().x+20,GetScreenSize().y-40));
@g_Exit = Button("sprites/exit.png", exitPos);	
g_Exit.putButton();
if (g_Exit.isPressed()){
LoadScene("scenes/start.esc", "createStartScene", "updateStartScene", "GameLoop");}}







stringInput volinput;
int opaux=1;
string butaux1="entities/checkbox-u.png";
string butaux2="entities/checkbox-u.png";

int settexttodraw1=0;
void updateOptionsScene(){
	

	
	
	Button@ g_volume;
	vector2 volumePos(vector2(250,240));
	//SetSpriteOrigin("sprites/exit.png", volumePos);
	@g_volume = Button("sprites/volume.png", volumePos);
	g_volume.putButton();
	if (g_volume.isPressed()){
	opaux++;
	}
	
	if(opaux%2==0)
	volinput.PlaceInput("Volume(0-10)", vector2(340,220), "Verdana30_shadow.fnt", ARGB(255,0,0,255));
	volume=parseFloat(volinput.GetString())/10;
	if(opaux!=1)
	SetGlobalVolume(volume);
	/*if(volume>10 || volume < 0 || volume!=DT_INT)
	{	if(opaux!=1){
	volume=auxvolume;
	DrawFadingText(vector2(640,225), "WARNING: Value is not correct!", "Verdana24_shadow.fnt", 0xFFFF003B, 5000);}
	}*/
	
	Button@ g_exit;
	vector2 exitPos(vector2(GetScreenSize().x+20,GetScreenSize().y-40));
	SetSpriteOrigin("sprites/exit.png", exitPos-vector2(90,0));
	@g_exit = Button("sprites/exit.png", exitPos-vector2(90,0));
	g_exit.putButton();
	if (g_exit.isPressed()){
	file f1, f2;
	f1.open("SavedData/showfps.kta", "w");
	string showfpsS=showfps? "1":"0";
		
		f1.writeString(showfpsS); 
		f1.close();
		
	f2.open("SavedData/showsupl.kta", "w");
	string showsuplS;
	showsuplS=showsupl? "1":"0";
		
		f1.writeString(showsuplS); 
		f1.close();
	
		auxvolume=volume;

	PauseSample("soundfx/menu sound.mp3");
	LoadScene("scenes/start.esc", "createStartScene", "updateStartScene", "GameLoop");}
	DrawText(vector2(160, 305), "Show FPS", "Verdana30_shadow.fnt", ARGB(255, 0, 0, 255));
	Button@ g_showfps;
	vector2 showfpsPos(vector2(130,320));
	//SetSpriteOrigin("sprites/exit.png", volumePos);
	@g_showfps = Button(butaux1, showfpsPos);
	g_showfps.putButton();
	if (g_showfps.isPressed())
	{
	butauxi1++;
	}
	if(butauxi1%2==1)
	{
	butaux1="entities/checkbox-u.png";
	showfps=false;
	}
	else
	{
	butaux1="entities/checkbox-c.png";
	showfps=true;
	}
	DrawText(vector2(160, 405), "Show Supplies", "Verdana30_shadow.fnt", ARGB(255, 0, 0, 255));
	Button@ g_showsupl;
	vector2 showsuplPos(vector2(130,420));
	//SetSpriteOrigin("sprites/exit.png", volumePos);
	@g_showsupl = Button(butaux2, showsuplPos);
	g_showsupl.putButton();
	if (g_showsupl.isPressed())
	{
	butauxi2++;
	}
	if(butauxi2%2==1)
	{
	butaux2="entities/checkbox-u.png";
	showsupl=false;
	}
	else
	{
	butaux2="entities/checkbox-c.png";
	showsupl=true;
	}
	
	
}






void GameLoop(){
	levelhc();

	randb=1;
	SetZAxisDirection(vector2(0,0));
	UsePixelShaders(true);
	//nv1=2;
	SetGravity(vector2(0,0));
	LoadSoundEffect("soundfx/fire.wav");
	allsounds.insertLast("soundfx/fire.wav");
	LoadSoundEffect("soundfx/railgun.mp3");
	allsounds.insertLast("soundfx/railgun.mp3");
	LoadSoundEffect("soundfx/impact.wav");
	allsounds.insertLast("soundfx/impact.wav");
	LoadSoundEffect("soundfx/explosion.mp3");
	allsounds.insertLast("soundfx/explosion.mp3");
	LoadSoundEffect("soundfx/boostb.mp3");
	allsounds.insertLast("soundfx/boostb.mp3");
	LoadSoundEffect("soundfx/explosion2.wav");
	allsounds.insertLast("soundfx/explosion2.wav");
	LoadSoundEffect("soundfx/fire2.wav");
	allsounds.insertLast("soundfx/fire2.wav");
	LoadSoundEffect("soundfx/fire3.mp3");
	allsounds.insertLast("soundfx/fire3.mp3");
	SetSampleVolume("soundfx/impact.wav", 0.7);
	SetSampleVolume("soundfx/fire.wav", 0.6);
	//SetSampleVolume("");
	//SetSampleVolume("");
	LoadMusic("soundfx/soundtrack.mp3");
	allsounds.insertLast("soundfx/soundtrack.mp3");
	SetSampleVolume("soundfx/soundtrack.mp3", 0.7*volume);
	LoopSample("soundfx/soundtrack.mp3", true);
	PlaySample("soundfx/soundtrack.mp3");
	if(level!=1)
	inmoney=money;
	else
	inmoney=0;
	ddamage=true;
	//damage=80;
		/*ETHEntityArray allent;
	GetAllEntitiesInScene(allent);
	const int allentnum = allent.Size();
	for(int it=1; it<=allentnum; it++)
	{
	allent[it].SetNormal("default_nm.png");
	
	}*/
	
	ETHEntityArray entities;
//GetAllEntitiesInScene(entities);
//SetFixedTimeStep(true);
//float timeV=1.0f / 120.0f;
//SetFixedTimeStepValue(timeV);
EnableLightmaps(true);

// double the size of every entity in scene
for (uint t = 0; t < entities.Size(); t++)
{
    entities[t].SetNormal("default_nm.png");
	//if( entities[t].GetPosition().z<0)
	// entities[t].SetPositionZ(0);
}
	
	SetSpriteOrigin("sprites/alienware.png", vector2(0.5,0.5));
}
bool myaux=true;
int goalpha=0;
int goalpha2=0;
void createGameScene()
{
if(level == 3 or level == 7)
{
if(GetCameraPos().x != 0 or GetCameraPos().y != 0)
SetCameraPos(vector2(0,0));
}
//maxhp=GetMaxHp();
//float timeV2=GetTimeStepScale()*2;
//SetTimeStepScale(timeV2);
	if (fnitro<=0)
	nitro=false;
	if(repair<=0)
	repairx=false;
	else
	repairx=true;
	if(deincetinit)
	{
	if(GetTime()-timpdeincetinire2>timpdeincetinire1)
	{Incetineste(1);deincetinit=false;}
	}
	//SetupSpriteRects("sprites/damage4.png", 1, 2);
	//SetSpriteRect("sprites/damage4.png", GetSpriteRects("sprites/damage4.png").y-1);
	//float xvar=maindir.x+maindir.y;
	//DrawText(vector2(0,400), vector2ToString(maindir)+ " "+ xvar, "Verdana30_shadow.fnt", 0xFFFFFFFF);
	
	if(ddamage){
	if(damage<=0)
	{
	ddamage=false;
	}}
	if(gob1)
	{
	SetGlobalVolume(0);
	showBars=false;
	showsupl=false;
	showfps=false;
	goalpha=GetTime()-got1;
	goalpha2=GetTime()-got1+3500;
	if(goalpha>2550)
	goalpha=2550;
	if(goalpha2>2550)
	goalpha2=2550;
	//print(""+goalpha2);
	
	if(goalpha>=2550)
	{
	mystring="sprites/alienware.png";myvector2=GetScreenSize()/2;}
	DrawSprite(mystring, myvector2, ARGB(goalpha/10, 255,255,255));
	
	
	if(GetTime()-got1>=10000){
	StopSample("soundfx/soundtrack.mp3");
	SetGlobalVolume(volume);
	LoadScene("scenes/gameover.esc", "", "upadteGameOver");}
	}



	if(showsupl)
	{
		
	SetSpriteOrigin("sprites/damage4.png", vector2(0, 1));
	SetSpriteOrigin("sprites/nitro4.png", vector2(0, 1));
	if(ddamage)
	DrawShapedSprite("sprites/damage4.png", vector2(400,99),vector2(100, damage/maxDamage*100), 0xFFFFFFFF);
	if(nitro)
	DrawShapedSprite("sprites/nitro4.png", vector2(500,99),vector2(100, fnitro/maxNitro*100), 0xFFFFFFFF);
	//DrawShapedSprite("sprites/cover5.png", vector2(400,0), vector2(300, 102));
	ddamage?
	DrawShapedSprite("sprites/damage2.png", vector2(400,2),vector2(100,100), 0xFFFFFFFF)
	:
	DrawShapedSprite("sprites/damage3.png", vector2(400,2),vector2(100,100), 0xFF999999);
	DrawShapedSprite(armor? "sprites/armor2.png":"sprites/armor3.png", vector2(300,2),vector2(100,100), armor? 0xFFFFFFFF:0xFF999999);
		DrawShapedSprite(nitro? "sprites/nitro2.png":"sprites/nitro3.png", vector2(500,2),vector2(100,100), nitro? 0xFFFFFFFF:0xFF999999);
	DrawShapedSprite("sprites/cover4.png", vector2(305,8), vector2(90, 90));
	DrawShapedSprite("sprites/cover4.png", vector2(405,8), vector2(90, 90));
	DrawShapedSprite("sprites/cover4.png", vector2(505,8), vector2(90, 90));
	}
	if(showfps)
	DrawText(GetScreenSize()-ComputeTextBoxSize("Verdana24_shadow.fnt","FPS:"+GetFPSRate())*1.5, "FPS:"+GetFPSRate(), "Verdana24_shadow.fnt", 0xFF006CFF);
	SetSpriteOrigin("sprites/hp bar.png", vector2(0,0));
	Button2@ g_repair;
	@g_repair=Button2("sprites/repair-k2.png", vector2(690, 55));
		g_repair.SetColor(repair>0? 0xFFFFFFFF : 0xFF999999);

	if(showBars){
	g_repair.putButton();
	if(g_repair.isPressed())
	{
	if(repairx){
	repair--;
	hpp=GetMaxHp();
	}}
	//DrawSprite("sprites/repair-k2.png", vector2(655, 8), repairx? 0xFFFFFFFF:0xFF999999);
	DrawSprite("sprites/barbg.png", vector2(0,-1.5));
	if(nv1==0){
	if(rl2<100){rl2=(GetTime()-lastpress)/100;}
	DrawShapedSprite("sprites/reload bar.png", vector2(0, 0), vector2(rl2*2,28));
	
	float _sizex_ = (rl2)-(ComputeTextBoxSize("Verdana24_shadow.fnt", "Reload").x/2);
	DrawText(vector2(_sizex_, 0), "Reload", "Verdana24_shadow.fnt", 0xFF3333FF);
	}
	DrawShapedSprite("sprites/hp bar.png", vector2(0, 40), vector2(hpp/maxhp*200,28));
	
	
	if(rl<100){rl=100;}
	if(nv1!=0){
	DrawShapedSprite("sprites/reload bar.png", vector2(0, 0), vector2((200-rl)*2,28));
	float _size_ = (200-rl)-(ComputeTextBoxSize("Verdana24_shadow.fnt", "Reload").x/2);
	
	DrawText(vector2(_size_, 0), "Reload", "Verdana24_shadow.fnt", 0xFF3333FF);}
	float _size2_=hpp/maxhp*100-(ComputeTextBoxSize("Verdana24_shadow.fnt", "Hp").x/2);
	DrawText(vector2(_size2_, 40), "Hp", "Verdana24_shadow.fnt", 0xFFFF8888);
	
	Button@ g_soundm;
	vector2	soundmPos(vector2(998, 16));
	@g_soundm = Button("sprites/sound_mute1.png", soundmPos);
	g_soundm.putButton();
	if (g_soundm.isPressed())
	{	SetSampleVolume("soundfx/soundtrack.mp3", 0);
		volume=0;
		SetGlobalVolume(volume);
	}
	Button@ g_soundh;
	vector2	soundhPos(vector2(966, 16));
	@g_soundh = Button("sprites/sound_high1.png", soundhPos);
	g_soundh.putButton();
	if (g_soundh.isPressed())
	{	
		
		SetGlobalVolume(volume);
		SetSampleVolume("soundfx/soundtrack.mp3", volume);
	}
	}
	
	
	if(damage<=0)
	{ddamage=false;}
	
	SetGravity(vector2(0,0));
	
	
	if(showBars){
	DrawSprite("sprites/ymng.png", vector2(0,80));
	DrawText(vector2(140,80), ""+money, "Verdana24_shadow.fnt", ARGB(255,0,0,255));
	
	}	
	if(level==1)
	{
	DrawNotification(" Use arrows and space!  ","Verdana20_shadow.fnt", 2000, 2000);
	DrawNotification(" Destroy the asteroids!","Verdana20_shadow.fnt", 5000, 2000);
	DrawNotification("Hmm... Something wants   \n            TO KILL ME!","Verdana20_shadow.fnt", 10000, 2000);
	}
	
	
	if(levelh[level]<=money-inmoney)
	{
	StopSample("soundfx/soundtrack.mp3");
	rl2=0;
	rl=0;
	falses();
	days+=1;
	level+=1;
	LoadScene("scenes/buy.esc", "createBuyScene", "updateBuyScene", "GameLoop");
	}
	
	time=GetTime()/1000;
	
	
	tim3=GetTime();
	
	tmdsa=GetTime();
	
	ntime=GetTime()/1000;


	if(level==2){
	}
	if(level==3){

	DrawNotification(" Some enemies!...  ","Verdana20_shadow.fnt", 2000, 5000);
	}
	
	if(input.GetKeyState(K_ALT)==KS_DOWN && input.GetKeyState(K_F4)==KS_HIT){ 
	SaveScene("scenes/saved.esc");
	string moneyy=money;
	string hhpp=hp;
	SaveStringToFile(GetExternalStorageDirectory() + "money.txt", moneyy);
	SaveStringToFile(GetExternalStorageDirectory() + "hp.txt", hhpp);
	Exit();}
	if (input.GetKeyState(K_ESC)==KS_HIT)
	{	SaveScene("scenes/Level 0.esc");
		//SaveScene("scenes/load.esc");
	LoadScene("scenes/start.esc", "createEscScene", "updateEscScene");}
	
	}
	
void createEscScene(){
/*string moneyy=money;
	string hhpp=hp;
	SaveStringToFile(GetExternalStorageDirectory() + "money.txt", moneyy);
	SaveStringToFile(GetExternalStorageDirectory() + "hp.txt", hhpp);*/
	}

void updateEscScene(){
	Button@ g_Exit;
	@g_Exit = Button("sprites/save.png", vector2(472,370));
	g_Exit.putButton();
	if (g_Exit.isPressed()){
	file f1, f2, f3, f4;
		f1.open("SavedData/money.kta", "w");
		f2.open("SavedData/hp.kta", "w");
		f3.open("SavedData/level.kta", "w");
		f4.open("SavedData/ship.kta", "w");
		string moneyread1, hpread1, levelread1, shipread1;
		moneyread1=""+money;
		hpread1=""+hpp;
		levelread1=""+level;
		shipread1=""+nv1;
		f1.writeString(moneyread1); 
		f1.close();
		f2.writeString(hpread1); 
		f2.close();
		f3.writeString(levelread1); 
		f3.close();
		f4.writeString(shipread1); 
		f4.close();
		
		
		}
	
	Button@ g_exitf;
	@g_exitf = Button("sprites/exit.png", vector2(378, 440));
	g_exitf.putButton();
	if(g_exitf.isPressed())
	{
	StopSample("soundfx/soundtrack.mp3");
	LoadScene("scenes/start.esc", "createStartScene", "updateStartScene", "Loads");}
	Button@ g_Resume;
	@g_Resume = Button("sprites/resume.png", vector2(487,300));
	g_Resume.putButton();
	if (g_Resume.isPressed()){	
		file f1, f2, f3, f4;
		f1.open("SavedData/money.kta", "r");
		f2.open("SavedData/hp.kta", "r");
		f3.open("SavedData/level.kta", "r");
		f4.open("SavedData/ship.kta", "r");
		string moneyread1, hpread1, levelread1, shipread1;
		f1.readString(f1.getSize(), moneyread1); 
		f1.close();
		f2.readString(f2.getSize(), hpread1); 
		f2.close();
		f3.readString(f3.getSize(), levelread1); 
		f3.close();
		f4.readString(f4.getSize(), shipread1); 
		f4.close();
		money=parseInt(moneyread1);
		hpp=parseFloat(hpread1);
		level=parseInt(levelread1);
		nv1=parseInt(shipread1);
		savedg=true;
		
		LoadScene("scenes/load.esc", "prepareLoadingScene", "updateLoadingScene");
	}}
	
	
	
	

string[] resourcesToLoads;
uint resourceIterator;
void prepareLoadingScene()
{	//StopSample("soundfx/soundtrack.mp3");
	//StopSample("soundfx/menu sound.mp3");
	resourcesToLoads.insertLast("entities/llllol.png");
	resourcesToLoads.insertLast("entities/dsadsad.jpg");
	resourcesToLoads.insertLast("entities/spce.png");
	resourcesToLoads.insertLast("entities/ship2.png");
	resourcesToLoads.insertLast("entities/missile.png");
	//resourcesToLoads.insertLast("entities/normalmaps/normal (2).png");
	resourcesToLoads.insertLast("entities/normalmaps/default_nm.png");
	resourcesToLoads.insertLast("particles/fire.dds");
	resourcesToLoads.insertLast("particles/dust.png");
	resourcesToLoads.insertLast("entities/loading2.png");
	resourcesToLoads.insertLast("entities/asteroid3c.png");
	//resourcesToLoads.insertLast("entities/normalmaps/astreoide2_nm.png");
	resourcesToLoads.insertLast("sprites/sound_high1.png");
	resourcesToLoads.insertLast("sprites/sound_mute1.png");
	resourcesToLoads.insertLast("entities/fighterspr1.png");
	//resourcesToLoads.insertLast("entities/normalmaps/default_nm.png");
	resourcesToLoads.insertLast("particles/flash.bmp");
	resourcesToLoads.insertLast("entities/drone1p1.png");
	resourcesToLoads.insertLast("entities/drone1p2.png");
	//resourcesToLoads.insertLast("entities/normalmaps/nave_normal (3).png");
	resourcesToLoads.insertLast("entities/missile2.png");
	resourcesToLoads.insertLast("sprites/armor3.png");
	resourcesToLoads.insertLast("sprites/damage3.png");
	resourcesToLoads.insertLast("sprites/nitro3.png");
	resourcesToLoads.insertLast("sprites/hp bar.png");
	resourcesToLoads.insertLast("sprites/barbg.png");
	resourcesToLoads.insertLast("sprites/reload bar.png");
	resourcesToLoads.insertLast("sprites/save.png");
	resourcesToLoads.insertLast("sprites/resume.png");
	resourcesToLoads.insertLast("particles/explosion.png");
	resourcesToLoads.insertLast("sprites/ymng.png");
	resourcesToLoads.insertLast("particles/corona.png");
	resourcesToLoads.insertLast("entities/railmissile.png");
	resourcesToLoads.insertLast("particles/particle.bmp");
	resourcesToLoads.insertLast("particles/explo.png");
	if(level!=1)
	inmoney=money;
    resourceIterator = 0;
}

void updateLoadingScene()
{	
	
	if(SeekEntity("loaderp1.ent").GetPosition().x>254){SeekEntity("loaderp1.ent").SetPositionX(253);}
	SeekEntity("loaderp1.ent").AddToPositionX(UnitsPerSecond(100));
	if (resourceIterator < resourcesToLoads.length()){
    LoadSprite(resourcesToLoads[resourceIterator++]);
	}

    
    if (resourceIterator == resourcesToLoads.length() && SeekEntity("loaderp1.ent").GetPosition().x >= 253)
	{
	if(!savedg){
        LoadScene("scenes/Level "+level+".esc", "GameLoop", "createGameScene", "updateGameScene");
		rl2=100;
		
		if(nv1==1)
		{hpp=200;}
		if(nv1==2)
		{hpp=300;}
		if(nv1==3)
		{hpp=400;}
		if(nv1==5)
		{hpp=500;}
		}
		else
		{
		LoadScene("scenes/Level 0.esc", "GameLoop", "createGameScene", "updateGameScene");
	
		rl2=100;
		
		}
	}
}
	
	
	
