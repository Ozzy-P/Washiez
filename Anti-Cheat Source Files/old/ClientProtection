
local l__Parent__1 = script.Parent;
script.Parent = script.Parent.Parent;
local l__LocalPlayer__2 = game.Players.LocalPlayer;
while not game:IsLoaded() do
	wait();
end;
local l__AEComEvent__3 = game:GetService("ReplicatedStorage"):WaitForChild("AEComEvent", 20);
local l__AEComFunc__4 = game:GetService("ReplicatedStorage"):WaitForChild("AEComFunc", 20);
if not l__AEComEvent__3 or not l__AEComFunc__4 then
	l__LocalPlayer__2:Kick("Anti-Exploit Initialization Failure - Please Rejoin");
end;
local l__RunService__1 = game:GetService("RunService");
l__Parent__1:GetPropertyChangedSignal("Disabled"):Connect(function()
	if l__Parent__1.Disabled == true then
		if not l__RunService__1:IsStudio() then
			l__AEComEvent__3:FireServer("BanMe", "Tempering with the Anti-Exploit");
			l__LocalPlayer__2:Kick("Do not tamper with the Anti-Exploit");
			return;
		end;
	else
		return;
	end;
	warn("AE Kicking Player");
end);
l__Parent__1:GetPropertyChangedSignal("Parent"):Connect(function()
	if not l__Parent__1:IsDescendantOf(l__LocalPlayer__2) and not l__Parent__1:IsDescendantOf(game:GetService("ReplicatedFirst")) then
		if not l__RunService__1:IsStudio() then
			l__AEComEvent__3:FireServer("BanMe", "Tempering with the Anti-Exploit");
			l__LocalPlayer__2:Kick("Do not tamper with the Anti-Exploit");
			return;
		end;
	else
		return;
	end;
	warn("AE Kicking Player");
end);
script.Parent.DescendantRemoving:Connect(function(p1)
	if p1 == l__Parent__1 then
		if not l__RunService__1:IsStudio() then
			l__AEComEvent__3:FireServer("BanMe", "Tempering with the Anti-Exploit");
			l__LocalPlayer__2:Kick("Do not tamper with the Anti-Exploit");
			return;
		end;
	else
		return;
	end;
	warn("AE Kicking Player");
end);
local u2 = false;
spawn(function()
	while true do
		wait(0.3);
		if (not l__AEComEvent__3 or not l__AEComFunc__4) and not u2 then
			u2 = true;
			if l__RunService__1:IsStudio() then
				warn("AE Kicking Player");
			else
				l__AEComEvent__3:FireServer("BanMe", "Tempering with the Anti-Exploit");
				l__LocalPlayer__2:Kick("Do not tamper with the Anti-Exploit");
			end;
		end;
		if (not l__AEComEvent__3:IsDescendantOf(game:GetService("ReplicatedStorage")) or not l__AEComFunc__4:IsDescendantOf(game:GetService("ReplicatedStorage"))) and not u2 then
			u2 = true;
			if l__RunService__1:IsStudio() then
				warn("AE Kicking Player");
			else
				l__AEComEvent__3:FireServer("BanMe", "Tempering with the Anti-Exploit");
				l__LocalPlayer__2:Kick("Do not tamper with the Anti-Exploit");
			end;
		end;	
	end;
end);
spawn(function()
	wait(1);
	if math.random(1, 2) == 2 then
		local v5 = "\195\162";
	else
		v5 = "\195\166";
	end;
	script.Name = math.random(1111, 9999) .. v5;
	if math.random(1, 2) == 2 then
		local v6 = "\195\162";
	else
		v6 = "\195\166";
	end;
	l__Parent__1.Name = math.random(1111, 9999) .. v6;
end);

