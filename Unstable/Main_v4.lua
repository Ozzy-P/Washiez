-- Main v4
-- Uses debug library
-- Not for auto-exec, manual load only (or until anti-exploit has finished loading)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CollectionService = {}
CollectionService.AddTag = function(ida,str)
    if not CollectionService[str] then
        CollectionService[str] = {}
    end
    table.insert(CollectionService[str],ida)
end


CollectionService.GetTagged = function(name)
    if CollectionService[name] then
        return CollectionService[name]
    else
        return {}
    end
end

local function SendNotification(msg) --Self explanatory.
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Blume ctOS"; -- Old code from ctOS GUI, superseded by "Message" (FA ChBr.Dev)
		Text = msg;
	})
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

local marker,AND = nil,false
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
            debug.setupvalue(fi,i2,"!")
            warn("---"..i.."---")
            --print("Ida")
            AND = true
        end
    end
end

if AND then
    for _,PlayerScript in pairs(LocalPlayer.PlayerScripts:GetChildren()) do
        if tonumber(PlayerScript.Name:sub(1,1)) and (not PlayerScript:FindFirstChildOfClass("ModuleScript")) then
            PlayerScript.Disabled = true
        end
    end
        for Iv, Ev in next, game:GetService("ReplicatedStorage"):GetChildren() do
        if Ev.Name:find("AE") then
            Ev:Destroy()
        end
    end
    SendNotification("Status: ONLINE")
end

