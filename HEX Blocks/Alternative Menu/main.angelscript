//STUFF
#include "src/Buddy.angelscript"
#include "src/Random.angelscript"

//UTIL
#include "src/eth_util.angelscript"
#include "src/Layer.angelscript"
#include "src/Colors.angelscript"
#include "src/TouchManager.angelscript"
#include "src/isPointInRect.angelscript"
#include "src/Interpolator.angelscript"
#include "src/Button.angelscript"
#include "src/MenuButton.angelscript"
#include "src/Vars.angelscript"
#include "src/SetOrigin.angelscript"
#include "src/Functions.angelscript"
#include "src/Drawing.angelscript"

//SCENES
#include "src/Scene.angelscript"
#include "src/SceneManager.angelscript"
#include "src/MainMenuScene.angelscript"
#include "src/MainMenu.angelscript"
#include "src/Ratings.angelscript"
#include "src/RatingScene.angelscript"
#include "src/LevelBar.angelscript"

void main()
{
	SetFixedWidth(720);
	SetSharedData("MenuScene", "TRUE");
	g_sceneManager.setScene(MainMenuScene());	
}
