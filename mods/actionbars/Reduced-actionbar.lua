--[[
Author: ShaguTweaks
Modified by: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard art work from 1.12. I've created new buttons and textured them to match
Dragonflight.
]]

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



-- Sections  
 local sections  = {
        'TOPLEFT', 'TOPRIGHT', 'BOTTOMLEFT', 'BOTTOMRIGHT', 'TOP', 'BOTTOM', 'LEFT', 'RIGHT'
    }

-- general function to hide textures and frames
local restyle = CreateFrame("Frame", nil, UIParent)
local addonpath = "Interface\\AddOns\\Deli_Ui"
local customfont = addonpath .. "\\fonts\\PROTOTYPE.TTF"
  local function hide(frame, texture)
    if not frame then return end

    if texture and texture == 1 and frame.SetTexture then
      frame:SetTexture("")
    elseif texture and texture == 2 and frame.SetNormalTexture then
      frame:SetNormalTexture("")
    else
      frame:ClearAllPoints()
      frame.Show = function() return end
      frame:Hide()
    end
  end

  -- frames that shall be hidden
  
  local frames = {
    -- actionbar paging
    MainMenuBarPageNumber, ActionBarUpButton, ActionBarDownButton,
    -- xp and reputation bar
    MainMenuXPBarTexture2, MainMenuXPBarTexture3,
   ReputationWatchBarTexture2, ReputationWatchBarTexture3,

    -- actionbar backgrounds
	  --MainMenuBarTexture0,
    --MainMenuBarTexture1,
    MainMenuBarTexture2, MainMenuBarTexture3,
    MainMenuMaxLevelBar2, MainMenuMaxLevelBar3, 
	--BonusActionBarTexture0,
    -- shapeshift backgrounds
    ShapeshiftBarLeft, ShapeshiftBarMiddle, ShapeshiftBarRight,
  }

  --[[
    I removed these from the local frames so I can reskin them
    -- micro button panel
    CharacterMicroButton, SpellbookMicroButton, TalentMicroButton,
    QuestLogMicroButton, MainMenuMicroButton, SocialsMicroButton,
    WorldMapMicroButton, MainMenuBarPerformanceBarFrame, HelpMicroButton,
    -- bag panel
    CharacterBag3Slot, CharacterBag2Slot, CharacterBag1Slot,
    CharacterBag0Slot, MainMenuBarBackpackButton, KeyRingButton,
    
  ]]


-- Skin frames?

 local function skin(f, offset, x, y)
        local t = {}
        offset = offset or 0
        x = x or 0
        y = y or 0
            
        for i = 1, 8 do
            local section = sections[i]
            local x = f:CreateTexture(nil, 'OVERLAY', nil, 1)
            x:SetTexture(addonpath..'\\img\\borders\\'..'border-'..section..'.tga')
            t[sections[i]] = x
        end

        t.TOPLEFT:SetWidth(8)
        t.TOPLEFT:SetHeight(8)
        t.TOPLEFT:SetPoint('BOTTOMRIGHT', f, 'TOPLEFT', 4 + offset + x, -4 - offset + y)

        t.TOPRIGHT:SetWidth(8)
        t.TOPRIGHT:SetHeight(8)
        t.TOPRIGHT:SetPoint('BOTTOMLEFT', f, 'TOPRIGHT', -4 - offset + x, -4 - offset + y)

        t.BOTTOMLEFT:SetWidth(8)
        t.BOTTOMLEFT:SetHeight(8)
        t.BOTTOMLEFT:SetPoint('TOPRIGHT', f, 'BOTTOMLEFT', 4 + offset + x, 4 + offset + y)

        t.BOTTOMRIGHT:SetWidth(8)
        t.BOTTOMRIGHT:SetHeight(8)
        t.BOTTOMRIGHT:SetPoint('TOPLEFT', f, 'BOTTOMRIGHT', -4 - offset + x, 4 + offset + y)

        t.TOP:SetHeight(8)
        t.TOP:SetPoint('TOPLEFT', t.TOPLEFT, 'TOPRIGHT')
        t.TOP:SetPoint('TOPRIGHT', t.TOPRIGHT, 'TOPLEFT')

        t.BOTTOM:SetHeight(8)
        t.BOTTOM:SetPoint('BOTTOMLEFT', t.BOTTOMLEFT, 'BOTTOMRIGHT')
        t.BOTTOM:SetPoint('BOTTOMRIGHT', t.BOTTOMRIGHT, 'BOTTOMLEFT')

        t.LEFT:SetWidth(8)
        t.LEFT:SetPoint('TOPLEFT', t.TOPLEFT, 'BOTTOMLEFT')
        t.LEFT:SetPoint('BOTTOMLEFT', t.BOTTOMLEFT, 'TOPLEFT')

        t.RIGHT:SetWidth(8)
        t.RIGHT:SetPoint('TOPRIGHT', t.TOPRIGHT, 'BOTTOMRIGHT')
        t.RIGHT:SetPoint('BOTTOMRIGHT', t.BOTTOMRIGHT, 'TOPRIGHT')

        f.borderTextures = t
        f.SetBorderColor = SetBorderColor
        f.GetBorderColor = GetBorderColor
    end


local function bg(frame, i, c, a)
            frame:SetBackdrop({
                bgFile = "Interface\\TabardFrame\\TabardFrameBackground",
                -- edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                -- tile = true, tileSize = 12, edgeSize = 22, 
                insets = { left = i, right = i, top = i, bottom = i }
            })
            frame:SetBackdropColor(c,c,c,a)
        end
		


  -- textures that shall be set empty
  local textures = {
    ReputationWatchBarTexture2, ReputationWatchBarTexture3,
    ReputationXPBarTexture2, ReputationXPBarTexture3,
    SlidingActionBarTexture0, SlidingActionBarTexture1,
	
  }

  -- button textures that shall be set empty
  local normtextures = {
    ShapeshiftButton1, ShapeshiftButton2,
    ShapeshiftButton3, ShapeshiftButton4,
    ShapeshiftButton5, ShapeshiftButton6,
  }

  -- elements that shall be resized to 511px
  local resizes = {
    MainMenuBar, MainMenuExpBar, MainMenuBarMaxLevelBar,
    ReputationWatchBar, ReputationWatchStatusBar,
  }

  -- hide frames
  for id, frame in pairs(frames) do hide(frame) end
  
  --hide error frames
 
 UIErrorsFrame:Hide();

  -- clear textures
  for id, frame in pairs(textures) do hide(frame, 1) end
  for id, frame in pairs(normtextures) do hide(frame, 2) end

  -- resize actionbar
  for id, frame in pairs(resizes) do frame:SetWidth(511) end

  -- experience bar
 MainMenuXPBarTexture0:SetPoint("LEFT", MainMenuExpBar, "LEFT")
 MainMenuXPBarTexture1:SetPoint("RIGHT", MainMenuExpBar, "RIGHT")

  -- reputation bar
  ReputationWatchBar:SetPoint("BOTTOM", MainMenuExpBar, "TOP", 0, 0)
  ReputationWatchBarTexture0:SetPoint("LEFT", ReputationWatchBar, "LEFT")
  ReputationWatchBarTexture1:SetPoint("RIGHT", ReputationWatchBar, "RIGHT")
  
  -- move menubar texture background
  MainMenuMaxLevelBar0:SetPoint("LEFT", MainMenuBarArtFrame, "LEFT")
  MainMenuBarTexture0:SetPoint("LEFT", MainMenuBarArtFrame, "LEFT")
  MainMenuBarTexture1:SetPoint("RIGHT", MainMenuBarArtFrame, "RIGHT")

  -- move gryphon textures
  MainMenuBarLeftEndCap:SetPoint("RIGHT", MainMenuBarArtFrame, "LEFT", 33, 0)
  MainMenuBarRightEndCap:SetPoint("LEFT", MainMenuBarArtFrame, "RIGHT", -33, 0)

  -- move MultiBarBottomRight ontop of MultiBarBottomLeft
  MultiBarBottomRight:ClearAllPoints()
  MultiBarBottomRight:SetPoint("BOTTOM", MultiBarBottomLeft, "TOP", 0, 5)
  MultiBarBottomLeft:SetFrameStrata("LOW")

  -- reload custom frame positions after original frame manage runs
  local hookUIParent_ManageFramePositions = UIParent_ManageFramePositions
  UIParent_ManageFramePositions = function(a1, a2, a3)
    -- run original function
    hookUIParent_ManageFramePositions(a1, a2, a3)

    -- move bars above xp bar if xp or reputation is tracked
	MainMenuBarLeftEndCap:ClearAllPoints()
	MainMenuBarRightEndCap:ClearAllPoints()
   -- MainMenuBar:ClearAllPoints()
   if MainMenuExpBar:IsVisible() or ReputationWatchBar:IsVisible() then
	local anchor = GetWatchedFactionInfo() and ReputationWatchBar or MainMenuExpBar
	
	MainMenuBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 45)
	MainMenuBarLeftEndCap:SetPoint("RIGHT", MainMenuBarArtFrame, "LEFT", 26, 10)
	MainMenuBarRightEndCap:SetPoint("LEFT", MainMenuBarArtFrame, "RIGHT", -26, 10)
    else
      MainMenuBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 45)
	MainMenuBarLeftEndCap:SetPoint("RIGHT", MainMenuBarArtFrame, "LEFT", 26, 25)
	MainMenuBarRightEndCap:SetPoint("LEFT", MainMenuBarArtFrame, "RIGHT", -26, 25)
	MainMenuBarMaxLevelBar:SetAlpha(0)
    end

	MainMenuExpBar:ClearAllPoints()
	-- MainMenuExpBar:SetPoint("BOTTOM", MainMenuBar, "BOTTOM", 0, -14)
	MainMenuExpBar:SetPoint("TOPLEFT", ActionButton1, "BOTTOMLEFT", -5, -12)
    MainMenuExpBar:SetPoint("TOPRIGHT", ActionButton12, "BOTTOMRIGHT", 5, -12)
	
	MultiBarBottomLeft:ClearAllPoints()
	MultiBarBottomLeft:SetPoint("BOTTOM", MainMenuBar, "TOP", 3, -5)
	ReputationWatchStatusBar:ClearAllPoints()
	ReputationWatchBar:SetPoint("TOP", MainMenuExpBar, "BOTTOM", 0, -6)  
	
-- move pet actionbar above other actionbars
PetActionBarFrame:ClearAllPoints()
local anchor = MainMenuBarArtFrame

-- Create a function to update the anchor and position of PetActionBarFrame
local function updatePetActionBarPosition()
    if MultiBarBottomRight:IsVisible() then
        anchor = MultiBarBottomRight
    elseif MultiBarBottomLeft:IsVisible() then
        anchor = MultiBarBottomLeft
    end
    PetActionBarFrame:SetPoint("BOTTOM", anchor, "TOP", 0, 3)
end

-- Call the function initially to set the position
updatePetActionBarPosition()

-- Set scripts to update the position when action bars show/hide
MultiBarBottomRight:SetScript("OnShow", updatePetActionBarPosition)
MultiBarBottomRight:SetScript("OnHide", updatePetActionBarPosition)
MultiBarBottomLeft:SetScript("OnShow", updatePetActionBarPosition)
MultiBarBottomLeft:SetScript("OnHide", updatePetActionBarPosition)


    -- ShapeshiftBarFrame
    ShapeshiftBarFrame:ClearAllPoints()
    local offset = 0
    local anchor = ActionButton1
    anchor = MultiBarBottomLeft:IsVisible() and MultiBarBottomLeft or anchor
    anchor = MultiBarBottomRight:IsVisible() and MultiBarBottomRight or anchor

    offset = anchor == ActionButton1 and ( MainMenuExpBar:IsVisible() or ReputationWatchBar:IsVisible() ) and 6 or 0
    offset = anchor == ActionButton1 and offset + 6 or offset
    ShapeshiftBarFrame:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 8, 2 + offset)

    -- move castbar ontop of other bars
    local anchor = MainMenuBarArtFrame
    anchor = MultiBarBottomLeft:IsVisible() and MultiBarBottomLeft or anchor
    anchor = MultiBarBottomRight:IsVisible() and MultiBarBottomRight or anchor
    local pet_offset = PetActionBarFrame:IsVisible() and 40 or 0
    CastingBarFrame:SetPoint("BOTTOM", anchor, "TOP", -0, 50 + pet_offset)

-- Actionbar BG
local mmbg = CreateFrame("Frame", nil, MainMenuBar)
        mmbg:SetFrameStrata("LOW")
        local i = 10
        mmbg:SetPoint("TOPLEFT", ActionButton1, "TOPLEFT", -i, i)
        mmbg:SetPoint("BOTTOMRIGHT", ActionButton12, "BOTTOMRIGHT", i, -i-1)
        -- mmbg:Hide()


bg(mmbg, 4, 1, .7)
        skin(mmbg, 5)

end
-- reskin the actionbars
   function restyle:buttons()
        local function style(button)
            if not button then return end        

            local hotkey = _G[button:GetName().."HotKey"]
            if hotkey then
                local font, size, outline = customfont, 12, "OUTLINE"
                hotkey:SetFont(font, size, outline)
            end

            local macro = _G[button:GetName().."Name"]  
            if macro then
                local font, size, outline = customfont, 12, "OUTLINE"
                macro:SetFont(font, size, outline)   
            end

            local count = _G[button:GetName()..'Count']
            if count then
                local font, size, outline = customfont, 14, "OUTLINE"
                count:SetFont(font, size, outline)   
            end
        end
        
        for i = 1, 24 do
            local button = _G['BonusActionButton'..i]
            if button then
                style(button)
            end
        end

        for i = 1, 12 do
            for _, button in pairs(
                    {
                    _G['ActionButton'..i],
                    _G['MultiBarRightButton'..i],
                    _G['MultiBarLeftButton'..i],
                    _G['MultiBarBottomLeftButton'..i],
                    _G['MultiBarBottomRightButton'..i],
                }
            ) do
                style(button)
            end        
        end 

        for i = 1, 10 do
            for _, button in pairs(
                {
                    _G['ShapeshiftButton'..i],
                    _G['PetActionButton'..i]
                }
            ) do
                style(button)
            end
        end
    end

restyle:buttons()
-- MainMenuExpBar:SetAlpha(0) --Required for tXPbar.lua to work
