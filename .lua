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
  egg = false
}

lib:AddTable(workspace["Server"]["Enemies"]["World"],var.zone)

T1:Dropdown("Choose island to farm",var.zone,function(value)
    var.szone = value
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
      lib:children(workspace["Server"]["Enemies"]["World"][var.szone],function(v)
          game:GetService("ReplicatedStorage")["Bridge"]:FireServer("Attack","Click",{["Enemy"] = v,["Type"] = "World"})
      end)
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
