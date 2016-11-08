local assets =
{
	Asset( "ANIM", "anim/marco.zip" ),
	Asset( "ANIM", "anim/ghost_marco_build.zip" ),
}

local skins =
{
	normal_skin = "marco",
	ghost_skin = "ghost_marco_build",
}

local base_prefab = "marco"

local tags = {"MARCO", "CHARACTER"}

return CreatePrefabSkin("marco_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})