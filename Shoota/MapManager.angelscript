class MapManager : GameObject
{
	uint[] blocks;
	vector2[] positions;
	vector2 topLeft;
	vector2 bottomRight;
	float side;
	uint selectedId;

	void create()
	{
		blocks.resize(0);
		positions.resize(0);
	
		float xOffset = 318*GetScale();
		float xSize = 224*GetScale();
		float yOffset = (GetScreenSize().y - 898*GetScale())/2;
		float ySize = 224*GetScale();
		
		side = (128 + 96) * GetScale();
		
		for(uint i=0;i<15;i++)
		{	
			blocks.insertLast(0);
			float x = xOffset + (i%3)*xSize;
			float y = yOffset + (i/3)*ySize;
			positions.insertLast(vector2(x,y));
		}
		
		topLeft = positions[0] - V2_96;
		bottomRight = positions[14] + V2_96;
		
		spawnTurret(g_mainInventory.getMain(),10);
	}	
	
	void remove(vector2 q)
	{
		for(uint i=0;i<positions.length();i++)
		{
			if(distance(q, positions[i]) < 3)
			{
				blocks[i] = 0;
				return;
			}
		}
	}
	
	void spawnTurret(uint turretId, uint idx)
	{
		blocks[idx] = turretId;
		g_bulletPoint.decrease(getItem(turretId).cost);
		Turret@ newTurret = getTurret(turretId, positions[idx]);
		g_turret.insertNewTurret(newTurret);
		g_enemyManager.explodeEnemies(positions[idx]);
		g_enemyManager.resetTargets();
	}
	
	void update()
	{
		
	}
	
	void updateSelection(float bias)
	{
		ETHInput@ input = GetInputHandle();
		vector2 touchPos = input.GetTouchPos(0);
		
		if(input.GetTouchState(0) == KS_DOWN)
		
			if(isPointInRect(touchPos, topLeft, bottomRight))
			{
				vector2 new = touchPos - topLeft;
				
				uint x = uint(new.x / side);
				uint y = uint(new.y / side);
				selectedId = y*3 + x;
			}
			
			else selectedId = 15;
	
	
		uint color = ARGB(uint(bias*255.0f), 255,255,255);
		draw(color, selectedId);
	}
	
	void deselect(uint turretId)
	{
		if(selectedId != 15)
		{
			if(blocks[selectedId] == 0)
			{	
				spawnTurret(turretId, selectedId);
				g_ui.forceDown();
			}
		}
	}
	
	void draw(uint color, uint select)
	{
		for(uint i=0;i<15;i++)
		{
			if(blocks[i] == 0)
			{	
				if(i != select)
					DrawShapedSprite("sprites/block_fill.png", positions[i], V2_128, color);
				else
					DrawShapedSprite("sprites/block_fill.png", positions[i], V2_165, color);
			}
		}
	}
	
	void resume()
	{
	
	}

	string getTag(){ return "Map"; }
}

MapManager g_mapManager;