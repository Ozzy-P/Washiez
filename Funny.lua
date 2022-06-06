-- 100% working (no virus)
-- Auto-execute only.
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local AntiRef = nil;

ReplicatedFirst.ChildAdded:Connect(function(Anti)
    Anti.Disabled = true;
    AntiRef = Anti;
end)

AEComEvent = game:GetService("ReplicatedStorage"):WaitForChild("AEComEvent", 20);
AEComFunc = game:GetService("ReplicatedStorage"):WaitForChild("AEComFunc", 20);

function AEComFunc.OnClientInvoke(invokeReason, serverKey)
	if invokeReason ~= "ValidateConnection" then
		return;
	end;
	warn("Anti-Exploit: Server Requested Validation");
	return { (game.PlaceId - game.GameId) / serverKey, AntiRef, "go away" };
end;
AEComEvent:FireServer("ValidateConnection");
