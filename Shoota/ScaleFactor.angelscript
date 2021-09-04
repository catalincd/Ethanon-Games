float PX_2;
float PX_5;
float PX_10;
float PX_15;
float PX_24;
float PX_32;
float PX_48;
float PX_64;
float PX_80;
float PX_96;
float PX_100;
float PX_128;
float PX_150;
float PX_175;
float PX_192;
float PX_200;
float PX_220;
float PX_256;
float PX_168;
float PX_384;
float PX_512;
float PX_768;
float PX_1024;


vector2 SS_75;
vector2 SS_50;
vector2 SS_25;
vector2 SS_90;
vector2 SS_110;
vector2 SS_150;
vector2 SS_190;

float SS_HALF_X;
float SS_HALF_Y;

vector2 V2_256;
vector2 V2_200;
vector2 V2_192;
vector2 V2_165;
vector2 V2_128;
vector2 V2_100;
vector2 V2_96;
vector2 V2_64;
vector2 V2_32;
vector2 V2_16;

vector2 BILL;

vector2 LIMIT_SCREEN_SIZE_TOP;
vector2 LIMIT_SCREEN_SIZE_DOWN;

vector2 LIFE_BAR_SIZE;
vector2 LIFE_BAR_OFFSET;

class ScaleFactor
{		
	void set()
	{
		PX_2 = 2*GetScale();
		PX_5 = 5*GetScale();
		PX_10 = 10*GetScale();
		PX_15 = 15*GetScale();
		PX_24 = 24*GetScale();
		PX_32 = 32*GetScale();
		PX_48 = 48*GetScale();
		PX_64 = 64*GetScale();
		PX_80 = 80*GetScale();

		PX_96 = 96*GetScale();
		PX_100 = 100*GetScale();
		PX_128 = 128*GetScale();
		PX_150 = 150*GetScale();
		PX_168 = 168*GetScale();
		PX_175 = 175*GetScale();
		PX_192 = 192*GetScale();
		PX_200 = 200*GetScale();
		PX_220 = 220*GetScale();
		PX_256 = 256*GetScale();
		PX_384 = 384*GetScale();
		PX_512 = 512*GetScale();
		PX_768 = 768*GetScale();
		PX_1024 = 1024*GetScale();
		
		
		SS_75 = GetScreenSize() * 0.75f;
		SS_50 = GetScreenSize() * 0.5f;
		SS_25 = GetScreenSize() * 0.25f;
		SS_90 = GetScreenSize() * 0.9f;
		SS_110 = GetScreenSize() * 1.04f;
		SS_150 = GetScreenSize() * 1.5f;
		SS_190 = GetScreenSize() * 1.9f;
		
		SS_HALF_X = SS_50.x;
		SS_HALF_Y = SS_50.y;
		
		V2_256 = vector2(256,256) * GetScale();
		V2_200 = vector2(200,200) * GetScale();
		V2_192 = vector2(192,192) * GetScale();
		V2_165 = vector2(165,165) * GetScale();
		V2_128 = vector2(128,128) * GetScale();
		V2_100 = vector2(100,100) * GetScale();
		V2_96 = vector2(96,96) * GetScale();
		V2_64 = vector2(64,64) * GetScale();
		V2_32 = vector2(32,32) * GetScale();
		V2_16 = vector2(16,16) * GetScale();
		
		LIFE_BAR_SIZE = vector2(196, 24) * GetScale();
		LIFE_BAR_OFFSET = LIFE_BAR_SIZE / 2;
		
		LIMIT_SCREEN_SIZE_TOP = -1*V2_256;
		LIMIT_SCREEN_SIZE_DOWN = GetScreenSize() + V2_256;
		
		BILL = vector2(200,100) * GetScale() * 0.75;
	}
	
	bool outOfScreenLimit(vector2 p)
	{
		if(p.x < LIMIT_SCREEN_SIZE_TOP.x || p.y < LIMIT_SCREEN_SIZE_TOP.y || p.x > LIMIT_SCREEN_SIZE_DOWN.x || p.y > LIMIT_SCREEN_SIZE_DOWN.y)
			return true;
		
		return false;
	}
	
}

ScaleFactor SF;