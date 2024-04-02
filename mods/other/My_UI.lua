 local resolution = GetCVar("gxResolution")
    local _, _, screenwidth, screenheight = strfind(resolution, "(.+)x(.+)")
    screenwidth = tonumber(screenwidth)
    -- screenheight = tonumber(screenheight)
    -- local res = screenwidth/screenheight
    -- local uw
    -- if res > 1.78 then uw = true end

    local function unitframes()
        -- Player
        PlayerFrame:SetClampedToScreen(true)
        PlayerFrame:ClearAllPoints()
        PlayerFrame:SetPoint("RIGHT", UIParent, "CENTER", -130, -210)

        -- Target
        TargetFrame:SetClampedToScreen(true)
        TargetFrame:ClearAllPoints()
        TargetFrame:SetPoint("LEFT", UIParent, "CENTER", 130, -210)
		
		--TargetOfTarget
		TargetFrame:SetClampedToScreen(true)
		TargetofTargetFrame:ClearAllPoints()
		TargetofTargetFrame:SetPoint("RIGHT", TargetFrame, 55, -5)
end



    local function buffs()
        -- Buffs start with TemporaryEnchantFrame
        -- Debuffs are aligned underneath the TemporaryEnchantFrame
        TemporaryEnchantFrame:ClearAllPoints()
        TemporaryEnchantFrame:SetPoint("BOTTOMRIGHT", PlayerFrame, -5, -7)
		BuffButton0:ClearAllPoints()
		BuffButton8:ClearAllPoints()
		BuffButton8:SetPoint("LEFT", BuffButton7, "LEFT", -38, 0 )
		BuffButton16:ClearAllPoints()
		BuffButton16:SetPoint("TOPRIGHT", UIParent, -40, -140)
        -- prevent TemporaryEnchantFrame from moving
        TemporaryEnchantFrame.ClearAllPoints = function() end
        TemporaryEnchantFrame.SetPoint = function() end
    end

    local function chat()
        local _, fontsize = ChatFrame1:GetFont()
        -- local lines = 9 -- number of desired chat lines
        -- local h = (fontsize * (lines*1.1))
        local h = 120
        local w = 400
        -- local x = 32
        -- if uw then x = screenwidth/9 end
        local x = screenwidth/9
        local y = 115

        ChatFrame1:SetClampedToScreen(true)
        ChatFrame1:SetWidth(w)
        ChatFrame1:SetHeight(h)
        ChatFrame1:ClearAllPoints()
        ChatFrame1:SetPoint("BOTTOMRIGHT", "UIParent", -x/2, y)

        local found
        local frame




    end

    local events = CreateFrame("Frame", nil, UIParent)
    events:RegisterEvent("PLAYER_ENTERING_WORLD")

    events:SetScript("OnEvent", function()
        if not this.loaded then
            this.loaded = true
            unitframes()
          -- minimap()
            buffs()
            chat()
        end
    end)