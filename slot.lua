
local myname, ns = ...


local colorCache = {}
local plain = {r = .05, g = .05, b = .05}
local function ColorBorder(self)
	local bag_frame = self:GetParent()
	local color = plain

	local link = GetContainerItemLink(bag_frame.id, self.id)
	if link then
		local _, _, rarity = GetItemInfo(link)
		if rarity and rarity > 1 then
			color = colorCache[rarity]
			if not color then
				local r, g, b, hex = GetItemQualityColor(rarity)
				color = {r = r, g = g, b = b}
				colorCache[rarity] = color
			end
		end
	end

	local target = self.border
	target:SetVertexColor(color.r, color.g, color.b)
end


function ns.MakeSlotFrame(bag, slot)
	local name = string.format('%sItem%d', bag:GetName(), slot)
	local frame = CreateFrame("Button", name, bag, "ContainerFrameItemButtonTemplate")
	frame.id = slot
	frame:SetID(slot)

	frame:ClearAllPoints()
	if slot == 1 then
		frame:SetPoint('LEFT', bag, 42, 0)
	else
		frame:SetPoint('LEFT', bag.slots[slot-1], 'RIGHT', 2, 0)
	end

	local border = frame:CreateTexture(nil, "OVERLAY")
	border:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
	border:SetBlendMode("ADD")
	border:SetAlpha(.5)

	border:SetPoint('CENTER', frame, 'CENTER', 0, 1)
	border:SetWidth(frame:GetWidth() * 2 - 5)
	border:SetHeight(frame:GetHeight() * 2 - 5)

	frame.border = border
	frame.ColorBorder = ColorBorder

	return frame
end
