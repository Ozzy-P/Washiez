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
	local v7 = script:GetAttribute("Event");
	local v8 = script:GetAttribute("Function");
	if script.Parent.Name ~= "PlayerScripts" then
		script.Parent = l__LocalPlayer__3:WaitForChild("PlayerScripts");
	end;
	local l__ClientProtection__9 = script:WaitForChild("ClientProtection");
	l__ClientProtection__9:SetAttribute("Event", v7);
	l__ClientProtection__9:SetAttribute("Function", v8);
	l__ClientProtection__9:SetAttribute("ParentSafe", script:GetAttribute("ParentSafe") and false);
	l__ClientProtection__9.Disabled = false;
	l__ClientProtection__9:GetPropertyChangedSignal("Disabled"):Connect(function()
		if l__ClientProtection__9.Disabled == true then
			if not u4 then
				banMe("Tampering with the Anti-Exploit");
				l__LocalPlayer__3:Kick("Do not tamper with the Anti-Exploit");
				return;
			end;
		else
			return;
		end;
		warn("AE Kicking Player (Protector Tampering)");
	end);
	l__ClientProtection__9:GetPropertyChangedSignal("Parent"):Connect(function()
		if not l__ClientProtection__9:IsDescendantOf(l__LocalPlayer__3) and not l__ClientProtection__9:IsDescendantOf(game:GetService("ReplicatedFirst")) then
			if not u4 then
				banMe("Tampering with the Anti-Exploit");
				l__LocalPlayer__3:Kick("Do not tamper with the Anti-Exploit");
				return;
			end;
		else
			return;
		end;
		warn("AE Kicking Player (Protector Tampering 2)");
	end);
	script.Parent.DescendantRemoving:Connect(function(p2)
		if p2 == l__ClientProtection__9 then
			if not u4 then
				banMe("Tampering with the Anti-Exploit");
				l__LocalPlayer__3:Kick("Do not tamper with the Anti-Exploit");
				return;
			end;
		else
			return;
		end;
		warn("AE Kicking Player (Protector Tampering 3)");
	end);
	while not game:IsLoaded() do
		wait();	
	end;
	u6 = game:GetService("ReplicatedStorage"):WaitForChild(v7, 20);
	u2 = game:GetService("ReplicatedStorage"):WaitForChild(v8, 20);
	if not u6 or not u2 or not l__ClientProtection__9 then
		l__LocalPlayer__3:Kick("Anti-Exploit Initialization Failure - Please Rejoin");
		return;
	end;
	local u8 = nil;
	u8 = l__ClientProtection__9:GetAttributeChangedSignal("Ready"):Connect(function()
		if l__ClientProtection__9:GetAttribute("Ready") == true then
			script:SetAttribute("AEEvent", "");
			script:SetAttribute("AEFunction", "");
			u8:Disconnect();
		end;
	end);
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
local v10 = 0;
while not u7 or u7 == nil do
	wait(0.5);
	v10 = v10 + 1;
	if v10 >= 240 then
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
	local l__LocalPlayer__9 = game.Players.LocalPlayer;
	local v11, v12 = pcall(function()
		if l__LocalPlayer__9 then
			if l__LocalPlayer__9.Character then
				if l__LocalPlayer__9.Character:FindFirstChild("HumanoidRootPart") then
					local v13 = {};
					local v14, v15, v16 = pairs(l__LocalPlayer__9.Character:GetChildren());
					while true do
						local v17, v18 = v14(v15, v16);
						if v17 then

						else
							break;
						end;
						v16 = v17;
						if v18:IsA("Humanoid") then
							table.insert(v13, v18);
						end;					
					end;
					if not l__LocalPlayer__9.Character:FindFirstChild("Head") then
						if 1 < #v13 then
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
		local v19 = l__LocalPlayer__3.Character or l__LocalPlayer__3.CharacterAdded:Wait();
		while not v19:FindFirstChildWhichIsA("Humanoid") do
			wait();		
		end;
		local v20 = v19:FindFirstChildWhichIsA("Humanoid");
		checkFling();	
	end;
end);
local u10 = {};
local u11 = {};
function withCharacterAE()
	if u10.character == nil then
		u10.character = {};
	end;
	if u10.tools == nil then
		u10.tools = {};
	end;
	if u11.tools == nil then
		u11.tools = {};
	end;
	local v21, v22, v23 = pairs(u10.character);
	while true do
		local v24, v25 = v21(v22, v23);
		if v24 then

		else
			break;
		end;
		v23 = v24;
		v25:Disconnect();	
	end;
	local v26, v27, v28 = pairs(u10.tools);
	while true do
		local v29, v30 = v26(v27, v28);
		if v29 then

		else
			break;
		end;
		v28 = v29;
		v30:Disconnect();	
	end;
	local v31 = l__LocalPlayer__3.Character or l__LocalPlayer__3.CharacterAdded:Wait();
	while true do
		if not v31:FindFirstChildWhichIsA("Humanoid") then

		else
			break;
		end;
		wait();	
	end;
	local v32 = v31:FindFirstChildWhichIsA("Humanoid");
	local function u12(p5, p6, p7)
		if not p5:IsA("Tool") then
			return;
		end;
		if u7.toolGrip == true then
			if p6 == p5 then
				if p7 == "GripPos" then
					if not (10000000000 <= p5.GripPos.Y) then
						if p5.GripPos.Y <= -10000000000 then
							banMe("Punch Fling");
						end;
					else
						banMe("Punch Fling");
					end;
				end;
			end;
		end;
		if u7.toolSize == true then
			if p6.Name == "Handle" then
				if p7 == "Size" then
					p6.Anchored = true;
					if not u2:InvokeServer("MatchOnServer", {
						Object = p6, 
						Property = p7, 
						MatchTo = p6[p7]
					}) then
						banMe("Tool Size Exploit");
						return;
					end;
					p6.Anchored = false;
				end;
			end;
		end;
	end;
	u10.character.DescAdd = v31.DescendantAdded:Connect(function(p8)
		if u7.bodyMovers ~= true then
			return;
		end;
		if not p8:IsA("BodyMover") then
			if p8:IsA("BasePart") then
				if u2:InvokeServer("ExistsOnServer", p8) ~= true then
					p8:Destroy();
				end;
			end;
		elseif u2:InvokeServer("ExistsOnServer", p8) ~= true then
			p8:Destroy();
		end;
	end);
	local function u13(p9)
		if u11.tools[p9] then
			return;
		end;
		p9.Changed:Connect(function(p10)
			u12(p9, p9, p10);
		end);
		local v33, v34, v35 = pairs(p9:GetDescendants());
		while true do
			local v36, v37 = v33(v34, v35);
			if v36 then

			else
				break;
			end;
			v35 = v36;
			v37.Changed:Connect(function(p11)
				u12(p9, v37, p11);
			end);		
		end;
		u11.tools[p9] = true;
	end;
	u10.character.BPackChange = l__LocalPlayer__3:WaitForChild("Backpack").DescendantAdded:Connect(function(p12)
		if p12:IsA("Tool") then
			wait();
			if u2:InvokeServer("ExistsOnServer", p12) == false then
				if u7.fakeTools == true then
					p12:Destroy();
				end;
			end;
			u13(p12);
		end;
	end);
	u10.character.NoStatusWeld = v32:WaitForChild("Status").DescendantAdded:Connect(function(p13)
		if u7.weldReplication ~= true then
			return;
		end;
		if not p13:IsA("Weld") then
			if p13.Name == "RightGrip" then
				v32:WaitForChild("Status"):Destroy();
				banMe("Weld Replication Crash");
			end;
		else
			v32:WaitForChild("Status"):Destroy();
			banMe("Weld Replication Crash");
		end;
	end);
	u10.character.FakeHumanoid = v31.ChildRemoved:Connect(function(p14)
		if u7.fakeHumanoid ~= true then
			return;
		end;
		if p14:IsA("Humanoid") then
			wait(0.5);
			local v38 = v31:FindFirstChildWhichIsA("Humanoid");
			if v38 then
				if v38 ~= p14 then
					if u2:InvokeServer("ExistsOnServer", v38) == false then
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
	u10.character.Walkspeed = v32:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
		if u7.walkspeed ~= true then
			return;
		end;
		if u2:InvokeServer("MatchOnServer", {
			Object = v31.Humanoid, 
			Property = "WalkSpeed", 
			MatchTo = v32.WalkSpeed
		}) == false then
			l__LocalPlayer__3:Kick("\nAnti-Exploit:\nIllegal WalkSpeed");
		end;
	end);
	u10.character.Swimming = v32.StateChanged:Connect(function(p15, p16)
		if u7.swimming ~= true then
			return;
		end;
		if game:GetService("Workspace").Gravity < 1 then
			if p16 == Enum.HumanoidStateType.Swimming then
				l__LocalPlayer__3:Kick("\nAnti-Exploit:\nAir Swimming");
			end;
		end;
	end);
	local v39, v40, v41 = pairs(l__LocalPlayer__3:WaitForChild("Backpack"):GetChildren());
	while true do
		local v42, v43 = v39(v40, v41);
		if v42 then

		else
			break;
		end;
		v41 = v42;
		u13(v43);	
	end;
	local v44, v45, v46 = pairs(v31:GetChildren());
	while true do
		local v47, v48 = v44(v45, v46);
		if v47 then

		else
			break;
		end;
		v46 = v47;
		if v48:IsA("BasePart") then
			local u14 = 0;
			local u15 = tick();
			u10.character.CollideChange = v48:GetPropertyChangedSignal("CanCollide"):Connect(function()
				if checkFling() == false then
					if 0 < v32.Health then
						wait(1);
						if u7.characterCollisions ~= true then
							return;
						end;
						if not v48 then
							return;
						end;
						if u2:InvokeServer("MatchOnServer", {
							Object = v48, 
							Property = "CanCollide", 
							MatchTo = v48.CanCollide
						}) == false then
							l__LocalPlayer__3:Kick("\nAnti-Exploit:\nCharacter Collision Modifications");
							return;
						end;
						u14 = u14 + 1;
						if 100 <= u14 then
							if tick() - u15 <= 5 then
								l__LocalPlayer__3:Kick("\nAnti-Exploit:\nCharacter Collision Modifications (vCount Hundred Tick)");
							end;
							u15 = tick();
							u14 = 0;
						end;
					end;
				end;
			end);
			u10.character.CollisionChange = v48:GetPropertyChangedSignal("CollisionGroupId"):Connect(function()
				if checkFling() == false then
					if 0 < v32.Health then
						wait(1);
						if u7.characterCollisions ~= true then
							return;
						end;
						if not v48 then
							return;
						end;
						if u2:InvokeServer("MatchOnServer", {
							Object = v48, 
							Property = "CollisionGroupId", 
							MatchTo = v48.CollisionGroupId
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
	if u10.other == nil then
		u10.other = {};
	end;
	local v49, v50, v51 = pairs(u10.other);
	while true do
		local v52, v53 = v49(v50, v51);
		if v52 then

		else
			break;
		end;
		v51 = v52;
		v53:Disconnect();	
	end;
	u10.other.CASDescAdd = game:GetService("ContextActionService").DescendantAdded:Connect(function(p17)
		if u7.suspiciousCAS ~= true then
			return;
		end;
		if not p17:IsA("BasePart") then
			if not p17:IsA("Folder") then
				if p17:IsA("ValueBase") then
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
local u16 = coroutine.wrap(function()
	wait(3);
	local v54 = u2:InvokeServer("CheckAdmin");
	print("Client Is Admin:", tostring(v54));
	if v54 == false and u7.hideDevConsole == true then
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
	u16();
end);
l__LocalPlayer__3.CharacterAdded:Connect(function()
	wait();
	local function u17()
		local v55, v56 = pcall(function()
			withCharacterAE();
		end);
		if v56 then
			wait(1);
			warn("Anti-Exploit:", "Rerunning Character AE", v56);
			u17();
		end;
	end;
	u17();
end);
game:GetService("ReplicatedStorage").DescendantRemoving:Connect(function(p18)
	if p18 == u6 or p18 == u2 then
		if not u4 then
			l__LocalPlayer__3:Kick("Do not tamper with the Anti-Exploit");
			return;
		end;
	else
		return;
	end;
	warn("AE Kicking Player (Tampering Event)");
end);
local u18 = {};
spawn(function()
	u18 = u2:InvokeServer("GetConsoleBans") or {};
	while wait(60) do
		u18 = u2:InvokeServer("GetConsoleBans") or {};	
	end;
end);
l__LogService__3.MessageOut:Connect(function(p19, p20)
	if not u1 then
		for v57, v58 in pairs(u18) do
			if v57 and string.find(string.lower(p19), string.lower(v57), 1, true) ~= nil and not u1 then
				banMe(v58);
			end;
		end;
		if u7.stackDetection == true then
			local v59 = p19:match("^s*Script '(.*)', Line [0-9]+.*");
			if v59 and #v59 >= 5 then
				if not (function()
					for v60, v61 in pairs({ "%.", "^console", "^error" }) do
						if v59:match(v61) then
							return true;
						end;
					end;
				end)() then
					banMe(string.format("Illegal Error Stack: %s", v59));
				end;
			end;
		end;
	end;
end);
warn("Anti-Exploit:", "Fully Initialized Client");
