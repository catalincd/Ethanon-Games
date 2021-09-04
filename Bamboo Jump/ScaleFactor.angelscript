vector2 V2_256 = vector2(256, 256);
vector2 V2_512 = vector2(512, 512);
vector2 V2_1536 = vector2(1536, 1536);

vector2 outerScreen = GetScreenSize() * 1.2f;
vector2 outerScreen2 = GetScreenSize() * 1.1f;
vector2 outerScreen3 = GetScreenSize() * 1.5f;

vector2 outerScreen2_O = GetScreenSize() * -0.1f;

void setScaleFactor()
{
	V2_256 = vector2(256, 256) * GetScale();
	V2_512 = vector2(512, 512) * GetScale();
	V2_1536 = vector2(1536, 1536) * GetScale();
	outerScreen = GetScreenSize() * 1.2f;
	outerScreen2 = GetScreenSize() * 1.1f;
	outerScreen3 = GetScreenSize() * 1.5f;
	
	vector2 outerScreen2_O = GetScreenSize() * -0.1f;
}