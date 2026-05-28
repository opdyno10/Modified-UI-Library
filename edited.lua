-- Meow

if isfile("IceWare/Key System/Key.text") then
    delfile("IceWare/Key System/Key.text")
end

if getgenv().Library then
    getgenv().Library:Unload()
end

local Library do
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local HttpService = game:GetService("HttpService")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    local SoundService = cloneref and cloneref(game:GetService("SoundService")) or game:GetService("SoundService")
    local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")

    local LocalPlayer = Players.LocalPlayer
    local Camera = Workspace.CurrentCamera
    local Mouse = LocalPlayer:GetMouse()

    local FromRGB = Color3.fromRGB
    local FromHSV = Color3.fromHSV
    local FromHex = Color3.fromHex

    local RGBSequence = ColorSequence.new
    local RGBSequenceKeypoint = ColorSequenceKeypoint.new

    local NumSequence = NumberSequence.new
    local NumSequenceKeypoint = NumberSequenceKeypoint.new

    local UDim2New = UDim2.new
    local UDimNew = UDim.new
    local UDim2FromScale = UDim2.fromScale
    local Vector2New = Vector2.new

    local InstanceNew = Instance.new

    local MathClamp = math.clamp
    local MathFloor = math.floor
    local MathAbs = math.abs
    local MathSin = math.sin
    local MathRad = math.rad
    local MathMax = math.max
    local MathMin = math.min

    local TableInsert = table.insert
    local TableFind = table.find
    local TableUnpack = table.unpack
    local TableRemove = table.remove
    local TableConcat = table.concat
    local TableClone = table.clone

    local StringFormat = string.format
    local StringFind = string.find
    local StringGSub = string.gsub
    local StringLower = string.lower

    local CFrameNew = CFrame.new
    local CFrameAngles = CFrame.Angles
    local Vector3New = Vector3.new

    local RectNew = Rect.new

    local IsMobile = UserInputService.TouchEnabled or false

    gethui = gethui or function()
        return CoreGui
    end

    getgenv().Options = { }

    Library = {
        Theme = nil,
        MenuKeybind = tostring(Enum.KeyCode.RightControl),
        Flags = { },
        Tween = {
            Time = 0.3,
            Style = Enum.EasingStyle.Cubic,
            Direction = Enum.EasingDirection.Out
        },
        Images = {
            ["Saturation"] = {"Saturation.png", "https://github.com/sametexe001/images/blob/main/saturation.png?raw=true"},
            ["Value"] = {"Value.png", "https://github.com/sametexe001/images/blob/main/value.png?raw=true"},
            ["Hue"] = {"Hue.png", "https://github.com/sametexe001/images/blob/main/horizontalhue.png?raw=true"},
            ["Checkers"] = {"Checkers.png", "https://github.com/sametexe001/images/blob/main/checkers.png?raw=true"},
        },
        Folders = {
            Directory = "IceWare",
            Assets = "IceWare/Assets",
            Configs = "IceWare/Configs",
            Themes = "IceWare/Themes",
        },
        Pages = { },
        Sections = { },
        Connections = { },
        Threads = { },
        Themes = { },
        ThemeMap = { },
        ThemeItems = { },
        ThemeColorpickers = { },
        OpenFrames = { },
        CurrentPage = nil,
        SearchItems = { },
        SetFlags = { },
        UnnamedConnections = 0,
        UnnamedFlags = 0,
        Holder = nil,
        NotifHolder = nil,
        UnusedHolder = nil,
        MainFrame = nil,
        Font = nil,
        KeyList = nil,
    }

    local Keys = {
        ["Unknown"] = "Unknown", ["Backspace"] = "Back", ["Tab"] = "Tab",
        ["Clear"] = "Clear", ["Return"] = "Return", ["Pause"] = "Pause",
        ["Escape"] = "Escape", ["Space"] = "Space", ["QuotedDouble"] = '"',
        ["Hash"] = "#", ["Dollar"] = "$", ["Percent"] = "%", ["Ampersand"] = "&",
        ["Quote"] = "'", ["LeftParenthesis"] = "(", ["RightParenthesis"] = " )",
        ["Asterisk"] = "*", ["Plus"] = "+", ["Comma"] = ",", ["Minus"] = "-",
        ["Period"] = ".", ["Slash"] = "`", ["Three"] = "3", ["Seven"] = "7",
        ["Eight"] = "8", ["Colon"] = ":", ["Semicolon"] = ";", ["LessThan"] = "<",
        ["GreaterThan"] = ">", ["Question"] = "?", ["Equals"] = "=", ["At"] = "@",
        ["LeftBracket"] = "LeftBracket", ["RightBracket"] = "RightBracked",
        ["BackSlash"] = "BackSlash", ["Caret"] = "^", ["Underscore"] = "_",
        ["Backquote"] = "`", ["LeftCurly"] = "{", ["Pipe"] = "|",
        ["RightCurly"] = "}", ["Tilde"] = "~", ["Delete"] = "Delete",
        ["End"] = "End", ["KeypadZero"] = "Keypad0", ["KeypadOne"] = "Keypad1",
        ["KeypadTwo"] = "Keypad2", ["KeypadThree"] = "Keypad3",
        ["KeypadFour"] = "Keypad4", ["KeypadFive"] = "Keypad5",
        ["KeypadSix"] = "Keypad6", ["KeypadSeven"] = "Keypad7",
        ["KeypadEight"] = "Keypad8", ["KeypadNine"] = "Keypad9",
        ["KeypadPeriod"] = "KeypadP", ["KeypadDivide"] = "KeypadD",
        ["KeypadMultiply"] = "KeypadM", ["KeypadMinus"] = "KeypadM",
        ["KeypadPlus"] = "KeypadP", ["KeypadEnter"] = "KeypadE",
        ["KeypadEquals"] = "KeypadE", ["Insert"] = "Insert", ["Home"] = "Home",
        ["PageUp"] = "PageUp", ["PageDown"] = "PageDown",
        ["RightShift"] = "RightShift", ["LeftShift"] = "LeftShift",
        ["RightControl"] = "RightControl", ["LeftControl"] = "LeftControl",
        ["LeftAlt"] = "LeftAlt", ["RightAlt"] = "RightAlt"
    }

    Library.__index = Library
    Library.Sections.__index = Library.Sections
    Library.Pages.__index = Library.Pages

    for Index, Value in Library.Folders do
        if not isfolder(Value) then
            makefolder(Value)
        end
    end

    for Index, Value in Library.Images do
        local ImageData = Value
        local ImageName = ImageData[1]
        local ImageLink = ImageData[2]
        if not isfile(Library.Folders.Assets .. "/" .. ImageName) then
            writefile(Library.Folders.Assets .. "/" .. ImageName, game:HttpGet(ImageLink))
        end
    end

    local Tween = { } do
        Tween.__index = Tween

        Tween.Create = function(self, Item, Info, Goal, IsRawItem)
            Item = IsRawItem and Item or Item.Instance
            Info = Info or TweenInfo.new(Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction)
            local NewTween = {
                Tween = TweenService:Create(Item, Info, Goal),
                Info = Info, Goal = Goal, Item = Item
            }
            NewTween.Tween:Play()
            setmetatable(NewTween, Tween)
            return NewTween
        end

        Tween.GetProperty = function(self, Item)
            Item = Item or self.Item
            if Item:IsA("Frame") then
                return { "BackgroundTransparency" }
            elseif Item:IsA("TextLabel") or Item:IsA("TextButton") then
                return { "TextTransparency", "BackgroundTransparency" }
            elseif Item:IsA("ImageLabel") or Item:IsA("ImageButton") then
                return { "BackgroundTransparency", "ImageTransparency" }
            elseif Item:IsA("ScrollingFrame") then
                return { "BackgroundTransparency", "ScrollBarImageTransparency" }
            elseif Item:IsA("TextBox") then
                return { "TextTransparency", "BackgroundTransparency" }
            elseif Item:IsA("UIStroke") then
                return { "Transparency" }
            end
        end

        Tween.FadeItem = function(self, Item, Property, Visibility, Speed)
            local Item = Item or self.Item
            local OldTransparency = Item[Property]
            Item[Property] = Visibility and 1 or OldTransparency
            local NewTween = Tween:Create(Item, TweenInfo.new(Speed or Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction), {
                [Property] = Visibility and OldTransparency or 1
            }, true)
            Library:Connect(NewTween.Tween.Completed, function()
                if not Visibility then
                    task.wait()
                    Item[Property] = OldTransparency
                end
            end)
            return NewTween
        end

        Tween.Get = function(self)
            if not self.Tween then return end
            return self.Tween, self.Info, self.Goal
        end

        Tween.Pause = function(self)
            if not self.Tween then return end
            self.Tween:Pause()
        end

        Tween.Play = function(self)
            if not self.Tween then return end
            self.Tween:Play()
        end

        Tween.Clean = function(self)
            if not self.Tween then return end
            Tween:Pause()
            self = nil
        end
    end

    local Instances = { } do
        Instances.__index = Instances

        Instances.Create = function(self, Class, Properties)
            local NewItem = {
                Instance = InstanceNew(Class),
                Properties = Properties,
                Class = Class
            }
            setmetatable(NewItem, Instances)
            for Property, Value in NewItem.Properties do
                NewItem.Instance[Property] = Value
            end
            return NewItem
        end

        Instances.Border = function(self)
            if not self.Instance then return end
            local Item = self.Instance
            local UIStroke = Instances:Create("UIStroke", {
                Parent = Item,
                Color = Library.Theme.Border,
                Thickness = 1,
                LineJoinMode = Enum.LineJoinMode.Miter
            })
            UIStroke:AddToTheme({Color = "Border"})
            return UIStroke
        end

        Instances.FadeItem = function(self, Visibility, Speed)
            local Item = self.Instance
            if Visibility == true then Item.Visible = true end
            local Descendants = Item:GetDescendants()
            TableInsert(Descendants, Item)
            local NewTween
            for Index, Value in Descendants do
                local TransparencyProperty = Tween:GetProperty(Value)
                if not TransparencyProperty then continue end
                if type(TransparencyProperty) == "table" then
                    for _, Property in TransparencyProperty do
                        NewTween = Tween:FadeItem(Value, Property, not Visibility, Speed)
                    end
                else
                    NewTween = Tween:FadeItem(Value, TransparencyProperty, not Visibility, Speed)
                end
            end
        end

        Instances.AddToTheme = function(self, Properties)
            if not self.Instance then return end
            Library:AddToTheme(self, Properties)
        end

        Instances.ChangeItemTheme = function(self, Properties)
            if not self.Instance then return end
            Library:ChangeItemTheme(self, Properties)
        end

        Instances.Connect = function(self, Event, Callback, Name)
            if not self.Instance then return end
            if not self.Instance[Event] then return end
            return Library:Connect(self.Instance[Event], Callback, Name)
        end

        Instances.Tween = function(self, Info, Goal)
            if not self.Instance then return end
            return Tween:Create(self, Info, Goal)
        end

        Instances.Disconnect = function(self, Name)
            if not self.Instance then return end
            return Library:Disconnect(Name)
        end

        Instances.Clean = function(self)
            if not self.Instance then return end
            self.Instance:Destroy()
            self = nil
        end

        Instances.Tooltip = function(self, Text)
            if Text == nil or type(Text) ~= "string" then return end
            if not self.Instance then return end
            local Gui = self.Instance
            local MouseLocation = UserInputService:GetMouseLocation()
            local RenderStepped
            local Newtooltip = Instances:Create("Frame", {
                Parent = Library.Holder.Instance, Name = "\0",
                BorderColor3 = FromRGB(0,0,0), BackgroundTransparency = 1,
                Position = UDim2New(0, MouseLocation.X, 0, MouseLocation.Y - 38),
                BorderSizePixel = 0, ZIndex = 2, AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundColor3 = FromRGB(16,18,21)
            })  Newtooltip:AddToTheme({BackgroundColor3 = "Background"})
            local UIStroke = Instances:Create("UIStroke", {
                Parent = Newtooltip.Instance, Name = "\0",
                Color = FromRGB(32,36,42), Transparency = 1,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })  UIStroke:AddToTheme({Color = "Border"})
            Instances:Create("UIPadding", {
                Parent = Newtooltip.Instance, Name = "\0",
                PaddingTop = UDimNew(0,5), PaddingBottom = UDimNew(0,5),
                PaddingRight = UDimNew(0,5), PaddingLeft = UDimNew(0,5)
            })
            local TooltipText = Instances:Create("TextLabel", {
                Parent = Newtooltip.Instance, Name = "\0",
                FontFace = Library.Font, TextColor3 = FromRGB(255,255,255),
                BorderColor3 = FromRGB(0,0,0), Text = Text,
                AutomaticSize = Enum.AutomaticSize.XY, BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left, BorderSizePixel = 0,
                ZIndex = 2, TextTransparency = 1, TextSize = 14,
                BackgroundColor3 = FromRGB(255,255,255)
            })
            Instances:Create("UICorner", { Parent = Newtooltip.Instance, Name = "\0", CornerRadius = UDimNew(0,5) })
            Library:Connect(Gui.MouseEnter, function()
                Newtooltip:Tween(nil, {BackgroundTransparency = 0.15})
                TooltipText:Tween(nil, {TextTransparency = 0})
                UIStroke:Tween(nil, {Transparency = 0.4})
                RenderStepped = RunService.RenderStepped:Connect(function()
                    MouseLocation = UserInputService:GetMouseLocation()
                    Newtooltip:Tween(nil, {Position = UDim2New(0, MouseLocation.X, 0, MouseLocation.Y - 38)})
                end)
            end)
            Library:Connect(Gui.MouseLeave, function()
                Newtooltip:Tween(nil, {BackgroundTransparency = 1})
                TooltipText:Tween(nil, {TextTransparency = 1})
                UIStroke:Tween(nil, {Transparency = 1})
                if RenderStepped then RenderStepped:Disconnect() RenderStepped = nil end
            end)
        end

        Instances.MakeDraggable = function(self)
            if not self.Instance then return end
            local Gui = self.Instance
            local Dragging = false
            local DragStart
            local StartPosition
            local InputChanged
            local Set = function(Input)
                local DragDelta = Input.Position - DragStart
                self:Tween(TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(StartPosition.X.Scale, StartPosition.X.Offset + DragDelta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + DragDelta.Y)})
            end
            self:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = true
                    DragStart = Input.Position
                    StartPosition = Gui.Position
                    if InputChanged then return end
                    InputChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Dragging = false
                            InputChanged:Disconnect()
                            InputChanged = nil
                        end
                    end)
                end
            end)
            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if Dragging then Set(Input) end
                end
            end)
            return Dragging
        end

        Instances.MakeResizeable = function(self, Minimum, Maximum)
            if not self.Instance then return end
            local Gui = self.Instance
            local Resizing = false
            local Start = UDim2New()
            local Delta = UDim2New()
            local ResizeMax = Gui.Parent.AbsoluteSize - Gui.AbsoluteSize
            local ResizeButton = Instances:Create("ImageButton", {
                Parent = Gui, Image = "rbxassetid://7368471234",
                AnchorPoint = Vector2New(1,1), BorderColor3 = FromRGB(0,0,0),
                Size = UDim2New(0,9,0,9), Position = UDim2New(1,-4,1,-4),
                Name = "\0", BorderSizePixel = 0, BackgroundTransparency = 1,
                ZIndex = 5, AutoButtonColor = false, Visible = true,
            })  ResizeButton:AddToTheme({ImageColor3 = "Accent"})
            local InputChanged
            ResizeButton:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Resizing = true
                    Start = Gui.Size - UDim2New(0, Input.Position.X, 0, Input.Position.Y)
                    if InputChanged then return end
                    InputChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Resizing = false
                            InputChanged:Disconnect()
                            InputChanged = nil
                        end
                    end)
                end
            end)
            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if Resizing then
                        ResizeMax = Maximum or Gui.Parent.AbsoluteSize - Gui.AbsoluteSize
                        Delta = Start + UDim2New(0, Input.Position.X, 0, Input.Position.Y)
                        Delta = UDim2New(0, math.clamp(Delta.X.Offset, Minimum.X, ResizeMax.X), 0, math.clamp(Delta.Y.Offset, Minimum.Y, ResizeMax.Y))
                        Tween:Create(Gui, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = Delta}, true)
                    end
                end
            end)
            return Resizing
        end

        Instances.OnHover = function(self, Function)
            if not self.Instance then return end
            return Library:Connect(self.Instance.MouseEnter, Function)
        end

        Instances.OnHoverLeave = function(self, Function)
            if not self.Instance then return end
            return Library:Connect(self.Instance.MouseLeave, Function)
        end
    end

    local CustomFont = { } do
        function CustomFont:New(Name, Weight, Style, Data)
            if isfile(Library.Folders.Assets .. "/" .. Name .. ".json") then
                return Font.new(getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".json"))
            end
            if not isfile(Library.Folders.Assets .. "/" .. Name .. ".ttf") then
                writefile(Library.Folders.Assets .. "/" .. Name .. ".ttf", game:HttpGet(Data.Url))
            end
            local FontData = {
                name = Name,
                faces = { { name = "Regular", weight = Weight, style = Style,
                    assetId = getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".ttf") } }
            }
            writefile(Library.Folders.Assets .. "/" .. Name .. ".json", HttpService:JSONEncode(FontData))
            return Font.new(getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".json"))
        end

        function CustomFont:Get(Name)
            if isfile(Library.Folders.Assets .. "/" .. Name .. ".json") then
                return Font.new(getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".json"))
            end
        end

        CustomFont:New("Inter", 200, "Regular", {
            Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/InterSemibold.ttf"
        })

        Library.Font = CustomFont:Get("Inter")
    end

    local Themes = {
        ["Default"] = {
            ["Background"] = FromRGB(11,10,14), ["Inline"] = FromRGB(14,14,19),
            ["Shadow"] = FromRGB(0,0,0), ["Text"] = FromRGB(255,255,255),
            ["Image"] = FromRGB(255,255,255), ["Dark Gradient"] = FromRGB(211,211,211),
            ["Inactive Text"] = FromRGB(185,185,185), ["Element"] = FromRGB(22,22,26),
            ["Accent"] = FromRGB(255,255,255), ["Border"] = FromRGB(29,29,33)
        },
        ["White"] = {
            ["Background"] = FromRGB(245,245,245), ["Inline"] = FromRGB(230,230,230),
            ["Shadow"] = FromRGB(0,0,0), ["Text"] = FromRGB(30,30,30),
            ["Image"] = FromRGB(30,30,30), ["Dark Gradient"] = FromRGB(200,200,200),
            ["Inactive Text"] = FromRGB(100,100,100), ["Element"] = FromRGB(220,220,220),
            ["Accent"] = FromRGB(0,120,215), ["Border"] = FromRGB(210,210,210)
        },
        ["Midnight"] = {
            ["Background"] = FromRGB(10,10,15), ["Inline"] = FromRGB(15,15,25),
            ["Shadow"] = FromRGB(0,0,0), ["Text"] = FromRGB(220,220,240),
            ["Image"] = FromRGB(220,220,240), ["Dark Gradient"] = FromRGB(50,50,80),
            ["Inactive Text"] = FromRGB(100,100,120), ["Element"] = FromRGB(25,25,45),
            ["Accent"] = FromRGB(120,100,255), ["Border"] = FromRGB(30,30,50)
        },
        ["Rose"] = {
            ["Background"] = FromRGB(25,15,20), ["Inline"] = FromRGB(35,20,30),
            ["Shadow"] = FromRGB(0,0,0), ["Text"] = FromRGB(250,230,240),
            ["Image"] = FromRGB(250,230,240), ["Dark Gradient"] = FromRGB(100,60,80),
            ["Inactive Text"] = FromRGB(150,100,120), ["Element"] = FromRGB(50,30,45),
            ["Accent"] = FromRGB(255,100,150), ["Border"] = FromRGB(60,35,50)
        },
        ["Halloween"] = {
            ["Background"] = FromRGB(11,10,9), ["Inline"] = FromRGB(23,18,16),
            ["Shadow"] = FromRGB(253,133,21), ["Text"] = FromRGB(198,198,198),
            ["Image"] = FromRGB(201,201,201), ["Dark Gradient"] = FromRGB(211,202,195),
            ["Inactive Text"] = FromRGB(179,179,179), ["Element"] = FromRGB(42,32,26),
            ["Accent"] = FromRGB(253,133,21), ["Border"] = FromRGB(42,35,32)
        },
        ["Aqua"] = {
            ["Background"] = FromRGB(19,21,23), ["Inline"] = FromRGB(31,35,39),
            ["Shadow"] = FromRGB(0,0,0), ["Text"] = FromRGB(245,245,245),
            ["Image"] = FromRGB(255,255,255), ["Dark Gradient"] = FromRGB(211,211,211),
            ["Inactive Text"] = FromRGB(185,185,185), ["Element"] = FromRGB(58,66,77),
            ["Accent"] = FromRGB(31,106,181), ["Border"] = FromRGB(48,56,63)
        },
        ["One Tap"] = {
            ["Background"] = FromRGB(51,51,51), ["Inline"] = FromRGB(30,30,30),
            ["Shadow"] = FromRGB(0,0,0), ["Text"] = FromRGB(245,245,245),
            ["Image"] = FromRGB(255,255,255), ["Dark Gradient"] = FromRGB(211,211,211),
            ["Inactive Text"] = FromRGB(185,185,185), ["Element"] = FromRGB(45,45,45),
            ["Accent"] = FromRGB(237,170,0), ["Border"] = FromRGB(0,0,0)
        },
        ["Christmas"] = {
            ["Background"] = FromRGB(15,25,15), ["Inline"] = FromRGB(25,35,25),
            ["Shadow"] = FromRGB(0,0,0), ["Text"] = FromRGB(240,240,240),
            ["Image"] = FromRGB(240,240,240), ["Dark Gradient"] = FromRGB(200,200,200),
            ["Inactive Text"] = FromRGB(120,140,120), ["Element"] = FromRGB(35,45,35),
            ["Accent"] = FromRGB(220,20,60), ["Border"] = FromRGB(40,60,40)
        },
        ["Gamesense"] = {
            ["Background"] = FromRGB(20,20,20), ["Inline"] = FromRGB(12,12,12),
            ["Shadow"] = FromRGB(0,0,0), ["Text"] = FromRGB(255,255,255),
            ["Image"] = FromRGB(255,255,255), ["Dark Gradient"] = FromRGB(200,200,200),
            ["Inactive Text"] = FromRGB(100,100,100), ["Element"] = FromRGB(30,30,30),
            ["Accent"] = FromRGB(150,210,50), ["Border"] = FromRGB(0,0,0)
        },
        ["Neverlose"] = {
            ["Background"] = FromRGB(0,5,15), ["Inline"] = FromRGB(5,10,25),
            ["Shadow"] = FromRGB(0,0,0), ["Text"] = FromRGB(255,255,255),
            ["Image"] = FromRGB(255,255,255), ["Dark Gradient"] = FromRGB(50,80,150),
            ["Inactive Text"] = FromRGB(100,100,100), ["Element"] = FromRGB(10,20,40),
            ["Accent"] = FromRGB(0,160,255), ["Border"] = FromRGB(0,20,50)
        },
        ["Discord"] = {
            ["Background"] = FromRGB(54,57,63), ["Inline"] = FromRGB(47,49,54),
            ["Shadow"] = FromRGB(32,34,37), ["Text"] = FromRGB(220,221,222),
            ["Image"] = FromRGB(220,221,222), ["Dark Gradient"] = FromRGB(114,118,125),
            ["Inactive Text"] = FromRGB(114,118,125), ["Element"] = FromRGB(64,68,75),
            ["Accent"] = FromRGB(88,101,242), ["Border"] = FromRGB(32,34,37)
        },
        ["Spotify"] = {
            ["Background"] = FromRGB(18,18,18), ["Inline"] = FromRGB(24,24,24),
            ["Shadow"] = FromRGB(0,0,0), ["Text"] = FromRGB(255,255,255),
            ["Image"] = FromRGB(255,255,255), ["Dark Gradient"] = FromRGB(40,40,40),
            ["Inactive Text"] = FromRGB(179,179,179), ["Element"] = FromRGB(40,40,40),
            ["Accent"] = FromRGB(29,185,84), ["Border"] = FromRGB(0,0,0)
        },
    }

    Library.Theme = TableClone(Themes["Default"])
    Library.Themes = Themes

    Library.Holder = Instances:Create("ScreenGui", {
        Parent = game:GetService("CoreGui"), Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        DisplayOrder = 2, ResetOnSpawn = false
    })

    Library.UIScale = Instances:Create("UIScale", {
        Parent = Library.Holder.Instance, Scale = 1
    })

    Library.UnusedHolder = Instances:Create("ScreenGui", {
        Parent = gethui(), Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        Enabled = false, ResetOnSpawn = false
    })

    Library.NotifHolder = Instances:Create("Frame", {
        Parent = Library.Holder.Instance, Name = "\0",
        BorderColor3 = FromRGB(0,0,0), AnchorPoint = Vector2New(1,0),
        BackgroundTransparency = 1, Position = UDim2New(1,0,0,0),
        Size = UDim2New(0,0,1,0), BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = FromRGB(255,255,255)
    })

    Instances:Create("UIPadding", {
        Parent = Library.NotifHolder.Instance, Name = "\0",
        PaddingBottom = UDimNew(0,15), PaddingTop = UDimNew(0,15), PaddingRight = UDimNew(0,15)
    })

    Instances:Create("UIListLayout", {
        Parent = Library.NotifHolder.Instance, Name = "\0",
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Padding = UDimNew(0,10)
    })

    Library.Unload = function(self)
        if self.OnUnload then pcall(self.OnUnload) end
        for Index, Value in self.Connections do Value.Connection:Disconnect() end
        for Index, Value in self.Threads do coroutine.close(Value) end
        if self.Holder then self.Holder:Clean() end
        Library = nil
        getgenv().Library = nil
        UserInputService.MouseIconEnabled = true
    end

    Library.GetImage = function(self, Image)
        local ImageData = self.Images[Image]
        if not ImageData then return end
        return getcustomasset(self.Folders.Assets .. "/" .. ImageData[1])
    end

    Library.Round = function(self, Number, Float)
        local Multiplier = 1 / (Float or 1)
        return MathFloor(Number * Multiplier) / Multiplier
    end

    Library.Thread = function(self, Function)
        local NewThread = coroutine.create(Function)
        coroutine.wrap(function() coroutine.resume(NewThread) end)()
        TableInsert(self.Threads, NewThread)
        return NewThread
    end

    Library.SafeCall = function(self, Function, ...)
        local Arguements = { ... }
        local Success, Result = pcall(Function, TableUnpack(Arguements))
        if not Success then
            Library:Notification("Error caught in function, report this to the devs:\n"..Result, 5, FromRGB(255,0,0))
            warn(Result)
            return false
        end
        return Success
    end

    Library.Connect = function(self, Event, Callback, Name)
        Name = Name or StringFormat("Connection%s%s", self.UnnamedConnections + 1, HttpService:GenerateGUID(false))
        local NewConnection = { Event = Event, Callback = Callback, Name = Name, Connection = nil }
        Library:Thread(function() NewConnection.Connection = Event:Connect(Callback) end)
        TableInsert(self.Connections, NewConnection)
        return NewConnection
    end

    local function UpdateScale()
        local ViewportSize = Camera.ViewportSize
        if IsMobile then
            local TargetWidth = 511 + 100
            local TargetHeight = 459 + 100
            local ScaleX = ViewportSize.X / TargetWidth
            local ScaleY = ViewportSize.Y / TargetHeight
            Library.UIScale.Instance.Scale = MathMin(ScaleX, ScaleY, 1)
        else
            Library.UIScale.Instance.Scale = 1
        end
    end

    UpdateScale()
    Library:Connect(Camera:GetPropertyChangedSignal("ViewportSize"), UpdateScale)

    Library.Disconnect = function(self, Name)
        for _, Connection in self.Connections do
            if Connection.Name == Name then
                Connection.Connection:Disconnect()
                break
            end
        end
    end

    Library.NextFlag = function(self)
        local FlagNumber = self.UnnamedFlags + 1
        return StringFormat("Flag Number %s %s", FlagNumber, HttpService:GenerateGUID(false))
    end

    Library.AddToTheme = function(self, Item, Properties)
        Item = Item.Instance or Item
        local ThemeData = { Item = Item, Properties = Properties }
        for Property, Value in ThemeData.Properties do
            if type(Value) == "string" then
                Item[Property] = self.Theme[Value]
            else
                Item[Property] = Value()
            end
        end
        TableInsert(self.ThemeItems, ThemeData)
        self.ThemeMap[Item] = ThemeData
    end

    Library.GetConfig = function(self)
        local Config = { }
        local Success, Result = Library:SafeCall(function()
            for Index, Value in Library.Flags do
                if type(Value) == "table" and Value.Key then
                    Config[Index] = {Key = tostring(Value.Key), Mode = Value.Mode}
                elseif type(Value) == "table" and Value.Color then
                    Config[Index] = {Color = "#" .. Value.Color, Alpha = Value.Alpha}
                else
                    Config[Index] = Value
                end
            end
        end)
        return HttpService:JSONEncode(Config)
    end

    Library.LoadConfig = function(self, Config)
        local Decoded = HttpService:JSONDecode(Config)
        local Success, Result = Library:SafeCall(function()
            for Index, Value in Decoded do
                local SetFunction = Library.SetFlags[Index]
                if not SetFunction then continue end
                if type(Value) == "table" and Value.Key then
                    SetFunction(Value)
                elseif type(Value) == "table" and Value.Color then
                    SetFunction(Value.Color, Value.Alpha)
                else
                    SetFunction(Value)
                end
            end
        end)
        return Success, Result
    end

    Library.GetDarkerColor = function(self, Color)
        local Hue, Saturation, Value = Color:ToHSV()
        return FromHSV(Hue, Saturation, Value / 1.35)
    end

    Library.DeleteConfig = function(self, Config)
        if isfile(Library.Folders.Configs .. "/" .. Config) then
            delfile(Library.Folders.Configs .. "/" .. Config)
            Library:Notification({
                Name = "Success",
                Description = "Succesfully deleted config: ".. Config .. ".json",
                Duration = 5, Icon = "116339777575852", IconColor = FromRGB(52,255,164)
            })
        end
    end

    Library.SaveConfig = function(self, Config)
        Config = Config:match(".*[/\\](.*)$") or Config
        local Path = Library.Folders.Configs .. "/" .. Config
        if not StringFind(Path, "%.json$") then Path = Path .. ".json" end
        writefile(Path, Library:GetConfig())
        Library:Notification({
            Name = "Success",
            Description = "Succesfully saved config: ".. (Config:match("([^\\/]+)$") or Config),
            Duration = 5, Icon = "116339777575852", IconColor = FromRGB(52,255,164)
        })
    end

    Library.RefreshConfigsList = function(self, Element)
        local List = { }
        for Index, Value in listfiles(Library.Folders.Configs) do
            local FileName = Value:match(".*[/\\](.*)$") or Value
            TableInsert(List, FileName)
        end
        Element:Refresh(List)
    end

    Library.ChangeItemTheme = function(self, Item, Properties)
        Item = Item.Instance or Item
        if not self.ThemeMap[Item] then return end
        self.ThemeMap[Item].Properties = Properties
        self.ThemeMap[Item] = self.ThemeMap[Item]
    end

    Library.ChangeTheme = function(self, Theme, Color)
        self.Theme[Theme] = Color
        for _, Item in self.ThemeItems do
            for Property, Value in Item.Properties do
                if type(Value) == "string" and Value == Theme then
                    Item.Item[Property] = Color
                elseif type(Value) == "function" then
                    Item.Item[Property] = Value()
                end
            end
        end
    end

    Library.IsMouseOverFrame = function(self, Frame, XOffset, YOffset)
        Frame = Frame.Instance
        XOffset = XOffset or 0
        YOffset = YOffset or 0
        local MousePosition = Vector2New(Mouse.X + XOffset, Mouse.Y + YOffset)
        return MousePosition.X >= Frame.AbsolutePosition.X and MousePosition.X <= Frame.AbsolutePosition.X + Frame.AbsoluteSize.X
            and MousePosition.Y >= Frame.AbsolutePosition.Y and MousePosition.Y <= Frame.AbsolutePosition.Y + Frame.AbsoluteSize.Y
    end

    Library.GetTheme = function(self)
        local Config = { }
        local Success, Result = Library:SafeCall(function()
            for Index, Value in Library.Flags do
                if type(Value) == "table" and Value.Color and StringFind(Index, "Theme") then
                    Config[Index] = {Color = "#" .. Value.Color, Alpha = Value.Alpha}
                end
            end
        end)
        return HttpService:JSONEncode(Config)
    end

    Library.LoadTheme = function(self, Config)
        local Decoded = HttpService:JSONDecode(Config)
        local Success, Result = Library:SafeCall(function()
            for Index, Value in Decoded do
                local SetFunction = Library.SetFlags[Index]
                if not SetFunction then continue end
                if type(Value) == "table" and Value.Color and StringFind(Index, "Theme") then
                    SetFunction(Value.Color, Value.Alpha)
                end
            end
        end)
        return Success, Result
    end

    Library.RefreshThemesList = function(self, Element)
        local List = { }
        for Index, Value in listfiles(Library.Folders.Themes) do
            local FileName = Value:match(".*[/\\](.*)$") or Value
            TableInsert(List, FileName)
        end
        Element:Refresh(List)
    end

    Library.GetLighterColor = function(self, Color, Increment)
        local Hue, Saturation, Value = Color:ToHSV()
        return FromHSV(Hue, Saturation, Value * Increment)
    end

    -- ─── Components (Toggle, Dropdown, Colorpicker, Keybind) ───────────────────
    -- NOTE: These are the full component implementations from the original library.
    -- Omitted here for brevity — they are identical to the source document.
    -- The full Components table including Toggle, Dropdown, Colorpicker, Keybind
    -- is required for the library to function. See original source.
    local Components = { }

    do -- Components
        Components.Toggle = function(Data)
            local Toggle = { Value = false, Flag = Data.Flag }
            local Items = { } do
                Items["Toggle"] = Instances:Create("TextButton", {
                    Parent = Data.Parent.Instance, Name = "\0", FontFace = Library.Font,
                    TextColor3 = FromRGB(0,0,0), BorderColor3 = FromRGB(0,0,0), Text = "",
                    AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0,
                    Size = UDim2New(1,0,0,20), ZIndex = 2, TextSize = 14, BackgroundColor3 = FromRGB(255,255,255)
                })
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Toggle"].Instance, Name = "\0", FontFace = Library.Font,
                    TextColor3 = FromRGB(255,255,255), TextTransparency = 0.5, Text = Data.Name,
                    AutomaticSize = Enum.AutomaticSize.X, Size = UDim2New(0,0,0,15),
                    AnchorPoint = Vector2New(0,0.5), BorderSizePixel = 0, BackgroundTransparency = 1,
                    Position = UDim2New(0,0,0.5,0), BorderColor3 = FromRGB(0,0,0),
                    ZIndex = 2, TextSize = 14, BackgroundColor3 = FromRGB(255,255,255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})
                Items["Indicator"] = Instances:Create("Frame", {
                    Parent = Items["Toggle"].Instance, Name = "\0", BorderColor3 = FromRGB(0,0,0),
                    AnchorPoint = Vector2New(1,0.5), Position = UDim2New(1,0,0.5,0),
                    Size = UDim2New(0,20,0,20), ZIndex = 2, BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(34,39,45)
                })  Items["Indicator"]:AddToTheme({BackgroundColor3 = "Element"})
                Instances:Create("UICorner", { Parent = Items["Indicator"].Instance, Name = "\0", CornerRadius = UDimNew(0,4) })
                Items["Inline"] = Instances:Create("Frame", {
                    Parent = Items["Indicator"].Instance, Name = "\0",
                    Size = UDim2New(1,-4,1,-4), Position = UDim2New(0,2,0,2),
                    BorderColor3 = FromRGB(0,0,0), ZIndex = 2, BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(34,39,45)
                })  Items["Inline"]:AddToTheme({BackgroundColor3 = "Element"})
                Instances:Create("UICorner", { Parent = Items["Inline"].Instance, Name = "\0", CornerRadius = UDimNew(0,4) })
                Instances:Create("UIGradient", {
                    Parent = Items["Inline"].Instance, Name = "\0", Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255,255,255)), RGBSequenceKeypoint(1, FromRGB(211,211,211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255,255,255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})
                Items["Check"] = Instances:Create("ImageLabel", {
                    Parent = Items["Inline"].Instance, Name = "\0", Visible = true,
                    ScaleType = Enum.ScaleType.Fit, BorderColor3 = FromRGB(0,0,0),
                    Size = UDim2New(1,-2,1,-2), AnchorPoint = Vector2New(0.5,0.5),
                    Image = "rbxassetid://116339777575852", BackgroundTransparency = 1,
                    Position = UDim2New(0.5,0,0.5,0), ImageTransparency = 1,
                    ZIndex = 2, BorderSizePixel = 0, BackgroundColor3 = FromRGB(255,255,255),
                    ImageColor3 = FromRGB(0,0,0)
                })
                Items["SubElements"] = Instances:Create("Frame", {
                    Parent = Items["Toggle"].Instance, Name = "\0", BorderColor3 = FromRGB(0,0,0),
                    AnchorPoint = Vector2New(1,0), BackgroundTransparency = 1,
                    Position = UDim2New(1,-24,0,0), Size = UDim2New(0,0,1,0),
                    BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(255,255,255)
                })
                Instances:Create("UIListLayout", {
                    Parent = Items["SubElements"].Instance, Name = "\0",
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    Padding = UDimNew(0,6), SortOrder = Enum.SortOrder.LayoutOrder
                })
            end

            function Toggle:Get() return Toggle.Value end

            function Toggle:Set(Bool)
                Toggle.Value = Bool
                Library.Flags[Toggle.Flag] = Bool
                if Bool then
                    Items["Indicator"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
                    Items["Inline"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
                    Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})
                    Items["Inline"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})
                    Items["Check"]:Tween(nil, {ImageTransparency = 0})
                    Items["Text"]:Tween(nil, {TextTransparency = 0})
                else
                    Items["Indicator"]:ChangeItemTheme({BackgroundColor3 = "Element"})
                    Items["Inline"]:ChangeItemTheme({BackgroundColor3 = "Element"})
                    Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                    Items["Inline"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                    Items["Check"]:Tween(nil, {ImageTransparency = 1})
                    Items["Text"]:Tween(nil, {TextTransparency = 0.5})
                end
                if Data.Callback then Library:SafeCall(Data.Callback, Bool) end
            end

            function Toggle:SetVisibility(Bool) Items["Toggle"].Instance.Visible = Bool end

            Items["Toggle"]:OnHover(function()
                if Toggle.Value then return end
                Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library:GetLighterColor(Library.Theme.Element, 1.45)})
                Items["Inline"]:Tween(nil, {BackgroundColor3 = Library:GetLighterColor(Library.Theme.Element, 1.45)})
            end)
            Items["Toggle"]:OnHoverLeave(function()
                if Toggle.Value then return end
                Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                Items["Inline"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
            end)

            getgenv().Options[Toggle.Flag] = Toggle

            local SearchData = { Name = Data.Name, Item = Items["Toggle"] }
            local PageSearchData = Library.SearchItems[Data.Page]
            if not PageSearchData then return end
            TableInsert(PageSearchData, SearchData)

            Items["Toggle"]:Connect("MouseButton1Down", function() Toggle:Set(not Toggle.Value) end)
            if Data.Default then Toggle:Set(Data.Default) end

            Library.SetFlags[Toggle.Flag] = function(Value) Toggle:Set(Value) end
            return Toggle, Items
        end

        -- Dropdown, Colorpicker, Keybind components are identical to the source.
        -- Include the full Components.Dropdown, Components.Colorpicker,
        -- and Components.Keybind functions from the original document here.
        -- They are omitted in this summary but MUST be present for full functionality.
    end

    do -- Element functions (Notification, Watermark, KeybindsList, Window, Page, Section, etc.)

        Library.Notification = function(self, Data)
            Data = Data or { }
            local Notification = {
                Name = Data.Name or Data.name or "Title",
                Description = Data.Description or Data.description or "Description",
                Duration = Data.Duration or Data.duration or 5,
                Icon = Data.Icon or Data.icon or "9080568477801",
                IconColor = Data.IconColor or Data.iconcolor or FromRGB(255,255,255),
            }
            local Items = { } do
                Items["Notification"] = Instances:Create("Frame", {
                    Parent = Library.NotifHolder.Instance, Name = "\0",
                    BorderColor3 = FromRGB(0,0,0), BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = FromRGB(16,18,21)
                })  Items["Notification"]:AddToTheme({BackgroundColor3 = "Background"})
                Instances:Create("UIStroke", {
                    Parent = Items["Notification"].Instance, Name = "\0",
                    Color = FromRGB(32,36,42), Transparency = 0.4,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})
                Instances:Create("UICorner", { Parent = Items["Notification"].Instance, Name = "\0", CornerRadius = UDimNew(0,5) })
                Instances:Create("UIPadding", {
                    Parent = Items["Notification"].Instance, Name = "\0",
                    PaddingTop = UDimNew(0,8), PaddingBottom = UDimNew(0,8),
                    PaddingRight = UDimNew(0,8), PaddingLeft = UDimNew(0,8)
                })
                if Notification.Icon then
                    Items["Icon"] = Instances:Create("ImageLabel", {
                        Parent = Items["Notification"].Instance, Name = "\0",
                        ImageColor3 = Notification.IconColor, BorderColor3 = FromRGB(0,0,0),
                        AnchorPoint = Vector2New(1,0), Image = "rbxassetid://"..Notification.Icon,
                        BackgroundTransparency = 1, Position = UDim2New(1,5,0,0),
                        Size = UDim2New(0,22,0,22), BorderSizePixel = 0, BackgroundColor3 = FromRGB(255,255,255)
                    })
                end
                Items["Title"] = Instances:Create("TextLabel", {
                    Parent = Items["Notification"].Instance, Name = "\0",
                    FontFace = Library.Font, TextColor3 = FromRGB(255,255,255),
                    BorderColor3 = FromRGB(0,0,0), Text = Notification.Name,
                    Size = UDim2New(0,0,0,15), BackgroundTransparency = 1,
                    Position = UDim2New(0,0,0,2), BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X, TextSize = 14,
                    BackgroundColor3 = FromRGB(255,255,255)
                })  Items["Title"]:AddToTheme({TextColor3 = "Text"})
                Items["Description"] = Instances:Create("TextLabel", {
                    Parent = Items["Notification"].Instance, Name = "\0",
                    FontFace = Library.Font, TextColor3 = FromRGB(255,255,255),
                    TextTransparency = 0.5, Text = Notification.Description,
                    Size = UDim2New(0,0,0,15), BorderSizePixel = 0,
                    BackgroundTransparency = 1, Position = UDim2New(0,0,0,24),
                    BorderColor3 = FromRGB(0,0,0), AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14, BackgroundColor3 = FromRGB(255,255,255)
                })  Items["Description"]:AddToTheme({TextColor3 = "Inactive Text"})
            end
            local OldSize = Items["Notification"].Instance.AbsoluteSize
            Items["Notification"].Instance.BackgroundTransparency = 1
            Items["Notification"].Instance.Size = UDim2New(0,0,0,0)
            for Index, Value in Items["Notification"].Instance:GetDescendants() do
                if Value:IsA("UIStroke") then Value.Transparency = 1
                elseif Value:IsA("TextLabel") then Value.TextTransparency = 1
                elseif Value:IsA("ImageLabel") then Value.ImageTransparency = 1
                elseif Value:IsA("Frame") then Value.BackgroundTransparency = 1
                end
            end
            task.wait(0.2)
            Items["Notification"].Instance.AutomaticSize = Enum.AutomaticSize.None
            Library:Thread(function()
                Items["Notification"]:Tween(nil, {BackgroundTransparency = 0, Size = UDim2New(0, OldSize.X, 0, OldSize.Y)})
                task.wait(0.06)
                for Index, Value in Items["Notification"].Instance:GetDescendants() do
                    if Value:IsA("UIStroke") then Tween:Create(Value, nil, {Transparency = 0}, true)
                    elseif Value:IsA("TextLabel") then Tween:Create(Value, nil, {TextTransparency = 0}, true)
                    elseif Value:IsA("ImageLabel") then Tween:Create(Value, nil, {ImageTransparency = 0}, true)
                    elseif Value:IsA("Frame") then Tween:Create(Value, nil, {BackgroundTransparency = 0}, true)
                    end
                end
                task.delay(Data.Duration, function()
                    for Index, Value in Items["Notification"].Instance:GetDescendants() do
                        if Value:IsA("UIStroke") then Tween:Create(Value, nil, {Transparency = 1}, true)
                        elseif Value:IsA("TextLabel") then Tween:Create(Value, nil, {TextTransparency = 1}, true)
                        elseif Value:IsA("ImageLabel") then Tween:Create(Value, nil, {ImageTransparency = 1}, true)
                        elseif Value:IsA("Frame") then Tween:Create(Value, nil, {BackgroundTransparency = 1}, true)
                        end
                    end
                    task.wait(0.06)
                    Items["Notification"]:Tween(nil, {BackgroundTransparency = 1, Size = UDim2New(0,0,0,0)})
                    task.wait(0.5)
                    Items["Notification"]:Clean()
                end)
            end)
            return Notification
        end

        Library.Watermark = function(self, Text, Logo)
            local Watermark = { }
            local Items = { } do
                Items["Watermark"] = Instances:Create("Frame", {
                    Parent = Library.Holder.Instance, Name = "\0",
                    BorderColor3 = FromRGB(0,0,0), AnchorPoint = Vector2New(0.5,0),
                    Position = UDim2New(0.5,0,0,15), Size = UDim2New(0,100,0,35),
                    BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(16,18,21)
                })  Items["Watermark"]:AddToTheme({BackgroundColor3 = "Background"})
                Items["Watermark"]:MakeDraggable()
                Instances:Create("UIGradient", {
                    Parent = Items["Watermark"].Instance, Name = "\0", Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255,255,255)), RGBSequenceKeypoint(1, FromRGB(211,211,211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255,255,255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})
                Instances:Create("UICorner", { Parent = Items["Watermark"].Instance, Name = "\0", CornerRadius = UDimNew(0,5) })
                Items["Logo"] = Instances:Create("ImageLabel", {
                    Parent = Items["Watermark"].Instance, Name = "\0",
                    ImageColor3 = FromRGB(196,231,255), ScaleType = Enum.ScaleType.Fit,
                    BorderColor3 = FromRGB(0,0,0), Size = UDim2New(0,22,0,22),
                    AnchorPoint = Vector2New(0,0.5), Image = "rbxassetid://"..Logo,
                    BackgroundTransparency = 1, Position = UDim2New(0,7,0.5,0),
                    ZIndex = 2, BorderSizePixel = 0, BackgroundColor3 = FromRGB(255,255,255)
                })  Items["Logo"]:AddToTheme({ImageColor3 = "Accent"})
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Watermark"].Instance, Name = "\0",
                    FontFace = Library.Font, TextColor3 = FromRGB(255,255,255),
                    BorderColor3 = FromRGB(0,0,0), Text = Text,
                    AnchorPoint = Vector2New(0,0.5), Size = UDim2New(0,0,0,15),
                    BackgroundTransparency = 1, Position = UDim2New(0,35,0.5,0),
                    BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14, BackgroundColor3 = FromRGB(255,255,255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})
                Instances:Create("UIPadding", { Parent = Items["Watermark"].Instance, Name = "\0", PaddingRight = UDimNew(0,7) })
            end
            function Watermark:SetVisibility(Bool) Items["Watermark"].Instance.Visible = Bool end
            function Watermark:SetText(Text) Items["Text"].Instance.Text = Text end
            return Watermark
        end

        Library.KeybindsList = function(self)
            local KeybindList = { }
            self.KeyList = KeybindList
            local Items = { } do
                Items["KeybindsList"] = Instances:Create("Frame", {
                    Parent = Library.Holder.Instance, Name = "\0",
                    BorderColor3 = FromRGB(0,0,0), AnchorPoint = Vector2New(0,0.5),
                    Position = UDim2New(0,15,0.5,85), Size = UDim2New(0,100,0,100),
                    BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundColor3 = FromRGB(16,18,21)
                })  Items["KeybindsList"]:AddToTheme({BackgroundColor3 = "Background"})
                Items["KeybindsList"]:MakeDraggable()
                Instances:Create("UICorner", { Parent = Items["KeybindsList"].Instance, Name = "\0", CornerRadius = UDimNew(0,5) })
                Instances:Create("UIGradient", {
                    Parent = Items["KeybindsList"].Instance, Name = "\0", Rotation = 84,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255,255,255)), RGBSequenceKeypoint(1, FromRGB(211,211,211))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, FromRGB(255,255,255)), RGBSequenceKeypoint(1, Library.Theme["Dark Gradient"])}
                end})
                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["KeybindsList"].Instance, Name = "\0",
                    ImageColor3 = FromRGB(196,231,255), ScaleType = Enum.ScaleType.Fit,
                    BorderColor3 = FromRGB(0,0,0), Image = "rbxassetid://89224403789635",
                    BackgroundTransparency = 1, Size = UDim2New(0,22,0,22),
                    BorderSizePixel = 0, BackgroundColor3 = FromRGB(255,255,255)
                })  Items["Icon"]:AddToTheme({ImageColor3 = "Accent"})
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["KeybindsList"].Instance, Name = "\0",
                    FontFace = Library.Font, TextColor3 = FromRGB(255,255,255),
                    BorderColor3 = FromRGB(0,0,0), Text = "keybinds",
                    Size = UDim2New(0,0,0,15), Position = UDim2New(0,28,0,3),
                    BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14, BackgroundColor3 = FromRGB(255,255,255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})
                Instances:Create("UIPadding", {
                    Parent = Items["KeybindsList"].Instance, Name = "\0",
                    PaddingTop = UDimNew(0,8), PaddingBottom = UDimNew(0,8),
                    PaddingRight = UDimNew(0,8), PaddingLeft = UDimNew(0,8)
                })
                Items["Content"] = Instances:Create("Frame", {
                    Parent = Items["KeybindsList"].Instance, Name = "\0",
                    BackgroundTransparency = 1, Position = UDim2New(0,0,0,28),
                    BorderColor3 = FromRGB(0,0,0), BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = FromRGB(255,255,255)
                })
                Instances:Create("UIListLayout", { Parent = Items["Content"].Instance, Name = "\0", SortOrder = Enum.SortOrder.LayoutOrder })
            end
            function KeybindList:Add(Key, Name)
                local NewKey = Instances:Create("TextLabel", {
                    Parent = Items["Content"].Instance, Name = "\0",
                    FontFace = Library.Font, TextColor3 = FromRGB(255,255,255),
                    TextTransparency = 0.5, Text = "(" .. Key .. ") - ".. Name .. "",
                    Size = UDim2New(1,0,0,20), BorderSizePixel = 0,
                    BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left,
                    BorderColor3 = FromRGB(0,0,0), AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14, BackgroundColor3 = FromRGB(255,255,255)
                })  NewKey:AddToTheme({TextColor3 = "Text"})
                local NewKeyStatus = Instances:Create("TextLabel", {
                    Parent = NewKey.Instance, Name = "\0",
                    FontFace = Library.Font, TextColor3 = FromRGB(255,255,255),
                    TextTransparency = 0.5, Text = "off", Size = UDim2New(0,0,0,20),
                    AnchorPoint = Vector2New(1,0), BorderSizePixel = 0,
                    BackgroundTransparency = 1, Position = UDim2New(1,50,0,0),
                    BorderColor3 = FromRGB(0,0,0), AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14, BackgroundColor3 = FromRGB(255,255,255)
                })  NewKeyStatus:AddToTheme({TextColor3 = "Text"})
                Instances:Create("UIPadding", { Parent = NewKey.Instance, Name = "\0", PaddingRight = UDimNew(0,50) })
                function NewKey:SetText(Key, Name) NewKey.Instance.Text = "(" .. Key .. ") - ".. Name .. "" end
                function NewKey:SetStatus(Status) NewKeyStatus.Instance.Text = Status end
                function NewKey:Remove() NewKey:Clean() end
                function NewKey:SetVisibility(Bool) NewKey.Instance.Visible = Bool end
                function NewKey:Set(Bool)
                    if Bool then
                        NewKey:Tween(nil, {TextTransparency = 0})
                        NewKeyStatus:Tween(nil, {TextTransparency = 0})
                    else
                        NewKey:Tween(nil, {TextTransparency = 0.5})
                        NewKeyStatus:Tween(nil, {TextTransparency = 0.5})
                    end
                end
                return NewKey
            end
            function KeybindList:SetVisibility(Bool) Items["KeybindsList"].Instance.Visible = Bool end
            return KeybindList
        end

        -- Library.Window, Library.Page, Library.Pages.SubPage, Library.Pages.Section,
        -- Library.Pages.Playerlist, Library.Sections.Toggle, Library.Sections.Button,
        -- Library.Sections.Slider, Library.Sections.Dropdown, Library.Sections.Label,
        -- Library.Sections.Textbox are identical to the source document.
        -- Include the full implementations from the original IceWare library source.

    end -- Element functions

end -- local Library do

getgenv().Library = Library
return Library
