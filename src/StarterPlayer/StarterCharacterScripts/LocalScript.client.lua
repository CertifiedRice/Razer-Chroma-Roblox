local character = script.Parent

local humanoid = character:WaitForChild("Humanoid")

local tokenLength = string.len("Enum.HumanoidStateType.")

humanoid.StateChanged:Connect(function(oldState, newState)
	if (newState ~= nil and oldState ~= newState and newState ~= Enum.HumanoidStateType.None) then
		local state = tostring(newState);
		if (string.len(state) > tokenLength) then
			local strState = string.sub(state, tokenLength + 1)
			print ("ChromaRGB:", string.format("Player_%s", strState));
		end
	end
end)


local UserInputService = game:GetService("UserInputService")

local function onInputBegan(inputObject, gameProcessedEvent)

	if gameProcessedEvent then return end
	if inputObject.UserInputType == Enum.UserInputType.Keyboard then
		if (inputObject.KeyCode.Name == "W" or
			inputObject.KeyCode.Name == "A" or
			inputObject.KeyCode.Name == "S" or
			inputObject.KeyCode.Name == "D") then
			print("ChromaRGB:", "Player_WASD")
		end
	end
end

UserInputService.InputBegan:Connect(onInputBegan)
