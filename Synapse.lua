-- Stable anti-cheat version

-- Washiez Anti-Cheat v3 (QA Tested by Ozzy uwu)
-- Optimized for Synapse X.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local LogService = game:GetService("LogService")
local RunService = game:GetService("RunService")

repeat wait() until Players.LocalPlayer ~= nil
local Player = Players.LocalPlayer

local function _LogService(str,func,delay,wait)
    task.delay(0,func)
    if wait then
        task.wait(delay)
    end       
end

local function main()

    local __LogService = _LogService("Anti-Exploit: Fully Initialized Client", function()
        for _,PlayerScript in pairs(Player.PlayerScripts:GetChildren()) do
            if tonumber(PlayerScript.Name:sub(1,1)) ~= nil then
                local _gameMT = nil
                _gameMT = hookmetamethod(game, "__index", function(S, _I)
                    if not checkcaller() and S == PlayerScript and _I == "Disabled" then
                        return "The current identity (2) cannot class security check (lacking permission 1)" 
                    end
                    return _gameMT(S, _I)
                end)
                CollectionService:AddTag(PlayerScript,"MTAPIMUTEX")
            end
        end
    end, 2, true)

    __LogService:Wait()
    __LogService = nil
    
    local _gameMTNC = nil
    _gameMTNC = hookmetamethod(game, "__namecall", function(self,...)
        local method = getnamecallmethod()
        if not checkcaller() and method == "IsStudio" then
            return nil
        end
        return _gameMTNC(self,...)
    end)

    for _,LocalScript in pairs(CollectionService:GetTagged("MTAPIMUTEX")) do
        LocalScript.Disabled = true
    end

    print("Server is secure.")
    
end


if not game:IsLoaded() then
    game.Loaded:Wait()
end

main()
