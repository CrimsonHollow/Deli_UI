--[[
Author: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard art work from 1.12. I've created new buttons and textured them to match
Dragonflight.
]]
-- Hide the original gryphons
MainMenuBarLeftEndCap:Hide()
MainMenuBarRightEndCap:Hide()

-- Create new textures
local leftGryphon = MainMenuBar:CreateTexture(nil, "OVERLAY")
local rightGryphon = MainMenuBar:CreateTexture(nil, "OVERLAY")

-- Position the new textures
leftGryphon:SetPoint("LEFT", MainMenuBarArtFrame, "LEFT", -90, 12)
rightGryphon:SetPoint("RIGHT", MainMenuBarArtFrame, "RIGHT", 90, 12)


--Checking Horde vs. Alliance wouldn't work, so using races
local race = UnitRace("player")
--DEFAULT_CHAT_FRAME:AddMessage("Your race is " .. race .. ".")

if race == "Night Elf" then
    leftGryphon:SetTexture("Interface\\Addons\\Deli_Ui\\img\\Gryphon")
    rightGryphon:SetTexture("Interface\\Addons\\Deli_Ui\\img\\Gryphon")
elseif race == "Human" then
    leftGryphon:SetTexture("Interface\\Addons\\Deli_Ui\\img\\Gryphon")
    rightGryphon:SetTexture("Interface\\Addons\\Deli_Ui\\img\\Gryphon")
elseif race == "Gnome" then
    leftGryphon:SetTexture("Interface\\Addons\\Deli_Ui\\img\\Gryphon")
    rightGryphon:SetTexture("Interface\\Addons\\Deli_Ui\\img\\Gryphon")
elseif race == "Dwarf" then
    leftGryphon:SetTexture("Interface\\Addons\\Deli_Ui\\img\\Gryphon")
    rightGryphon:SetTexture("Interface\\Addons\\Deli_Ui\\img\\Gryphon")
elseif race == "High Elf" then
    leftGryphon:SetTexture("Interface\\Addons\\Deli_Ui\\img\\Gryphon")
    rightGryphon:SetTexture("Interface\\Addons\\Deli_Ui\\img\\Gryphon")
else
    leftGryphon:SetTexture("Interface\\Addons\\Deli_Ui\\img\\Wyvern")
    rightGryphon:SetTexture("Interface\\Addons\\Deli_Ui\\img\\Wyvern")
	leftGryphon:SetPoint("LEFT", MainMenuBarArtFrame, "LEFT", -90, 16)
	rightGryphon:SetPoint("RIGHT", MainMenuBarArtFrame, "RIGHT", 90, 16)
end

--Size the endcaps
leftGryphon:SetWidth(126)
leftGryphon:SetHeight(126)
rightGryphon:SetWidth(126)
rightGryphon:SetHeight(126)

-- Flip the right texture
rightGryphon:SetTexCoord(1, 0, 0, 1)
