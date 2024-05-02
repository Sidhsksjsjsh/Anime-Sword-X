local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4")
local T1 = wndw:Tab("Main")
local T2 = wndw:Tab("Hatch")
local T3 = wndw:Tab("Dungeon")
local hisis = T1:Label(lib:ColorFonts("Cannot run Health Indicators","Red"))

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
  },
  rank = false,
  dngn = {
    se = "Bandit",
    toggle = false,
    zone = "Clown Island",
    isfor = "Public"
  },
  shadow = false
}
--game:GetService("ReplicatedStorage")["Enemies"].Leveling Island.Cha
--game:GetService("ReplicatedStorage")["Boss"].Clown Island.Buggy

local names = {"K","M","B","T","Qa","Qi","Sx","Sp","Oc","No","Dd","Ud","Dd","Td","Qad","Qid","Sxd","Spd","Ocd","Nod","Vg","Uvg","Dvg","Tvg","Qavg","Qivg","Sxvg","Spvg","Ocvg"}
local pows = {}
for i = 1,#names do 
  table.insert(pows,1000^i)
end

local function formatNumber(x: number): string 
	if math.abs(x) < 1000 then
    return tostring(x)
  end 
	local p = math.min(math.floor(math.log10(math.abs(x))/3),#names)
	local num = math.floor(math.abs(x)/pows[p]*100)/100
	return num * math.sign(x) .. names[p]
end

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
    if value == true then
      game:GetService("ReplicatedStorage")["Bridge"]:FireServer("Swords","Best")
    end
    
    while wait(1) do
      if var.best.sword == false then break end
      game:GetService("ReplicatedStorage")["Bridge"]:FireServer("Swords","Best")
    end
end)

T1:Toggle("Auto rank up",false,function(value)
    var.rank = value
    while wait() do
      if var.rank == false then break end
      game:GetService("ReplicatedStorage")["Bridge"]:FireServer("RankUp","Evolve")
    end
end)

T1:Toggle("Auto spin shadows",false,function(value)
    var.shadow = value
    while wait() do
      if var.shadow == false then break end
      game:GetService("ReplicatedStorage")["Bridge"]:FireServer("Gacha","Spin")
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
    if value == true then
      game:GetService("ReplicatedStorage")["Bridge"]:FireServer("Pets","Best")
    end
    
    while wait(1) do
      if var.best.pet == false then break end
      game:GetService("ReplicatedStorage")["Bridge"]:FireServer("Pets","Best")
    end
end)

T3:Dropdown("Who can access it",{"Public","Friend"},function(value)
    var.dngn.isfor = value
end)

T3:Dropdown("Choose enemy",var.enemys,function(value)
    var.dngn.se = value
end)

T3:Button("Create room",function()
    game:GetService("ReplicatedStorage")["Bridge"]:FireServer("Dungeon","Start",var.dngn.isfor)
end)

T3:Toggle("Auto kill",false,function(value)
    var.dngn.toggle = value
    while wait() do
      if var.dngn.toggle == false then break end
      if workspace["Server"]["Enemies"]["Dungeon"]["Leveling Island"]:FindFirstChild(var.dngn.se) then
        game:GetService("ReplicatedStorage")["Bridge"]:FireServer("Attack","Click",{["Enemy"] = workspace["Server"]["Enemies"]["Dungeon"]["Leveling Island"][var.dngn.se],["Type"] = "Dungeon"})
      else
        lib:notify(lib:ColorFonts("Cannot found " .. var.dngn.se .. " in the dungeon","Red"),10) --Can't find Hyung in the dungeon
        var.dngn.toggle = false
      end
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

lib:runtime(function()
    if workspace["Server"]["Enemies"]["World"][var.szone]:FindFirstChild(var.senem) and workspace["Server"]["Enemies"]["Boss"][var.szone]:FindFirstChild(var.sboss) then
      hisis:EditLabel(lib:ColorFonts(var.senem,"Red") .. "'s Health\nHealth : " .. formatNumber(workspace["Server"]["Enemies"]["World"][var.szone][var.senem]["Health"]["Value"]) .. " / " .. formatNumber(workspace["Server"]["Enemies"]["World"][var.szone][var.senem]["MaxHealth"]["Value"]) .. "\n-----------------\n" .. lib:ColorFonts(var.sboss,"Red") .. "' Health (BOSS)\nHealth : " .. formatNumber(workspace["Server"]["Enemies"]["Boss"][var.szone][var.sboss]["Health"]["Value"]) .. " / " .. formatNumber(workspace["Server"]["Enemies"]["Boss"][var.szone][var.sboss]["MaxHealth"]["Value"]))
    else
      hisis:EditLabel(lib:ColorFonts("#ERROR_OCCURED_IN_LINE_1746\n#BOSS_OR_ENEMY_NOT_FOUND\n#" .. string.upper(var.senem:gsub(" ","_")) .. "_IS_NOT_A_VALID_MEMBER_OF_" .. string.upper(var.szone:gsub(" ","_")) .. "\n#" .. string.upper(var.sboss:gsub(" ","_")) .. "_IS_NOT_A_VALID_MEMBER_OF_" .. string.upper(var.szone:gsub(" ","_")),"Red"))
    end
end)
