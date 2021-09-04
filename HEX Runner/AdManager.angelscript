class AdManager
{
	void showAd()
	{
		if(ENABLE_ADS)
		{
			ForwardCommand("admob show");
		}
	}
	
	void hideAd()
	{
		ForwardCommand("admob hide");
	}
}

AdManager g_adManager;


