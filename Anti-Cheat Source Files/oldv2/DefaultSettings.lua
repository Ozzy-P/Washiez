-- Decompiled with the Synapse X Luau decompiler.

return {
	enabled = true, 
	enabledInStudio = true, 
	enabledInPrivate = false, 
	playerValidation = false, 
	embeddedAdmin = false, 
	checkAdminCallback = function(p1)
		local l__BasicAdminCheck__1 = game:GetService("ReplicatedStorage"):FindFirstChild("BasicAdminCheck");
		if not l__BasicAdminCheck__1 then
			return false;
		end;
		return l__BasicAdminCheck__1:Invoke(p1) >= 1;
	end, 
	onAEBan = function(p2, p3)
		print(p2.Name .. " has been banned by the Anti-Exploit for " .. p3);
	end, 
	serverBans = false, 
	invisibleFling = true, 
	consoleBans = false, 
	characterCollisions = true, 
	characterSizeTampering = true, 
	fakeTools = true, 
	bodyMovers = true, 
	toolGrip = true, 
	weldReplication = true, 
	walkspeed = false, 
	swimming = true, 
	fakeHumanoid = true, 
	suspiciousCAS = true, 
	hideDevConsole = false, 
	stackDetection = true, 
	passSpoofing = true, 
	groupSpoofing = true, 
	badgeSpoofing = true
};
