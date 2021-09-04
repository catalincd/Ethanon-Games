class OverlayManager
{
	uint[] owned;
	
	void init()
	{
		load();
	}
	
	void load()
	{
		string str = g_dataManager.getOwnedOverlays();
		owned.resize(0);
		owned = getArrayFromString(str);
	}
	
	void save()
	{
		string str = getStringFromArray(owned);
		g_dataManager.saveOwnedOverlays(str);
	}
	
	bool ownedItem(uint itm)
	{
		return find(itm, owned);
	}
	
	void buy(uint itm)
	{
		owned.insertLast(itm);
		TOTAL_BOOST_COINS -= getOverlayCost(itm);
		g_dataManager.save();
		save();
	}
}

bool afford(uint id)
{
	return TOTAL_BOOST_COINS >= getOverlayCost(id);
}

uint getOverlayCost(uint id)
{
	if(id == 1) return 15;
	if(id == 2) return 30;
	if(id == 3) return 100;
	if(id == 4) return 300;
	if(id == 5) return 700;

	return 0;
}


OverlayManager g_overlay;