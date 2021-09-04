#include "eth_util.angelscript"
#include "Scene.angelscript"
#include "SceneManager.angelscript"
#include "TutorialScene.angelscript"
#include "GameScene.angelscript"
#include "SettingsScene.angelscript"
#include "MainMenuScene.angelscript"
#include "MainMenuBlock.angelscript"
#include "BlockEntity.angelscript"
#include "Constants.angelscript"
#include "GameObject.angelscript"
#include "MainBlock.angelscript"
#include "Swyper.angelscript"
#include "STimeManager.angelscript"
#include "Colors.angelscript"
#include "Interpolator.angelscript"
#include "BlockAnimator.angelscript"
#include "CameraManager.angelscript"
#include "BlockArray.angelscript"
#include "BlockEntity.angelscript"
#include "Creator.angelscript"
#include "Functions.angelscript"
#include "Properties.angelscript"
#include "EntityProperties.angelscript"
#include "GameOverManager.angelscript"
#include "GameOverProperties.angelscript"
#include "Random.angelscript"
#include "GameLayer.angelscript"
#include "Text.angelscript"
#include "Timer.angelscript"
#include "ScoreManager.angelscript"
#include "Effector.angelscript"
#include "utilString.angelscript"
#include "Callbacks.angelscript"
#include "SoundManager.angelscript"
#include "SpeedFactorManager.angelscript"
#include "ColorManager.angelscript"
#include "EnergyManager.angelscript"
#include "ColorSelector.angelscript"
#include "MainMenuRunningBlock.angelscript"
#include "DataManager.angelscript"
#include "UserDataManager.angelscript"
#include "Customizer.angelscript"
#include "Wheel.angelscript"
#include "Loader.angelscript"
#include "Idx.angelscript"
#include "OptionsLayer.angelscript"
#include "StatScene.angelscript"
#include "Filters.angelscript"
#include "Bouncer.angelscript"
#include "AdManager.angelscript"
#include "PauseManager.angelscript"
#include "BackgroundEffector.angelscript"
#include "TipManager.angelscript"
#include "GameEffector.angelscript"
#include "OverlayManager.angelscript"
#include "OverlaySelector.angelscript"

void main()
{
	SetFixedWidth(720);
	
	if(GetScreenSize().x / GetScreenSize().y > 0.6)
		RATIO = true;
	
	#if WINDOWS
		WINDOWS = true;
	#endif
	g_loader.load();
	g_dataManager.load();
	if(GAMES_PLAYED == 0)
	{
			TUTORIAL = true;
	}
	g_sceneManager.setCurrentScene(MainMenuScene());
}
