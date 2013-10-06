
local myname, ns = ...


local function Update(self) PaperDollItemSlotButton_Update(self) end
local function OnClick(self) PutItemInBag(self.id) end
local function OnLeave()
	GameTooltip:Hide()
	ResetCursor()
end


function ns.MakeBagSlotFrame(bag, parent)
	local name = parent:GetName()..'Slot'
	local frame = CreateFrame('CheckButton', name, parent:GetParent(), 'ItemButtonTemplate')
	frame:SetSize(37, 37)
	frame:SetPoint('LEFT', parent)

	frame:RegisterForDrag("LeftButton")

	local id, texture = GetInventorySlotInfo("Bag"..(bag-1).."Slot")
	frame.isBag = true
	frame.id = id
	frame:SetID(id)

	frame.icon:SetTexture(texture)
	frame.backgroundTextureName = texture

	frame.UpdateTooltip = BagSlotButton_OnEnter
	frame.Update = Update

	frame:SetScript('OnEnter', BagSlotButton_OnEnter)
	frame:SetScript('OnLeave', OnLeave)
	frame:SetScript('OnDragStart', BagSlotButton_OnDrag)
	frame:SetScript('OnReceiveDrag', OnClick)
	frame:SetScript('OnClick', OnClick)
	frame:SetScript('OnShow', PaperDollItemSlotButton_OnShow)
	frame:SetScript('OnHide', PaperDollItemSlotButton_OnHide)
	frame:SetScript('OnEvent', PaperDollItemSlotButton_OnEvent)

	parent.bagslot = frame
end