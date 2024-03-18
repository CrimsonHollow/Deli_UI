--[[
Author: ShaguTweaks
Modified by: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard art work from 1.12. I've created new buttons and textured them to match
Dragonflight.
]]
 


local addonpath = "Interface\\AddOns\\Deli_Ui"
local customfont = addonpath .. "\\fonts\\PROTOTYPE.TTF"

	
  PlayerFrameHealthBar:SetStatusBarTexture[[Interface\Addons\Deli_Ui\img\UI-StatusBar]]
  TargetFrameHealthBar:SetStatusBarTexture[[Interface\Addons\Deli_Ui\img\UI-StatusBar]]
  PlayerFrameTexture:SetTexture[[Interface\Addons\Deli_Ui\img\UI-TargetingFrame]]  
  PlayerStatusTexture:SetTexture[[Interface\Addons\Deli_Ui\img\UI-Player-Status]]  
  PlayerFrameHealthBar:SetPoint("TOPLEFT", 106, -23)


--hide
PlayerFrame.name:Hide()
PlayerFrameGroupIndicator:SetAlpha(0)
    PlayerHitIndicator:SetText(nil)
    PlayerHitIndicator.SetText = function() end
    PetHitIndicator:SetText(nil)
    PetHitIndicator.SetText = function() end



local function health()
  TargetFrame.StatusTexts = CreateFrame("Frame", nil, TargetFrame)
  TargetFrame.StatusTexts:SetAllPoints(TargetFrame)

  TargetFrameHealthBar.TextString = TargetFrame.StatusTexts:CreateFontString("TargetFrameHealthBarText", "OVERLAY")
  TargetFrameHealthBar.TextString:SetPoint("TOP", TargetFrameHealthBar, "BOTTOM", -2, 23)

  TargetFrameManaBar.TextString = TargetFrame.StatusTexts:CreateFontString("TargetFrameManaBarText", "OVERLAY")
  TargetFrameManaBar.TextString:SetPoint("TOP", TargetFrameManaBar, "BOTTOM", -2, 22)

  PetFrameHealthBar.TextString:SetPoint("CENTER", PetFrameHealthBar, "CENTER", -2, 0)
  PetFrameManaBar.TextString:SetPoint("CENTER", PetFrameManaBar, "CENTER", -2, -2)

  for _, frame in pairs( { TargetFrameHealthBar, TargetFrameManaBar, PlayerFrameHealthBar, PlayerFrameManaBar }) do
    frame.TextString:SetFontObject("GameFontWhite")
    frame.TextString:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
    frame.TextString:SetHeight(32)
  end

  for _, frame in pairs( { PetFrameHealthBar, PetFrameManaBar }) do
    frame.TextString:SetFontObject("GameFontWhite")
    frame.TextString:SetFont(STANDARD_TEXT_FONT, 9, "OUTLINE")
    frame.TextString:SetHeight(32)
    frame.TextString:SetJustifyH("LEFT")
  end

  local HookTextStatusBar_UpdateTextString = TextStatusBar_UpdateTextString
  function TextStatusBar_UpdateTextString(sb)
    if not sb then sb = this end

    HookTextStatusBar_UpdateTextString(sb)
    local string = sb.TextString

    if string and sb.unit then
      -- hide tbc text string element

      sb.lockShow = 42
      sb:Show()

      local min, max = sb:GetMinMaxValues()
      local cur = sb:GetValue()
      local percent = max > 0 and floor(cur/max*100) or 0

      if sb:GetName() == "TargetFrameHealthBar" then
        cur, max = ShaguTweaks.libhealth:GetUnitHealth(sb.unit)
      end

      if cur == percent and strfind(sb:GetName(), "Health") then
        string:SetText(percent .. "%")
      elseif sb:GetName() == "TargetFrameHealthBar" and cur < max then
        string:SetText(Abbreviate(cur) .. " - " .. percent .. "%")
      else
        string:SetText(Abbreviate(cur))
      end

      if max == 0 then
        string:Hide()
        string:SetText("")
      elseif sb.unit == "target" and UnitIsDead("target") then
        string:Hide()
        string:SetText("")
      elseif sb.unit == "target" and UnitIsGhost("target") then
        string:Hide()
        string:SetText("")
      else
        string:Show()
      end
    end
  end
end
 
health()

-- Change Fonts
        local names = {
            PlayerFrame.name,
			PlayerLevelText,
			TargetLevelText,
			PlayerFrameHealthBar.TextString,
			PlayerFrameManaBar.TextString,
			TargetFrameHealthBar.TextString,
			TargetFrameManaBar.TextString,
			TargetFrame.name,
            TargetofTargetName,
			TargetofTargetHealthBar.TextString,
			TargetofTargetManaBar.TextString,
            --PartyMemberFrame1.name,
            --PartyMemberFrame2.name,
            --PartyMemberFrame3.name,
            --PartyMemberFrame4.name,
            --PartyMemberFrame1PetFrame.name,
            --PartyMemberFrame2PetFrame.name,
            --PartyMemberFrame3PetFrame.name,
            --PartyMemberFrame4PetFrame.name
        }
		
		PlayerFrame.name:Hide()
		PlayerFrameHealthBar.TextString:SetPoint("TOP", PlayerFrameHealthBar, "BOTTOM", 0, 30)
		TargetFrameHealthBar.TextString:SetPoint("TOP", TargetFrameHealthBar, "BOTTOM", -2, 30)
		PlayerFrameHealthBar.TextString:SetPoint("TOP", PlayerFrame, "TOP", 50, -15)
		PlayerFrame.name:SetPoint("TOP", PlayerFrame, "TOP", 50, -15)
		TargetFrame.name:SetPoint("TOP", TargetFrame, "TOP", -50, -15)
        local font, size, outline = customfont, 12, "OUTLINE"
        for _, name in pairs(names) do
            name:SetFont(font, size, outline)
        end
		PetName:SetFont(font, size -2, outline)
		PetFrameHealthBar.TextString:SetFont(font, size -4, outline)
		PetFrameManaBar.TextString:SetFont(font, size -4, outline)

		PlayerFrameHealthBar.TextString:SetFont(font, size +2, outline)
		TargetFrameHealthBar.TextString:SetFont(font, size +2, outline)



  -- Get the Player unitframe
local playerFrame = PlayerFrame
-- Change the font of the Player unitframe
-- playerFrame.healthbar.TextString:SetFont(customfont, 10, "OUTLINE")
-- playerFrame.healthbar.TextString:SetTextColor(1, 1, 1)
-- playerFrame.manabar.TextString:SetFont(customfont, 10,"OUTLINE")
-- playerFrame.manabar.TextString:SetTextColor(1, 1, 1)
local petFrame = PetFrame
-- petFrame.healthbar.TextString:SetFont(customfont, 8, "OUTLINE")
-- petFrame.healthbar.TextString:SetTextColor(1, 1, 1)
-- petFrame.manabar.TextString:SetTextColor(1, 1, 1)
 -- Center the text over the Heal and Mana bars
petFrame.healthbar.TextString:SetPoint("CENTER", petFrame.healthbar, "CENTER", 0, 2)
petFrame.healthbar.TextString:SetJustifyH("CENTER")
petFrame.manabar.TextString:SetPoint("CENTER", petFrame.manabar, "CENTER", 0, -2)
petFrame.manabar.TextString:SetJustifyH("CENTER")
PetName:ClearAllPoints()
PetName:SetPoint("CENTER", petFrame.healthbar, "CENTER", -22, 15)


-- Get the MainMenuExpBar
local expBar = MainMenuExpBar
-- Change the font of the MainMenuExpBar
expBar.TextString:SetFont(customfont, 10, "OUTLINE")
expBar.TextString:SetTextColor(1, 1, 1)
 
  PlayerFrameHealthBar:SetWidth(120)
  PlayerFrameHealthBar:SetHeight(30)
  PlayerFrameManaBar:SetWidth(120)
  PlayerFrameBackground:SetWidth(122)
  PlayerStatusTexture:SetTexture[[Interface\Addons\Deli_Ui\img\UI-Player-Status]]

  TargetFrameTexture:SetTexture[[Interface\Addons\Deli_Ui\img\UI-TargetingFrame2]]  
  TargetFrameHealthBar:SetPoint("TOPRIGHT", -103, -23)
  TargetFrameHealthBar:SetHeight(30)
  TargetFrameHealthBar:SetWidth(123)
  TargetFrameManaBar:SetPoint("TOPRIGHT", -103, -52)
  TargetFrameManaBar:SetWidth(123)
  TargetFrameBackground:SetPoint("TOPRIGHT", -103, -22)
  TargetFrameBackground:SetWidth(123)
  --TargetFrame:SetWidth(120)
  -- TargetLevelText:ClearAllPoints()
  -- TargetLevelText:SetPoint("BOTTOMRIGHT",TargetFrameHealthBar, 65, -20)
  -- Get the PlayerName text object
-- Get the PlayerName and Health text objects
local playerNameText = PlayerFrame.healthbar.TextString
playerNameText:SetHeight(30)

  TargetofTargetFrame:ClearAllPoints()
   TargetofTargetFrame:SetPoint("BOTTOM", TargetFrame, 38, -15)

  -- Hook the PetFrame_Update function
    local new_PetFrame_Update = PetFrame_Update
    local new_PetFrame = PetFrame
    PetFrame_Update = function()
      -- Call the original function
      new_PetFrame_Update()
      PetFrameTexture:SetTexture("Interface\\Addons\\Deli_Ui\\img\\pet")
      PetFrame:ClearAllPoints()
      PetFrame:SetPoint("BOTTOM", PlayerFrame, -10, -30)
    end

  local original = TargetFrame_CheckClassification
  function TargetFrame_CheckClassification()
    local classification = UnitClassification("target")
    if ( classification == "worldboss" ) then
      TargetFrameTexture:SetTexture[[Interface\Addons\Deli_Ui\img\UI-TargetingFrame-Elite]]
    elseif ( classification == "rareelite"  ) then
      TargetFrameTexture:SetTexture[[Interface\Addons\Deli_Ui\img\UI-TargetingFrame-Elite]]
    elseif ( classification == "elite"  ) then
      TargetFrameTexture:SetTexture[[Interface\Addons\Deli_Ui\img\UI-TargetingFrame-Elite]]
    elseif ( classification == "rare"  ) then
      TargetFrameTexture:SetTexture[[Interface\Addons\Deli_Ui\img\UI-TargetingFrame-Elite_Rare]]
    else
      TargetFrameTexture:SetTexture[[Interface\Addons\Deli_Ui\img\UI-TargetingFrame2]]  
    end
  end

  local wait = CreateFrame("Frame")
  wait:RegisterEvent("PLAYER_ENTERING_WORLD")
  wait:SetScript("OnEvent", function()

    -- adjust healthbar colors to frame colors
    local original = TargetFrame_CheckFaction
    function TargetFrame_CheckFaction(self)
      original(self)

      if TargetFrameHealthBar._SetStatusBarColor then
        local r, g, b, a = TargetFrameNameBackground:GetVertexColor()
        TargetFrameHealthBar:_SetStatusBarColor(r, g, b, a)
      end
    end
  end)

  -- delay to first draw
  wait:SetScript("OnUpdate", function()
    -- move text strings a bit higher
    if PlayerFrameHealthBar.TextString then
      PlayerFrameHealthBar.TextString:SetPoint("TOP", PlayerFrameHealthBar, "BOTTOM", 0, 30)
    end

    if TargetFrameHealthBar.TextString then
      TargetFrameHealthBar.TextString:SetPoint("TOP", TargetFrameHealthBar, "BOTTOM", -2, 30)
    end

    -- use class color for player (if enabled)
    if PlayerFrameNameBackground then
      -- disable vanilla ui color restore functions
      PlayerFrameHealthBar._SetStatusBarColor = PlayerFrameHealthBar.SetStatusBarColor
      PlayerFrameHealthBar.SetStatusBarColor = function() return end

      -- set player healthbar to class color
      local r, g, b, a = PlayerFrameNameBackground:GetVertexColor()
      PlayerFrameHealthBar:_SetStatusBarColor(r, g, b, a)

      -- hide status textures
      PlayerFrameNameBackground:Hide()
      PlayerFrameNameBackground.Show = function() return end
    end

    -- use frame color for target frame
    if TargetFrameNameBackground then
      -- disable vanilla ui color restore functions
      TargetFrameHealthBar._SetStatusBarColor = TargetFrameHealthBar.SetStatusBarColor
      TargetFrameHealthBar.SetStatusBarColor = function() return end

      -- hide status textures
      TargetFrameNameBackground.Show = function() return end
      TargetFrameNameBackground:Hide()
    end

    TargetFrame_CheckFaction(PlayerFrame)
    wait:UnregisterAllEvents()
    wait:Hide()
  end)
