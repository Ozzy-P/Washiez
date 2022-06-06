-- 100% working (no virus)
-- Auto-execute only.
local ReplicatedFirst = game:GetService("ReplicatedFirst");

ReplicatedFirst.ChildAdded:Connect(function(Anti)
    Anti.Disabled = true
end)
