#include "Button.angelscript"

bool randBool()
{
int x = rand(1, 2);
if(x==1)
return true;
else
return false;
}

uint RandColor()
{
uint r=rand(255);
uint g=rand(255);
uint b=rand(255);
uint rgb=ARGB(255, r, g, b);
return rgb;
}

int repair = 0;
bool repairx=false;
float GetMaxHp()
{
float x;
if(nv1==0)
x=100;
if(nv1==1)
x=200;
if(nv1==2)
x=300;
if(nv1==3)
x=400;
if(nv1==5)
x=500;
if(nv1==6)
x=350;
//if(armor)
//x*=2;
return x;
}

vector2 Middle(string text, string font)
{
vector2 size=ComputeTextBoxSize(font, text);
vector2 toreturn;
toreturn=GetScreenSize()/2-size/2;
return toreturn;
}

void createBuyScene(){
LoadMusic("soundfx/menu sound.mp3");
//gs2d::Application::SharedData.Set(GS_L("com.ucoz.programingro.playerName"), GS_L("Bob"));
//money=160;
randb=1;
}

void StartRandom(int time)
{
string won;
int nr = rand(1,10);
if(nr==1)
{
won="You didn't win anything!... \nMaybe next time!";}

if(nr==2)
{
won="Congratulations! You won all supplies!";
nitro=true;
ddamage=true;
armor=true;
repair+=1;
hpp=GetMaxHp();
}
if(nr==3)
{
won="Congratulations! You won Ship 1!";nv1=1;
		taken=1;
		hpp=200;
		maxhp=hpp;}
if(nr==4)
{
won="Congratulations! You won Ship 2!";nv1=2;
		taken=2;
		hpp=300;
		maxhp=hpp;}		

if(nr==5)
{
won="Congratulations! You won Ship 4!";nv1=3;
		taken=3;
		hpp=400;
		maxhp=hpp;}		
if(nr==6)
{
won="Congratulations! You won Ship 5!";nv1=5;
		taken=5;
		hpp=500;
		maxhp=hpp;}		
		
if(nr==7)
{
bool myb=randBool();
if(myb){
won="Congratulations! You won Ship 6!";nv1=6;
		taken=6;
		hpp=350;
		maxhp=hpp;}
		else won="You didn't win anything!... \nMaybe next time!";
		}
		
if(nr==8)
{
won="Congratulations! You won 200$!";money+=200;}	
if(nr==9)
{
won="Congratulations! You won 500$!";money+=500;}	
if(nr==10)
{
won="You didn't win anything!... \nMaybe next time!";}
		
DrawFadingText(Middle(won, "Verdana30_shadow.fnt"), won, "Verdana30_shadow.fnt", 0xFFFF1111, 6000);
}

void updateBuyScene(){
	
	if(GetSceneFileName()=="scenes/buy.esc"){
	if (IsSamplePlaying("soundfx/menu sound.mp3")==false){PlaySample("soundfx/menu sound.mp3");}}
	DrawSprite("sprites/ymn.png", vector2(0.0f,0.0f));
	DrawText(vector2(325.0f, -5.0f), ""+money, "Verdana64_shadow.fnt", ARGB(255,0,0,255));
	DrawSprite("sprites/hp.png", vector2(0.0f,80.0f));
	DrawText(vector2(230.0f, 75.0f), ""+hpp, "Verdana64_shadow.fnt", ARGB(255,0,0,255));
	Button@ g_exit;
	vector2 exitPos(vector2(GetScreenSize().x-90,40));

	@g_exit = Button("sprites/exit.png", exitPos);
	g_exit.putButton();
	if (g_exit.isPressed()){
	PauseSample("soundfx/menu sound.mp3");
	LoadScene("scenes/start.esc", "createStartScene", "updateStartScene", "GameLoop");}
	
	
	Button@ g_resume;
	vector2 resPos(vector2(GetScreenSize().x-400,40));
	SetSpriteOrigin("sprites/resume.png", resPos);
	@g_resume = Button("sprites/resume.png", resPos);
	g_resume.putButton();
	if (g_resume.isPressed()){
	StopSample("soundfx/menu sound.mp3");
	LoadScene("scenes/load.esc", "prepareLoadingScene", "updateLoadingScene");}

	//ship1Pos
	
	
	Button@ g_right;
	vector2 auxp0=GetScreenSize()-GetSpriteFrameSize("sprites/righta.png")/2;
	@g_right=Button("sprites/righta.png",auxp0);
	g_right.putButton();
	if(g_right.isDown())
	{
	
	it2pos.x-=1;
	ship3Pos.x-=1;
	it1pos.x-=1;
	auxp1.x-=1;
	auxp2.x-=1;
	auxp3.x-=1;
	auxp4.x-=1;
	auxp5.x-=1;
	damagepos.x-=1;
	auxp6.x-=1;
	auxp7.x-=1;
	nitropos.x-=1;
	auxp8.x-=1;
	auxp9.x-=1;
	ship2Pos.x-=1;
	auxp10.x-=1;
	auxp11.x-=1;
	auxp12.x-=1;
	auxp13.x-=1;
	auxp14.x-=1;
	auxp15.x-=1;
	auxp16.x-=1;
	ship1Pos.x-=1;
	ship5Pos.x-=1;
	itkpos.x-=1;
	auxpk.x-=1;
	auxpx.x-=1;
	itmpos.x-=1;
	auxpm.x-=1;
	}
	
	
	Button@ g_left;
	vector2 auxpp0=vector2(0+GetSpriteFrameSize("sprites/lefta.png").x/2,768-GetSpriteFrameSize("sprites/lefta.png").x/2);
	@g_right=Button("sprites/lefta.png",auxpp0);
	g_right.putButton();
	if(g_right.isDown())
	{
	
	it2pos.x+=1;
	ship3Pos.x+=1;
	it1pos.x+=1;
	auxp1.x+=1;
	auxp2.x+=1;
	auxp3.x+=1;
	auxp4.x+=1;
	auxp5.x+=1;
	damagepos.x+=1;
	auxp6.x+=1;
	auxp7.x+=1;
	nitropos.x+=1;
	auxp8.x+=1;
	auxp9.x+=1;
	ship2Pos.x+=1;
	auxp10.x+=1;
	auxp11.x+=1;
	auxp12.x+=1;
	auxp13.x+=1;
	auxp14.x+=1;
	auxp15.x+=1;
	auxp16.x+=1;
	ship1Pos.x+=1;
	ship5Pos.x+=1;
	itkpos.x+=1;
	auxpx.x+=1;
	auxpk.x+=1;
	itmpos.x+=1;
	auxpm.x+=1;
	}
	
	Button@ g_itemm;
	
	if(randb==1 && mystr!="sprites/rand.png")
	mystr="sprites/rand.png";
	
	DrawTextInBox(auxpm , "Random: 150$", "Verdana14_shadow.fnt", 0xFFFFFFFF);
	
	@g_itemm=Button(mystr, itmpos);
	g_itemm.putButton();
		if (g_itemm.isPressed())
	{
	if(randb==1){
	if(money>=150){
	randb=2;money-=150;}else
	DrawFadingText(auxpm+vector2(25,20), "You need more money", "Verdana14_shadow.fnt", RandColor(), 4000);
	}else
		DrawFadingText(auxpm+vector2(25,20), "After next level!", "Verdana14_shadow.fnt", RandColor(), 4000);

	}
	//if(money<150){
	//mystr="sprites/randr.png";}
	if(randb==2)
	{mystr="sprites/randr.png";StartRandom(GetTime());randb=3;}
	Button@ g_itemk;
	
	DrawTextInBox(auxpk-vector2(15,0), "Repair kit: 70$(x"+repair+")", "Verdana14_shadow.fnt", 0xFFFFFFFF);
	
	@g_itemk=Button("sprites/repair-k.png", itkpos);
	g_itemk.putButton();
		if (g_itemk.isPressed())
	{	
	if(money>=70)
	{
	repair+=1;money-=70;}
	else
	DrawFadingText(auxpk+vector2(25,20), "You need more money", "Verdana14_shadow.fnt", ARGB(255,255,255,255), 4000);
	}
	Button@ g_item2;
	
	DrawTextInBox(auxp1, "Repair your ship: 50$", "Verdana14_shadow.fnt", 0xFFFFFFFF);
	
	@g_item2=Button("sprites/repair.png", it2pos);
	g_item2.putButton();
		if (g_item2.isPressed())
	{	
	if(money>=50){
	if(nv1==0)
	hpp=100;
	if(nv1==1)
	hpp=200;
	if(nv1==2)
	hpp=300;
	if(nv1==3)
	hpp=400;
	if(nv1==5)
	hpp=500;
	money=money-50;}
		if(money<50)
		{DrawFadingText(auxp2, "You need more money", "Verdana14_shadow.fnt", ARGB(255,255,255,255), 4000);
		
	}}
	
	Button@ g_item1;
	
	DrawTextInBox(auxp3, "Double armor: 50$", "Verdana14_shadow.fnt", 0xFFFFFFFF);
	
	@g_item1=Button("sprites/armor.png", it1pos);
	g_item1.putButton();
		if (g_item1.isPressed())
	{	if(!armor){
	if(money>=50){
		armor=true;
		hpp*=2;

		money=money-50;}
		if(money<50)
		if(!armor){
		{DrawFadingText(auxp4, "You need more money", "Verdana14_shadow.fnt", ARGB(255,255,255,255), 4000);
		
	}}}}
	
	Button@ g_damage;
	DrawTextInBox(auxp5, "Double damage: 50$", "Verdana14_shadow.fnt", 0xFFFFFFFF);
	@g_damage=Button("sprites/damage.png", damagepos);
	g_damage.putButton();
	if(g_damage.isPressed())
	{	if(!ddamage){
	if(money>=50){
		ddamage=true;
		money=money-50;}
		if(money<50){
		if(!ddamage){
		{DrawFadingText(auxpx, "You need more money", "Verdana14_shadow.fnt", ARGB(255,255,255,255), 4000);
		
	}}}}}
	
		Button@ g_nitro;
	DrawTextInBox(auxp8, "Nitro: 50$", "Verdana14_shadow.fnt", 0xFFFFFFFF);
	
	@g_nitro=Button("sprites/nitro.png", nitropos);
	g_nitro.putButton();
	if(g_nitro.isPressed())
	{	if(!nitro){
	if(money>=50){
		nitro=true;
		money=money-50;}
		if(money<50)
		if(!nitro){
		{DrawFadingText(vector2(auxp8.x, auxp7.y), "You need more money", "Verdana14_shadow.fnt", ARGB(255,255,255,255), 4000);
		
	}}}}
	Button@ g_ship1;
	
	DrawTextInBox(auxp6, "Ship 1: 100$", "Verdana14_shadow.fnt", 0xFFFFFFFF);
	SetSpriteOrigin("sprites/spcep.png", ship1Pos+vector2(0,85));
	@g_ship1 = Button("sprites/spcep.png", ship1Pos+vector2(0,85));
	g_ship1.putButton();
	if (g_ship1.isPressed())
	{	if(nv1<1){
	if(money>=100){
		nv1=1;
		taken=1;
		hpp=200;
		maxhp=hpp;
		money-=100;}
		if(money<100)
		if(nv1!=1){
		{DrawFadingText(auxp9, "You need more money", "Verdana14_shadow.fnt", ARGB(255,255,255,255), 4000);
		
	}}}
	if(nv1>=1){taken=2;
	DrawFadingText(auxp9, "Nave taken!", "Verdana14_shadow.fnt", ARGB(255,255,255,255), 4000);}
	}
	
	Button@ g_ship3;

	DrawTextInBox(auxp11, "Ship 2: 200$", "Verdana14_shadow.fnt", 0xFFFFFFFF);
	SetSpriteOrigin("entities/nave3.png", ship3Pos+vector2(0, 20));
	@g_ship3 = Button("entities/nave3.png", ship3Pos+vector2(0, 20));
	g_ship3.putButton();
	if (g_ship3.isPressed())
	{	if(nv1<2){
	if(money>=200){
		nv1=2;
		taken=2;
		hpp=300;
		maxhp=hpp;
		money-=200;}
		if(money<200)
		if(nv1!=2){
		{DrawFadingText(auxp12, "You need more money", "Verdana14_shadow.fnt", ARGB(255,255,255,255), 4000);
		
	}}}
	if(nv1>=2){taken=3;
	DrawFadingText(auxp12, "Nave taken!", "Verdana14_shadow.fnt", ARGB(255,255,255,255), 4000);}
	}
	
	Button@ g_ship2;
	
	DrawTextInBox(auxp16, "Ship 3: 400$", "Verdana14_shadow.fnt", 0xFFFFFFFF);
	SetSpriteOrigin("entities/nave4.png", ship2Pos);
	@g_ship2 = Button("entities/nave4.png", ship2Pos);
	g_ship2.putButton();
	if (g_ship2.isPressed())
	{	if(nv1<3){
	if(money>=400){
		nv1=3;
		taken=3;
		hpp=400;
		maxhp=hpp;
		money-=400;}
		if(money<400)
		if(nv1!=2){
		{DrawFadingText(auxp13, "You need more money", "Verdana14_shadow.fnt", ARGB(255,255,255,255), 4000);
		
	}}}
	if(nv1>=2){taken=4;
	DrawFadingText(auxp13, "Nave taken!", "Verdana14_shadow.fnt", ARGB(255,255,255,255), 4000);}
	}
	
	Button@ g_ship5;
	
	DrawTextInBox(auxp15, "Ship 4: 500$", "Verdana14_shadow.fnt", 0xFFFFFFFF);
	//SetSpriteOrigin("entities/spaceship.png", ship5Pos);
	@g_ship5 = Button("entities/spaceship.png", ship5Pos);
	g_ship5.putButton();
	if (g_ship5.isPressed())
	{	if(nv1<5){
	if(money>=500){
		nv1=5;
		taken=5;
		hpp=500;
		maxhp=hpp;
		money-=500;}
		if(money<500)
		if(nv1!=5){
		{DrawFadingText(auxp14, "You need more money", "Verdana14_shadow.fnt", ARGB(255,255,255,255), 4000);
		
	}}}
	if(nv1>=5){taken=5;
	DrawFadingText(auxp14, "Nave taken!", "Verdana14_shadow.fnt", ARGB(255,255,255,255), 4000);}
	return;}
	
	
	
	
	}