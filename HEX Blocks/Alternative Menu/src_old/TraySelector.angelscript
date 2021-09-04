#include "Button.angelscript"

class TraySelector : Scene
{

	Button@[] m_buttons;
	Achievement[] m_acv;
	float mainScale = 0.5;
	vector2 navSize;
	vector2 textPos;
	vector2 textPos2;
	vector2 sprPos;
	vector2 sprPos2;
	
	string text1;
	string text2;
	string text3;
	string text4;
	
	vector2 textScale1;
	vector2 textScale2;
	vector2 textScale3;
	vector2 textScale4;
	
	vector2 textPosX1;
	vector2 textPosX2;
	vector2 textPosX3;
	vector2 textPosX4;
	
	Achievement ach;
	
	vector2 index = vector2(0,0);
	bool resuming = false; 
	InterpolationTimer@ Zoomer = InterpolationTimer(350);
	InterpolationTimer@ Op = InterpolationTimer(300);
	InterpolationTimer@ Op2 = InterpolationTimer(300);
	InterpolationTimer@ Op3 = InterpolationTimer(200);
	uint alpha;
	bool selected = false;
	bool selectedAs = false;
	bool selectedAs2 = false;
	bool goingBack = false;
	uint selectedIdx;
	bool showed = false;
	UseButton @m_use;
	
	TraySelector()
	{
		const string sceneName = "empty";
		super(sceneName);
	}
	
	void onResume()
	{
		g_setOrigin.resetAllOrigins();
		SetBackgroundColor(PRIM.getUInt());
		g_loader.load();
		
	}

	void onCreated()
	{
		dataBase.loadMisc();
		SetBackgroundColor(PRIM.getUInt());
		int tx = 0;
		for(uint i=0;i<g_achievementManager.m_achieventsNum;i++)
		{
			vector2 pos = vector2(70+uint(i%3)*205, 135+uint(i/3)*205)+vector2(85,85);
			Button@ b;
			@b = Button("sprites/button.png", pos*GetScale());
			b.setScale(1.0);
			b.setSecondarySprite(g_achievementManager.m_ach[i].path+g_gameManager.png);
			if(!g_achievementManager.m_ach[i].aq)
			b.setLock();
			else
			{
				b.setText2(g_achievementManager.m_ach[i].aq_date.getNormal());
				if(g_achievementManager.m_ach[i].new)
				{
					b.setNew(tx*200);
					tx++;
				}
			}
			b.setText(g_achievementManager.m_ach[i].name);
			m_buttons.insertLast(b);
		}
		
		g_achievementManager.emptyNews();
		
		navSize = vector2(SCREEN_SIZE_X, 70*GetScale());
		textPos =  vector2(SCREEN_SIZE_X2, SCREEN_SIZE_Y+35*GetScale()) - (ComputeTextBoxSize(dataBase.font40, "BACK TO MAIN MENU")/2*GetScale());
		textPos2 = vector2(SCREEN_SIZE_X2, SCREEN_SIZE_Y+35*GetScale()) - (ComputeTextBoxSize(dataBase.font40, "BACK")/2*GetScale());
		sprPos =  vector2(0, SCREEN_SIZE_Y);
		sprPos2 = vector2(0, SCREEN_SIZE_Y);
		
		
		
		Zoomer.setFilter(@smoothEnd);
	}
	
	void resetAchievement()
	{
		text1 = "ACHIEVED:  "+ach.aq_date.getNormal();
		textScale1 = ComputeTextBoxSize(dataBase.font30, text1)/2*GetScale();
		textPosX1 = vector2(350,285)*GetScale()+textScale1;
		
		text2 = ""+ach.name;
		textScale2 = ComputeTextBoxSize(dataBase.font30, text2)/2*GetScale();
		textPosX2 = vector2(350,235)*GetScale()+textScale2;
		
		text3 = "SCORE REQUIRED:  "+ach.xp_req;
		textScale3 = ComputeTextBoxSize(dataBase.font30, text3)/2*GetScale();
		textPosX3 = vector2(350,335)*GetScale()+textScale3;
		
		text4 = "  "+g_gameManager.getType(ach.type);
		textScale4 = ComputeTextBoxSize(dataBase.font30, text4)/2*GetScale();
		textPosX4 = vector2(350,175)*GetScale()+textScale4;
	}
	
	void onUpdate()
	{	
	
		if(GetInputHandle().GetKeyState(K_SPACE)==KS_HIT)
		onResume();
		uint whitee = ARGB(alpha, PRIM);
		uint blackk = ARGB(alpha, SEC);
		uint realWhite = ARGB(alpha, 255,255,255);
		DrawShapedSprite(g_gameManager.blockS, sprPos-index, navSize, blackk);
		DrawText(textPos-index, "BACK TO MAIN MENU", dataBase.font40, whitee, GetScale());
		Zoomer.update();
		if(Zoomer.isOver() && !showed)
		{
			ForwardCommand("admob show");
			showed = true;
		}
		if(!resuming)
		{
			mainScale = 0.3+(Zoomer.getBias()*0.7);
			alpha = uint(Zoomer.getBias()*255.0);
			index.y = Zoomer.getBias()*70*GetScale();
		}
		else
		{
			if(showed)
			{
				ForwardCommand("admob hide");
				showed = false;
			}
			mainScale = 0.3+((1-Zoomer.getBias())*0.7);
			alpha = uint((1-Zoomer.getBias())*255.0);
			index.y = (1-Zoomer.getBias())*70*GetScale();
			if(Zoomer.isOver())
				g_sceneManager.setCurrentScene(MainMenuScene());
		}
		for(uint i=0;i<m_buttons.length();i++)
		{
			m_buttons[i].setScale(mainScale);
			m_buttons[i].setColor(realWhite);
			if(!selected)
			{
				m_buttons[i].putButton();
				if(m_buttons[i].isPressed())
				{
					m_buttons[i].setPressed(false);
					selectedIdx = i;
					selected = true;
					Op.reset(300);
					ach = g_achievementManager.m_ach[i];
					resetAchievement();
					@m_use = UseButton(vector2(200, 500)*GetScale());
					if(g_gameManager.check(ach.type, ach.argument))
						m_use.lock();
				}
			}
			else
				m_buttons[i].drawOnly();
			
		}
		
		if(selected)
		{
			uint scolor = ARGB(uint((goingBack? 1-Op.getBias():Op.getBias())*255),PRIM);
			DrawShapedSprite("sprites/white.png", vector2(0,0), SCREEN_SIZE, scolor);
			if(!goingBack)
			Op.update();
			if(Op.isOver() && !selectedAs)
			{
				selectedAs = true;
				m_buttons[selectedIdx].seen();
				Op2.reset(300);
			}
			
			if(selectedAs)
			{
				//DrawRectangle(vector2(2, 250), vector2(64,64), black, cyan,  cyan, black);
				
				if(m_use.isPressed())
				{
					m_use.lock();
					g_gameManager.select(g_achievementManager.m_ach[selectedIdx].type,g_achievementManager.m_ach[selectedIdx].argument);
					m_use.setPressed(false);
				}
				if(!goingBack)
				Op2.update();
				uint whiteee = ARGB(uint((goingBack? 1-Op2.getBias():Op2.getBias())*255), PRIM);
				uint blackkk = ARGB(uint((goingBack? 1-Op2.getBias():Op2.getBias())*255), SEC);
				
				
				float yoff = 70*GetScale()*(goingBack? 1-Op2.getBias():Op2.getBias());
				DrawShapedSprite(g_gameManager.blockS, sprPos2-vector2(0,yoff), navSize, blackkk);
				DrawText(textPos2-vector2(0,yoff), "BACK", dataBase.font40, PRIM.getUInt(), GetScale());
				if(!goingBack)
				if(GetInputHandle().GetTouchState(0)==KS_HIT && GetInputHandle().GetTouchPos(0).y>SCREEN_SIZE_Y-(70*GetScale()) || (GetInputHandle().GetKeyState(K_BACK)==KS_HIT))
				{
					goingBack = true;
					Op.reset(300);
					Op2.reset(300);
					Op3.reset(200);
				}
				
			}
			
			/*if(!goingBack)
				if(Op2.isOver())
				{
					Op3.update();
					
				}
			*/
			float bias3 = (goingBack? 1-Op2.getBias():Op2.getBias());
			uint sscolor = ARGB(uint(bias3*255), PRIM);
			uint sscolor2 = ARGB(uint(bias3*255), SEC);
			uint sscolor3 = ARGB(uint(bias3*255), 255,255,255);

			float xscale = (0.5+(bias3*0.5));
			DrawShapedSprite("sprites/button.png", vector2(200,300)*GetScale(), vector2(250, 250)*xscale*GetScale(), sscolor3);
			DrawShapedSprite(ach.path+g_gameManager.png, vector2(200,300)*GetScale(), vector2(53, 53)*xscale*GetScale(), sscolor3);
			
			DrawText(textPosX1-(textScale1*xscale), text1, dataBase.font30, sscolor2, GetScale()*xscale);
			DrawText(textPosX2-(textScale2*xscale), text2, dataBase.font30, sscolor2, GetScale()*xscale);
			DrawText(textPosX3-(textScale3*xscale), text3, dataBase.font30, sscolor2, GetScale()*xscale);
			DrawText(textPosX4-(textScale4*xscale), text4, dataBase.font30, sscolor2, GetScale()*xscale);
			
			m_use.setColor(sscolor2);
			m_use.setScale(xscale);
			m_use.putButton();
			
			if(goingBack)
			{
				//Op3.update();
				//if(Op3.isOver())
				Op2.update();
				if(Op2.isOver())
				{
					Op.update();
				}
				if(Op.isOver())
				{
					goingBack = false;
					Op.reset(300);
					Op2.reset(300);
					Op3.reset(200);
					selected = false;
					selectedAs = false;
				}
			}
		}
		
		
		if(!resuming && !selected)
		if((GetInputHandle().GetTouchState(0)==KS_HIT && GetInputHandle().GetTouchPos(0).y>SCREEN_SIZE_Y-(70*GetScale())) || (GetInputHandle().GetKeyState(K_BACK)==KS_HIT))
		{
			
				resuming = true;
				Zoomer.reset(350);
				for(uint i=0;i<m_buttons.length();i++)
				{
					m_buttons[i].bouncing = false;
				}
		}
	}
}