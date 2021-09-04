class Loader
{
	
	string[] sprites = {	"sprites/block_bl2x.png",
							"sprites/blockx_b.png",
							"sprites/blockx_w.png",
							"sprites/button.png",
							"sprites/grey.png",
							"sprites/lock.png",
							"sprites/stroke.png",
							"sprites/trans.png",
							"sprites/white.png",
							"entities/ball_b.png",
							"entities/ball_w.png",
							"entities/ball3_w.png",
							"entities/ball3_b.png",
							"entities/ball4_w.png",
							"entities/ball4_b.png",
							"entities/ball5_w.png",
							"entities/ball5_b.png",
							"entities/ball6_w.png",
							"entities/ball6_b.png",
							"entities/ball7_w.png",
							"entities/ball7_b.png",
							"entities/block_w.png",
							"entities/block_b.png",
							"entities/transition.png",
							"particles/block_b_p.png",
							"particles/block_bl_p.png",
							"particles/particle.png"
							
						};

	void load()
	{
		for(uint i=0;i<sprites.length();i++)
		{
			LoadSprite(sprites[i]);
		}
	}
	
}

Loader g_loader;