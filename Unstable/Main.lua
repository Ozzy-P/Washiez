
-- Unstable anti-cheat version
-- Washiez Anti-Cheat v2.5 (QA Tested by Ozzy uwu)

local gameMT = getrawmetatable(game)
local newMT = {
    ["__index"] = gameMT.__index
}
local newNC = {
    ["__namecall"] = gameMT.__namecall
}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local LogService = game:GetService("LogService")
local RunService = game:GetService("RunService")

repeat wait() until Players.LocalPlayer ~= nil
local Player = Players.LocalPlayer

local function main()

    for _,PlayerScript in pairs(Player.PlayerScripts:GetChildren()) do
        if tonumber(PlayerScript.Name:sub(1,1)) ~= nil then
            setreadonly(gameMT, false)
            gameMT.__index = newcclosure(function(S, _I, ...)
                if S == PlayerScript then
                    if _I == "Disabled" then
                        return "The current identity (2) cannot class security check (lacking permission 1)" 
                    end
                end
                return newMT.__index(S, _I, ...)
            end)
            setreadonly(gameMT, true)
            CollectionService:AddTag(PlayerScript,"MTAPIMUTEX")
        end
    end


    setreadonly(gameMT, false)
    gameMT.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "IsStudio" then
            return true
        end
        return newNC.__namecall(self, ...)
    end)
    setreadonly(gameMT, true)

    for _,LocalScript in pairs(CollectionService:GetTagged("MTAPIMUTEX")) do
        LocalScript.Disabled = true
    end

    print("Server is secure.")
    
end

local hasResponded = false
for _,v in pairs(LogService:GetLogHistory()) do
    if v.message == "Anti-Exploit: Server Requested Validation" then
        hasResponded = true
    end
end

local uService
if not hasResponded then
    uService = LogService.MessageOut:Connect(function(message)
        if message == "Anti-Exploit: Server Requested Validation" then
            uService:Disconnect()
            task.delay(2,function()
                main()
                hasResponded = nil
            end)
        end
    end)
else
    main()
    uService = nil
    hasResponded = nil
end
