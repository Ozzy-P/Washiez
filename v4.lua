-- Preferred auto-exec.

if game.PlaceId == 6764533218 then
    local ReplicatedFirst = game:GetService("ReplicatedFirst");
    local AntiRef = nil;

    local function SendNotification(msg) --Self explanatory.
	    game:GetService("StarterGui"):SetCore("SendNotification", {
		    Title = "Blume ctOS"; -- Old code from ctOS GUI, superseded by "Message" (FA ChBr.Dev)
		    Text = msg;
		    Duration = 15;
		    Button1 = "Ok";
	    })
    end

    ReplicatedFirst.ChildAdded:Connect(function(Anti)
        Anti.Disabled = true;
        AntiRef = Anti;
    end)
    
    if AntiRef then
        SendNotification("Secured.")
    end
    
    task.wait(4)
    if not AntiRef then
        local RepScripts = ReplicatedFirst:GetDescendants()
        for _,Script in pairs(RepScripts) do
            if Script:IsA("LocalScript") then
                for _, Connection in pairs(getconnections(Script:GetPropertyChangedSignal("Disabled"))) do
                    Connection:Disable()
                end
                for _, Connection in pairs(getconnections(Script.Changed)) do
                    Connection:Disable()
                end
                SendNotification("Secured (R = " .. _ .. ")")
            end
        end
    end
end
