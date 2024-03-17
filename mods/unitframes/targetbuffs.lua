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

function buffsize(TargetFrameBuff)
for i = 1, 5 do
	local buff =_G['TargetFrameBuff' .. i]
	buff:SetScale(1.4)
	
	
end
	end


function debuffsize(TargetFrameDebuff)
for i = 1, 5 do
	local debuff =_G['TargetFrameDebuff' .. i]
	debuff:SetScale(1.4)
	
	
end
	end

function debuffposition(TargetFrameDebuff)
for i = 2, 5 do
local debuff =_G['TargetFrameDebuff' .. i]
debuff:SetPoint('LEFT', _G['TargetFrameDebuff' .. (i-1)], 'RIGHT', 2, 0)
	end
end

function buffposition(TargetFrameBuff)
for i = 2, 5 do
local buff =_G['TargetFrameBuff' .. i]
buff:SetPoint('LEFT', _G['TargetFrameBuff' .. (i-1)], 'RIGHT', 2, 0)
	end
end



local TargetDebuffButton_Update_old = TargetDebuffButton_Update
TargetDebuffButton_Update = function()
    TargetDebuffButton_Update_old()
    TargetFrameBuff1:ClearAllPoints()
	TargetFrameDebuff1:ClearAllPoints()
TargetFrameBuff1:SetPoint("TOPLEFT" , TargetFrame,"BOTTOMLEFT", 4, 23)
TargetFrameDebuff1:SetPoint("TOPLEFT" , TargetFrame,"BOTTOMLEFT", 4, 23)

end



buffsize()
buffposition()
debuffsize()
debuffposition()
