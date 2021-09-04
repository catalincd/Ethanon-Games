class GameEffector : GameObject
{
	ETHEntityArray eyeEntities;
	ETHEntityArray spriteEntities;
	vector2 spriteSize = vector2(64,64);
	float radius = 3.0f;
	vector2 mainBlockPos;
	
	string getTag()
	{
		return "GameEffector";
	}
	
	void create()
	{
		eyeEntities.clear();
		spriteEntities.clear();
		spriteSize = vector2(64,64) * GetScale();
		radius = 3.0f * GetScale();
	}
	
	void update()
	{
		if(!GAME_OVER)
			mainBlockPos = g_block.getPositionXY();
		if(ENABLE_EFFECTS)
		{
			
			for(uint i=0;i<eyeEntities.size();i++)
			{
				vector2 thisPos = eyeEntities[i].GetPositionXY();
				vector2 newPos = thisPos - GetCameraPos();
				DrawShapedSprite("sprites/block/eyes_contour.png", newPos, spriteSize, white);
				vector2 offsetPos = normalize(mainBlockPos-thisPos) * radius;
				DrawShapedSprite("sprites/block/eyes.png", newPos+offsetPos, spriteSize, white);
			}
			
			//for(uint i=0;i<spriteEntities.size();i++)
			//{
			//	uint id = spriteEntities[i].GetUInt("ef");
			//	vector2 thisPos = spriteEntities[i].GetPositionXY();
			//	vector2 newPos = thisPos - GetCameraPos();
			//	if(id == 1)	DrawShapedSprite("sprites/overlays/block_dead.png", newPos, spriteSize, white);
			//	if(id == 2)	DrawShapedSprite("sprites/overlays/star.png", newPos, spriteSize, white);
			//	if(id == 3)	DrawShapedSprite("sprites/overlays/broken.png", newPos, spriteSize, white);
			//}
		}
		eyeEntities.RemoveDeadEntities();
		spriteEntities.RemoveDeadEntities();
	}
	
	void add(ETHEntity@ new)
	{
		if(rand(0,BLOCK_EFFECT_RATIO) == 0)
		{
			uint effect_id = rand(0, 3);
			new.SetUInt("ef", effect_id);
			
			if(effect_id == 0 )
				eyeEntities.Insert(new);
			else
			{
				if(effect_id == 1) new.SetSprite("contour.png");
				if(effect_id == 2) new.SetSprite("dead.png");
				if(effect_id == 3) new.SetSprite("line.png");
			}
		}
	}
	
	void resume()
	{
	
	}
}

GameEffector g_gameEffector;