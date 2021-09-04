#include "eth_util.angelscript"
#include "DateTime.angelscript"
#include "DataBase.angelscript"
#include "Functions.angelscript"
#include "Vars.angelscript"
#include "SetOrigin.angelscript"
#include "Loader.angelscript"
#include "Colors.angelscript"
#include "Drawing.angelscript"
#include "AddF.angelscript"
#include "Creator.angelscript"
#include "Effector.angelscript"
#include "Blocks.angelscript"
#include "Callbacks.angelscript"
#include "Achievement.angelscript"
#include "AchievementManager.angelscript"
#include "ScoreManager.angelscript"
#include "GameManager.angelscript"
#include "SoundManager.angelscript"
#include "SceneManager.angelscript"
#include "MainMenuScene.angelscript"
#include "StatsScene.angelscript"
#include "SettingsScene.angelscript"
#include "TraySelector.angelscript"
#include "GameScene.angelscript"

void main()
{
	SetFixedWidth(720);
	g_sceneManager.setCurrentScene(MainMenuScene());

}

