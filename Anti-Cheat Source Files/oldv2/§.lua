local l__RunService__1 = game:GetService("RunService");
local l__StarterGui__2 = game:GetService("StarterGui");
local l__LogService__3 = game:GetService("LogService");
local l__DefaultSettings__4 = script:FindFirstChild("DefaultSettings");
script.Name = "";
local u1 = false;
local u2 = nil;
local l__LocalPlayer__3 = game.Players.LocalPlayer;
local u4 = l__RunService__1:IsStudio();
function banMe(p1)
	if u1 then
		return;
	end;
	u1 = true;
	local u5 = p1;
	local v5, v6 = pcall(function()
		if u5 == nil then
			u5 = "Unspecified Reason";
		end;
		if u2:InvokeServer("BanMe", u5) ~= true then
			l__LocalPlayer__3:Kick("Communication Error");
		end;
	end);
	if v6 then
		if u4 then
			warn("AE Kicking Player: " .. u5);
		else
			l__LocalPlayer__3:Kick(u5);
		end;
	end;
end;
local u6 = nil;
local u7 = nil;
spawn(function()
	if script.Parent.Name ~= "PlayerScripts" then
		script.Parent = l__LocalPlayer__3:WaitForChild("PlayerScripts");
	end;
	local l__ClientProtection__7 = script:WaitForChild("ClientProtection");
	l__ClientProtection__7.Disabled = false;
	l__ClientProtection__7:GetPropertyChangedSignal("Disabled"):Connect(function()
		if l__ClientProtection__7.Disabled == true then
			if not u4 then
				banMe("Tampering with the Anti-Exploit");
				l__LocalPlayer__3:Kick("Do not tamper with the Anti-Exploit");
				return;
			end;
		else
			return;
		end;
		warn("AE Kicking Player");
	end);
	l__ClientProtection__7:GetPropertyChangedSignal("Parent"):Connect(function()
		if not l__ClientProtection__7:IsDescendantOf(l__LocalPlayer__3) and not l__ClientProtection__7:IsDescendantOf(game:GetService("ReplicatedFirst")) then
			if not u4 then
				banMe("Tampering with the Anti-Exploit");
				l__LocalPlayer__3:Kick("Do not tamper with the Anti-Exploit");
				return;
			end;
		else
			return;
		end;
		warn("AE Kicking Player");
	end);
	script.Parent.DescendantRemoving:Connect(function(p2)
		if p2 == l__ClientProtection__7 then
			if not u4 then
				banMe("Tampering with the Anti-Exploit");
				l__LocalPlayer__3:Kick("Do not tamper with the Anti-Exploit");
				return;
			end;
		else
			return;
		end;
		warn("AE Kicking Player");
	end);
	while not game:IsLoaded() do
		wait();	
	end;
	u6 = game:GetService("ReplicatedStorage"):WaitForChild("AEComEvent", 20);
	u2 = game:GetService("ReplicatedStorage"):WaitForChild("AEComFunc", 20);
	if not u6 or not u2 or not l__ClientProtection__7 then
		l__LocalPlayer__3:Kick("Anti-Exploit Initialization Failure - Please Rejoin");
		return;
	end;
	function u2.OnClientInvoke(p3, p4)
		if p3 ~= "ValidateConnection" then
			return;
		end;
		warn("Anti-Exploit: Server Requested Validation");
		return { (game.PlaceId - game.GameId) / p4, script, script.Name };
	end;
	u6:FireServer("ValidateConnection");
	u7 = u2:InvokeServer("GetSettings");
	if u7 and u4 and not u7.enabledInStudio then
		banMe("Running as studio when studio is not enabled");
	end;
end);
local v8 = 0;
while not u7 or u7 == nil do
	wait(0.5);
	v8 = v8 + 1;
	if v8 >= 240 then
		u7 = l__DefaultSettings__4 and require(l__DefaultSettings__4) or nil;
		warn("Attempted to load default settings (could not load from server)");
		break;
	end;
end;
_G.AEClientOffenses = _G.AEClientOffenses or {};
function checkFling()
	if u7.invisibleFling ~= true then
		return false;
	end;
	local l__LocalPlayer__8 = game.Players.LocalPlayer;
	local v9, v10 = pcall(function()
		if l__LocalPlayer__8 then
			if l__LocalPlayer__8.Character then
				if l__LocalPlayer__8.Character:FindFirstChild("HumanoidRootPart") then
					local v11 = {};
					local v12, v13, v14 = pairs(l__LocalPlayer__8.Character:GetChildren());
					while true do
						local v15, v16 = v12(v13, v14);
						if v15 then

						else
							break;
						end;
						v14 = v15;
						if v16:IsA("Humanoid") then
							table.insert(v11, v16);
						end;					
					end;
					if not l__LocalPlayer__8.Character:FindFirstChild("Head") then
						if 1 < #v11 then
							banMe("Invisible Flinging");
							return true;
						end;
					end;
				end;
			end;
		end;
	end);
	return false;
end;
spawn(function()
	while wait(4) do
		local v17 = l__LocalPlayer__3.Character or l__LocalPlayer__3.CharacterAdded:Wait();
		while not v17:FindFirstChildWhichIsA("Humanoid") do
			wait();		
		end;
		local v18 = v17:FindFirstChildWhichIsA("Humanoid");
		checkFling();	
	end;
end);
local u9 = {};
function withCharacterAE()
	if u9.character == nil then
		u9.character = {};
	end;
	if u9.tools == nil then
		u9.tools = {};
	end;
	local v19, v20, v21 = pairs(u9.character);
	while true do
		local v22, v23 = v19(v20, v21);
		if v22 then

		else
			break;
		end;
		v21 = v22;
		v23:Disconnect();	
	end;
	local v24, v25, v26 = pairs(u9.tools);
	while true do
		local v27, v28 = v24(v25, v26);
		if v27 then

		else
			break;
		end;
		v26 = v27;
		v28:Disconnect();	
	end;
	local v29 = l__LocalPlayer__3.Character or l__LocalPlayer__3.CharacterAdded:Wait();
	while true do
		if not v29:FindFirstChildWhichIsA("Humanoid") then

		else
			break;
		end;
		wait();	
	end;
	local v30 = v29:FindFirstChildWhichIsA("Humanoid");
	u9.character.DescAdd = v29.DescendantAdded:Connect(function(p5)
		if u7.bodyMovers ~= true then
			return;
		end;
		if not p5:IsA("BodyMover") then
			if p5:IsA("BasePart") then
				if u2:InvokeServer("ExistsOnServer", p5) ~= true then
					p5:Destroy();
				end;
			end;
		elseif u2:InvokeServer("ExistsOnServer", p5) ~= true then
			p5:Destroy();
		end;
	end);
	local function u10(p6)
		if u7.toolGrip ~= true then
			return;
		end;
		if p6:IsA("Tool") then
			if u9.tools[p6.Name] then
				u9.tools[p6.Name]:Disconnect();
			end;
			u9.tools[p6.Name] = p6.Changed:Connect(function()
				if not (10000000000 <= p6.GripPos.Y) then
					if p6.GripPos.Y <= -10000000000 then
						banMe("Punch Fling");
					end;
				else
					banMe("Punch Fling");
				end;
			end);
		end;
	end;
	u9.character.BPackChange = l__LocalPlayer__3:WaitForChild("Backpack").DescendantAdded:Connect(function(p7)
		if p7:IsA("Tool") then
			wait();
			if u2:InvokeServer("ExistsOnServer", p7) == false then
				if u7.fakeTools == true then
					p7:Destroy();
				end;
			end;
			u10(p7);
		end;
	end);
	u9.character.NoStatusWeld = v30:WaitForChild("Status").DescendantAdded:Connect(function(p8)
		if u7.weldReplication ~= true then
			return;
		end;
		if not p8:IsA("Weld") then
			if p8.Name == "RightGrip" then
				v30:WaitForChild("Status"):Destroy();
				banMe("Weld Replication Crash");
			end;
		else
			v30:WaitForChild("Status"):Destroy();
			banMe("Weld Replication Crash");
		end;
	end);
	u9.character.FakeHumanoid = v29.ChildRemoved:Connect(function(p9)
		if u7.fakeHumanoid ~= true then
			return;
		end;
		if p9:IsA("Humanoid") then
			wait(0.5);
			local v31 = v29:FindFirstChildWhichIsA("Humanoid");
			if v31 then
				if v31 ~= p9 then
					if u2:InvokeServer("ExistsOnServer", v31) == false then
						l__LocalPlayer__3:Kick("\nAnti-Exploit:\nFake Humanoid");
					end;
				end;
			end;
		end;
	end);
	if u2:InvokeServer("CheckAdmin") then
		print("Disabling Character AE (Admin)");
		return;
	end;
	u9.character.Walkspeed = v30:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
		if u7.walkspeed ~= true then
			return;
		end;
		if u2:InvokeServer("MatchOnServer", {
			Object = v29.Humanoid, 
			Property = "WalkSpeed", 
			MatchTo = v30.WalkSpeed
		}) == false then
			l__LocalPlayer__3:Kick("\nAnti-Exploit:\nIllegal WalkSpeed");
		end;
	end);
	u9.character.Swimming = v30.StateChanged:Connect(function(p10, p11)
		if u7.swimming ~= true then
			return;
		end;
		if game:GetService("Workspace").Gravity < 1 then
			if p11 == Enum.HumanoidStateType.Swimming then
				l__LocalPlayer__3:Kick("\nAnti-Exploit:\nAir Swimming");
			end;
		end;
	end);
	local v32, v33, v34 = pairs(l__LocalPlayer__3:WaitForChild("Backpack"):GetChildren());
	while true do
		local v35, v36 = v32(v33, v34);
		if v35 then

		else
			break;
		end;
		v34 = v35;
		u10(v36);	
	end;
	local v37, v38, v39 = pairs(v29:GetChildren());
	while true do
		local v40, v41 = v37(v38, v39);
		if v40 then

		else
			break;
		end;
		v39 = v40;
		if v41:IsA("BasePart") then
			local u11 = 0;
			local u12 = tick();
			u9.character.CollideChange = v41:GetPropertyChangedSignal("CanCollide"):Connect(function()
				if checkFling() == false then
					if 0 < v30.Health then
						wait(1);
						if u7.characterCollisions ~= true then
							return;
						end;
						if not v41 then
							return;
						end;
						if u2:InvokeServer("MatchOnServer", {
							Object = v41, 
							Property = "CanCollide", 
							MatchTo = v41.CanCollide
						}) == false then
							l__LocalPlayer__3:Kick("\nAnti-Exploit:\nCharacter Collision Modifications");
							return;
						end;
						u11 = u11 + 1;
						if 100 <= u11 then
							if tick() - u12 <= 5 then
								l__LocalPlayer__3:Kick("\nAnti-Exploit:\nCharacter Collision Modifications (vCount Hundred Tick)");
							end;
							u12 = tick();
							u11 = 0;
						end;
					end;
				end;
			end);
			u9.character.CollisionChange = v41:GetPropertyChangedSignal("CollisionGroupId"):Connect(function()
				if checkFling() == false then
					if 0 < v30.Health then
						wait(1);
						if u7.characterCollisions ~= true then
							return;
						end;
						if not v41 then
							return;
						end;
						if u2:InvokeServer("MatchOnServer", {
							Object = v41, 
							Property = "CollisionGroupId", 
							MatchTo = v41.CollisionGroupId
						}) == false then
							l__LocalPlayer__3:Kick("Character Collision Modifications");
						end;
					end;
				end;
			end);
		end;	
	end;
end;
function otherAE()
	if u9.other == nil then
		u9.other = {};
	end;
	local v42, v43, v44 = pairs(u9.other);
	while true do
		local v45, v46 = v42(v43, v44);
		if v45 then

		else
			break;
		end;
		v44 = v45;
		v46:Disconnect();	
	end;
	u9.other.CASDescAdd = game:GetService("ContextActionService").DescendantAdded:Connect(function(p12)
		if u7.suspiciousCAS ~= true then
			return;
		end;
		if not p12:IsA("BasePart") then
			if not p12:IsA("Folder") then
				if p12:IsA("ValueBase") then
					banMe("Suspicious CAS Activity");
				end;
			else
				banMe("Suspicious CAS Activity");
			end;
		else
			banMe("Suspicious CAS Activity");
		end;
	end);
	if u7.passSpoofing then
		if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(l__LocalPlayer__3.UserId, math.random(1, 100000)) == true then
			banMe("Gamepass Ownership Spoofing");
		end;
	end;
	if u7.groupSpoofing then
		if not (0 < l__LocalPlayer__3:GetRankInGroup(9999999999)) then
			if l__LocalPlayer__3:IsInGroup(99999999999) then
				banMe("Group Rank Spoofing");
			end;
		else
			banMe("Group Rank Spoofing");
		end;
	end;
	if u7.badgeSpoofing then
		if game:GetService("BadgeService"):UserHasBadgeAsync(l__LocalPlayer__3.UserId, 9999999999) then
			banMe("Badge Ownership Spoofing");
		end;
	end;
end;
local u13 = coroutine.wrap(function()
	wait(3);
	if u2:InvokeServer("CheckAdmin") == false and u7.hideDevConsole == true then
		l__RunService__1.Heartbeat:Connect(function()
			pcall(function()
				l__StarterGui__2:SetCore("DevConsoleVisible", false);
			end);
		end);
	end;
end);
pcall(function()
	withCharacterAE();
	otherAE();
	u13();
end);
l__LocalPlayer__3.CharacterAdded:Connect(function()
	wait();
	local function u14()
		local v47, v48 = pcall(function()
			withCharacterAE();
		end);
		if v48 then
			wait(1);
			warn("Anti-Exploit:", "Rerunning Character AE", v48);
			u14();
		end;
	end;
	u14();
end);
game:GetService("ReplicatedStorage").DescendantRemoving:Connect(function(p13)
	if p13 == u6 or p13 == u2 then
		banMe("Tampering with the Anti-Exploit");
	end;
end);
local u15 = {};
spawn(function()
	u15 = u2:InvokeServer("GetConsoleBans") or {};
	while wait(60) do
		u15 = u2:InvokeServer("GetConsoleBans") or {};	
	end;
end);
l__LogService__3.MessageOut:Connect(function(p14, p15)
	if not u1 then
		for v49, v50 in pairs(u15) do
			if v50 and v50.name and string.find(string.lower(p14), string.lower(v50.name), 1, true) ~= nil and not u1 then
				banMe(v50.desc);
			end;
		end;
		if u7.stackDetection == true then
			local v51 = p14:match("^s*Script '(.*)', Line [0-9]+.*");
			if v51 and #v51 >= 5 then
				if not (function()
					for v52, v53 in pairs({ "%.", "^console", "^error" }) do
						if v51:match(v53) then
							return true;
						end;
					end;
				end)() then
					banMe(string.format("Illegal Error Stack: %s", v51));
				end;
			end;
		end;
	end;
end);
warn("Anti-Exploit:", "Fully Initialized Client");
