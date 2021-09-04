#include "eth_util.angelscript"
#include "Drawing.angelscript"
#include "Callbacks.angelscript"
#include "TimeManager.angelscript"
#include "SceneManager.angelscript"
#include "MainMenuScene.angelscript"
#include "GameScene.angelscript"
#include "ScoreManager.angelscript"
#include "BlockEntity.angelscript"
#include "BlockArray.angelscript"
#include "BlockAnimations.angelscript"
#include "Block.angelscript"
#include "Layer.angelscript"
#include "Constants.angelscript"
#include "AddF.angelscript"
#include "Colors.angelscript"
#include "Interpolator.angelscript"
#include "Animator.angelscript"
#include "Creator.angelscript"
#include "Scale.angelscript"
#include "Functions.angelscript"
#include "Waypoint.angelscript"
#include "Text.angelscript"

bool windows = false;


void main()
{
	SetFixedWidth(1280);
	//SetFixedHeight(720);
	//LoadScene("empty", "create", "update");
	g_textManager.init();
	g_textManagerMenu.initMenu();
	g_scale.create();
	g_sceneManager.setCurrentScene(GameScene());	
	#if WINDOWS	
	windows = true;
	#endif
}

