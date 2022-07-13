-- Main v4
-- Uses debug library
-- Auto-initialized at client startup.

local Players = game:GetService("Players")
local LogService = game:GetService("LogService")
local LocalPlayer_ = Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
local LocalPlayer = Players.LocalPlayer

local function SendNotification(msg) --Self explanatory.
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Blume ctOS"; -- Old code from ctOS GUI, superseded by "Message" (FA ChBr.Dev)
		Text = msg;
	})
end

local function _LogService(_M,fn,_D,_R)
    local hasResponded, _Event = false, Instance.new("BindableEvent")
    for _,v in pairs(LogService:GetLogHistory()) do
        if v.message == _M then
            hasResponded = true   
        end
    end
    
    local uService
    if not hasResponded then
        uService = LogService.MessageOut:Connect(function(message)
            if message == _M then
                uService:Disconnect()
                task.delay(_D or 0,function()
                    fn()
                    hasResponded = nil
                    if _R then
                        task.delay(1,function()
                            _Event:Fire()
                        end)
                    end
                end)
            end
        end)
        return _Event.Event
    else
        fn()
        uService = nil
        hasResponded = nil
        if _R then
            task.delay(1,function()
                _Event:Fire()
            end)
            return _Event.Event
        end
    end
end

-- Made by vinidalvino
-- https://v3rmillion.net/showthread.php?tid=992227
function get_fn_from_script(ScriptName)
    assert(ScriptName,"No script name provided")
    local found = {}
    for _,Env in pairs(debug.getregistry()) do
        if type(Env) == "function" and not is_protosmasher_closure(Env) and islclosure(Env) then
            pcall(function()
                if getfenv(Env).script.Name == ScriptName then
                    table.insert(found,Env)
                end
            end)
        end
    end
    return found
end

local function main()

    local marker,main,AND = nil,nil,false
    for _,Script in next,(LocalPlayer.PlayerScripts:GetChildren()) do
        local Modulus = Script:FindFirstChildOfClass("ModuleScript")
        if Modulus and Modulus.Name == "DefaultSettings" then
            marker = Script
        end
    end

    script = get_fn_from_script(marker.Name)
    if #script == 0 then
        error("Could not locate asset.")
    end
    for i,fi in next,script do
        --warn("---"..i.."---")
        for i2,v2 in pairs(debug.getupvalues(fi)) do
            if typeof(v2) == "Instance" and v2:IsA("LocalScript") and tostring(v2.Name:sub(1,1)) then
                for rbxID,RBXSignal in next, getconnections(v2:GetPropertyChangedSignal("Disabled")) do
                    RBXSignal:Disable()
                end
                for rbxID,RBXSignal in next, getconnections(game:GetService("ReplicatedStorage").DescendantRemoving) do
                    RBXSignal:Disable()
                end
                main = v2
                debug.setupvalue(fi,i2,"!")
                warn("---"..i.."---")
                --print("Ida")
                AND = true
            end
        end
    end

    if AND then
        main.Disabled = not main.Disabled 
            for Iv, Ev in next, game:GetService("ReplicatedStorage"):GetChildren() do
            if Ev.Name:find("AE") then
                Ev:Destroy()
            end
        end
        SendNotification("Status: ONLINE")
    end
end

_LogService("Anti-Exploit: Fully Initialized Client",main,2)
