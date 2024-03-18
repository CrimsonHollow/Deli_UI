
Abbreviate = function(number, eachk)
  local sign = number < 0 and -1 or 1
  number = math.abs(number)

  if number > 1000000 then
    return ShaguTweaks.round(number/1000000*sign,2) .. "m"
  elseif not eachk and number > 10000 then
    return ShaguTweaks.round(number/1000*sign,2) .. "k"
  elseif eachk and number > 1000 then
    return ShaguTweaks.round(number/1000*sign,2) .. "k"
  end

  return number
end


    local function abbrevname(t)
        return string.sub(t,1,1)..". "
    end
      
    local function getNameString(unitstr)
        local name = UnitName(unitstr)
        local size = 15
        
        -- first try to only abbreviate the first word
        if name and strlen(name) > size then
            name = string.gsub(name, "^(%S+) ", abbrevname)
        end
        
        -- abbreviate all if it still doesn't fit
        if name and strlen(name) > size then
            name = string.gsub(name, "(%S+) ", abbrevname)
        end
        
        return name
    end

 function abbrevName(frame, unit)
        local name = getNameString(unit)
        if name and frame.name then
            frame.name:SetText(name)
        end
    end

    local target = CreateFrame("Frame")
    target:RegisterEvent("PLAYER_TARGET_CHANGED")
    target:SetScript("OnEvent", function()
        abbrevName(TargetFrame, "target")
    end)
    
    local tot = CreateFrame("Frame", nil, TargetFrame)
    tot:SetScript("OnUpdate", function()
        abbrevName(TargetofTargetFrame, "targettarget")
    end)
