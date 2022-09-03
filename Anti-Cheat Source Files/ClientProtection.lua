local v1 = game:GetService("RunService"):IsStudio();
local l__Parent__2 = script.Parent;
script.Parent = script.Parent.Parent;
local l__LocalPlayer__3 = game.Players.LocalPlayer;
local v4 = script:GetAttribute("ParentSafe") == true;
while not game:IsLoaded() do
	wait();
end;
while not script:GetAttribute("Event") do
	wait();
end;
local v5 = game:GetService("ReplicatedStorage"):WaitForChild(script:GetAttribute("Event"), 20);
local v6 = game:GetService("ReplicatedStorage"):WaitForChild(script:GetAttribute("Function"), 20);
if not v5 or not v6 then
	l__LocalPlayer__3:Kick("Anti-Exploit Initialization Failure - Please Rejoin");
end;
script:SetAttribute("Ready", true);
script:SetAttribute("Event", "");
script:SetAttribute("Function", "");
l__Parent__2:GetPropertyChangedSignal("Disabled"):Connect(function()
	if l__Parent__2.Disabled == true then
		if not v1 then
			v5:FireServer("BanMe", "Tempering with the Anti-Exploit");
			l__LocalPlayer__3:Kick("Do not tamper with the Anti-Exploit");
			return;
		end;
	else
		return;
	end;
	warn("AE Kicking Player (Client Tampering)");
end);
l__Parent__2:GetPropertyChangedSignal("Parent"):Connect(function()
	if v4 then
		return;
	end;
	if not l__Parent__2:IsDescendantOf(l__LocalPlayer__3) and not l__Parent__2:IsDescendantOf(game:GetService("ReplicatedFirst")) then
		if not v1 then
			v5:FireServer("BanMe", "Tempering with the Anti-Exploit");
			l__LocalPlayer__3:Kick("Do not tamper with the Anti-Exploit");
			return;
		end;
	else
		return;
	end;
	warn("AE Kicking Player (Client Tampering 2)");
end);
script.Parent.DescendantRemoving:Connect(function(p1)
	if v4 then
		return;
	end;
	if p1 == l__Parent__2 then
		if not v1 then
			v5:FireServer("BanMe", "Tempering with the Anti-Exploit");
			l__LocalPlayer__3:Kick("Do not tamper with the Anti-Exploit");
			return;
		end;
	else
		return;
	end;
	warn("AE Kicking Player (Client Tampering 3)");
end);
local u1 = false;
spawn(function()
	while true do
		wait(0.3);
		if (not v5 or not v6) and not u1 then
			u1 = true;
			if v1 then
				warn("AE Kicking Player (Event Tampering)");
			else
				v5:FireServer("BanMe", "Tempering with the Anti-Exploit");
				l__LocalPlayer__3:Kick("Do not tamper with the Anti-Exploit");
			end;
		end;
		if (not v5:IsDescendantOf(game:GetService("ReplicatedStorage")) or not v6:IsDescendantOf(game:GetService("ReplicatedStorage"))) and not u1 then
			u1 = true;
			if v1 then
				warn("AE Kicking Player (Event Tampering 2)");
			else
				v5:FireServer("BanMe", "Tempering with the Anti-Exploit");
				l__LocalPlayer__3:Kick("Do not tamper with the Anti-Exploit");
			end;
		end;	
	end;
end);
spawn(function()
	wait(1);
	if math.random(1, 2) == 2 then
		local v7 = "\195\162";
	else
		v7 = "\195\166";
	end;
	script.Name = math.random(1111, 9999) .. v7;
	if math.random(1, 2) == 2 then
		local v8 = "\195\162";
	else
		v8 = "\195\166";
	end;
	l__Parent__2.Name = math.random(1111, 9999) .. v8;
end);
