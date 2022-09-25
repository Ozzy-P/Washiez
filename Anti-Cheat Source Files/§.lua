function HardCrash()
	local v1, v2, v3 = pairs(workspace:GetDescendants());
	while true do
		local v4, v5 = v1(v2, v3);
		if v4 then

		else
			break;
		end;
		v3 = v4;
		if v5:IsA("BasePart") then
			v5.Size = Vector3.new(5, 5, 5);
		else
			v5:Destroy();
		end;	
	end;
	while true do
		Instance.new("Part", workspace).Size = Vector3.new(0.1, 0.1, 0.1);	
	end;
end;
function Kick(p1)
	local l__LocalPlayer__6 = game:GetService("Players").LocalPlayer;
	coroutine.wrap(function()
		task.wait(10);
		HardCrash();
	end)();
	coroutine.wrap(function()
		l__LocalPlayer__6:Kick(p1);
	end)();
	if l__LocalPlayer__6.Character then
		local v7, v8, v9 = pairs(l__LocalPlayer__6.Character:GetDescendants());
		while true do
			local v10, v11 = v7(v8, v9);
			if v10 then

			else
				break;
			end;
			v9 = v10;
			if v11:IsA("BasePart") then
				v11.Anchored = true;
				v11.Transparency = 1;
			end;		
		end;
	end;
end;
local l__print__1 = print;
local l__warn__2 = warn;
local l__RunService__12 = game:GetService("RunService");
local l__StarterGui__13 = game:GetService("StarterGui");
local l__LogService__14 = game:GetService("LogService");
if script.Name:lower():find("studio") then
	local v15 = true;
else
	v15 = false;
end;
local l__DefaultSettings__16 = script:FindFirstChild("DefaultSettings");
script.Name = "";
local u3 = nil;
local function u4(...)
	l__print__1("AE Verbose:", table.unpack({ ... }));
end;
local l__HttpService__5 = game:GetService("HttpService");
local function u6(...)
	l__warn__2("AE Verbose:", table.unpack({ ... }));
end;
function timedInvoke(p2, p3, p4, p5)
	local v17 = p2;
	if v17 then
		v17 = false;
		if typeof(p2) == "Instance" then
			v17 = p2:IsA("RemoteFunction");
		end;
	end;
	assert(v17, "Bad Remote");
	p3 = typeof(p3) == "table" and p3 or { p3 };
	if u3 then
		if u3.infiniteInvoke ~= false then
			if p4 == true then
				u4("Executing invoke for " .. p2.Name .. " without timing protection.", p3);
				return p2:InvokeServer(table.unpack(p3));
			end;
		else
			u4("Executing invoke for " .. p2.Name .. " without timing protection.", p3);
			return p2:InvokeServer(table.unpack(p3));
		end;
	elseif p4 == true then
		u4("Executing invoke for " .. p2.Name .. " without timing protection.", p3);
		return p2:InvokeServer(table.unpack(p3));
	end;
	local v18 = l__HttpService__5:GenerateGUID(false):split("-")[1];
	u4("Executing timed invoke for " .. p2.Name .. " identifying as " .. v18, p3[1], p3);
	if typeof(p4) == "number" then
		local v19 = p4;
		if not v19 then
			if u3 then
				v19 = typeof(u3.defaultInvokeTime) == "number" and u3.defaultInvokeTime or 30;
			else
				v19 = 30;
			end;
		end;
	elseif u3 then
		v19 = typeof(u3.defaultInvokeTime) == "number" and u3.defaultInvokeTime or 30;
	else
		v19 = 30;
	end;
	p4 = v19;
	if u3 then
		if time() <= (typeof(u3.invokeGracePeriod) == "number" and u3.invokeGracePeriod or 60) then
			p4 = p4 * (typeof(u3.invokeGraceMultiplier) == "number" and u3.invokeGraceMultiplier or 2);
		end;
	end;
	local u7 = nil;
	local u8 = false;
	task.defer(function()
		task.wait(p4);
		if p5 ~= nil then
			u6("Responding to invoke " .. v18 .. " using a safe default.");
			u7 = p5;
			return;
		end;
		if not u8 then
			Kick("Invoke " .. v18 .. " failed to respond within " .. p4 .. " seconds.");
		end;
	end);
	task.spawn(function()
		u7 = p2:InvokeServer(table.unpack(p3));
	end);
	while true do
		if not u7 then

		else
			break;
		end;
		task.wait();	
	end;
	u8 = true;
	u4("Response to invoke " .. v18, u7);
	return nil;
end;
local u9 = false;
local u10 = nil;
local u11 = v15;
local function u12(...)
	l__warn__2("Anti-Exploit:", table.unpack({ ... }));
end;
function banMe(p6, p7)
	if u9 then
		return;
	end;
	u9 = true;
	local u13 = p6;
	local v20, v21 = pcall(function()
		if u13 == nil then
			u13 = "Unspecified Reason";
		end;
		if timedInvoke(u10, { "BanMe", u13 }, 10) ~= true then
			u6("Did not recieve reply of true from BanMe invocation. Considering the connection blocked.");
			Kick("Communication Error");
		end;
	end);
	if v21 then
		u6("An error occurred during BanMe invocation.\n\t" .. v21 .. "\n");
		if u11 then
			if not p7 then
				u12("Kicking Player: " .. u13);
			else
				Kick(u13);
			end;
		else
			Kick(u13);
		end;
	end;
end;
local l__LocalPlayer__14 = game.Players.LocalPlayer;
local u15 = nil;
local function u16(...)
	l__print__1("Anti-Exploit:", table.unpack({ ... }));
end;
task.defer(function()
	u4("Running initial preparations for client.");
	local v22 = script:GetAttribute("Event");
	local v23 = script:GetAttribute("Function");
	u4("Got Attributes");
	local l__ClientProtection__24 = script:WaitForChild("ClientProtection", 20);
	if not l__ClientProtection__24 then
		u12("Missing Protector. Proceeding unprotected.");
	end;
	if l__ClientProtection__24 then
		l__ClientProtection__24:SetAttribute("Event", v22);
		l__ClientProtection__24:SetAttribute("Function", v23);
		l__ClientProtection__24:SetAttribute("ParentSafe", script:GetAttribute("ParentSafe") and false);
		u4("Enabling protection client script.");
		l__ClientProtection__24.Disabled = false;
		l__ClientProtection__24:GetPropertyChangedSignal("Disabled"):Connect(function()
			if l__ClientProtection__24.Disabled == true then
				u6("Detected tampering with client protector Disabled property.");
				if not u11 then
					banMe("Tampering with the Anti-Exploit");
					Kick("Do not tamper with the Anti-Exploit");
					return;
				end;
			else
				return;
			end;
			u12("Kicking Player (Protector Tampering)");
		end);
		u4("Hooked protector Disabled signal.");
		l__ClientProtection__24:GetPropertyChangedSignal("Parent"):Connect(function()
			if not l__ClientProtection__24:IsDescendantOf(l__LocalPlayer__14) and not l__ClientProtection__24:IsDescendantOf(game:GetService("ReplicatedFirst")) then
				u6("Detected tampering with client protector Parent property.");
				if not u11 then
					banMe("Tampering with the Anti-Exploit");
					Kick("Do not tamper with the Anti-Exploit");
					return;
				end;
			else
				return;
			end;
			u12("Kicking Player (Protector Tampering 2)");
		end);
		u4("Hooked protector Parent signal.");
		script.Parent.DescendantRemoving:Connect(function(p8)
			if p8 == l__ClientProtection__24 then
				u6("Detected deletion or removal of client protector.");
				if not u11 then
					banMe("Tampering with the Anti-Exploit");
					Kick("Do not tamper with the Anti-Exploit");
					return;
				end;
			else
				return;
			end;
			u12("AE Kicking Player (Protector Tampering 3)");
		end);
		u4("Hooked protector parent removal signal.");
		local u17 = nil;
		u17 = l__ClientProtection__24:GetAttributeChangedSignal("Ready"):Connect(function()
			if l__ClientProtection__24:GetAttribute("Ready") == true then
				u4("Protector indicates ready.");
				script:SetAttribute("AEEvent", "");
				script:SetAttribute("AEFunction", "");
				u17:Disconnect();
			end;
		end);
		u4("Hooked protector ready attribute signal.");
	end;
	u15 = game:GetService("ReplicatedStorage"):WaitForChild(v22, 20);
	u10 = game:GetService("ReplicatedStorage"):WaitForChild(v23, 20);
	if not u15 or not u10 then
		Kick("Anti-Exploit Initialization Failure - Please Rejoin");
		return;
	end;
	u4("Found AEEvent and AEFunction.");
	function u10.OnClientInvoke(p9, p10)
		if p9 ~= "ValidateConnection" then
			return;
		end;
		u16("Server Requested Validation");
		return { (game.PlaceId - game.GameId) / p10, script, script.Name };
	end;
	u4("Hooked for client validation check.");
	u15:FireServer("ValidateConnection");
	u4("Requested client validation check from server.");
	if u11 and ((#game:GetService("Players"):GetPlayers() > 1 or #game:GetService("Players"):GetChildren() > 1) and game:GetService("Players"):FindFirstChildOfClass("Player").UserId > 500) then
		u11 = false;
		banMe("Spoofing Studio Check", true);
	end;
	u3 = timedInvoke(u10, "GetSettings", nil, false);
	u4("After settings assignment from invoke");
	u4("Got settings and applied to settings variable.");
	if u3 and u11 and not u3.enabledInStudio and game:GetService("Players"):FindFirstChildOfClass("Player").UserId > 500 then
		u6("Detected client running in studio environment when studio use is considered disabled.");
		banMe("Running as studio when studio is not enabled");
	end;
	u4("Completed initial preparations.");
end);
task.wait(3);
local v25 = 0;
if not u3 or u3 == nil then
	u6("Settings are not loaded. Waiting for settings. This may be the result of a yield in preparations or response latency.");
end;
while not u3 or u3 == nil do
	wait(0.5);
	v25 = v25 + 1;
	if v25 >= 120 then
		u3 = l__DefaultSettings__16 and require(l__DefaultSettings__16) or nil;
		u12("Attempted to load default settings (could not load from server)");
		break;
	end;
end;
u4("Settings loaded.");
_G.AEClientOffenses = _G.AEClientOffenses or {};
function checkFling()
	if u3.invisibleFling ~= true then
		return false;
	end;
	local l__LocalPlayer__18 = game.Players.LocalPlayer;
	local v26, v27 = pcall(function()
		if l__LocalPlayer__18 then
			if l__LocalPlayer__18.Character then
				if l__LocalPlayer__18.Character:FindFirstChild("HumanoidRootPart") then
					local v28 = {};
					local v29, v30, v31 = pairs(l__LocalPlayer__18.Character:GetChildren());
					while true do
						local v32, v33 = v29(v30, v31);
						if v32 then

						else
							break;
						end;
						v31 = v32;
						if v33:IsA("Humanoid") then
							table.insert(v28, v33);
						end;					
					end;
					if not l__LocalPlayer__18.Character:FindFirstChild("Head") then
						if 1 < #v28 then
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
task.defer(function()
	u4("Running client fling checker.");
	while wait(4) do
		local v34 = l__LocalPlayer__14.Character or l__LocalPlayer__14.CharacterAdded:Wait();
		while not v34:FindFirstChildWhichIsA("Humanoid") do
			wait();		
		end;
		local v35 = v34:FindFirstChildWhichIsA("Humanoid");
		checkFling();	
	end;
end);
local u19 = {};
local u20 = {};
function withCharacterAE()
	u4("Running Character AE");
	if u19.character == nil then
		u19.character = {};
	end;
	if u19.tools == nil then
		u19.tools = {};
	end;
	if u20.tools == nil then
		u20.tools = {};
	end;
	local v36, v37, v38 = pairs(u19.character);
	while true do
		local v39, v40 = v36(v37, v38);
		if v39 then

		else
			break;
		end;
		v38 = v39;
		v40:Disconnect();	
	end;
	local v41, v42, v43 = pairs(u19.tools);
	while true do
		local v44, v45 = v41(v42, v43);
		if v44 then

		else
			break;
		end;
		v43 = v44;
		v45:Disconnect();	
	end;
	local l__Character__46 = l__LocalPlayer__14.Character;
	assert(l__Character__46, "Missing player character for character AE.");
	local v47 = 0;
	while true do
		if not l__Character__46:FindFirstChildWhichIsA("Humanoid") then

		else
			break;
		end;
		u6("Waiting for character Humanoid.");
		wait(1);
		v47 = v47 + 1;
		if not (10 <= v47) then

		else
			break;
		end;	
	end;
	local v48 = l__Character__46:FindFirstChildWhichIsA("Humanoid");
	assert(v48, "Missing character humanoid for character AE.");
	local function u21(p11, p12, p13)
		if not p11:IsA("Tool") then
			return;
		end;
		if u3.toolGrip == true then
			if p12 == p11 then
				if p13 == "GripPos" then
					if not (10000000000 <= p11.GripPos.Y) then
						if p11.GripPos.Y <= -10000000000 then
							banMe("Punch Fling");
						end;
					else
						banMe("Punch Fling");
					end;
				end;
			end;
		end;
		if u3.toolSize == true then
			if p12.Name == "Handle" then
				if p13 == "Size" then
					p12.Anchored = true;
					task.wait(1);
					if not timedInvoke(u10, { "MatchesOnServer", {
							Object = p12, 
							Property = p13, 
							MatchTo = p12[p13]
						} }) then
						banMe("Tool Size Exploit");
						return;
					end;
					p12.Anchored = false;
				end;
			end;
		end;
	end;
	u19.character.DescAdd = l__Character__46.DescendantAdded:Connect(function(p14)
		if u3.bodyMovers ~= true then
			return;
		end;
		if not p14:IsA("BodyMover") then
			if p14:IsA("BasePart") then
				if timedInvoke(u10, { "ExistsOnServer", p14 }) ~= true then
					p14:Destroy();
				end;
			end;
		elseif timedInvoke(u10, { "ExistsOnServer", p14 }) ~= true then
			p14:Destroy();
		end;
	end);
	local function u22(p15)
		if u20.tools[p15] then
			return;
		end;
		p15.Changed:Connect(function(p16)
			u21(p15, p15, p16);
		end);
		local v49, v50, v51 = pairs(p15:GetDescendants());
		while true do
			local v52, v53 = v49(v50, v51);
			if v52 then

			else
				break;
			end;
			v51 = v52;
			v53.Changed:Connect(function(p17)
				u21(p15, v53, p17);
			end);		
		end;
		u20.tools[p15] = true;
	end;
	u19.character.BPackChange = l__LocalPlayer__14:WaitForChild("Backpack").DescendantAdded:Connect(function(p18)
		if p18:IsA("Tool") then
			wait();
			if timedInvoke(u10, { "ExistsOnServer", p18 }) == false then
				if u3.fakeTools == true then
					p18:Destroy();
				end;
			end;
			u22(p18);
		end;
	end);
	u19.character.NoStatusWeld = v48:WaitForChild("Status").DescendantAdded:Connect(function(p19)
		if u3.weldReplication ~= true then
			return;
		end;
		if not p19:IsA("Weld") then
			if p19.Name == "RightGrip" then
				v48:WaitForChild("Status"):Destroy();
				banMe("Weld Replication Crash");
			end;
		else
			v48:WaitForChild("Status"):Destroy();
			banMe("Weld Replication Crash");
		end;
	end);
	u19.character.FakeHumanoid = l__Character__46.ChildRemoved:Connect(function(p20)
		if u3.fakeHumanoid ~= true then
			return;
		end;
		if p20:IsA("Humanoid") then
			wait(0.5);
			local v54 = l__Character__46:FindFirstChildWhichIsA("Humanoid");
			if v54 then
				if v54 ~= p20 then
					if timedInvoke(u10, { "ExistsOnServer", v54 }) == false then
						Kick("\nAnti-Exploit:\nFake Humanoid");
					end;
				end;
			end;
		end;
	end);
	if timedInvoke(u10, "CheckAdmin", nil, false) then
		u4("Disabling Character AE (Admin)");
		return;
	end;
	u19.character.Walkspeed = v48:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
		if u3.walkspeed ~= true then
			return;
		end;
		if timedInvoke(u10, { "MatchOnServer", {
				Object = l__Character__46.Humanoid, 
				Property = "WalkSpeed", 
				MatchTo = v48.WalkSpeed
			} }) == false then
			Kick("\nAnti-Exploit:\nIllegal WalkSpeed");
		end;
	end);
	u19.character.Swimming = v48.StateChanged:Connect(function(p21, p22)
		if u3.swimming ~= true then
			return;
		end;
		if game:GetService("Workspace").Gravity < 1 then
			if p22 == Enum.HumanoidStateType.Swimming then
				Kick("\nAnti-Exploit:\nAir Swimming");
			end;
		end;
	end);
	local v55, v56, v57 = pairs(l__LocalPlayer__14:WaitForChild("Backpack"):GetChildren());
	while true do
		local v58, v59 = v55(v56, v57);
		if v58 then

		else
			break;
		end;
		v57 = v58;
		u22(v59);	
	end;
	local v60, v61, v62 = pairs(l__Character__46:GetChildren());
	while true do
		local v63, v64 = v60(v61, v62);
		if v63 then

		else
			break;
		end;
		v62 = v63;
		if v64:IsA("BasePart") then
			local u23 = 0;
			local u24 = tick();
			u19.character.CollideChange = v64:GetPropertyChangedSignal("CanCollide"):Connect(function()
				if checkFling() == false then
					if 0 < v48.Health then
						wait(1);
						if u3.characterCollisions ~= true then
							return;
						end;
						if not v64 then
							return;
						end;
						if timedInvoke(u10, { "MatchOnServer", {
								Object = v64, 
								Property = "CanCollide", 
								MatchTo = v64.CanCollide
							} }) == false then
							Kick("\nAnti-Exploit:\nCharacter Collision Modifications");
							return;
						end;
						u23 = u23 + 1;
						if 100 <= u23 then
							if tick() - u24 <= 5 then
								Kick("\nAnti-Exploit:\nCharacter Collision Modifications (vCount Hundred Tick)");
							end;
							u24 = tick();
							u23 = 0;
						end;
					end;
				end;
			end);
			u19.character.CollisionChange = v64:GetPropertyChangedSignal("CollisionGroupId"):Connect(function()
				if checkFling() == false then
					if 0 < v48.Health then
						wait(1);
						if u3.characterCollisions ~= true then
							return;
						end;
						if not v64 then
							return;
						end;
						if timedInvoke(u10, { "MatchOnServer", {
								Object = v64, 
								Property = "CollisionGroupId", 
								MatchTo = v64.CollisionGroupId
							} }) == false then
							Kick("Character Collision Modifications");
						end;
					end;
				end;
			end);
		end;	
	end;
end;
function otherAE()
	u4("Running Other AE");
	if u19.other == nil then
		u19.other = {};
	end;
	local v65, v66, v67 = pairs(u19.other);
	while true do
		local v68, v69 = v65(v66, v67);
		if v68 then

		else
			break;
		end;
		v67 = v68;
		v69:Disconnect();	
	end;
	u19.other.CASDescAdd = game:GetService("ContextActionService").DescendantAdded:Connect(function(p23)
		if u3.suspiciousCAS ~= true then
			return;
		end;
		if not p23:IsA("BasePart") then
			if not p23:IsA("Folder") then
				if p23:IsA("ValueBase") then
					banMe("Suspicious CAS Activity");
				end;
			else
				banMe("Suspicious CAS Activity");
			end;
		else
			banMe("Suspicious CAS Activity");
		end;
	end);
	if u3.passSpoofing then
		coroutine.wrap(function()
			if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(l__LocalPlayer__14.UserId, 100000) == true then
				banMe("Gamepass Ownership Spoofing");
			end;
			task.wait(120);
		end)();
	end;
	if u3.groupSpoofing then
		coroutine.wrap(function()
			if not (0 < l__LocalPlayer__14:GetRankInGroup(9999999999)) then
				if l__LocalPlayer__14:IsInGroup(99999999999) then
					banMe("Group Rank Spoofing");
				end;
			else
				banMe("Group Rank Spoofing");
			end;
			task.wait(120);
		end)();
	end;
	if u3.badgeSpoofing then
		coroutine.wrap(function()
			if game:GetService("BadgeService"):UserHasBadgeAsync(l__LocalPlayer__14.UserId, 9999999999) then
				banMe("Badge Ownership Spoofing");
			end;
			task.wait(120);
		end)();
	end;
end;
local u25 = coroutine.wrap(function()
	task.wait(3);
	local v70 = timedInvoke(u10, "CheckAdmin", nil, false);
	u16("Client Is Admin:", tostring(v70));
	if v70 == false and u3.hideDevConsole == true then
		u4("Running Console Protection");
		l__RunService__12.Heartbeat:Connect(function()
			pcall(function()
				l__StarterGui__13:SetCore("DevConsoleVisible", false);
			end);
		end);
	end;
end);
task.defer(function()
	u4("Preparing Primary Function Calls");
	local v71, v72 = pcall(withCharacterAE);
	local v73, v74 = pcall(otherAE);
	local v75, v76 = pcall(u25);
	local v77 = 0;
	if not v71 then
		v77 = v77 + 1;
		u12(v72);
	end;
	if not v73 then
		v77 = v77 + 1;
		u12(v74);
	end;
	if not v75 then
		v77 = v77 + 1;
		u12(v76);
	end;
	if v77 == 1 then
		local v78 = "";
	else
		v78 = "s";
	end;
	u4("Executed primary function calls with " .. tostring(v77) .. " error" .. v78 .. ".");
end);
l__LocalPlayer__14.CharacterAdded:Connect(function()
	wait();
	local function u26()
		local v79, v80 = pcall(function()
			withCharacterAE();
		end);
		if v80 then
			wait(1);
			u6("Rerunning Character AE", v80);
			u26();
		end;
	end;
	u26();
end);
game:GetService("ReplicatedStorage").DescendantRemoving:Connect(function(p24)
	if p24 == u15 or p24 == u10 then
		u6("Detected tampering with AEEvent or AEFunction.");
		if not u11 then
			Kick("Do not tamper with the Anti-Exploit");
			return;
		end;
	else
		return;
	end;
	u12("AE Kicking Player (Tampering Event)");
end);
local u27 = {};
spawn(function()
	u27 = timedInvoke(u10, "GetConsoleBans", false) or {};
end);
l__LogService__14.MessageOut:Connect(function(p25, p26)
	if not u9 then
		for v81, v82 in pairs(u27) do
			if v81 and string.find(string.lower(p25), string.lower(v81), 1, true) ~= nil and not u9 then
				banMe(v82);
			end;
		end;
		if u3.stackDetection == true then
			local v83 = p25:match("^s*Script '(.*)', Line [0-9]+.*");
			if v83 and #v83 >= 5 then
				if not (function()
					for v84, v85 in pairs({ "%.", "^console", "^error" }) do
						if v83:match(v85) then
							return true;
						end;
					end;
				end)() then
					banMe(string.format("Illegal Error Stack: %s", v83));
				end;
			end;
		end;
	end;
end);
u12("Client Initialized");
