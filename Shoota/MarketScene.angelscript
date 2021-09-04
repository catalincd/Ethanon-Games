class Market
{
	Item@[] mainTurrets;
	Item@[] autoTurrets;
	MarketButton@[] buttons;
	TextButton@ backButton;
	float xMargin;
	float yMarginMain;
	float yMarginAuto;
	vector2 blockHalfSize;
	vector2 marginBlockSize;
	vector2 fundsPos;
	uint itemNum = 5;
	uint selected = 999;
	uint[] owned;
	bool ownedCurrent = false;
	bool mainSelected = false;
	
	void initItems()
	{
		mainTurrets.resize(0);
		mainTurrets.insertLast(turret1);
		mainTurrets.insertLast(turret2);
		mainTurrets.insertLast(turret3);
		mainTurrets.insertLast(turret4);
		mainTurrets.insertLast(turret5);
		
		autoTurrets.resize(0);
		autoTurrets.insertLast(auto_turret1);
		autoTurrets.insertLast(auto_turret2);
		autoTurrets.insertLast(auto_turret3);
		autoTurrets.insertLast(auto_turret4);
		autoTurrets.insertLast(auto_turret5);
		autoTurrets.insertLast(auto_turret6);
		autoTurrets.insertLast(auto_turret7);
		autoTurrets.insertLast(defensive1);
		autoTurrets.insertLast(defensive2);
		autoTurrets.insertLast(defensive3);
		
	}
	
	void initButtons()
	{
		buttons.resize(0);
	
		for(uint i=0;i<mainTurrets.length();i++)
		{
			buttons.insertLast(MarketButton(mainTurrets[i].name, getMainPos(i), mainTurrets[i].id, i, true));
		}
		
		for(uint i=0;i<autoTurrets.length();i++)
		{
			buttons.insertLast(MarketButton(autoTurrets[i].name, getAutoPos(i), autoTurrets[i].id, i+mainTurrets.length(), false));
		}
		
		
		for(uint i=0;i<buttons.length();i++)
		{
			if(find(buttons[i].turretId, owned))
			{
				buttons[i].enable();
			}
		}
	}
	
	void create()
	{
		blockHalfSize = V2_100 * 0.75f;
		marginBlockSize = V2_100 * 2;
		xMargin = 65 * GetScale();
		yMarginMain = 250 * GetScale();
		yMarginAuto = 600 * GetScale();
		itemNum = 5;
		selected = 999;
		
		fundsPos = vector2(GetScreenSize().x - PX_100 * 1.78, PX_100 * 1.25);
		
		@backButton = TextButton(vector2(GetScreenSize().x * 0.5, GetScreenSize().y * 0.65), "BACK", text128, red, true);
		
		g_stats.create();
		loadTurrets();
		initItems();
		initButtons();
	}
	
	void buy()
	{
		Item@ item = getItem(selected+1);
		buyItem(item.costPlaying);
		owned.insertLast(item.id);
		ownedCurrent = true;
		buttons[selected].enable();
		saveTurrets();
	}
	
	void loadTurrets()
	{
		owned.resize(0);
		string loaded = g_dataManager.loadTurrets();
		owned = getArrayFromString(loaded);
	}
	
	
	void saveTurrets()
	{
		string str = getStringFromArray(owned);
		g_dataManager.saveTurrets(str);
	}
	
	
	void update()
	{
		for(uint i=0;i<buttons.length();i++)
		{
			buttons[i].update();
		}
		drawStats(selected, ownedCurrent, mainSelected);
		
		backButton.update();
		if(backButton.isPressed())
		{
			backButton.setPressed(false);
			g_sceneManager.transition(ItemSelectorScene());
		}
		DrawFunds(FUNDS, fundsPos, 0.75, 0.5f, green);
	}
	
	void select(uint newId)
	{
		if(newId != selected)
		{
			if(selected != 999)
			buttons[selected].deselect();
			selected = newId;
			ownedCurrent = find(buttons[selected].turretId, owned);
			mainSelected = selected < mainTurrets.length();
		}
		else
		{
			selected = 999;
		}
	}
	
	vector2 getAutoPos(uint id)
	{
		uint x = id % itemNum;
		uint y = id / itemNum;
		vector2 top = vector2(xMargin,yMarginAuto) + blockHalfSize;
		return (top + (vector2(x,y) * marginBlockSize));
	}

	vector2 getMainPos(uint id)
	{
		uint x = id % itemNum;
		uint y = id / itemNum;
		vector2 top = vector2(xMargin,yMarginMain) + blockHalfSize;
		return (top + (vector2(x,y) * marginBlockSize));
	}
	
}

Market g_market;




class MarketScene : Scene
{
	MarketScene()
	{
		super("empty");
	}
	
	void onCreated()
	{
		g_market.create();
	}
	
	void onUpdate()
	{
		g_market.update();
	}
	
}