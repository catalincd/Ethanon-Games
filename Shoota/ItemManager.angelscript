class ItemManager : GameObject
{

	Item@[] items;
	ItemButton@[] buttons;
	bool selected = false;
	uint selectedId = 0;

	void fillItems()
	{
		items.resize(0);
		uint[] itemsUint = g_mainInventory.getAutos();
		for(uint i=0;i<itemsUint.length();i++)
			items.insertLast(@getItem(itemsUint[i]));
	}
	
	void fillButtons()
	{
		float xOffset = 120 * GetScale();
		float xSize = 320 * GetScale();
		float yOffset = 200 * GetScale();
		float ySize = 320 * GetScale();
		float yScreenOffset = GetScreenSize().y * 0.5f;
		
		buttons.resize(0);
		for(uint t=0;t<items.length();t++)
		{
			vector2 pos = V2_200 + vector2(xOffset + (t%3)*xSize, t/3 * ySize + yScreenOffset);
			buttons.insertLast(ItemButton(t, pos, items[t]));
		}
	}

	void create()
	{
		fillItems();
		fillButtons();
	}
	
	void update()
	{
		
		if(selected)
		{
			uint opacity = getOpacity();
			uint newWhite = ARGB(opacity, 255, 255, 255);
			uint newGrey = ARGB(opacity, 80, 80, 80);
			uint newBlack = ARGB(opacity, 0, 0, 0);
			uint newRed = ARGB(opacity, 255, 0, 0);
			for(uint i=0;i<buttons.length();i++)
			{
				if(i != selectedId)
					buttons[i].setColors(newWhite, newGrey, newBlack, newRed);
			}
			g_mapManager.updateSelection(getBias());
		}
		
		if(g_ui.windowUp)
			for(uint i=0;i<buttons.length();i++)
			{
				buttons[i].update();
			}
	}

	void setButtons()
	{
		int currentPoints = g_bulletPoint.getBulletPoints();
		for(uint i=0;i<buttons.length();i++)
		{
			if(uint(currentPoints) < buttons[i].reference.cost)
				buttons[i].disable();
			else
				buttons[i].enable();
		}

	}
	
	void deselect()
	{
		
		selected = false;
		for(uint i=0;i<buttons.length();i++)
		{
			buttons[i].setColors(white, DARK_GREY, black, red);
		}
		
		g_mapManager.deselect(buttons[selectedId].reference.id);
		
		///check for proper spawning
		///keep up if no spawn
		///force down after spawning a turret
		////////////////////////////////g_ui.forceDown();///////////////////////////////////
	}
	
	float getButtonBias()
	{
		return buttons[selectedId].getBias();
	}
	
	uint getFullWhiteColor()
	{
		return ARGB(uint(255.0f * (1-getButtonBias())),255,255,255);
	}
	
	uint getOpacity()
	{
		return uint(255.0f * (1-getButtonBias()));
	}
	
	float getBias()
	{
		return selected?  getButtonBias():0.0f; 
	}

	void select(uint i)
	{
		selected = true;
		selectedId = i;
	}

	void setButtonsYOffset(float yOff)
	{
		for(uint i=0;i<buttons.length();i++)
		{
			buttons[i].setYOffset(yOff);
		}
	}
	
	void resume()
	{
		for(uint i=0;i<buttons.length();i++)
		{
			buttons[i].resume();
		}
	}
	
	string getTag(){ return "ItemManager"; }
}

ItemManager g_itemManager;