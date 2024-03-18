--[[
Author: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard art work from 1.12. I've created new buttons and textured them to match
Dragonflight.
]]

local addonpath = "Interface\\AddOns\\Deli_Ui"
local customfont = addonpath .. "\\fonts\\PROTOTYPE.TTF"

local w = 250
local h = 20

--CastingBarFrame
--CastingBarBorder
--CastingBarSpark
--CastingBarFlash
--CastingBarText



local castbar = CastingBarFrame
castbar:SetStatusBarTexture("Interface\\AddOns\\Deli_Ui\\img\\Castbar\\CastingBarStandard2")
castbar:SetWidth(w)
castbar:SetHeight(h)

local castbartext = CastingBarText
castbartext:SetFont(customfont, 12, "OUTLINE")
castbartext:ClearAllPoints()
castbartext:SetPoint("CENTER", castbar, "CENTER", 0, 1)
castbartext:SetTextColor(1,1,1)

 -- local border = CastingBarBorder
-- border:SetTexture("Interface\\AddOns\\Deli_Ui\\img\\Castbar\\CastingBarFrame2")
-- -- Set the border size to match the castbar
-- border:SetWidth(castbar:GetWidth() + 5)
-- border:SetHeight(castbar:GetHeight()+ 5)
-- border:ClearAllPoints()
-- border:SetPoint("CENTER", castbar, "CENTER", 0, 0)

CastingBarBorder:ClearAllPoints()
CastingBarBorder:SetPoint("TOPLEFT", CastingBarFrame, "TOPLEFT", -2 , 2)
CastingBarBorder:SetPoint("BOTTOMRIGHT", CastingBarFrame, "BOTTOMRIGHT", 2, -2) 
CastingBarBorder:SetTexture("Interface\\Addons\\Deli_Ui\\img\\Castbar\\CastingBarFrame2")

if ShaguTweaks.DarkMode then
	ShaguTweaks.AddBorder(castbar, bottom ,  .3, .3, .3, 1 )
     :SetVertexColor( .3, .3, .3, 1)
    end   

local spark = CastingBarSpark
spark:SetTexture("Interface\\AddOns\\Deli_Ui\\img\\Castbar\\CastingBarSpark")
spark:ClearAllPoints()
-- spark:SetPoint("CENTER", castbar, "CENTER", 0,-2)
spark:SetWidth(10)
spark:SetHeight(h + 12)

local flash = CastingBarFlash
flash:ClearAllPoints()
flash:SetPoint("CENTER", UIParent, 5000, 0)


--icon logic

-- castbar.texture = CreateFrame("Frame", nil, castbar)
    -- castbar.texture:SetPoint("RIGHT", CastingBarFrame, "LEFT", -10, 2)
    -- castbar.texture:SetWidth(28)
    -- castbar.texture:SetHeight(28)
	
	
	
    -- castbar.texture.icon = castbar.texture:CreateTexture(nil, "BACKGROUND")
    -- castbar.texture.icon:SetPoint("CENTER", 0, 0)
    -- castbar.texture.icon:SetWidth(24)
    -- castbar.texture.icon:SetHeight(24)
     -- castbar.texture:SetBackdrop({
         -- -- edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
         -- edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
         -- tile = true, tileSize = 8, edgeSize = 12,
         -- insets = { left = 2, right = 2, top = 2, bottom = 2 }
     -- })

--Hook & Reference Blizzards castbar
function CastingBarFrame_OnUpdate()
    if ( this.casting ) then
        local status = GetTime();
        if ( status > this.maxValue ) then
            status = this.maxValue
        end
        CastingBarFrameStatusBar:SetValue(status);
        CastingBarFlash:Hide();
        local sparkPosition = ((status - this.startTime) / (this.maxValue - this.startTime)) * w;
        if ( sparkPosition < 0 ) then
            sparkPosition = 0;
        end
        CastingBarSpark:SetPoint("CENTER", CastingBarFrame, "LEFT", sparkPosition, -0);
    elseif ( this.channeling ) then
        local time = GetTime();
        if ( time > this.endTime ) then
            time = this.endTime
        end
        if ( time == this.endTime ) then
            this.channeling = nil;
            this.fadeOut = 1;
            return;
        end
        local barValue = this.startTime + (this.endTime - time);
        CastingBarFrameStatusBar:SetValue( barValue );
        CastingBarFlash:Hide();
        local sparkPosition = ((barValue - this.startTime) / (this.endTime - this.startTime)) * w;
        CastingBarSpark:SetPoint("CENTER", CastingBarFrame, "LEFT", sparkPosition, -0);
    elseif ( GetTime() < this.holdTime ) then
        return;
    elseif ( this.flash ) then
        local alpha = CastingBarFlash:GetAlpha() + CASTING_BAR_FLASH_STEP;
        if ( alpha < 1 ) then
            CastingBarFlash:SetAlpha(alpha);
        else
            CastingBarFlash:SetAlpha(1.0);
            this.flash = nil;
        end
    elseif ( this.fadeOut ) then
        local alpha = this:GetAlpha() - CASTING_BAR_ALPHA_STEP;
        if ( alpha > 0 ) then
            this:SetAlpha(alpha);
        else
            this.fadeOut = nil;
            this:Hide();
        end
    end
end