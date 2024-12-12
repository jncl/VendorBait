
local _, ns = ...

local f = ns.newShiner(_G.QuestRewardScrollChildFrame)
f:Hide()


local function update()
	f:Hide()
	local bestp, besti = 0
	for i = 1, _G.GetNumQuestChoices() do
		local _, _, qty = _G.GetQuestItemInfo("choice", i)
		local link = _G.GetQuestItemLink("choice", i)
		if not link then return ns.StartTimer(_G.GetTime() + 1, update) end

		local price = link and _G.select(11, _G.C_Item.GetItemInfo(link))
		if not price then return
		elseif (price * (qty or 1)) > bestp then
			bestp = price * (qty or 1)
			besti = i
		end
	end

	if besti then
		local qif = _G.QuestInfo_GetRewardButton(_G.QuestInfoFrame.rewardsFrame, besti)
		f:ClearAllPoints()
		f:SetAllPoints(qif.Icon)
		f:Show()
	end
end
ns.RegisterEvent("QUEST_COMPLETE", update)
ns.RegisterEvent("QUEST_ITEM_UPDATE", update)
ns.RegisterEvent("GET_ITEM_INFO_RECEIVED", update)


if _G.QuestFrameRewardPanel:IsVisible() then update() end
