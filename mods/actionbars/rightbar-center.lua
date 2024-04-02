

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



  for i = 2, 12 do
		local b = 5
        local button = _G['MultiBarRightButton' .. i]
        button:ClearAllPoints()
		button:SetFrameStrata("BACKGROUND")
         if mod(i - 1, b) == 0 then
             button:SetPoint('TOP', _G['MultiBarRightButton' .. (i - b)], 'BOTTOM', 0, -6)
         else
             button:SetPoint('LEFT', _G['MultiBarRightButton' .. (i - 1)], 'RIGHT', 6, 0)
         end
     end
 -- anchor button 1 so 12 buttons are centered above default bars
MultiBarRightButton1:ClearAllPoints()
MultiBarRightButton1:SetFrameStrata("BACKGROUND")
MultiBarRightButton1:SetPoint("CENTER",UIParent,"CENTER",-83,-185)

function barsize(MultiBarRightButton)
for i = 1, 12 do
	local bar =_G['MultiBarRightButton' .. i]
	bar:SetScale(1.1)
	
	
end
	end

barsize()