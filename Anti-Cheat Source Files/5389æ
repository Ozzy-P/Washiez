
local l__StarterGui__1 = game:GetService("StarterGui");
local l__LogService__2 = game:GetService("LogService");
script.Name = "go away";
local u1 = false;
local u2 = nil;
local l__LocalPlayer__3 = game.Players.LocalPlayer;
local l__RunService__4 = game:GetService("RunService");
function banMe(p1)
	if u1 then
		return;
	end;
	u1 = true;
	local u5 = p1;
	local v3, v4 = pcall(function()
		if u5 == nil then
			u5 = "Unspecified Reason";
		end;
		if u2:InvokeServer("BanMe", u5) ~= true then
			l__LocalPlayer__3:Kick("Communication Error");
		end;
	end);
	if v4 then
		if l__RunService__4:IsStudio() then
			warn("AE Kicking Player");
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
	local l__ClientProtection__5 = script:WaitForChild("ClientProtection");
	l__ClientProtection__5.Disabled = false;
	l__ClientProtection__5:GetPropertyChangedSignal("Disabled"):Connect(function()
		if l__ClientProtection__5.Disabled == true then
			if not l__RunService__4:IsStudio() then
				banMe("Tampering with the Anti-Exploit");
				l__LocalPlayer__3:Kick("Do not tamper with the Anti-Exploit");
				return;
			end;
		else
			return;
		end;
		warn("AE Kicking Player");
	end);
	l__ClientProtection__5:GetPropertyChangedSignal("Parent"):Connect(function()
		if not l__ClientProtection__5:IsDescendantOf(l__LocalPlayer__3) and not l__ClientProtection__5:IsDescendantOf(game:GetService("ReplicatedFirst")) then
			if not l__RunService__4:IsStudio() then
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
		if p2 == l__ClientProtection__5 then
			if not l__RunService__4:IsStudio() then
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
	if not u6 or not u2 or not l__ClientProtection__5 then
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
end);
while not u7 or u7 == nil do
	wait();
end;
_G.AEClientOffenses = _G.AEClientOffenses or {};
function checkFling()
	if u7.invisibleFling ~= true then
		return false;
	end;
	local l__LocalPlayer__8 = game.Players.LocalPlayer;
	local v6, v7 = pcall(function()
		if l__LocalPlayer__8 then
			if l__LocalPlayer__8.Character then
				if l__LocalPlayer__8.Character:FindFirstChild("HumanoidRootPart") then
					local v8 = {};
					local v9, v10, v11 = pairs(l__LocalPlayer__8.Character:GetChildren());
					while true do
						local v12, v13 = v9(v10, v11);
						if v12 then

						else
							break;
						end;
						v11 = v12;
						if v13:IsA("Humanoid") then
							table.insert(v8, #v8 + 1, v13);
						end;					
					end;
					if not l__LocalPlayer__8.Character:FindFirstChild("Head") then
						if 1 < #v8 then
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
		local v14 = l__LocalPlayer__3.Character or l__LocalPlayer__3.CharacterAdded:Wait();
		while not v14:FindFirstChildWhichIsA("Humanoid") do
			wait();		
		end;
		local v15 = v14:FindFirstChildWhichIsA("Humanoid");
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
	local v16, v17, v18 = pairs(u9.character);
	while true do
		local v19, v20 = v16(v17, v18);
		if v19 then

		else
			break;
		end;
		v18 = v19;
		v20:Disconnect();	
	end;
	local v21, v22, v23 = pairs(u9.tools);
	while true do
		local v24, v25 = v21(v22, v23);
		if v24 then

		else
			break;
		end;
		v23 = v24;
		v25:Disconnect();	
	end;
	if u2:InvokeServer("CheckAdmin") then
		print("Disabling Character AE (Admin)");
		return;
	end;
	local v26 = l__LocalPlayer__3.Character or l__LocalPlayer__3.CharacterAdded:Wait();
	while true do
		if not v26:FindFirstChildWhichIsA("Humanoid") then

		else
			break;
		end;
		wait();	
	end;
	local v27 = v26:FindFirstChildWhichIsA("Humanoid");
	u9.character.DescAdd = v26.DescendantAdded:Connect(function(p5)
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
	u9.character.NoStatusWeld = v27:WaitForChild("Status").DescendantAdded:Connect(function(p6)
		if u7.weldReplication ~= true then
			return;
		end;
		if not p6:IsA("Weld") then
			if p6.Name == "RightGrip" then
				v27:WaitForChild("Status"):Destroy();
				banMe("Weld Replication Crash");
			end;
		else
			v27:WaitForChild("Status"):Destroy();
			banMe("Weld Replication Crash");
		end;
	end);
	local function u10(p7)
		if u7.toolGrip ~= true then
			return;
		end;
		if p7:IsA("Tool") then
			if u9.tools[p7.Name] then
				u9.tools[p7.Name]:Disconnect();
			end;
			u9.tools[p7.Name] = p7.Changed:Connect(function()
				if not (10000000000 <= p7.GripPos.Y) then
					if p7.GripPos.Y <= -10000000000 then
						banMe("Punch Fling");
					end;
				else
					banMe("Punch Fling");
				end;
			end);
		end;
	end;
	u9.character.BPackChange = l__LocalPlayer__3:WaitForChild("Backpack").DescendantAdded:Connect(function(p8)
		if p8:IsA("Tool") then
			wait();
			if u2:InvokeServer("ExistsOnServer", p8) == false then
				if u7.fakeTools == true then
					p8:Destroy();
				end;
			end;
			u10(p8);
		end;
	end);
	u9.character.Walkspeed = v27:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
		if u7.walkspeed ~= true then
			return;
		end;
		if u2:InvokeServer("MatchOnServer", {
			Object = v26.Humanoid, 
			Property = "WalkSpeed", 
			MatchTo = v27.WalkSpeed
		}) == false then
			l__LocalPlayer__3:Kick("\nAnti-Exploit:\nIllegal WalkSpeed");
		end;
	end);
	u9.character.Swimming = v27.StateChanged:Connect(function(p9, p10)
		if u7.swimming ~= true then
			return;
		end;
		if game:GetService("Workspace").Gravity < 1 then
			if p10 == Enum.HumanoidStateType.Swimming then
				l__LocalPlayer__3:Kick("\nAnti-Exploit:\nAir Swimming");
			end;
		end;
	end);
	u9.character.FakeHumanoid = v26.ChildRemoved:Connect(function(p11)
		if u7.fakeHumanoid ~= true then
			return;
		end;
		if p11:IsA("Humanoid") then
			wait(0.5);
			local v28 = v26:FindFirstChildWhichIsA("Humanoid");
			if v28 then
				if v28 ~= p11 then
					if u2:InvokeServer("ExistsOnServer", v28) == false then
						l__LocalPlayer__3:Kick("\nAnti-Exploit:\nFake Humanoid");
					end;
				end;
			end;
		end;
	end);
	local v29, v30, v31 = pairs(l__LocalPlayer__3:WaitForChild("Backpack"):GetChildren());
	while true do
		local v32, v33 = v29(v30, v31);
		if v32 then

		else
			break;
		end;
		v31 = v32;
		u10(v33);	
	end;
	local v34, v35, v36 = pairs(v26:GetChildren());
	while true do
		local v37, v38 = v34(v35, v36);
		if v37 then

		else
			break;
		end;
		v36 = v37;
		if v38:IsA("BasePart") then
			local u11 = 0;
			local u12 = tick();
			u9.character.CollideChange = v38:GetPropertyChangedSignal("CanCollide"):Connect(function()
				if checkFling() == false then
					if 0 < v27.Health then
						wait(1);
						if u7.characterCollisions ~= true then
							return;
						end;
						if not v38 then
							return;
						end;
						if u2:InvokeServer("MatchOnServer", {
							Object = v38, 
							Property = "CanCollide", 
							MatchTo = v38.CanCollide
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
			u9.character.CollisionChange = v38:GetPropertyChangedSignal("CollisionGroupId"):Connect(function()
				if checkFling() == false then
					if 0 < v27.Health then
						wait(1);
						if u7.characterCollisions ~= true then
							return;
						end;
						if not v38 then
							return;
						end;
						if u2:InvokeServer("MatchOnServer", {
							Object = v38, 
							Property = "CollisionGroupId", 
							MatchTo = v38.CollisionGroupId
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
	local v39, v40, v41 = pairs(u9.other);
	while true do
		local v42, v43 = v39(v40, v41);
		if v42 then

		else
			break;
		end;
		v41 = v42;
		v43:Disconnect();	
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
		l__RunService__4.Heartbeat:Connect(function()
			pcall(function()
				l__StarterGui__1:SetCore("DevConsoleVisible", false);
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
		local v44, v45 = pcall(function()
			withCharacterAE();
		end);
		if v45 then
			wait(1);
			warn("Anti-Exploit:", "Rerunning Character AE", v45);
			u14();
		end;
	end;
	u14();
end);
game:GetService("ReplicatedStorage").DescendantRemoving:Connect(function(p13)
	if p13 == u6 or p13 == u2 then
		banMe("Tampering with the Anti-Exploit");
		wait();
		if not l__RunService__4:IsStudio() then
			l__LocalPlayer__3:Kick("Do not tamper with the Anti-Exploit");
			return;
		end;
	else
		return;
	end;
	warn("AE Kicking Player");
end);
local u15 = {};
spawn(function()
	u15 = u2:InvokeServer("GetConsoleBans") or {};
	while wait(60) do
		u15 = u2:InvokeServer("GetConsoleBans") or {};	
	end;
end);
l__LogService__2.MessageOut:Connect(function(p14, p15)
	if not u1 then
		for v46, v47 in pairs(u15) do
			if v47 and v47.name and string.find(string.lower(p14), string.lower(v47.name), 1, true) ~= nil and not u1 then
				banMe(v47.desc);
			end;
		end;
		if u7.stackDetection == true then
			local v48 = p14:match("^s*Script '(.*)', Line [0-9]+.*");
			if v48 then
				if not (function()
					for v49, v50 in pairs({ "%.", "^console", "^error" }) do
						if v48:match(v50) then
							return true;
						end;
					end;
				end)() then
					banMe(string.format("Illegal Error Stack: %s", v48));
				end;
			end;
		end;
	end;
end);
warn("Anti-Exploit:", "Fully Initialized Client");

