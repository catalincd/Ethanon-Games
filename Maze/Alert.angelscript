class SAlert
{
	bool showing = false;
	bool hoc = false;
	TextButton@ yesButton;
	TextButton@ noButton;
	uint shadeColor = 0xAA000000;
	string message;
	vector2 initTextPos;
	vector2 textPos;
	
	void create()
	{
		initTextPos = GetScreenSize() * vector2(0.5f, 0.25f);
	
		@yesButton = TextButton("YES", GetScreenSize() * vector2(0.75f, 0.75f), f128, green);
		@noButton = TextButton("NO", GetScreenSize() * vector2(0.25f, 0.75f), f128, red);
		yesButton.setDelay(150);
		noButton.setDelay(150);
	}
	
	void show(string mes = "ARE YOU SURE?")
	{
		message = mes;
		
		textPos = initTextPos - (ComputeTextBoxSize(f64, message) * GetScale() / 2.0f);
		
		showing = true;
		hoc = false;
	}
	
	void hide()
	{
		showing = false;
	}
	
	void hideOnChange()
	{
		hoc = true;
	}
	
	void update()
	{
		if(showing)
		{
			DrawShapedSprite("sprites/flick.png", V2_ZERO, GetScreenSize(), shadeColor);
			DrawText(textPos, message, f64, white.getUInt(), GetScale());
			yesButton.update();
			noButton.update();
		}
	}
	
	bool yes()
	{
		return yesButton.isHit();
	}
	
	bool no()
	{
		return noButton.isHit();
	}	
}

SAlert Alert;