class ItemSelector
{

	TextButton@ startButton;
	TextButton@ marketButton;

	Item@[] mainTurrets;
	Item@[] autoTurrets;
	ItemSelectorButton@[] mainButtons;
	ItemSelectorButton@[] autoButtons;

	float xMargin;
	float yMarginMain;
	float yMarginAuto;
	vector2 blockHalfSize;
	vector2 marginBlockSize;
	//uint autoLimit = MAX_AUTO_TURRETS;
	uint itemNum;
	uint mainSelected;
	uint[] autoSelected;
	uint autoNum;

	void fillTurrets()
	{
		mainTurrets.resize(0);
		autoTurrets.resize(0);
		
		uint[] ownedItems = getArrayFromString(g_dataManager.loadTurrets());
		for(uint i=0;i<ownedItems.length();i++)
		{
			Item@ itm = getItem(ownedItems[i]);
			if(isMainTurret(itm.id))
			{
				mainTurrets.insertLast(itm);
			}
			else
			{
				autoTurrets.insertLast(itm);
			}
		}
		
		autoNum = autoTurrets.length();
	
		mainSelected = 999;
		autoSelected.resize(0);
	}

	void fill()
	{
		fillTurrets();
		mainButtons.resize(0);	
		for(uint i=0;i<mainTurrets.length();i++)
		{
			mainButtons.insertLast(ItemSelectorButton(mainTurrets[i].name, getMainPos(i),mainTurrets[i].id, i, true));
		}

		autoButtons.resize(0);	
		for(uint i=0;i<autoTurrets.length();i++)
		{
			autoButtons.insertLast(ItemSelectorButton(autoTurrets[i].name, getAutoPos(i),autoTurrets[i].id, i));
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
		fill();
		@startButton = TextButton(vector2(GetScreenSize().x * 0.5, GetScreenSize().y * 0.8), "START", text128, red, true);
		@marketButton = TextButton(vector2(GetScreenSize().x * 0.5, GetScreenSize().y * 0.9), "MARKET", text128, red, true);
		selectInventory();
		initLock();
	}

	void selectInventory()
	{
		g_dataManager.loadInventory();
		uint mainB = getMainButtonId(g_mainInventory.getMain());
		if(mainB != 999)
		{
			mainSelected = mainB;
			mainButtons[mainSelected].selected = true;
		}
		
		uint[] autoTurretIds = g_mainInventory.getAutos();
		
		for(uint i=0;i<autoTurretIds.length();i++)
		{
			
			uint newTurretId = getAutoButtonId(autoTurretIds[i]);
			if(newTurretId != 999)
			{
				autoSelected.insertLast(newTurretId);
				autoButtons[newTurretId].selected = true;
			}
		}
		
	}

	void initLock()
	{
	
	}

	void update()
	{
		for(uint i=0;i<mainButtons.length();i++)
			mainButtons[i].update();
		for(uint i=0;i<autoButtons.length();i++)
			autoButtons[i].update();

		startButton.update();
		if(startButton.isPressed())
		{
			startButton.setPressed(false);
			if(validateStart())
			{
				updateGlobalInventory();
				LOADING_OVERLAY = true;
				g_sceneManager.transition(GameScene());
			}
		}
		
		
		marketButton.update();
		if(marketButton.isPressed())
		{
			marketButton.setPressed(false);
			g_sceneManager.transition(MarketScene());
		}
	}

	void updateGlobalInventory()
	{
		uint thisMain = mainButtons[mainSelected].id;
		uint[] thisAutos;
		for(uint i=0;i<autoSelected.length();i++)
		{
			thisAutos.insertLast(autoButtons[autoSelected[i]].id);
		}
		g_mainInventory.set(thisMain, thisAutos);
		g_dataManager.saveInventory(autoNum);
	}

	uint getMainButtonId(uint turretIdx)
	{
		for(uint i=0;i<mainButtons.length();i++)
		{
			if(mainButtons[i].id == turretIdx)
				return i;
		}
		return 999;
	}

	uint getAutoButtonId(uint turretId)
	{
		for(uint i=0;i<autoButtons.length();i++)
		{
			if(autoButtons[i].id == turretId)
				return i;
		}
		return 999;
	}
	
	bool validateStart()
	{
		if(mainSelected == 999)
		{
			DrawFadingCenteredTextY(500*GetScale(), "PLEASE SELECT A MAIN TURRET", text64, red, 1500, GetScale());
			startButton.resetAnim();
			return false;
		}

		if(autoNum >= MAX_AUTO_TURRETS)
		{
			if(autoSelected.length() < MAX_AUTO_TURRETS)
			{
				DrawFadingCenteredTextY(500*GetScale(), "PLEASE SELECT 6 AUTO TURRETS", text64, red, 1500, GetScale());
				startButton.resetAnim();
				return false;
			}
		}
		else
		{
			if(autoSelected.length() < autoNum)
			{
				DrawFadingCenteredTextY(500*GetScale(), "PLEASE SELECT "+autoNum+" AUTO TURRETS", text64, red, 1500, GetScale());
				startButton.resetAnim();
				return false;
			}
		}

		return true;
	}

	void push(uint id, uint buttonId)
	{
		if(mainSelected!=buttonId)
		{
			if(mainSelected != 999)
			{
				mainButtons[mainSelected].selected = false;
			}
			mainSelected = buttonId;
			playNormal(11);
		}
		else 
		{
			mainSelected = 999;
			playNormal(12);
		}
	}

	uint autoIdExists(uint it)
	{
		for(uint i=0;i<autoSelected.length();i++)
			if(autoSelected[i] == it)
				return i;
		return 999;
	}

	void pushAuto(uint id, uint buttonId)
	{
		uint exists = autoIdExists(buttonId);
		if(exists != 999)
		{
			autoButtons[autoSelected[exists]].selected = false;
			autoSelected.removeAt(exists);
			playNormal(12);
		}
		else
		{
			if(autoSelected.length() < MAX_AUTO_TURRETS)
			{
				autoSelected.insertLast(buttonId);
				playNormal(11);
			}
			else
			{
				autoButtons[autoSelected[0]].selected = false;
				for(uint i=0;i<MAX_AUTO_TURRETS-1;i++)
				{
					autoSelected[i] = autoSelected[i+1];
				}
				autoSelected[MAX_AUTO_TURRETS-1] = buttonId;
				playNormal(12);
				playNormal(11);
			}
			
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
	//g_sceneManager.setCurrentScene(GameScene());
}


ItemSelector g_itemSelector;