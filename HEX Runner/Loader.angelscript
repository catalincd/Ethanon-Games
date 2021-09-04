class Loader
{

	void load()
	{
		set();
	}
	
	void set()
	{
		SetSpriteOrigin("entities/block_64.png", V2_HALF);
		SetSpriteOrigin("sprites/arrow_down.png", V2_HALF);
		SetSpriteOrigin("sprites/block/body6.png", V2_HALF);
		SetSpriteOrigin("sprites/block/eyes.png", V2_HALF);
	
		SetSpriteOrigin("sprites/block/eyes.png", V2_HALF);
		SetSpriteOrigin("sprites/overlays/block_dead.png", V2_HALF);
		SetSpriteOrigin("sprites/block/eyes_contour.png", V2_HALF);
		SetSpriteOrigin("sprites/block/blink.png", V2_HALF);
		SetSpriteOrigin("sprites/block/body6.png", V2_HALF);
		SetSpriteOrigin("sprites/block_spr.png", V2_HALF);
		SetSpriteOrigin("sprites/pause.png", V2_ONE);
		SetSpriteOrigin("sprites/notification.png", vector2(0.4, 0.4));
		SetSpriteOrigin("sprites/trail.png", vector2(0.5, 0));
		
		for(uint i=1;i<OVERLAYS_NUM;i++)
			SetSpriteOrigin(GetOverlayNameFromIdx(i), V2_HALF);
	}
	
	void resume()
	{
		set();
	}

}

Loader g_loader;