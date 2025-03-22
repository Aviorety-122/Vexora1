local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RedzLibV5/main/Source.Lua"))()

local Window = redzlib:MakeWindow({
  Title = "Vexora | Beta",
  SubTitle = "hello",
  SaveFolder = "Redz Config"
})

-- Tabs
local Tab1 = Window:MakeTab({"Tab 1", "cool"})

-- Functions

-- Infinite Jump
Tab1:AddToggle({
  Name = "Infinite Jump",
  Description = "Enables infinite jump",
  Default = false,
  Callback = function(state)
    getgenv().inf = state
    spawn(function()
      while inf do
        game:GetService("UserInputService").JumpRequest:connect(function()
          if inf then
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
          end
        end)
        wait()
      end
    end)
  end
})

-- Auto Farm
Tab1:AddToggle({
  Name = "Auto Farm",
  Description = "Automatically farms for you",
  Default = false,
  Callback = function(state)
    local autoFarmEnabled = state
    while autoFarmEnabled do
      task.wait(0.1)
      local player = game:GetService("Players").LocalPlayer
      if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = player.Character.HumanoidRootPart

        for _, v in pairs(workspace:GetChildren()) do
          if v:IsA("Part") or v:IsA("MeshPart") then
            humanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 3, 0)
            task.wait(0.5)
          end
        end
      end
    end
  end
})

-- Water God Mode
Tab1:AddToggle({
  Name = "Water God Mode",
  Description = "Removes Water Detection",
  Default = false,
  Callback = function(state)
    getgenv().Water = state
    game:GetService("RunService").Stepped:connect(function()
      pcall(function()
        if getgenv().Water and game.Players.LocalPlayer.Character:FindFirstChild("WaterDetector") then
          game.Players.LocalPlayer.Character.WaterDetector:remove()
        end
      end)
    end)
  end
})

-- Auto Chest
Tab1:AddToggle({
  Name = "Auto Chest",
  Description = "Auto opens chests",
  Default = false,
  Callback = function(state)
    getgenv().AutoChest = state
    getgenv().Number = 1
    game:GetService("RunService").Stepped:connect(function()
      if getgenv().AutoChest then
        workspace.ItemBoughtFromShop:InvokeServer("ChestType", getgenv().Number)
      end
    end)
  end
})

-- Anti AFK
Tab1:AddButton({
  Name = "Anti AFK",
  Callback = function()
    wait(3)
    local VirtualUser = game:service("VirtualUser")
    game:service("Players").LocalPlayer.Idled:connect(function()
      VirtualUser:CaptureController()
      VirtualUser:ClickButton2(Vector2.new())
    end)
  end
})

-- Anti LAG
Tab1:AddButton({
  Name = "Anti LAG",
  Callback = function()
    for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
      if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
        v.Material = Enum.Material.SmoothPlastic
        if v:IsA("Texture") then v:Destroy() end
      end
    end
  end
})

-- Teleport To
Tab1:AddButton({
  Name = "Teleport To",
  Callback = function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 0, 0) -- Example teleport location
  end
})

-- Rejoin Server
Tab1:AddButton({
  Name = "Rejoin Server",
  Callback = function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
  end
})

-- Set Jump Power Slider
Tab1:AddSlider({
  Name = "Jump Power",
  Min = 1,
  Max = 100,
  Increase = 1,
  Default = 50,
  Callback = function(Value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
  end
})

-- Set Walk Speed Slider
Tab1:AddSlider({
  Name = "Walk Speed",
  Min = 1,
  Max = 100,
  Increase = 1,
  Default = 50,
  Callback = function(Value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
  end
})

-- Set Hip Height Slider
Tab1:AddSlider({
  Name = "Hip Height",
  Min = 1,
  Max = 100,
  Increase = 1,
  Default = 50,
  Callback = function(Value)
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = Value
  end
})

-- Infinite Yield
Tab1:AddButton({
  Name = "Infinite Yield",
  Callback = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
  end
})

-- Morph Character
Tab1:AddButton({
  Name = "Morph Character",
  Callback = function()
    workspace.ChangeCharacter:FireServer("CharacterName") -- Change "CharacterName" to the morph name you want
  end
})

-- Fly (Vehicle Fly)
Tab1:AddButton({
  Name = "Vehicle Fly",
  Callback = function()
    local FlyKey = Enum.KeyCode.V
    local SpeedKey = Enum.KeyCode.LeftControl
    local SpeedKeyMultiplier = 3
    local FlightSpeed = 256
    local FlightAcceleration = 4
    local TurnSpeed = 16
    local UserInputService = game:GetService("UserInputService")
    local StarterGui = game:GetService("StarterGui")
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local User = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local UserCharacter = nil
    local UserRootPart = nil
    local Connection = nil

    workspace.Changed:Connect(function()
      Camera = workspace.CurrentCamera
    end)

    local setCharacter = function(c)
      UserCharacter = c
      UserRootPart = c:WaitForChild("HumanoidRootPart")
    end

    User.CharacterAdded:Connect(setCharacter)
    if User.Character then
      setCharacter(User.Character)
    end

    local CurrentVelocity = Vector3.new(0, 0, 0)
    local Flight = function(delta)
      local BaseVelocity = Vector3.new(0, 0, 0)
      if not UserInputService:GetFocusedTextBox() then
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
          BaseVelocity = BaseVelocity + (Camera.CFrame.LookVector * FlightSpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
          BaseVelocity = BaseVelocity - (Camera.CFrame.RightVector * FlightSpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
          BaseVelocity = BaseVelocity - (Camera.CFrame.LookVector * FlightSpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
          BaseVelocity = BaseVelocity + (Camera.CFrame.RightVector * FlightSpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
          BaseVelocity = BaseVelocity + (Camera.CFrame.UpVector * FlightSpeed)
        end
        if UserInputService:IsKeyDown(SpeedKey) then
          BaseVelocity = BaseVelocity * SpeedKeyMultiplier
        end
      end
      if UserRootPart then
        local car = UserRootPart:GetRootPart()
        if car.Anchored then return end
        if not isnetworkowner(car) then return end
        CurrentVelocity = CurrentVelocity:Lerp(
          BaseVelocity,
          math.clamp(delta * FlightAcceleration, 0, 1)
        )
        car.Velocity = CurrentVelocity + Vector3.new(0, 2, 0)
        if car ~= UserRootPart then
          car.RotVelocity = Vector3.new(0, 0, 0)
          car.CFrame = car.CFrame:Lerp(CFrame.lookAt(
            car.Position,
            car.Position + CurrentVelocity + Camera.CFrame.LookVector
          ), math.clamp(delta * TurnSpeed, 0, 1))
        end
      end
    end

    UserInputService.InputBegan:Connect(function(userInput, gameProcessed)
      if gameProcessed then return end
      if userInput.KeyCode == FlyKey then
        if Connection then
          StarterGui:SetCore("SendNotification", {Title = "Vehicle Fly", Text = "Flight disabled"})
          Connection:Disconnect()
          Connection = nil
        else
          StarterGui:SetCore("SendNotification", {Title = "Vehicle Fly", Text = "Flight enabled"})
          CurrentVelocity = UserRootPart.Velocity
          Connection = RunService.Heartbeat:Connect(Flight)
        end
      end
    end)

    StarterGui:SetCore("SendNotification", {Title = "Vehicle Fly", Text = "Loaded successfully, Press V to toggle"})
  end
})
