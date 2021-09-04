//Utilities
#include "eth_util.angelscript"
#include "Constants.angelscript"
#include "String.angelscript"
#include "Dictionary.angelscript"
#include "Execute.angelscript"
#include "Animation.angelscript"
#include "Filters.angelscript"
#include "Interpolator.angelscript"
#include "Transition.angelscript"
#include "isPointInRect.angelscript"
#include "ColorList.angelscript"


//Math
#include "Array.angelscript"
#include "Algebra.angelscript"
#include "Geometry.angelscript"
#include "Polygon.angelscript"

//Classes
#include "Origin.angelscript"
#include "Scene.angelscript"
#include "Element.angelscript"
#include "RuntimeEffect.angelscript"
#include "FadeInEffect.angelscript"
#include "FadeOutEffect.angelscript"
#include "ImageFrame.angelscript"
#include "Color.angelscript"
#include "Sprite.angelscript"
#include "Bouncer.angelscript"
#include "Tile.angelscript"
#include "Layer.angelscript"
#include "Page.angelscript"



//Scenes
#include "MainMenuScene.angelscript"
#include "SettingsScene.angelscript"
#include "GameScene.angelscript"

//Pages
#include "MainMenuPage.angelscript"
#include "SettingsPage.angelscript"



//Managers
#include "SceneManager.angelscript"
#include "Input.angelscript"
#include "Text.angelscript"

//Setting
#include "UserDataManager.angelscript"
#include "Setting.angelscript"
#include "SettingsList.angelscript"
#include "SettingsVarList.angelscript"
#include "SettingsManager.angelscript"

//Specific
#include "Balance.angelscript"
#include "Ball.angelscript"
#include "Maze.angelscript"
#include "MazeGenerator.angelscript"
#include "TouchDirection.angelscript"
#include "CameraManager.angelscript"
#include "Switch.angelscript"
#include "Complementary.angelscript"
#include "ColorGroup.angelscript"
#include "GameBackground.angelscript"
#include "TextButton.angelscript"
#include "SettingElement.angelscript"
#include "SpriteButton.angelscript"
#include "Flicker.angelscript"
#include "GameUI.angelscript"
#include "CasualScene.angelscript"
#include "ProgressManager.angelscript"
#include "Alert.angelscript"
#include "ProgressBar.angelscript"

void main()
{
	#if WINDOWS
	WINDOWS = true;
	#endif

	SetFixedWidth(1080.0f);
	
	float ratio = GetScreenSize().y / GetScreenSize().x;
	if(ratio < 1.98f)
		LAYOUT = 1;
	if(ratio < 1.71f)
		LAYOUT = 2;
	
	g_sceneManager.setSceneNow(MainMenuScene);
}


void mainInit()
{
	//SetPositionRoundUp(true);
	SetNumIterations(1,1);
	SetZAxisDirection(V2_ZERO);
	EnableLightmaps(false);
	g_settings.init();
	g_settings.load();
	progress.load();
}