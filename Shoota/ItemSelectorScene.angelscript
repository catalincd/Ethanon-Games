class ItemSelectorScene : Scene
{
	ItemSelectorScene()
	{
		super("empty");
	}

	void onCreated()
	{
		g_itemSelector.create();
	}

	void onUpdate()
	{
		g_itemSelector.update();
	}
}