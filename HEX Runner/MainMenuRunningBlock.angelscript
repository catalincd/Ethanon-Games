class Block
{
	bool dead = false;
	vector2 m_pos;
	vector2 m_size;
	vector2 m_eyesOffset;
	uint m_color;
	
	Block()
	{
		create();
	}
	
	Block(vector2 _pos)
	{
		m_pos = _pos;
		create();
	}
	
	void create()
	{
		dead = false;
		m_size = vector2(128,128)*GetScale()*randF(0.75, 1);
		m_color = GetColorFromIdx(rand(1,7));
	}
	
	void update()
	{
		draw();
		//print("hey");
	}
	
	
	void draw()
	{
		DrawShapedSprite("sprites/block/body6.png", m_pos,m_size, m_color);
		DrawShapedSprite("sprites/block/eyes.png", m_pos,m_size, COLOR_WHITE);
	}
		
}


uint blocksLen = 10;

void updateBlocks(Block[]& blocks){}

void updateBlocks2(Block[]& blocks)
{
	while(blocks.length() < blocksLen)
	{
		Block newBlock(vector2(GetScreenSize().x * randF(1), GetScreenSize().y * randF(1)));
		blocks.insertLast(newBlock);
		
	}

	for(uint t=0;t<blocksLen;t++)
	{
		blocks[t].update();
	}

}