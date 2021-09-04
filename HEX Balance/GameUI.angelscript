class GameUI : GameObject
{
	vector2 forcePos;
	vector2 currentPos;

	void create()
	{
		forcePos = vector2(25,25) * GetScale();
		currentPos = vector2(GetScreenSize().x, 0.0f) + vector2(0,25) * GetScale();
	}
	
	void update()
	{
	
	}
	
	void draw(float force, uint total, uint current, uint dead)
	{
		DrawText("Angular \nF "+force, "Verdana64.fnt", forcePos, black.getUInt(), V2_ZERO);
		DrawText("Blocks \n"+total+" "+current+" "+dead, "Verdana64.fnt", currentPos, black.getUInt(), vector2(1.0f, 0.0f));
	}
	
	void drawGameOverLay(float bias)
	{
		uint color = ARGB(uint(255.0f * bias), 0,0,0);
		uint overColor = ARGB(uint(255.0f * bias), 255,0,0);
		
		
		DrawShapedSprite("sprites/white.png", V2_ZERO, GetScreenSize(), color);
		DrawText("GAME OVER", "Verdana64.fnt", GetScreenSize()/2, overColor, V2_HALF, 2.0f * bias);
		
	}
	
	void resume()
	{
	
	}
	
	string getTag()
	{
		return "UI";
	}
	
}

GameUI o_ui;