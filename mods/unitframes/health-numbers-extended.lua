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

local hooks = {}
hooksecurefunc = function(name, func, append)
  if not _G[name] then return end

  hooks[tostring(func)] = {}
  hooks[tostring(func)]["old"] = _G[name]
  hooks[tostring(func)]["new"] = func

  if append then
    hooks[tostring(func)]["function"] = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
      hooks[tostring(func)]["old"](a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
      hooks[tostring(func)]["new"](a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
    end
  else
    hooks[tostring(func)]["function"] = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
      hooks[tostring(func)]["new"](a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
      hooks[tostring(func)]["old"](a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
    end
  end

  _G[name] = hooks[tostring(func)]["function"]
end


 
 TargetofTargetFrame.StatusTexts = CreateFrame("Frame", nil, TargetofTargetFrame)
  TargetofTargetFrame.StatusTexts:SetAllPoints(TargetofTargetFrame)
  TargetofTargetFrame.StatusTexts:SetFrameStrata("LOW")
  TargetofTargetFrame.StatusTexts:SetFrameLevel(64)
  
  TargetofTargetHealthBar.TextString = TargetofTargetFrame.StatusTexts:CreateFontString("TargetofTargetHealthBarText")
  TargetofTargetHealthBar.TextString:SetPoint("CENTER", TargetofTargetHealthBar, "CENTER", -2, 0)

  TargetofTargetManaBar.TextString = TargetofTargetFrame.StatusTexts:CreateFontString("TargetofTargetManaBarText")
  TargetofTargetManaBar.TextString:SetPoint("CENTER", TargetofTargetManaBar, "CENTER", -2, 0)

  for _, frame in pairs( { TargetofTargetHealthBar, TargetofTargetManaBar }) do
    frame.TextString:SetFontObject("GameFontWhite")
    frame.TextString:SetFont(STANDARD_TEXT_FONT, 9, "OUTLINE")
    frame.TextString:SetHeight(32)
    frame.TextString:SetJustifyH("LEFT")
  end

  for i=1, 4 do
    local frame = _G["PartyMemberFrame"..i]
    local healthbar = _G["PartyMemberFrame"..i.."HealthBar"]
    local manabar = _G["PartyMemberFrame"..i.."ManaBar"]

    frame.StatusTexts = CreateFrame("Frame", nil, frame)
    frame.StatusTexts:SetAllPoints(frame)

    healthbar.TextString = frame.StatusTexts:CreateFontString("PartyMemberFrame"..i.."HealthBarText")
    healthbar.TextString:SetPoint("CENTER", healthbar, "CENTER", -2, 0)
    healthbar.TextString:SetFontObject("GameFontWhite")
    healthbar.TextString:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
    healthbar.TextString:SetHeight(32)
    healthbar.TextString:SetDrawLayer("OVERLAY")

    manabar.TextString = frame.StatusTexts:CreateFontString("PartyMemberFrame"..i.."ManaBarText")
    manabar.TextString:SetPoint("CENTER", manabar, "CENTER", -2, 0)
    manabar.TextString:SetFontObject("GameFontWhite")
    manabar.TextString:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
    manabar.TextString:SetHeight(32)
    manabar.TextString:SetDrawLayer("OVERLAY")
    
    TextStatusBar_UpdateTextString(healthbar)
    TextStatusBar_UpdateTextString(manabar)
  end

  local function UpdateToT()
    TextStatusBar_UpdateTextString(TargetofTargetHealthBar)
  end

  hooksecurefunc("TargetofTarget_Update", UpdateToT, true)

