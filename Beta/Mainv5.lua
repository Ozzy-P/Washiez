-- Washiez Anti-Cheat v5 (WIP)
-- Intercepts client after run time (use other version[s] for auto-execute)

local function SendNotification(msg)
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Blume ctOS";
		Text = msg;
		Duration = 15;
		Button1 = "Ok";
	})
end

local function setFn()
    local found = {}
    for _,Env in pairs(debug.getregistry()) do
        if type(Env) == "function" and not is_protosmasher_closure(Env) and islclosure(Env) then
            pcall(function()
                local newFenv = getfenv(Env)
                if getfenv(Env).Kick or getfenv(Env).banMe then
                    newFenv.Kick = function() end
                    newFenv.banMe = function() end
                    setfenv(Env,newFenv)
                    table.insert(found,Env)
                end
            end)
        end
    end
    return found
end

local function main()
    fn = setFn()
    if #fn == 0 then
        error("Could not set fn")
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
