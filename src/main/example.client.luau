local library = require(script.Parent.main)
library:ChangeConfig({
    ["Visible On Execution"] = true,
})
library:Init()

local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()


--// Services

local tweenservice = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local runservice = game:GetService("RunService")

local client = library:Window({
    Name = "Client",
})
--world.Obj.Position += UDim2.new(0,350, 0, 0)

local tp = client:Toggle({
    Name = "Click TP",
    State = true,
    Key = Enum.KeyCode.V,
    Func = function(self)
        self.Enabled = true
    end,
    OffFunc = function(self)
        self.Enabled = false
    end,
    Arguments = {
        {
            Title = "Key",
            Name = "V",
            Type = "Key",
            Func = function(self, input)
                self.Key = input
            end
        },
    },
})
uis.InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and tp.Data.Enabled then
        if input.KeyCode == tp.Data.Key then
            if mouse.Target == nil then return end
            pcall(function()
                local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
                local hipHeight = humanoid and humanoid.HipHeight > 0 and (humanoid.HipHeight + 1)
                local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
                local rootPartPosition = rootPart.Position
                local hitPosition = mouse.Hit.Position
                local newCFrame = CFrame.new(
                    hitPosition, 
                    Vector3.new(rootPartPosition.X, hitPosition.Y, rootPartPosition.Z)
                ) * CFrame.Angles(0, math.pi, 0)

                rootPart.CFrame = newCFrame + Vector3.new(0, hipHeight or 4, 0)
            end)
        end
    end
end)

client:Toggle({
    Name = "Speed",
    State = false,
    Func = function(self)
        plr.Character.Humanoid.WalkSpeed = self.Speed or 100
    end,
    OffFunc = function()
        plr.Character.Humanoid.WalkSpeed = 16
    end,
    Arguments = {
        {
            Title = "Speed",
            Name = "100",
            Type = "Input",
            Func = function(self, input)
                self.Speed = tonumber(input) or 100
            end
        },
    },
})

client:Toggle({
    Name = "High Jump",
    State = false,
    Func = function(self)
        plr.Character.Humanoid.UseJumpPower = true
        plr.Character.Humanoid.JumpPower = self.JP or 100
    end,
    OffFunc = function()
        plr.Character.Humanoid.JumpPower = 50
    end,
    Arguments = {
        {
            Title = "Jump power",
            Min = 50,
            Max = 200,
            Value = 50,
            Increment = 5,
            Type = "Slider",
            Func = function(self, input)
                plr.Character.Humanoid.UseJumpPower = true
                plr.Character.Humanoid.JumpPower = input
            end
        },
    },
})

client:Button({
    Name = "Reset",
    Func = function(self)
        if self.Joints then
            plr.Character:BreakJoints()
            else
            plr.Character.Humanoid.Health = 0
        end
    end,
    Arguments = {
        {
            Title = "Break Joints",
            Type = "Toggle",
            Repeating = false,
            State = false,
            Func = function(self, input)
                self.Joints = true
                print("Sigma")
            end,
            OffFunc = function(self)
                self.Joints = false
                print("Unsigma")
            end
        },
    },
})