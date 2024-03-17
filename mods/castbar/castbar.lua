--[[
Author: ShaguTweaks
Modified by: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard art work from 1.12. I've created new buttons and textured them to match
Dragonflight.
]]

local addonpath = "Interface\\AddOns\\Deli_Ui"
	local customfont = addonpath .. "\\fonts\\PROTOTYPE.TTF"

-- Create a tCastbar frame
local tCastbar = CreateFrame("StatusBar", "CastBar", UIParent)
tCastbar:SetWidth(250)
tCastbar:SetHeight(18)
--tCastbar:SetPoint("CENTER", UIParent, "CENTER", 0, -425)
-- Get the position of ActionButton6
local width = tCastbar:GetWidth()
local point, relativeTo, relativePoint, xOfs, yOfs = ActionButton7:GetPoint()
-- Set the point of the tCastbar frame to be 4 pixels above ActionButton6
tCastbar:SetPoint(point, relativeTo, relativePoint, xOfs - width/2, yOfs + 175)
tCastbar:SetStatusBarTexture("Interface\\AddOns\\Deli_Ui\\img\\Castbar\\CastingBarStandard2")
tCastbar:SetStatusBarColor(0.8, 0.8, 0.8)



-- Hide the tCastbar initially
tCastbar:Hide()
CastingBarFrame:UnregisterAllEvents()
CastingBarFrame:Hide()

-- Create a border and a background for the tCastbar
local border = CreateFrame("Frame", nil, tCastbar)
border:SetBackdrop({
  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
  --edgeFile = "Interface\\AddOns\\Deli_Ui\\img\\Castbar\\CastingBarFrame2",
  edgeSize = 16,
  insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
border:SetBackdropBorderColor(0.5, 0.5, 0.5)
border:SetPoint("TOPLEFT", tCastbar, -5, 5)
border:SetPoint("BOTTOMRIGHT", tCastbar, 5, -5)

local background = tCastbar:CreateTexture(nil, "BACKGROUND")
background:SetTexture(0, 0, 0, 0.5)
--background:SetTexture("Interface\\AddOns\\Deli_Ui\\img\\Castbar\\CastingBarBackground2")
background:SetAllPoints(tCastbar)

-- Create a text for the tCastbar
local text = tCastbar:CreateFontString(nil, "OVERLAY")
text:SetFont(customfont, 12, "OUTLINE")
--text:SetFont("Interface\\Addons\\Deli_Ui\\fonts\\Prototype.TTF", 12, "OUTLINE")
text:SetPoint("CENTER", tCastbar, "CENTER", 0, 1)
text:SetTextColor(1, 1, 1)

-- Create a spark for the tCastbar
local spark = tCastbar:CreateTexture(nil, "OVERLAY")
spark:SetTexture("Interface\\AddOns\\Deli_Ui\\img\\Castbar\\CastingBarSpark")
spark:SetBlendMode("ADD")
spark:SetWidth(20)
spark:SetHeight(25)

-- Register for events and update the tCastbar
tCastbar:RegisterEvent("SPELLCAST_START")
tCastbar:RegisterEvent("SPELLCAST_STOP")
tCastbar:RegisterEvent("SPELLCAST_FAILED")
tCastbar:RegisterEvent("SPELLCAST_INTERRUPTED")
tCastbar:RegisterEvent("SPELLCAST_DELAYED")
tCastbar:RegisterEvent("SPELLCAST_CHANNEL_START")
tCastbar:RegisterEvent("SPELLCAST_CHANNEL_UPDATE")
tCastbar:RegisterEvent("SPELLCAST_CHANNEL_STOP")

tCastbar:SetScript("OnEvent", function()
    local event = event
    local arg1 = arg1
    local arg2 = arg2
    if event == "SPELLCAST_START" then
      tCastbar.casting = true
      tCastbar.startTime = GetTime()
      tCastbar.maxValue = arg2 / 1000
      -- Show the tCastbar and set the max value
      tCastbar:Show()
      tCastbar:SetMinMaxValues(0, tCastbar.maxValue)
      tCastbar:SetValue(0)
      -- Set the text to the spell name
      text:SetText(arg1)
      -- Set the spark position
      spark:SetPoint("CENTER", tCastbar, "LEFT", 0, 0)
    end

    if event == "SPELLCAST_STOP" or event == "SPELLCAST_CHANNEL_STOP" then
      tCastbar.casting = false
      -- Hide the tCastbar
      tCastbar:Hide()
    end
    if event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED" then
      -- Set the tCastbar color to red and the text to "Interrupted"
      tCastbar:SetStatusBarColor(1, 0, 0)
      text:SetText("Interrupted")
      -- Set the spark position to the end
      spark:SetPoint("CENTER", tCastbar, "RIGHT", 0, 0)
      
      -- Set a flag to revert the color after 1 second
        tCastbar.revertColor = true
        tCastbar.revertTime = GetTime() + 1
        tCastbar:Hide()
    end
    if event == "SPELLCAST_DELAYED" then
      -- Adjust the max value and the current value
      local delay = arg1 / 1000
      tCastbar.startTime = tCastbar.startTime + delay
      tCastbar.maxValue = tCastbar.maxValue + delay
      tCastbar:SetMinMaxValues(0, tCastbar.maxValue)
    end
  end)
  
  tCastbar:SetScript("OnUpdate", function(elapsed)
    if tCastbar.casting then
      -- Update the tCastbar value and the spark position
      local value = GetTime() - tCastbar.startTime
      tCastbar:SetValue(value)
      local width = tCastbar:GetWidth()
      local min, max = tCastbar:GetMinMaxValues()
      local percent = (value - min) / (max - min)
      spark:SetPoint("CENTER", tCastbar, "LEFT", width * percent, 0)
    end
      -- Revert the color if the flag is set and the time has come
    if tCastbar.revertColor and GetTime() >= tCastbar.revertTime then
      tCastbar:SetStatusBarColor(0.8, 0.8, 0.8)
      tCastbar.revertColor = false
    end
  end)
