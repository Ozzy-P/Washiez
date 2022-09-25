return {
	enabled = true, 
	enabledInStudio = true, 
	enabledInPrivate = true, 
	playerValidation = false, 
	embeddedAdmin = true, 
	serverBans = false, 
	muteOutput = false, 
	verboseOutput = false, 
	checkAdminCallback = function(p1)
		if _G.Adonis == nil then
			return false;
		end;
		return _G.Adonis.CheckAdmin(p1);
	end, 
	onAEBan = function(p2, p3)
		print(p2.Name .. " has been banned by the Anti-Exploit for " .. p3);
	end, 
	sizeTampering = true, 
	characterAngular = true, 
	characterAngularLimit = 10000, 
	consoleBans = false, 
	fakeTools = true, 
	bodyMovers = true, 
	toolGrip = true, 
	toolSize = true, 
	weldReplication = true, 
	walkspeed = false, 
	swimming = true, 
	fakeHumanoid = true, 
	suspiciousCAS = true, 
	hideDevConsole = false, 
	stackDetection = true, 
	passSpoofing = true, 
	groupSpoofing = false, 
	badgeSpoofing = true, 
	characterCollisions = true, 
	invisibleFling = true, 
	infiniteInvoke = true, 
	defaultInvokeTime = 30, 
	invokeGracePeriod = 30, 
	invokeGraceMultiplier = 3
};
