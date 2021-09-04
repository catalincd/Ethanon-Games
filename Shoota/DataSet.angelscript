class DataSet
{
	void init()
	{
		setVolume();
	}
}

DataSet g_dataSet;


void setVolume()
{
	SetGlobalVolume(SOUND_ON? 1.0f : 0.0f);
}