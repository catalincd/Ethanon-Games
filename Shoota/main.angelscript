#include "eth_util.angelscript"
#include "Button.angelscript"
#include "Scene.angelscript"
#include "SceneManager.angelscript"
#include "GameScene.angelscript"
#include "GameObject.angelscript"
#include "MainMenuScene.angelscript"
#include "Turret.angelscript"
#include "Turrets.angelscript"
#include "Interpolator.angelscript"
#include "Colors.angelscript"
#include "Functions.angelscript"
#include "Filters.angelscript"
#include "BackgroundManager.angelscript"
#include "ScaleFactor.angelscript"
#include "Bullet.angelscript"
#include "Timer.angelscript"
#include "EnemyManager.angelscript"
#include "Callbacks.angelscript"
#include "Balance.angelscript"
#include "TurretManager.angelscript"
#include "TurretSimple.angelscript"
#include "AutoTurret.angelscript"
#include "SceneCreator.angelscript"
#include "ColorList.angelscript"
#include "Constants.angelscript"
#include "Angle.angelscript"
#include "SoundManager.angelscript"
#include "GameUIManager.angelscript"
#include "Loader.angelscript"
#include "Item.angelscript"
#include "ItemButton.angelscript"
#include "ItemManager.angelscript"
#include "MapManager.angelscript"
#include "Text.angelscript"
#include "UserDataManager.angelscript"
#include "DataManager.angelscript"
#include "DataSet.angelscript"
#include "LifeBar.angelscript"
#include "SpawnManager.angelscript"
#include "Inventory.angelscript"
#include "ItemSelectorScene.angelscript"
#include "ItemSelector.angelscript"
#include "BulletPointManager.angelscript"
#include "UIBar.angelscript"
#include "RankManager.angelscript"
#include "Gauge.angelscript"
#include "BPS.angelscript"
#include "HPGauge.angelscript"
#include "GameOver.angelscript"
#include "GameSuccess.angelscript"
#include "ExperienceManager.angelscript"
#include "Bouncer.angelscript"
#include "FundManager.angelscript"
#include "MarketScene.angelscript"
#include "Stats.angelscript"
#include "LoadingScreen.angelscript"
#include "RankLayer.angelscript"
#include "Geometry.angelscript"
#include "Background.angelscript"
#include "DefensiveTurret.angelscript"
#include "Swiper.angelscript"
#include "Settings.angelscript"




void main()
{
	SetFixedWidth(1080);
	SetPersistentResources(true);
	g_sceneManager.setCurrentScene(LoadingScene());
}


void runOnInitFuction()
{
	EnableLightmaps(false);
	SetZBuffer(false);
	SetPositionRoundUp(false);
	SetFastGarbageCollector(true);
	SetNumIterations(8, 3);
}
