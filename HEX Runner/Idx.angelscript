uint GetColorFromIdx(uint idx)
{
	switch(idx)
	{
		case 0: return white;
		case 1: return red;
		case 2: return magenta;
		case 3: return blue;
		case 4: return cyan;
		case 5: return green;
		case 6: return yellow;
		case 7: return orange;
	}
	
	return white;
}

vector3 GetV3ColorFromIdx(uint idx)
{
	switch(idx)
	{
		case 0: return vector3(1.0f,1.0f,1.0f);//white
		case 1: return vector3(1.0f,0.0f,0.0f);//red
		case 2: return vector3(0.94f,0.0f,1.0f);//magenta
		case 3: return vector3(0.0f,0.0f,1.0f);//blue
		case 4: return vector3(0.0f,1.0f,1.0f);//cyan
		case 5: return vector3(0.0f,1.0f,0.0f);//green
		case 6: return vector3(1.0f,1.0f,0.0f);//yellow
		case 7: return vector3(1.0f,0.5f,0);//orange
	}
	
	return V3_ONE;
}

string GetColorNameFromIdx(uint idx)
{
	switch(idx)
	{
		case 0: return "WHITE";
		case 1: return "RED";
		case 2: return "MAGENTA";
		case 3: return "BLUE";
		case 4: return "CYAN";
		case 5: return "GREEN";
		case 6: return "YELLOW";
		case 7: return "ORANGE";
	}
	
	return "WHITE";
}

string GetOverlayNameFromIdx(uint idx)
{
	switch(idx)
	{
		case 0: return "";
		case 1: return "sprites/overlays/broken.png";
		case 2: return "sprites/overlays/merlin.png";
		case 3: return "sprites/overlays/stripe.png";
		case 4: return "sprites/overlays/sas.png";
		case 5: return "sprites/overlays/soundcloud.png";
		case 6: return "sprites/overlays/69420.png";
		case 7: return "sprites/overlays/article13.png";
		case 8: return "sprites/overlays/narutoRunner.png";
		case 9: return "sprites/overlays/love.png";
		case 10: return "sprites/overlays/greatAmerica.png";
		//case 4: return "sprites/overlays/star.png";
		//case 5: return "sprites/overlays/crybaby.png";
	}
	
	return "";
}

uint OVERLAYS_NUM = 11;