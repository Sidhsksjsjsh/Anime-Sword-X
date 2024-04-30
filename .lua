local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4")
local T1 = wndw:Tab("Main")
local T2 = wndw:Tab("Hatch")

local workspace = game:GetService("Workspace")
local var = {
  click = false,
  zone = {},
  szone = "Clown Island",
  farm = false,
  ezone = "Clown Island",
  egg = false,
  boss = {},
  sboss = "Buggy",
  enemys = {},
  senem = "Bandit",
  isboss = false,
  best = {
    pet = false,
    sword = false
  }
}
--game:GetService("ReplicatedStorage")["Enemies"].Leveling Island.Cha
--game:GetService("ReplicatedStorage")["Boss"].Clown Island.Buggy

lib:AddTable(workspace["Server"]["Enemies"]["World"],var.zone)

lib:children(game:GetService("ReplicatedStorage")["Enemies"],function(v)
    lib:AddTable(v,var.enemys)
end)

lib:children(game:GetService("ReplicatedStorage")["Boss"],function(v)
    lib:AddTable(v,var.boss)
end)

T1:Dropdown("Choose island to farm",var.zone,function(value)
    var.szone = value
end)

T1:Dropdown("Choose enemy",var.enemys,function(value)
    var.senem = value
end)

T1:Dropdown("Choose boss",var.boss,function(value)
    var.sboss = value
end)

T1:Toggle("Boss",false,function(value)
    var.isboss = value
end)

T1:Toggle("Auto click",false,function(value)
    var.click = value
    while wait() do
      if var.click == false then break end
      game:GetService("ReplicatedStorage")["Bridge"]:FireServer("Attack","Click",{["Type"] = "Invasion"})
    end
end)

T1:Toggle("Auto kill",false,function(value)
    var.farm = value
    while wait() do
      if var.farm == false then break end
      if workspace["Server"]["Enemies"]["World"][var.szone]:FindFirstChild(var.senem) and var.isboss == false then
        game:GetService("ReplicatedStorage")["Bridge"]:FireServer("Attack","Click",{["Enemy"] = workspace["Server"]["Enemies"]["World"][var.szone][var.senem],["Type"] = "World"})
      elseif workspace["Server"]["Enemies"]["Boss"][var.szone]:FindFirstChild(var.sboss) and var.isboss == true then
        game:GetService("ReplicatedStorage")["Bridge"]:FireServer("Attack","Click",{["Enemy"] = workspace["Server"]["Enemies"]["Boss"][var.szone][var.sboss],["Type"] = "Boss"})
      elseif not workspace["Server"]["Enemies"]["World"][var.szone]:FindFirstChild(var.senem) then
        lib:notify(lib:ColorFonts("Cant find " .. var.senem .. " in " .. var.szone,"Red"),10)
        var.farm = false
      elseif not workspace["Server"]["Enemies"]["Boss"][var.szone]:FindFirstChild(var.sboss) then
        lib:notify(lib:ColorFonts("Cant find " .. var.sboss .. " in " .. var.szone,"Red"),10)
        var.farm = false
      end
    end
end)

T1:Toggle("Auto equip best swords every 1s",false,function(value)
    var.best.sword = value
    while wait(1) do
      if var.best.sword == false then break end
      game:GetService("ReplicatedStorage")["Bridge"]:FireServer("Swords","Best")
    end
end)

T2:Dropdown("Choose island to open a egg",var.zone,function(value)
    var.ezone = value
end)

T2:Toggle("Auto open",false,function(value)
    var.egg = value
    while wait() do
      if var.egg == false then break end
      game:GetService("ReplicatedStorage")["Bridge"]:FireServer("Stars","Roll",{["Map"] = var.ezone,["Type"] = "Open"})
    end
end)

T2:Toggle("Auto equip best pets every 1s",false,function(value)
    var.best.pet = value
    while wait(1) do
      if var.best.pet == false then break end
      game:GetService("ReplicatedStorage")["Bridge"]:FireServer("Pets","Best")
    end
end)

lib:DeveloperAccess(function()
    local T100 = wndw:Tab("Developer")
    T100:Button("Remote spy",function()
        lib:RemoteSpy()
    end)

    T100:Button("Dex",function()
        lib:DEX()
    end)

    T100:Button("Turtle Explorer",function()
        lib:TurtleExplorer()
    end)
end)
