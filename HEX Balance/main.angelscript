/*
 Hello world!
*/

#include "eth_util.angelscript"
#include "SceneManager.angelscript"
#include "Execute.angelscript"
#include "Transition.angelscript"
#include "Filters.angelscript"
#include "Interpolator.angelscript"
#include "ScaleFactor.angelscript"
#include "Constants.angelscript"
#include "Color.angelscript"
#include "ColorList.angelscript"
#include "GameScene.angelscript"
#include "MainMenuScene.angelscript"
#include "GameObject.angelscript"
#include "ScoreManager.angelscript"
#include "World.angelscript"
#include "GameUI.angelscript"
#include "Callbacks.angelscript"
#include "GameOverManager.angelscript"

void main()
{
	SetFixedWidth(1080);
	setScaleFactor();
	
	g_sceneManager.setSceneNow(MainMenuScene);
	
}

