
-- functions.lua

-- Contains global functions that are used to make this plugin work properly





-- Add IsWood to the ItemCategory class.
function ItemCategory.IsWood(a_BlockID)
	return (
		(a_BlockID == E_BLOCK_LOG) or
		(a_BlockID == E_BLOCK_NEW_LOG)
	)
end




function GetSaplingMeta(a_BlockType, a_BlockMeta)
	if (a_BlockType == E_BLOCK_LOG) then
		return a_BlockMeta
	end
	
	return a_BlockMeta + 4
end