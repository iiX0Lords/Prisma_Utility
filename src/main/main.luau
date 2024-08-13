local Workspace = game:GetService("Workspace")

--[[

	#Todo
	
	Config saving and loading
	Add notifications
	
	
	#Hud
	
	Watermark
	Enabled modules gui underneath water mark
	Ping??
	
]]

repeat
	task.wait()
until game:IsLoaded()

--// Client variables
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()


--// Services

local tweenservice = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local runservice = game:GetService("RunService")

prismaGUI = {}

prismaGUI.config = {
	Version = "<!#FV> 1.7.8 </#FV>",
	Personalization = {
		["ToggleGUIBind"] = Enum.KeyCode.Insert,
		["Visible On Execution"] = false,
		["Toggle On Colour"] = Color3.fromRGB(0, 141, 212),
		["Hover Colour"] = Color3.fromRGB(47, 47, 47)
	},
	Binds = {},
}

function prismaGUI:ChangeConfig(data)
	for n,v in pairs(data) do
		if prismaGUI.config.Personalization[n] ~= nil then
			prismaGUI.config.Personalization[n] = v
			print(`Changed {n} to {tostring(v)}`)
		end
	end
end

function prismaGUI:Init()
	
prismaGUI.Gui = Instance.new("ScreenGui",plr.PlayerGui)
prismaGUI.Gui.Name = "Prisma Utility"
prismaGUI.Gui.ResetOnSpawn = false
prismaGUI.Gui.IgnoreGuiInset = true
prismaGUI.Gui.DisplayOrder = 9999
prismaGUI.Gui.Parent = plr.PlayerGui
prismaGUI.Gui.Enabled = prismaGUI.config.Personalization["Visible On Execution"]

function bindObject(object, key)
	local binds = prismaGUI.config.Binds
	local bind
	
	for i,v in pairs(prismaGUI.config.Binds) do
		if v.Name == object.Name then
			bind = v
			break
		end
	end
	
	if bind ~= nil then
		if key == Enum.KeyCode.Unknown then
			bind.Key = Enum.KeyCode.ButtonA
		else
			bind.Key = key
		end
	else
		if key == Enum.KeyCode.Unknown then
			return
		end
		table.insert(binds, {
			Name = object.Name,
			Key = key,
			Func = object.Func
		})
	end
end
uis.InputBegan:Connect(function(input, processed)
	if processed then return end

	if input.KeyCode == prismaGUI.config.Personalization.ToggleGUIBind then
		prismaGUI.Gui.Enabled = not prismaGUI.Gui.Enabled
	end

	for i,v in pairs(prismaGUI.config.Binds) do
		if v.Key == input.KeyCode then
			task.spawn(function()
				v.Func()
			end)
		end
	end
end)

function prismaGUI:Window(data)
	local self = {}
	

	local template = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local title = Instance.new("TextLabel")
	local UIPadding = Instance.new("UIPadding")
	local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
	local toggle = Instance.new("ImageButton")
	local AspectRatio = Instance.new("UIAspectRatioConstraint")
	local DropShadowHolder = Instance.new("Frame")
	local DropShadow = Instance.new("ImageLabel")
	local contents = Instance.new("ScrollingFrame")
	local UICorner_2 = Instance.new("UICorner")
	local UIPadding_2 = Instance.new("UIPadding")
	
	local contentsBG = Instance.new("Frame")

	--Properties:

	template.Name = data.Name or "prisma"
	template.Parent = prismaGUI.Gui
	template.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
	template.BorderColor3 = Color3.fromRGB(0, 0, 0)
	template.BorderSizePixel = 0
	template.Position = UDim2.new(0.0647975057, 0, 0.0559875593, 0)
	template.Size = UDim2.new(0, 180, 0, 40)
	template.ZIndex = 2

	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = template

	title.Name = "title"
	title.Parent = template
	title.AnchorPoint = Vector2.new(0, 0.5)
	title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title.BackgroundTransparency = 1.000
	title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	title.BorderSizePixel = 0
	title.Position = UDim2.new(0, 0, 0.5, 0)
	title.Size = UDim2.new(1, 0, 1, 0)
	title.ZIndex = 2
	title.Font = Enum.Font.BuilderSans
	title.Text = data.Name or "prisma"
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextScaled = true
	title.TextSize = 14.000
	title.TextWrapped = true
	title.TextXAlignment = Enum.TextXAlignment.Left

	UIPadding.Parent = title
	UIPadding.PaddingLeft = UDim.new(0.0500000007, 0)

	UITextSizeConstraint.Parent = title
	UITextSizeConstraint.MaxTextSize = 15

	toggle.Name = "toggle"
	toggle.Parent = template
	toggle.AnchorPoint = Vector2.new(1, 0.5)
	toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	toggle.BackgroundTransparency = 1.000
	toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
	toggle.BorderSizePixel = 0
	toggle.Position = UDim2.new(0.975000024, 0, 0.5, 0)
	toggle.Size = UDim2.new(0.125, 0, 0.625, 0)
	toggle.Rotation = 180
	toggle.ZIndex = 2
	toggle.Image = "http://www.roblox.com/asset/?id=6031094679"
	
	toggle.MouseButton1Down:Connect(function()
		self:SetState()
	end)

	AspectRatio.Name = "AspectRatio"
	AspectRatio.Parent = toggle

	DropShadowHolder.Name = "DropShadowHolder"
	DropShadowHolder.Parent = template
	DropShadowHolder.BackgroundTransparency = 1.000
	DropShadowHolder.BorderSizePixel = 0
	DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
	DropShadowHolder.ZIndex = -99

	DropShadow.Name = "DropShadow"
	DropShadow.Parent = DropShadowHolder
	DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow.BackgroundTransparency = 1.000
	DropShadow.BorderSizePixel = 0
	DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow.Size = UDim2.new(1, 47, 1, 47)
	DropShadow.ZIndex = 0
	DropShadow.Image = "rbxassetid://6014261993"
	DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	DropShadow.ImageTransparency = 0.500
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

	contents.Name = "contents"
	contents.Parent = template
	contents.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
	contents.BorderColor3 = Color3.fromRGB(0, 0, 0)
	contents.BorderSizePixel = 0
	contents.BackgroundTransparency = 1
	contents.Selectable = false
	contents.Size = UDim2.new(1, 0, 8.25, 0)
	contents.BottomImage = ""
	contents.CanvasSize = UDim2.new(0, 0, 10, 0)
	contents.MidImage = "rbxassetid://13458741869"
	contents.ScrollBarThickness = 5
	contents.TopImage = ""
	contents.ScrollingEnabled = false
	contents.ScrollBarThickness = 0
	
	contentsBG.Name = "contents"
	contentsBG.Parent = template
	contentsBG.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
	contentsBG.BorderColor3 = Color3.fromRGB(0, 0, 0)
	contentsBG.BorderSizePixel = 0
	contentsBG.Selectable = false
	contentsBG.Size = UDim2.new(1, 0, 8.25, 0)
	contentsBG.ZIndex = 0
	
	contents:GetPropertyChangedSignal("Size"):Connect(function()
		DropShadowHolder.Size = contents.Size
		contentsBG.Size = contents.Size
	end)

	UICorner_2.CornerRadius = UDim.new(0, 0)
	UICorner_2.Parent = contentsBG

	UIPadding_2.Parent = contents
	UIPadding_2.PaddingTop = UDim.new(0, 42)
	--UIPadding_2.PaddingRight = UDim.new(0.02, 0)
	--UIPadding_2.PaddingLeft = UDim.new(0.02, 0)
	
	local layout = Instance.new("UIListLayout",contents)
	layout.Padding = UDim.new(0,0)

	local function updateContents()
		local size = layout.AbsoluteContentSize;
		local padding = layout.Parent.UIPadding;

		size = size + Vector2.new(0, padding.PaddingBottom.Offset + padding.PaddingTop.Offset);
		contents.Size = UDim2.new(1, 0, 0, size.Y)
	end
	
	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		local size = layout.AbsoluteContentSize;
		local padding = layout.Parent.UIPadding;

		size = size + Vector2.new(0, padding.PaddingBottom.Offset + padding.PaddingTop.Offset);

		if self.State then
			updateContents()
		end
	end)
	
	self.Obj = template
	self.State = data.State or false
	self.DB = false
	
	--// Dragging
	
	task.spawn(function()
		local Hovered = false
		local Holding = false
		local MoveCon = nil

		local InitialX, InitialY, UIInitialPos

		--// Functions

		local function Drag()
			if Holding == false then MoveCon:Disconnect(); return end
			local distanceMovedX = InitialX - mouse.X
			local distanceMovedY = InitialY - mouse.Y

			tweenservice:Create(template,TweenInfo.new(.3),{
				Position = UIInitialPos - UDim2.new(0, distanceMovedX, 0, distanceMovedY)
			}):Play()
			--template.Position = UIInitialPos - UDim2.new(0, distanceMovedX, 0, distanceMovedY)
		end

		--// Connections

		template.MouseEnter:Connect(function()
			Hovered = true
		end)

		template.MouseLeave:Connect(function()
			Hovered = false
		end)

		uis.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Holding = Hovered
				if Holding then
					InitialX, InitialY = mouse.X, mouse.Y
					UIInitialPos = template.Position

					MoveCon = mouse.Move:Connect(Drag)
				end
			end
		end)

		uis.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Holding = false
			end
		end)
	end)
	
	
	if self.State == false then
		contents.Size = UDim2.new(1, 0, 1, 0)
		toggle.Rotation = 90
	end
	
	
	function self:SetState(bool)
		if self.DB then return end
		self.DB = true
		
		self.State = bool or not self.State
		
		local speed = 1
		local size = layout.AbsoluteContentSize;
		local padding = layout.Parent.UIPadding;
		size = size + Vector2.new(0, padding.PaddingBottom.Offset + padding.PaddingTop.Offset);
		
		if self.State == true then
			--contents.ScrollingEnabled = true
			
			tweenservice:Create(toggle, TweenInfo.new(speed/2,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{
				Rotation = 180
			}):Play()
			
			tweenservice:Create(contents, TweenInfo.new(speed,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{
				Size = UDim2.new(1, 0, 0, size.Y)
			}):Play()
			task.wait(speed)
			self.DB = false
		else
			
			--contents.ScrollingEnabled = false
			
			tweenservice:Create(toggle, TweenInfo.new(speed/2,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{
				Rotation = 90
			}):Play()
			
			tweenservice:Create(contents, TweenInfo.new(speed/1,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{
				Size = UDim2.new(1, 0, 0.9, 0)
			}):Play()
			task.wait(speed)
			self.DB = false
		end
		
	end

	function doKeyTextbox(TextBox)
		wait()
		local connection
		local keyCode
		
		connection = uis.InputBegan:Connect(function(input, proccessed)
			if input.KeyCode == Enum.KeyCode.Unknown then
				TextBox:ReleaseFocus()
				connection:Disconnect()
				keyCode = Enum.KeyCode.ButtonL1
				return
			end
			TextBox.Text = input.KeyCode.Name
			keyCode = input.KeyCode
			TextBox:ReleaseFocus()
			connection:Disconnect()
		end)
		repeat task.wait() until keyCode ~= nil
		return keyCode
	end
	
	local function addBindButton(parent, data)
		local TextBox = Instance.new("TextBox")
		local AspectRatio = Instance.new("UIAspectRatioConstraint")
		local UIStroke = Instance.new("UIStroke",TextBox)
		local UICorner = Instance.new("UICorner",TextBox)
		local contraint = Instance.new("UITextSizeConstraint",TextBox)

		--Properties:

		TextBox.Parent = parent
		TextBox.AnchorPoint = Vector2.new(1, 0.5)
		TextBox.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
		TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.BorderSizePixel = 0
		TextBox.Position = UDim2.new(0.95, 0, 0.5, 0)
		TextBox.Size = UDim2.new(0, 40, 0.699999988, 0)
		TextBox.Font = Enum.Font.BuilderSans
		TextBox.Text = ""
		TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.TextScaled = true
		TextBox.Visible = false
		TextBox.TextSize = 17.000
		TextBox.TextWrapped = true
		
		contraint.MaxTextSize = 17

		AspectRatio.Name = "AspectRatio"
		AspectRatio.Parent = TextBox
		
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke.Color = Color3.fromRGB(77, 77, 77)
		
		UICorner.CornerRadius = UDim.new(0, 4)
		
		parent.MouseEnter:Connect(function()
			if data.ContextOpen then return end
			TextBox.Visible = true
		end)
		
		parent.MouseLeave:Connect(function()
			repeat task.wait() until not TextBox:IsFocused()
			if TextBox.Text ~= "" then return end
			TextBox.Visible = false
		end)
		
		TextBox.Focused:Connect(function()
			local key = doKeyTextbox(TextBox)
			bindObject(data, key)
		end)
		
		return TextBox
	end
	
	function slider(slider : CanvasGroup, min, max)

		local sliderMovedEvent = Instance.new("BindableEvent")
	
		local sliderConnection
		local endInputConnection
		slider.InputBegan:Connect(function(input : InputObject)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				local function mouseMoved()
					local sliderAbsolutePos = slider.AbsolutePosition
					local sliderAbsoluteSize = slider.AbsoluteSize
					local minXPos = sliderAbsolutePos.X
					local maxXPos = sliderAbsolutePos.X + sliderAbsoluteSize.X
					local range = max - min

					if mouse.X < minXPos then
						slider.Bar.Size = UDim2.new(0, 0, 1, 0)
					elseif mouse.X > maxXPos then
						slider.Bar.Size = UDim2.new(1, 0, 1, 0)
					else
						slider.Bar.Size = UDim2.new(0, mouse.X - minXPos, 1, 0)
					end
		
					sliderMovedEvent:Fire(slider.Bar.AbsoluteSize.X / sliderAbsoluteSize.X * range + min)
				end
				mouseMoved()
				sliderConnection = mouse.Move:Connect(mouseMoved)
		
				endInputConnection = uis.InputEnded:Connect(function(input, gp)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						sliderConnection:Disconnect()
						endInputConnection:Disconnect()
					end
				end)
			end
		end)
	
		return sliderMovedEvent.Event
	end

	function rightclickArgument(data)
		data.Obj.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
		if data.Arguments ~= nil then
			local button : TextButton = data.Obj
			if data.ContextOpen == nil then
				data.ContextOpen = false 
				
				local mainContent = Instance.new("Frame",button)
				mainContent.Name = "ArgumentContents"
				mainContent.BorderSizePixel = 0
				mainContent.AnchorPoint = Vector2.new(0.5, 0)
				mainContent.Size = UDim2.new(1., 0, 1, 0)
				mainContent.Position = UDim2.new(0.5, 0, 0, 23)
				mainContent.BackgroundTransparency = 0
				mainContent.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
				mainContent.Visible = false
				local layout = Instance.new("UIListLayout",mainContent)
				layout.Padding = UDim.new(0, 10)

				local thesigma = Instance.new("UIPadding",mainContent)
				thesigma.PaddingTop = UDim.new(0, 5)
				thesigma.PaddingRight = UDim.new(0, 5)
				thesigma.PaddingLeft = UDim.new(0, 5)

				for _,argument in pairs(data.Arguments) do
					local arg = Instance.new("Frame",mainContent)
					arg.BackgroundTransparency = 1
					arg.Size = UDim2.new(1, 0, 0, 25)

					local listlayout = Instance.new("UIListLayout",arg)
					listlayout.FillDirection = Enum.FillDirection.Horizontal
					listlayout.HorizontalFlex = Enum.UIFlexAlignment.Fill
					listlayout.Padding = UDim.new(0, 5)
					listlayout.SortOrder = Enum.SortOrder.Name

					local argTitle = Instance.new("TextLabel",arg)
					argTitle.Name = "a"
					argTitle.BackgroundTransparency = 1
					argTitle.AutomaticSize = Enum.AutomaticSize.X
					argTitle.Size = UDim2.new(0, 0, 1, 0)
					argTitle.Text = argument.Title or argument.Name
					argTitle.Text = argTitle.Text..":"
					argTitle.TextScaled = true
					argTitle.TextSize = 20
					argTitle.TextColor3 = Color3.fromRGB(255,255,255)
					argTitle.Font = Enum.Font.BuilderSans
					
					--local max = Instance.new("UITextSizeConstraint",argTitle)
					--max.MaxTextSize = 20

					if argument.Type == "Input" then
						local box = Instance.new("TextBox")
						local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
						local UICorner = Instance.new("UICorner")
						local stroke = Instance.new("UIStroke",box)

						--Properties:

						box.Name = "b"
						box.Parent = arg
						box.Active = false
						box.AnchorPoint = Vector2.new(0, 0)
						box.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
						box.Position = UDim2.new(0, 0, 0, 0)
						box.Selectable = false
						box.Size = UDim2.new(0.800000012, 0, 1, 0)
						box.TextColor3 = Color3.fromRGB(209, 209, 209)
						box.Text = argument.Name
						box.TextScaled = true
						box.TextWrapped = true

						UITextSizeConstraint.Parent = box
						UITextSizeConstraint.MaxTextSize = 10

						UICorner.CornerRadius = UDim.new(0, 6)
						UICorner.Parent = box

						stroke.Color = Color3.fromRGB(83, 83, 83)
						stroke.Thickness = 2
						stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

						box.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
							argument.Func(data,box.Text)
						end)
						
					elseif argument.Type == "Key" then
						local box = Instance.new("TextBox")
						local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
						local UICorner = Instance.new("UICorner")
						local stroke = Instance.new("UIStroke",box)

						--Properties:

						box.Name = "b"
						box.Parent = arg
						box.Active = false
						box.AnchorPoint = Vector2.new(0, 0)
						box.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
						box.Position = UDim2.new(0, 0, 0, 0)
						box.Selectable = false
						box.Size = UDim2.new(0.800000012, 0, 1, 0)
						box.TextColor3 = Color3.fromRGB(209, 209, 209)
						box.Text = argument.Name
						box.TextScaled = true
						box.TextWrapped = true

						UITextSizeConstraint.Parent = box
						UITextSizeConstraint.MaxTextSize = 10

						UICorner.CornerRadius = UDim.new(0, 6)
						UICorner.Parent = box

						stroke.Color = Color3.fromRGB(83, 83, 83)
						stroke.Thickness = 2
						stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

						box.Focused:Connect(function()
							local key = doKeyTextbox(box)
							argument.Func(data,key)
						end)

					elseif argument.Type == "Toggle" then
						listlayout.HorizontalFlex = Enum.UIFlexAlignment.None
						local box = Instance.new("TextButton")
						local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
						local UICorner = Instance.new("UICorner")
						local stroke = Instance.new("UIStroke",box)

						--Properties:

						box.Name = "b"
						box.Parent = arg
						box.Active = false
						box.AnchorPoint = Vector2.new(0, 0)
						box.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
						box.Position = UDim2.new(0, 0, 0, 0)
						box.Selectable = false
						box.Size = UDim2.new(0.15, 0, 1, 0)
						box.TextColor3 = Color3.fromRGB(209, 209, 209)
						box.TextScaled = true
						box.TextWrapped = true
						box.TextTransparency = 1

						UITextSizeConstraint.Parent = box
						UITextSizeConstraint.MaxTextSize = 10

						UICorner.CornerRadius = UDim.new(0, 6)
						UICorner.Parent = box

						stroke.Color = Color3.fromRGB(83, 83, 83)
						stroke.Thickness = 2
						stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

						box.MouseButton1Down:Connect(function()
							argument.State = not argument.State
							
							if argument.State == false then
								box.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
				
								if argument.OffFunc ~= nil then
									argument.OffFunc(data)
								end
							elseif argument.State then
								box.BackgroundColor3 = prismaGUI.config.Personalization["Toggle On Colour"]
								argument.NormalFunc(data)
							end
						end)
						
						argument.NormalFunc = argument.Func
						argument.Func = function()
							argument.State = not argument.State
							
							if argument.State == false then
								box.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
				
								if argument.OffFunc ~= nil then
									argument.OffFunc(data)
								end
							end
						end
						--// If performance problems occur change this 
						if argument.Repeating then
							runservice:BindToRenderStep(argument.Title,1,function()
							
								if argument.State then
									box.BackgroundColor3 = prismaGUI.config.Personalization["Toggle On Colour"]
									argument.NormalFunc(data)
								end
							end)
						end
					elseif argument.Type == "Slider" then

						listlayout:Destroy()
						argTitle.AnchorPoint = Vector2.new(0.5, 0)
						argTitle.Position = UDim2.new(0.5, 0, 0, 0)
						argTitle.Size = UDim2.new(1, 0, 0.5, 0)
						arg.Size = UDim2.new(1, 0, 0, 35)

						local container = Instance.new("CanvasGroup",arg)
						container.Size = UDim2.new(1, 0, 0.3, 0)
						container.AnchorPoint = Vector2.new(0.5, 1)
						container.Position = UDim2.new(0.5, 0, 0.9, 0)
						container.BorderSizePixel = 0
						container.BackgroundColor3 = Color3.fromRGB(49, 49, 49)

						Instance.new("UICorner",container).CornerRadius = UDim.new(1, 0)
						
						local label = Instance.new("TextLabel",arg)
						label.Size = UDim2.new(1, 0, 0.5, 0)
						label.AnchorPoint = Vector2.new(0.5, 1)
						label.Position = UDim2.new(0.5, 0, 1, 1)
						label.Font = Enum.Font.BuilderSans
						label.TextColor3 = Color3.fromRGB(255,255,255)
						label.BorderSizePixel = 0
						label.BackgroundTransparency = 1
						label.TextScaled = true
						label.Text = tostring(argument.Value)

						local maxSez = Instance.new("UITextSizeConstraint",label)
						maxSez.MaxTextSize = 15
						
						local bar = container:Clone()
						bar.Parent = container
						bar.Name = "Bar"
						bar.AnchorPoint = Vector2.new(0, 0.5)
						bar.Size = UDim2.new(0, 0, 1, 0)
						bar.Position = UDim2.new(0, 0, 0.5, 0)
						bar.BorderSizePixel = 0
						bar.BackgroundColor3 = prismaGUI.config.Personalization["Toggle On Colour"]

						local event : BindableEvent = slider(container, argument.Min, argument.Max)
						event:Connect(function(value)
							local val = math.floor(value + 0.5)
							val = (math.floor(val / argument.Increment + 0.5) * argument.Increment)
							label.Text = tostring(val)
							argument.Value = val
							
							argument.Func(data, val)
						end)

					end
					
				end
			end
			data.ContextOpen = not data.ContextOpen
			local argumentContents = button:FindFirstChild("ArgumentContents")

			if data.ContextOpen then --// Open
				tweenservice:Create(button, TweenInfo.new(0.2), {
					Size = UDim2.new(1, 0, 0, 40 + argumentContents:FindFirstChildOfClass("UIListLayout").AbsoluteContentSize.Y)
				}):Play()

				button:FindFirstChildOfClass("UIPadding").PaddingTop = UDim.new(0, 10)

				button.TextYAlignment = Enum.TextYAlignment.Top			
				button:FindFirstChildOfClass("TextBox").Visible = false
				argumentContents.Visible = true

			else --// Close
				tweenservice:Create(button, TweenInfo.new(0.2), {
					Size = UDim2.new(1, 0, 0, 35)
				}):Play()

				button:FindFirstChildOfClass("UIPadding").PaddingTop = UDim.new(0, 0)

				button.TextYAlignment = Enum.TextYAlignment.Center
				button:FindFirstChildOfClass("TextBox").Visible = true
				argumentContents.Visible = false
			end
		end
	end
	
	function self:Button(data)
		
		if data.Func == nil then
			warn("No function provided for button")
			return
		end
		
		local TextButton = Instance.new("TextButton")
		local UIPadding = Instance.new("UIPadding")
		local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

		--Properties:

		TextButton.Parent = contents
		TextButton.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
		TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextButton.BorderSizePixel = 0
		TextButton.Size = UDim2.new(1, 0, 0, 35)
		TextButton.Font = Enum.Font.BuilderSans
		TextButton.Text = "  "..data.Name or "Button"
		TextButton.TextColor3 = Color3.fromRGB(209, 209, 209)
		TextButton.TextScaled = true
		TextButton.TextSize = 14.000
		TextButton.TextWrapped = true
		TextButton.TextXAlignment = Enum.TextXAlignment.Left
		TextButton.ClipsDescendants = true
		TextButton.Name = data.Name or "Button"
		TextButton.AutoButtonColor = false

		UIPadding.Parent = TextButton
		--UIPadding.PaddingLeft = UDim.new(0.0500000007, 0)
		
		
		UITextSizeConstraint.Parent = TextButton
		UITextSizeConstraint.MaxTextSize = 14
		
		TextButton.MouseButton1Down:Connect(function()
			if data.ContextOpen then return end
			task.spawn(function()
				data.Func(data)
			end)
			
			local c = Instance.new("ImageLabel")
			c.Name = "Sample"
			c.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			c.BackgroundTransparency = 1.000
			c.BorderColor3 = Color3.fromRGB(27, 42, 53)
			c.Image = "http://www.roblox.com/asset/?id=4560909609"
			c.ImageColor3 = Color3.fromRGB(255, 255, 255)
			c.ImageTransparency = 0.600
			c.Parent = TextButton
			local x, y = (mouse.X - c.AbsolutePosition.X), (mouse.Y - c.AbsolutePosition.Y)
			c.Position = UDim2.new(0, x, 0, y)
			local len, size = 0.7, nil
			if TextButton.AbsoluteSize.X >= TextButton.AbsoluteSize.Y then
				size = (TextButton.AbsoluteSize.X * 1.5)
			else
				size = (TextButton.AbsoluteSize.Y * 1.5)
			end
			c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
			
			tweenservice:Create(c, TweenInfo.new(len),{
				ImageTransparency = 1
			}):Play()
			task.wait(len)
			c:Destroy()

		end)
		
		local bindButton = addBindButton(TextButton, data)
		
		TextButton.MouseEnter:Connect(function()
			if data.ContextOpen then return end
			TextButton.BackgroundColor3 = prismaGUI.config.Personalization["Hover Colour"]
		end)
		TextButton.MouseLeave:Connect(function()
			repeat task.wait() until not bindButton:IsFocused()
			TextButton.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
		end)
		
		data.Obj = TextButton

		TextButton.MouseButton2Click:Connect(function()
			rightclickArgument(data)
		end)
		
		return {Data = data, Obj = TextButton}
	end
	
	function self:Toggle(data)

		if data.Func == nil then
			warn("No function provided for togglebutton")
			return
		end
        if data.State == nil then
            data.State = false
        end

		local TextButton = Instance.new("TextButton")
		local UIPadding = Instance.new("UIPadding")
		local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

		--Properties:

		TextButton.Parent = contents
		TextButton.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
		TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextButton.BorderSizePixel = 0
		TextButton.Size = UDim2.new(1, 0, 0, 35)
		TextButton.Font = Enum.Font.BuilderSans
		TextButton.Text = "  "..data.Name or "Button"
		TextButton.TextColor3 = Color3.fromRGB(209, 209, 209)
		TextButton.TextScaled = true
		TextButton.TextSize = 14.000
		TextButton.TextWrapped = true
		TextButton.TextXAlignment = Enum.TextXAlignment.Left
		TextButton.ClipsDescendants = true
		TextButton.Name = data.Name or "Button"
		TextButton.AutoButtonColor = false

		UIPadding.Parent = TextButton
		--UIPadding.PaddingLeft = UDim.new(0.0500000007, 0)


		UITextSizeConstraint.Parent = TextButton
		UITextSizeConstraint.MaxTextSize = 14

		TextButton.MouseButton1Down:Connect(function()
			if data.ContextOpen then return end
			data.State = not data.State
			
			if data.State == false then
				TextButton.BackgroundColor3 = Color3.fromRGB(39, 39, 39)

				if data.OffFunc ~= nil then
					data.OffFunc(data)
				end
			end
		end)
		
		data.NormalFunc = data.Func
		data.Func = function()
			data.State = not data.State
			
			if data.State == false then
				TextButton.BackgroundColor3 = Color3.fromRGB(39, 39, 39)

				if data.OffFunc ~= nil then
					data.OffFunc(data)
				end
			end
		end

		local bindButton = addBindButton(TextButton, data)

		TextButton.MouseEnter:Connect(function()
			if data.ContextOpen then return end
			TextButton.BackgroundColor3 = prismaGUI.config.Personalization["Hover Colour"]
		end)
		TextButton.MouseLeave:Connect(function()
			repeat task.wait() until not bindButton:IsFocused()
			TextButton.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
		end)
		
		
		--// If performance problems occur change this 
		runservice:BindToRenderStep(data.Name,1,function()
			
			if data.State then
				TextButton.BackgroundColor3 = prismaGUI.config.Personalization["Toggle On Colour"]
				data.NormalFunc(data)
			end
		end)

		data.Obj = TextButton

		TextButton.MouseButton2Click:Connect(function()
			rightclickArgument(data)
		end)

		return {Data = data, Obj = TextButton}
	end
	
	return self
end

function prismaGUI:Notify(message, type)
	
end

end

return prismaGUI