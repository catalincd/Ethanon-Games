class OptionsLayer
{

	TextButton@ overlaysSwitch;
	TextButton@ adsSwitch;
	TextButton@ tutorialSwitch;
	TextButton@ eyesSwitch;
	TextButton@ tipsSwitch;
	TextButton@ touchSwitch;
	TextButton@ soundSwitch;
	vector2 pleasePos;
	
	void create()
	{
		@overlaysSwitch = TextButton(vector2(GetScreenSize().x / 2, 500*GetScale()), "yes");
		overlaysSwitch.setText("DRAW OVERLAYS IN-GAME:  " + AssembleColorCode(DRAWING_OVERLAYS? green:red)+(DRAWING_OVERLAYS? "ON " : "OFF"));

		@tutorialSwitch = TextButton(vector2(GetScreenSize().x / 2, 650*GetScale()), "yes");
		tutorialSwitch.setText("TUTORIAL:  " + AssembleColorCode(TUTORIAL? green:red)+(TUTORIAL? "ON " : "OFF"));


		@adsSwitch = TextButton(vector2(GetScreenSize().x / 2, 600*GetScale()), "yes");
		adsSwitch.setText("ENABLE ADS:  " + AssembleColorCode(ENABLE_ADS? green:red)+(ENABLE_ADS? "ON " : "OFF"));
		
		@tipsSwitch = TextButton(vector2(GetScreenSize().x / 2, 700*GetScale()), "yes");
		tipsSwitch.setText("SHOW TIPS:  " + AssembleColorCode(SHOW_TIPS? green:red)+(SHOW_TIPS? "ON " : "OFF"));

		@eyesSwitch = TextButton(vector2(GetScreenSize().x / 2, 550*GetScale()), "yes");
		eyesSwitch.setText("DRAW EYES IN-GAME:  " + AssembleColorCode(DRAWING_EYES? green:red)+(DRAWING_EYES? "ON " : "OFF"));
	
		@touchSwitch = TextButton(vector2(GetScreenSize().x / 2, 750*GetScale()), "yes");
		touchSwitch.setText("TOUCH CONTROLS:  " + AssembleColorCode(TOUCH_CONTROLS? green:red)+(TOUCH_CONTROLS? "ON " : "OFF"));

		@soundSwitch = TextButton(vector2(GetScreenSize().x / 2, 850*GetScale()), "yes");
		soundSwitch.setText("SOUND:  " + AssembleColorCode(ENABLE_SOUND? green:red)+(ENABLE_SOUND? "ON " : "OFF"));
		
		pleasePos = vector2(GetScreenSize().x/2, 450*GetScale()) - ComputeTextBoxSize("Verdana30.fnt", "PLEASE ENABLE ADS FOR THESE FEATURES") * GetScale() / 2;
	}
	
	
	void update()
	{
		tipsSwitch.update();
		if(tipsSwitch.isPressed())
		{
			SHOW_TIPS = !SHOW_TIPS;
			tipsSwitch.setText("SHOW TIPS:  " + AssembleColorCode(SHOW_TIPS? green:red)+(SHOW_TIPS? "ON " : "OFF"));
			tipsSwitch.setPressed(false);
		}
		
		soundSwitch.update();
		if(soundSwitch.isPressed())
		{
			ENABLE_SOUND = !ENABLE_SOUND;
			SetGlobalVolume(ENABLE_SOUND? 1.0f : 0.0f);
			soundSwitch.setText("SOUND:  " + AssembleColorCode(ENABLE_SOUND? green:red)+(ENABLE_SOUND? "ON " : "OFF"));
			soundSwitch.setPressed(false);
		}
	
		touchSwitch.update();
		if(touchSwitch.isPressed())
		{
			TOUCH_CONTROLS = !TOUCH_CONTROLS;
			touchSwitch.setText("TOUCH CONTROLS:  " + AssembleColorCode(TOUCH_CONTROLS? green:red)+(TOUCH_CONTROLS? "ON " : "OFF"));
			touchSwitch.setPressed(false);
		}
	
		overlaysSwitch.update();
		if(overlaysSwitch.isPressed())
		{
			DRAWING_OVERLAYS = !DRAWING_OVERLAYS;
			if(DRAWING_OVERLAYS && !ENABLE_ADS)
			{
				DrawFadingText(pleasePos,"PLEASE ENABLE ADS FOR THESE FEATURES", "Verdana30.fnt", red, 2000, GetScale());
				DRAWING_OVERLAYS = false;
			}
			else
			overlaysSwitch.setText("DRAW OVERLAYS IN-GAME:  " + AssembleColorCode(DRAWING_OVERLAYS? green:red)+(DRAWING_OVERLAYS? "ON " : "OFF"));
			overlaysSwitch.setPressed(false);
		}
		
		eyesSwitch.update();
		if(eyesSwitch.isPressed())
		{
			DRAWING_EYES = !DRAWING_EYES;
			if(DRAWING_EYES && !ENABLE_ADS)
			{
				DRAWING_EYES = false;
				DrawFadingText(pleasePos,"PLEASE ENABLE ADS FOR THESE FEATURES", "Verdana30.fnt", red, 2000, GetScale());
			}
			else
			eyesSwitch.setText("DRAW EYES IN-GAME:  " + AssembleColorCode(DRAWING_EYES? green:red)+(DRAWING_EYES? "ON " : "OFF"));
			eyesSwitch.setPressed(false);
		}
		
		tutorialSwitch.update();
		if(tutorialSwitch.isPressed())
		{
			TUTORIAL = !TUTORIAL;
			tutorialSwitch.setText("TUTORIAL:  " + AssembleColorCode(TUTORIAL? green:red)+(TUTORIAL? "ON " : "OFF"));
			tutorialSwitch.setPressed(false);
		}
		
		adsSwitch.update();
		if(adsSwitch.isPressed())
		{
			ENABLE_ADS = !ENABLE_ADS;
			if(ENABLE_ADS)
				g_adManager.showAd();
			else
				g_adManager.hideAd();
				
			if(!ENABLE_ADS)
			{
				DRAWING_OVERLAYS = false;
				DRAWING_EYES = false;
				overlaysSwitch.setText("DRAW OVERLAYS IN-GAME:  " + AssembleColorCode(DRAWING_OVERLAYS? green:red)+(DRAWING_OVERLAYS? "ON " : "OFF"));
				eyesSwitch.setText("DRAW EYES IN-GAME:  " + AssembleColorCode(DRAWING_EYES? green:red)+(DRAWING_EYES? "ON " : "OFF"));
			}
			adsSwitch.setText("ENABLE ADS:  " + AssembleColorCode(ENABLE_ADS? green:red)+(ENABLE_ADS? "ON " : "OFF"));
			adsSwitch.setPressed(false);
		}
	}
}

OptionsLayer g_optionsLayer;