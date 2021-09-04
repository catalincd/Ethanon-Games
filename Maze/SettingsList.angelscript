FloatSetting  SET_touchScale = FloatSetting("TOUCH SCALE", "touchScale", "preferences", 1.0f, 3.0f, 2.0f);
FloatSetting  SET_sens       = FloatSetting("SENSITIVITY", "sens", "preferences", 0.0f, 5.0f, 2.5f);

SwitchSetting SET_ads =        SwitchSetting("ENABLE ADS", "ads", "preferences", true);
SwitchSetting SET_touchFixed = SwitchSetting("TOUCH FIXED", "touchFixed", "preferences", true);
SwitchSetting SET_touchControls = SwitchSetting("TOUCH CONTROLS", "touchControls", "preferences", false);




float TOUCH_SCALE = 1.0f;
float SENSITIVITY = 1.0f;


bool ADS = true;
bool TOUCH_FIXED = true;
bool TOUCH_CONTROLS = false;


void ASSIGN_VALUES()
{
	TOUCH_SCALE = SET_touchScale.VALUE;
	SENSITIVITY = SET_sens.VALUE;
	
	
	ADS = SET_ads.ON;
	TOUCH_FIXED = SET_touchFixed.ON;
	TOUCH_CONTROLS = SET_touchControls.ON;
	
	
	ForwardCommand("admob "+(ADS? "show":"hide"));
}

