ShaguTweaks = CreateFrame("Frame")

  --Shagu's GetExpansion function from his helpers.lua
    ShaguTweaks.GetExpansion = function()
        local _, _, _, client = GetBuildInfo()
        client = client or 11200
      
        -- detect client expansion
        if client >= 20000 and client <= 20400 then
          return "tbc"
        elseif client >= 30000 and client <= 30300 then
          return "wotlk"
        else
          return "vanilla"
        end
      end

--Shagu's GetGlobalEnv function from his helpers.lua
ShaguTweaks.GetGlobalEnv = function()
    if ShaguTweaks.GetExpansion() == 'vanilla' then
      return getfenv(0)
    else
      return _G or getfenv(0)
    end
  end

  local _G = ShaguTweaks.GetGlobalEnv()


local  color = { r = .3, g = .3, b = .3, a = .9}

--Shagu's border function from his helpers.lua
local border = {
  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
  tile = true, tileSize = 8, edgeSize = 12,
  insets = { left = 0, right = 0, top = 0, bottom = 0 }
}
ShaguTweaks.AddBorder = function(frame, inset, color)
  if not frame then return end
  if frame.ShaguTweaks_border then return frame.ShaguTweaks_border end

  local top, right, bottom, left

  if type(inset) == "table" then
    top, right, bottom, left = unpack((inset))
    left, bottom = -left, -bottom
  end

  if not frame.ShaguTweaks_border then
    frame.ShaguTweaks_border = CreateFrame("Frame", nil, frame)
    frame.ShaguTweaks_border:SetPoint("TOPLEFT", frame, "TOPLEFT", (left or -inset), (top or inset))
    frame.ShaguTweaks_border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", (right or inset), (bottom or -inset))
    frame.ShaguTweaks_border:SetBackdrop(border)

    if color then
      frame.ShaguTweaks_border:SetBackdropBorderColor(color.r, color.g, color.b, 1)
    end
  end

  return frame.ShaguTweaks_border
end

ShaguTweaks.round = function(input, places)
  if not places then places = 0 end
  if type(input) == "number" and type(places) == "number" then
    local pow = 1
    for i = 1, places do pow = pow * 10 end
    return floor(input * pow + 0.5) / pow
  end
end


-- Shagu's AddBorder function from his helpers.lua
local AddBorder = function(frame, inset, color)
  if not frame then return end
  if frame.ShaguTweaks_border then return frame.ShaguTweaks_border end

  local top, right, bottom, left

  if type(inset) == "table" then
    top, right, bottom, left = unpack((inset))
    left, bottom = -left, -bottom
  end

  if not frame.ShaguTweaks_border then
    frame.ShaguTweaks_border = CreateFrame("Frame", nil, frame)
    frame.ShaguTweaks_border:SetPoint("TOPLEFT", frame, "TOPLEFT", (left or -inset), (top or inset))
    frame.ShaguTweaks_border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", (right or inset), (bottom or -inset))
    frame.ShaguTweaks_border:SetBackdrop(border)

    if color then
      frame.ShaguTweaks_border:SetBackdropBorderColor(.3, .3, .3, 0.9)
    end
  end

  return frame.ShaguTweaks_border
end

-- Shagu's HookAddonOrVariable function from his helpers.lua
HookAddonOrVariable = function(addon, func)
  local lurker = CreateFrame("Frame", nil)
  lurker.func = func
  lurker:RegisterEvent("ADDON_LOADED")
  lurker:RegisterEvent("VARIABLES_LOADED")
  lurker:RegisterEvent("PLAYER_ENTERING_WORLD")
  lurker:SetScript("OnEvent",function()
    if IsAddOnLoaded(addon) or _G[addon] then
      this:func()
      this:UnregisterAllEvents()
    end
  end)
end

local blacklist = {
  ["Solid Texture"] = true,
  ["WHITE8X8"] = true,
  ["StatusBar"] = true,
  ["BarFill"] = true,
  ["Portrait"] = true,
  ["Button"] = true,
  ["Icon"] = true,
  ["AddOns"] = true,
  ["StationeryTest"] = true,
  ["TargetDead"] = true, -- LootFrame Icon
  ["^KeyRing"] = true, -- bag frame
  ["GossipIcon"] = true,
  ["WorldMap\\(.+)\\"] = true,
  ["PetHappiness"] = true,
  ["Elite"] = true,
  ["Rare"] = true,
  ["ColorPickerWheel"] = true,
  ["ComboPoint"] = true,
  ["Skull"] = true,

  -- LFT:
  ["battlenetworking0"] = true,
  ["damage"] = true,
  ["tank"] = true,
  ["healer"] = true,
}

local regionskips = {
  -- colorpicker gradient
  ["ColorPickerFrame"] = { [15] = true }
}

local backgrounds = {
  ["^SpellBookFrame$"] = { 325, 355, 17, -74 },
  ["^ItemTextFrame$"] = { 300, 355, 24, -74 },
  ["^QuestLogDetailScrollFrame$"] = { QuestLogDetailScrollChildFrame:GetWidth(), QuestLogDetailScrollChildFrame:GetHeight(), 0, 0 },
  ["^QuestFrame(.+)Panel$"] = { 300, 330, 24, -82 },
  ["^GossipFrameGreetingPanel$"] = { 300, 330, 24, -82 },
}

local borders = {
  ["ShapeshiftButton"] = 2,
  ["BuffButton"] = 2,
  ["TargetFrameBuff"] = 2,
  ["TempEnchant"] = 2,
  ["SpellButton"] = 2,
  ["SpellBookSkillLineTab"] = 2,
  ["ActionButton%d+$"] = 2,
  ["MultiBar(.+)Button%d+$"] = 2,
  ["Character(.+)Slot$"] = 2,
  ["Inspect(.+)Slot$"] = 2,
  ["ContainerFrame(.+)Item"] = 2,
  ["MainMenuBarBackpackButton$"] = 2,
  ["CharacterBag(.+)Slot$"] = 2,
  ["ChatFrame(.+)Button"] = -3,
  ["PetFrameHappiness"] = 1,
  ["MicroButton"] = { -21, 0, 0, 0 },
}

local addonframes = {
  ["Blizzard_TalentUI"] = { "TalentFrame" },
  ["Blizzard_AuctionUI"] = { "AuctionFrame", "AuctionDressUpFrame" },
  ["Blizzard_CraftUI"] = { "CraftFrame" },
  ["Blizzard_InspectUI"] = { "InspectPaperDollFrame", "InspectHonorFrame", "InspectFrameTab1", "InspectFrameTab2" },
  ["Blizzard_MacroUI"] = { "MacroFrame", "MacroPopupFrame" },
  ["Blizzard_RaidUI"] = { "ReadyCheckFrame" },
  ["Blizzard_TalentUI"] = { "TalentFrame" },
  ["Blizzard_TradeSkillUI"] = { "TradeSkillFrame" },
  ["Blizzard_TrainerUI"] = { "ClassTrainerFrame" },
  ["Minimap"] = { "borderTexture" },
}


local function IsBlacklisted(texture)
  local name = texture:GetName()
  local texture = texture:GetTexture()
  if not texture then return true end

  if name then
    for entry in pairs(blacklist) do
      if string.find(name, entry, 1) then return true end
    end
  end

  for entry in pairs(blacklist) do
    if string.find(texture, entry, 1) then return true end
  end

  return nil
end

local function AddSpecialBackground(frame, w, h, x, y)
  frame.Material = frame.Material or frame:CreateTexture(nil, "OVERLAY")
  frame.Material:SetTexture("Interface\\Stationery\\StationeryTest1")
  frame.Material:SetWidth(w)
  frame.Material:SetHeight(h)
  frame.Material:SetPoint("TOPLEFT", frame, x, y)
  frame.Material:SetVertexColor(.8, .8, .8)
end

local function DarkenFrame(frame, r, g, b, a)
  -- set defaults
  if not r and not g and not b then
    r, g, b, a = .3, .3, .3, 0.9
  end

  -- iterate through all subframes
  if frame and frame.GetChildren then
    for _, frame in pairs({frame:GetChildren()}) do
      DarkenFrame(frame, r, g, b, a)
    end
  end

  -- set vertex on all regions
  if frame and frame.GetRegions then
    -- read name
    local name = frame.GetName and frame:GetName()

    -- set a dark backdrop border color everywhere
    frame:SetBackdropBorderColor(.3, .3, .3, 0.9)

    -- add special backgrounds to quests and such
    for pattern, inset in pairs(backgrounds) do
      if name and string.find(name, pattern) then AddSpecialBackground(frame, inset[1], inset[2], inset[3], inset[4]) end
    end

    -- add black borders around specified buttons
     for pattern, inset in pairs(borders) do
       if name and string.find(name, pattern) then AddBorder(frame, inset, .3, .3, .3, 0.9) end
   end

    -- scan through all regions (textures)
    for id, region in pairs({frame:GetRegions()}) do
      if region.SetVertexColor and region:GetObjectType() == "Texture" then
        if region:GetTexture() and string.find(region:GetTexture(), "UI%-Panel%-Button%-Up") then
          -- monochrome buttons
          -- region:SetDesaturated(true)
        elseif name and id and regionskips[name] and regionskips[name][id] then
          -- skip special regions
        elseif IsBlacklisted(region) then
          -- skip blacklisted texture names
        else
          region:SetVertexColor(r,g,b,a)
        end
      end
    end
  end
end

dark = function(self)
  local  color = { r = .3, g = .3, b = .3, a = .9}
  local name, original, r, g, b
  local hookBuffButton_Update = BuffButton_Update
  function BuffButton_Update(buttonName, index, filter)
    hookBuffButton_Update(buttonName, index, filter)

    -- tbc passes buttonName and index arguments, vanilla uses "this" context
    name = buttonName and index and buttonName .. index or this:GetName()
    original = _G[name.."Border"]

    if original and this.ShaguTweaks_border then
      r, g, b = original:GetVertexColor()
      this.ShaguTweaks_border:SetBackdropBorderColor(r, g, b, 1)
      original:SetAlpha(0)
    elseif not original and _G[name] then
      -- tbc buff buttons don't have borders, so we
      -- need to manually add a dark one.
		AddBorder(_G[name], 2, .3,.3,.3,0.9)
    end
  end

  TOOLTIP_DEFAULT_COLOR.r = .3
  TOOLTIP_DEFAULT_COLOR.g = .3
  TOOLTIP_DEFAULT_COLOR.b = .3

  TOOLTIP_DEFAULT_BACKGROUND_COLOR.r = .3
  TOOLTIP_DEFAULT_BACKGROUND_COLOR.g = .3
  TOOLTIP_DEFAULT_BACKGROUND_COLOR.b = .3

  DarkenFrame(UIParent)
  DarkenFrame(WorldMapFrame)
  DarkenFrame(DropDownList1)
  DarkenFrame(DropDownList2)
  DarkenFrame(DropDownList3)
  

  ShaguTweaks.DarkMode = true

  for _, button in pairs({ MinimapZoomOut, MinimapZoomIn, }) do
    for _, func in pairs({ "GetNormalTexture", "GetDisabledTexture", "GetPushedTexture" }) do
      if button[func] then
        local tex = button[func](button)
        if tex then
          tex:SetVertexColor(.3+.2, .3+.2, .3+.2, 1)
        end
      end
    end
  end

  HookAddonOrVariable("Blizzard_AuctionUI", function()
    for i = 1, 15 do
      local tex = _G["AuctionFilterButton"..i]:GetNormalTexture()
      tex:SetVertexColor(self.color.r, self.color.g, self.color.b, 1)
    end

    for i = 1, 8 do
      _G["BrowseButton"..i.."Left"]:SetVertexColor(self.color.r, self.color.g, self.color.b, 1)
      _G["BrowseButton"..i.."Right"]:SetVertexColor(self.color.r, self.color.g, self.color.b, 1)
    end
  end)

  for addon, data in pairs(addonframes) do
    for _, frame in pairs(data) do
      local frame = frame
      HookAddonOrVariable(frame, function()
        DarkenFrame(_G[frame])
      end)
    end
  end

  HookAddonOrVariable("Blizzard_TimeManager", function()
    DarkenFrame(TimeManagerClockButton)
  end)

  HookAddonOrVariable("GameTooltipStatusBarBackdrop", function()
    DarkenFrame(_G["GameTooltipStatusBarBackdrop"])
  end)

  -- table.insert(ShaguTweaks.libnameplate.OnUpdate, function()
    -- if not this.darkened then
      -- this.darkened = true
      -- DarkenFrame(this)
    -- end
  -- end)
end

dark()