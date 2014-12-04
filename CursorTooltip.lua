local tooltips = {}
local point = "BOTTOMLEFT"
local cursorOffsetX = 15
local cursorOffsetY = 15

local function SetPoint(tooltip)
	local mouseX, mouseY = GetCursorPosition()

	-- Need to get this dynamically, because scale might change after the addon has been loaded
	local scale = UIParent:GetEffectiveScale()

	mouseX = ((mouseX + cursorOffsetX) / scale)
	mouseY = ((mouseY - cursorOffsetY) / scale) - tooltip:GetHeight()

	tooltip:ClearAllPoints()
	tooltip:SetPoint(point, "UIParent", point, mouseX, mouseY)
end

local TooltipUpdate = function(tooltip, ...)
	SetPoint(tooltip)
end

-------------------------------------------------------------------------------------

TargetFrameHealthBar:HookScript('OnEnter', function() GameTooltip:Hide() end)
TargetFrameManaBar:HookScript('OnEnter', function() GameTooltip:Hide() end)

function GameTooltip_SetDefaultAnchor(tooltip, parent)
	tooltip:SetOwner(parent, "ANCHOR_CURSOR")
	SetPoint(tooltip)
	if not tooltips[tostring(tooltip)] then
		tooltips[tostring(tooltip)] = 1
		tooltip:HookScript("OnUpdate", TooltipUpdate)
	end
end
