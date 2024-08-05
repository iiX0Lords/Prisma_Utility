
# Prisma UI Library

Heheheha


# Documentation

* Quick Links:
    - [Button](#Button)
    - [Toggle](#Toggle)
    - [Argument Types](#Argument-Types)

## Button

```lua
library:Button({
	Name = "Button",
	Func = function(self)
		plr.Character:BreakJoints()
	end,
})
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `Name` | `string` | **Required**. This shows next to the button|
| `Func` | `function` | **Required**. Fired after button is clicked|
| `Arguments` | `table` | _Optional_. Refer to [Optional Arguments](#Argument-Types)

## Toggle

```lua
client:Toggle({
    Name = "Speed",
    State = false,
    Func = function(self)
        plr.Character.Humanoid.WalkSpeed = 100
    end,
    OffFunc = function(self)
        plr.Character.Humanoid.WalkSpeed = 16
    end,
})
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `Name` | `string` | **Required**. This shows next to the button|
| `State` | `bool` | **Required**. Default state of the toggle|
| `Func` | `function` | **Required**. Fired after being toggled on|
| `OffFunc` | `function` | **Required**. Fired after being toggled off|
| `Arguments` | `table` | _Optional_. Refer to [Optional Arguments](#Argument-Types)




## Argument Types:

All argument functions receive both the input type and the data from the original button so you can store your own data. [Example](##Key)

## Input
```lua
{
    Title = "Walkspeed",
    Name = "100",
    Type = "Input"
    Func = function(self, input)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(input)
    end,
}
```
| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `Title` | `string` | **Required**. This shows next to the button|
| `Name` | `string` | **Required**. This is the default text shown inside the box|
| `Type` | `string` | **Required**. The type of argument|
| `Func` | `function` | **Required**. Fired after the [TextBox](https://create.roblox.com/docs/reference/engine/classes/TextBox) looses focus|


## Key
```lua
{
    Title = "Key",
    Name = "V",
    Type = "Input"
    Func = function(self, input)
        self.Key = input
    end,
}
```
| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `Title` | `string` | **Required**. This shows next to the input|
| `Name` | `string` | **Required**. This is the default button/text shown inside the box|
| `Type` | `string` | **Required**. The type of argument|
| `Func` | `function` | **Required**. Fired after the [TextBox](https://create.roblox.com/docs/reference/engine/classes/TextBox) looses focus|

## Toggle
```lua
{
    Title = "Example",
    Type = "Toggle",
    Repeating = false,
    State = false,
    Func = function(self, input)
        print("On")
    end,
    OffFunc = function(self)
        print("Off")
    end
},
```
| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `Title` | `string` | **Required**. This shows next to the input|
| `Type` | `string` | **Required**. The type of argument|
| `Repeating` | `bool` | **Required**. If true then Func will be fired continuously|
| `State` | `bool` | **Required**. Default state|
| `Func` | `function` | **Required**. Fired when toggled or continuously fired if Repeating is true|