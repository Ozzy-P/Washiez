-- Washiez Anti-Cheat v5 (QA Tested by Ozzy uwu)
-- Intercepts client after run time (use other version[s] for auto-execute)


local function SendNotification(msg) --Self explanatory.
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Blume ctOS"; -- Old code from ctOS GUI, superseded by "Message" (FA ChBr.Dev)
		Text = msg;
		Duration = 15;
		Button1 = "Ok";
	})
end

-- Original by vinidalvino
-- https://v3rmillion.net/showthread.php?tid=992227
local function get_fn_from_script()
    local found = {}
    for _,Env in pairs(debug.getregistry()) do
        if type(Env) == "function" and not is_protosmasher_closure(Env) and islclosure(Env) then
            pcall(function()
                local newFenv = getfenv(Env)
                if getfenv(Env).Kick or getfenv(Env).banMe then
                    newFenv.Kick = function() print("UwU") end
                    newFenv.banMe = function() print("UwU") end
                    setfenv(Env,newFenv)
                    table.insert(found,Env)
                end
            end)
        end
    end
    return found
end

local function main()
    script = get_fn_from_script()
    if #script == 0 then
        error("Could not locate asset.")
    end

    SendNotification("Status: ONLINE")
end

main()


local mt = getrawmetatable(game)
local old = mt.__namecall
local protect = newcclosure or protect_function

if not protect then
protect = function(f) return f end
end

setreadonly(mt, false)
mt.__namecall = protect(function(self, ...)
local method = getnamecallmethod()
if method == "Kick" then
wait(9e9)
return
end
return old(self, ...)
end)
