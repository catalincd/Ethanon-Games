void ETHCallback_block(ETHEntity@ thisEntity)
{
	if(o_world.blockDead(thisEntity))
	{
		o_world.cubesDead++;
		o_world.cubesAlive--;
		@thisEntity = DeleteEntity(thisEntity);
	}
}