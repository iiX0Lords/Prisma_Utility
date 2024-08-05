
# Prisma UI Library

Heheheha


# Documentation

* Quick Links:
    - [Button](#Button)

## Button:

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
| `Arguments` | `table` | _Optional_. Refer to [Optional Arguments](#Arguments)




## Arguments

### Input
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
| `Func` | `function` | **Required**. Fired after the [TextBox](https://create.roblox.com/docs/reference/engine/classes/TextBox) looses focus|