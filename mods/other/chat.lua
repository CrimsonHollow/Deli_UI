local restyle = CreateFrame("Frame", nil, UIParent)
local addonpath = "Interface\\AddOns\\Deli_Ui"
	local customfont = addonpath .. "\\fonts\\PROTOTYPE.TTF"
   local font, size, outline = customfont, 9, "OUTLINE"
   
   function restyle:chatframes()
        local frames = {
            ChatFrame1,
            ChatFrame2,
            ChatFrame3
        }

        local font = customfont
        for _, frame in pairs(frames) do            
            local _, size, outline = frame:GetFont()
            frame:SetFont(font, size, outline)
        end
    end
	
	
restyle:chatframes()