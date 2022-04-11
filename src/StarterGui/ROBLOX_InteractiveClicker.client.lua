local clickEvent = script:WaitForChild('RemoteValue').Value

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local camera = game.Workspace.CurrentCamera
local equippedConnection
local unequippedConnection
local equipped = false

mouse.Button1Down:connect(function()
	local target = mouse.Target
	if not equipped and target then 
		local toTarget = target.Position - camera.CFrame.p
		clickEvent:FireServer(target, toTarget.magnitude) 
	end
end)

local function onCharacterAdded(character)
	equippedConnection = character.DescendantAdded:connect(function(descendant)
		if descendant:IsA('Tool') then
			equipped = true
		end
	end)
	unequippedConnection = character.DescendantRemoving:connect(function(descendant)
		if descendant:IsA('Tool') then
			equipped = false
		end
	end)
end

local function onCharacterRemoving(character)
	equippedConnection:disconnect()
	unequippedConnection:disconnect()
end

local function onClickEvent(module, ...)
	require(module):Initialize(clickEvent, ...)
end
clickEvent.OnClientEvent:connect(onClickEvent)

if player.Character then
	onCharacterAdded(player.Character)
end
player.CharacterAdded:connect(onCharacterAdded)
player.CharacterRemoving:connect(onCharacterRemoving)