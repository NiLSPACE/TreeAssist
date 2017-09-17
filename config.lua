
-- config.lua

-- Contains all the functions to load the config





g_ConfigDefaults = 
[[
AxeRequired      = false,
Collection       = "pickups",
SurvivalOnly     = false,
ReplantSapling   = true,
SaplingPlantTime = 25,
ReplantSaplingRate = 0.2,
]]





function LoadDefaultSettings()
	g_Config = loadstring("return {" .. g_ConfigDefaults .. "}")()
	LoadItemCollection()
end





function LoadItemCollection()
	if (type(g_Config.Collection) ~= 'string') then
		LOGWARNING("[TreeAssist] The item collection is malformed. \"pickups\" will be used.")
		g_Config.Collection = "pickups"
	end
	
	local CollType = g_Config.Collection:lower()
	if (CollType == 'pickups') then
		g_CollectionClass = cPickupCollection
	elseif (CollType == "instantinventory") then
		g_CollectionClass = cToInventoryCollection
	else
		LOGWARNING("[TreeAssist] item collector \"" .. CollType .. "\" is unknown. \"pickups\" will be used.")
		g_CollectionClass = cPickupCollection
	end
end





function LoadSettings()
	local Path = g_Plugin:GetLocalFolder() .. "/config.cfg"
	if (not cFile:IsFile(Path)) then
		LOGWARNING("[TreeAssist] The config file doesn't exist. TreeAssist will use the default settings for now")
		LoadDefaultSettings()
		return
	end
	
	local ConfigContent = cFile:ReadWholeFile(Path)
	if (ConfigContent == "") then
		LOGWARNING("[TreeAssist] The config file is empty. TreeAssist will use the default settings for now")
		LoadDefaultSettings()
		return
	end
	
	local ConfigLoader, Error  = loadstring("return {" .. ConfigContent .. "}")
	if (not ConfigLoader) then
		LOGWARNING("[TreeAssist] There is a problem in the config file. TreeAssist will use the default settings for now.")
		LoadDefaultSettings()
		return
	end
	
	local Result, ConfigTable, Error = pcall(ConfigLoader)
	if (not Result) then
		LOGWARNING("[TreeAssist] There is a problem in the config file. TreeAssist will use the default settings for now.")
		LoadDefaultSettings()
		return
	end
	
	if (ConfigTable.ReplantSapling and (type(ConfigTable.SaplingPlantTime) ~= 'number')) then
		LOGWARNING("[TreeAssist] ReplantSapling is activated, but there is no time set. TreeAssist will use the default time (20 ticks)")
		ConfigTable.SaplingPlantTime = 20
	end
	
	g_Config = ConfigTable
	
	LoadItemCollection()
end




	