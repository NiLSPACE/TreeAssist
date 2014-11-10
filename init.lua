
-- init.lua

-- Contains the initialization function, and the disabling function.





g_Plugin          = nil;
g_Config          = nil;
g_CollectionClass = nil;





function Initialize(a_Plugin)
	a_Plugin:SetName("TreeAssist")
	a_Plugin:SetVersion(2)
	g_Plugin = a_Plugin
	
	-- Load the config file
	LoadSettings()
	
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_LEFT_CLICK, OnPlayerLeftClick)
	
	return true
end





function OnDisable()
	LOG("TreeAssist v" .. g_Plugin:GetVersion() .. " is disabling")
end




