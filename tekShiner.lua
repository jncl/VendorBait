
local _, ns = ...

local R, G, B = .95, .95, .32
local SPEEDS = {2, 4, 6, 8}
-- local SPEEDS, TIMERS, SHINES, SPACING = {2, 4, 6, 8}, {0, 0, 0, 0}, {}, 6

local function OnUpdate(self, elapsed)
	for i,timer in _G.pairs(self.timers) do
		self.timers[i] = timer + elapsed
		if self.timers[i] > SPEEDS[i] * 4 then self.timers[i] = 0 end
	end

	local _, distance = self, self:GetWidth()

	for i=1,4 do
		local timer, speed = self.timers[i], SPEEDS[i]

		if timer <= speed then
			local basePosition = timer/speed*distance
			self.sparkles[0+i]:SetPoint("CENTER", self, "TOPLEFT", basePosition, 0)
			self.sparkles[4+i]:SetPoint("CENTER", self, "BOTTOMRIGHT", -basePosition, 0)
			self.sparkles[8+i]:SetPoint("CENTER", self, "TOPRIGHT", 0, -basePosition)
			self.sparkles[12+i]:SetPoint("CENTER", self, "BOTTOMLEFT", 0, basePosition)
		elseif timer <= speed*2 then
			local basePosition = (timer-speed)/speed*distance
			self.sparkles[0+i]:SetPoint("CENTER", self, "TOPRIGHT", 0, -basePosition)
			self.sparkles[4+i]:SetPoint("CENTER", self, "BOTTOMLEFT", 0, basePosition)
			self.sparkles[8+i]:SetPoint("CENTER", self, "BOTTOMRIGHT", -basePosition, 0)
			self.sparkles[12+i]:SetPoint("CENTER", self, "TOPLEFT", basePosition, 0)
		elseif timer <= speed*3 then
			local basePosition = (timer-speed*2)/speed*distance
			self.sparkles[0+i]:SetPoint("CENTER", self, "BOTTOMRIGHT", -basePosition, 0)
			self.sparkles[4+i]:SetPoint("CENTER", self, "TOPLEFT", basePosition, 0)
			self.sparkles[8+i]:SetPoint("CENTER", self, "BOTTOMLEFT", 0, basePosition)
			self.sparkles[12+i]:SetPoint("CENTER", self, "TOPRIGHT", 0, -basePosition)
		else
			local basePosition = (timer-speed*3)/speed*distance
			self.sparkles[0+i]:SetPoint("CENTER", self, "BOTTOMLEFT", 0, basePosition)
			self.sparkles[4+i]:SetPoint("CENTER", self, "TOPRIGHT", 0, -basePosition)
			self.sparkles[8+i]:SetPoint("CENTER", self, "TOPLEFT", basePosition, 0)
			self.sparkles[12+i]:SetPoint("CENTER", self, "BOTTOMRIGHT", -basePosition, 0)
		end
	end
end


function ns.newShiner(parent, r, g, b)
	local f = _G.CreateFrame("Frame", nil, parent or _G.UIParent)
	f.sparkles, f.timers = {}, {0, 0, 0, 0}

	for i=1,16 do
		local tex = f:CreateTexture(nil, "BACKGROUND")
		tex:SetTexture([[Interface\ItemSocketingFrame\UI-ItemSockets]])
		tex:SetTexCoord(0.3984375, 0.4453125, 0.40234375, 0.44921875)
		tex:SetBlendMode("ADD")
		tex:SetWidth(13) tex:SetHeight(13)
		tex:SetVertexColor(r or R, g or G, b or B)
		f.sparkles[i] = tex
	end

	f:SetScript("OnUpdate", OnUpdate)

	return f
end
