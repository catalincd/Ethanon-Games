#include "eth_util.angelscript"
#include "Button.angelscript"
#include "Collide.angelscript"
#include "BuyMenu.angelscript"
#include "Scenes.angelscript"
#include "CallBacks.angelscript"
#include "FrameTimer.angelscript"
#include "Ships.angelscript"
#include "Variables.angelscript"
#include "Classes.angelscript"
#include "isPointInRect.angelscript"
#include "Scroll Bar.angelscript"
#include "Functions.angelscript"
#include "Effects.angelscript"
#include "Drones.angelscript"

void main()
{	
	
	SetFastGarbageCollector(true);
	SetPersistentResources(true);
	//print(GetExternalStorageDirectory());
	EnableQuitKeys(false);
	LoadScene("scenes/Level 7.esc", "GameLoop", "createGameScene");
	//nv1=6;
	level=8;
	//LoadScene("scenes/start.esc", "createStartScene", "updateStartScene", "Loads");
}











