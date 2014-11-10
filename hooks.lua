
-- hooks.lua

-- Contains the hook functions





function OnPlayerLeftClick(a_Player, a_BlockX, a_BlockY, a_BlockZ, a_BlockFace, a_Action)
	-- Check if the user should only be allowed to use survival with this plugin
	if (g_Config.SurvivalOnly and not a_Player:IsGameModeSurvival()) then
		return false
	end
	
	-- Check if this is actualy a left click.
	if (a_Action ~= 0) then
		return false
	end
	
	-- Check if the blockface is correct
	if (a_BlockFace == BLOCK_FACE_NONE) then
		return false
	end
	
	-- Check if you may only use an axe, and if that is true check if the equipped item is an axe
	local EquippedItem = a_Player:GetEquippedItem()
	if (g_Config.AxeRequired and not ItemCategory.IsAxe(EquippedItem.m_ItemType)) then
		return false
	end
	
	-- Check if the block that is about to be digged up is wood
	local World = a_Player:GetWorld()
	local BlockType = World:GetBlock(a_BlockX, a_BlockY, a_BlockZ)
	if (not ItemCategory.IsWood(BlockType)) then
		return false
	end
	
	local BlockMeta = World:GetBlockMeta(a_BlockX, a_BlockY, a_BlockZ)
	
	-- Initialize the collection class
	local Collection = g_CollectionClass(a_Player, BlockType, BlockMeta)
	
	-- Go through each block above the current block until the block ID is different.
	for PosY = a_BlockY, World:GetHeight(a_BlockX, a_BlockZ), 1 do
		if (World:GetBlock(a_BlockX, PosY, a_BlockZ) ~= BlockType) then
			break;
		end
		
		if (World:GetBlockMeta(a_BlockX, PosY, a_BlockZ) ~= BlockMeta) then
			break;
		end
		
		World:SetBlock(a_BlockX, PosY, a_BlockZ, E_BLOCK_AIR, 0)
		Collection:NextBlock(a_BlockX, PosY, a_BlockZ)
	end
	
	Collection:Finish()
	
	if (g_Config.ReplantSapling) then
		World:QueueSetBlock(a_BlockX, a_BlockY, a_BlockZ, E_BLOCK_SAPLING, GetSaplingMeta(BlockType, BlockMeta), g_Config.SaplingPlantTime)
	end
end




