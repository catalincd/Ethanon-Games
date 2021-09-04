class Inventory
{
	uint mainTurret;
	uint[] autoTurrets;
	//MAX_AUTO_TURRETS

	string getString()
	{
		string str = "" + mainTurret;
		for(uint i=0;i<autoTurrets.length();i++)
		{
			str += "," + autoTurrets[i];
		}
		return str;
	}

	void fill(string str, uint autos = MAX_AUTO_TURRETS)
	{
		if(autos > MAX_AUTO_TURRETS) autos = MAX_AUTO_TURRETS;
		if(str != "")
		{
			string[] arr = split(str, ",");
			mainTurret = (parseUInt(arr[0]));
			autoTurrets.resize(0);
			for(uint i=0;i<autos;i++)
			{
				autoTurrets.insertLast(parseUInt(arr[i+1]));
			}
		}
	}

	void set(uint main, uint[] autos)
	{
		mainTurret = main;
		autoTurrets.resize(0);
		for(uint i=0;i<autos.length();i++)
			autoTurrets.insertLast(autos[i]);
	}

	uint getMain()
	{
		return mainTurret;
	}

	uint[] getAutos()
	{
		return autoTurrets;
	}

}


Inventory g_mainInventory;