class LifeBar
{
	
}


void drawLifeBar(ETHEntity@ thisEntity)
{
	uint lastHit = thisEntity.GetUInt("time");
	if(lastHit != 0)
		if(getTime() - lastHit < STRIDE_HP)
		{
			int hp = thisEntity.GetInt("hp");
			int hpMax = thisEntity.GetInt("hpMax");
			float scale = thisEntity.GetFloat("hpScale");
			float ratio = float(hp) / float(hpMax);
			
			vector2 sizeFull = LIFE_BAR_SIZE*scale;
			vector2 size = vector2(sizeFull.x * ratio,sizeFull.y);
			vector2 spritesPos = thisEntity.GetPositionXY() - (LIFE_BAR_OFFSET*scale) - vector2(0, PX_128*scale);
		
			DrawShapedSprite("sprites/square.png", spritesPos, sizeFull, black);
			DrawShapedSprite("sprites/square.png", spritesPos, size, green);
		}
	
}

void drawBlueLifeBar(ETHEntity@ thisEntity)
{
	if(thisEntity.IsAlive())
	{
		uint lastHit = thisEntity.GetUInt("time");
		if(lastHit != 0)
			if(getTime() - lastHit < STRIDE_HP)
			{
				int hp = thisEntity.GetInt("hp");
				int hpMax = thisEntity.GetInt("hpMax");
				float scale = thisEntity.GetFloat("hpScale");
				float ratio = float(hp) / float(hpMax);
				
				vector2 sizeFull = LIFE_BAR_SIZE*scale;
				vector2 size = vector2(sizeFull.x * ratio,sizeFull.y);
				vector2 spritesPos = thisEntity.GetPositionXY() - (LIFE_BAR_OFFSET*scale) - vector2(0, PX_128*scale);
			
				DrawShapedSprite("sprites/square.png", spritesPos, sizeFull, black);
				DrawShapedSprite("sprites/square.png", spritesPos, size, blue);
			}
	}
}