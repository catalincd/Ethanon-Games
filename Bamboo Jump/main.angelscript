#include "eth_util.angelscript"

#include "ScaleFactor.angelscript"

#include "Constants.angelscript"
#include "Callbacks.angelscript"

#include "Scene.angelscript"
#include "SceneManager.angelscript"

#include "GameScene.angelscript"
#include "MainMenuScene.angelscript"

#include "GameObject.angelscript"

//Objects
#include "World.angelscript"
#include "Jumper.angelscript"
#include "CameraManager.angelscript"
#include "GameOverManager.angelscript"
#include "Trap.angelscript"
#include "Traps.angelscript"


#include "Functions.angelscript"
#include "MenuButton.angelscript"
#include "Random.angelscript"
#include "isPointInRect.angelscript"
#include "Interpolator.angelscript"
#include "Filters.angelscript"
#include "Selector.angelscript"
#include "Origin.angelscript"
#include "DataBase.angelscript"
#include "UserDataManager.angelscript"
#include "ScoreManager.angelscript"


void main()
{
	SetFixedWidth(1080);
	setScaleFactor();
	
	g_sceneManager.setSceneNow(MainMenuScene());
}

void begin()
{
	dataBase.init();
	dataBase.load();
}
