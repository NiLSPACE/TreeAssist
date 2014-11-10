
-- itemcollection.lua

-- This file contains classes that will handle different methods for collecting items





function cCollectionSkeleton()
	local self = {}
	function self:NextBlock()
	end
	
	function self:Finish()
	end
	
	return self
end





function cToInventoryCollection(a_Player, a_BlockType, a_BlockMeta)
	local m_Inventory = a_Player:GetInventory()
	local m_Block = cItem(a_BlockType, 1, a_BlockMeta)
	
	local self = cCollectionSkeleton()
	
	function self:NextBlock(a_X, a_Y, a_Z)
		m_Block.m_ItemCount = m_Block.m_ItemCount + 1
	end
	
	function self:Finish()
		m_Inventory:AddItem(m_Block)
	end
	
	return self
end




function cPickupCollection(a_Player, a_BlockType, a_BlockMeta)
	local m_World = a_Player:GetWorld()
	local m_Block = cItems()
	m_Block:Add(a_BlockType, 1, a_BlockMeta)
	
	local self = cCollectionSkeleton()
	
	function self:NextBlock(a_X, a_Y, a_Z)
		m_World:SpawnItemPickups(m_Block, a_X, a_Y, a_Z, math.random())
	end
	
	return self
end




