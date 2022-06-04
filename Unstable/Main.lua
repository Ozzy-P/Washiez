-- Unstable anti-cheat version
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local LogService = game:GetService("LogService")
local gameMT = getrawmetatable(game)
local newMT = {
    ["__index"] = gameMT.__index
}
repeat wait() until Players.LocalPlayer ~= nil
local Player = Players.LocalPlayer

local function main()
for _,PlayerScript in pairs(Player.PlayerScripts:GetChildren()) do
    if tonumber(PlayerScript.Name:sub(1,1)) ~= nil then
        setreadonly(gameMT, false)
        gameMT.__index = newcclosure(function(S, _I, ...)
            if S == PlayerScript then
                if index == "Disabled" then
                    return "Current identity (2) cannot class security check (lacking permission 1)" 
                end
            end
            return newMT.__index(S, _I, ...)
        end)
        setreadonly(gameMT, true)
        CollectionService:AddTag(PlayerScript,"MTAPIMUTEX")
    end
end

for _,LocalScript in pairs(CollectionService:GetTagged("MTAPIMUTEX")) do
    LocalScript.Disabled = true
end

print("Server is secure.")
end

local hasResponded = false
for _,Log in pairs(LogService:GetLogHistory()) do
    if Log.message == "Anti-Exploit: Server Requested Validation" then
        hasResponded = true
    end
end

local uService
if not hasResponded then
    uService = LogService.MessageOut:Connect(function(message)
        if message == ("Anti-Exploit: Server Requested Validation") then
            uService:Disconnect()
            main()
            hasResponded = nil
        end
    end)
else
    main()
    uService = nil
end
