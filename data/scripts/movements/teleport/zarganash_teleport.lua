local setting = {
	[62120] = Position(33578, 31404, 9),
	[62121] = Position(33937, 31216, 11),
	[62122] = Position(33615, 31423, 10),
	[62123] = Position(33634, 31430, 10),
	[62124] = Position(33634, 31430, 10),
	[62125] = Position(33530, 31410, 9),
	[62126] = Position(33541, 31411, 9),
	[62127] = Position(33537, 31440, 9),
	[62128] = Position(33550, 31438, 9),
	[62129] = Position(33557, 31467, 9),
	[62130] = Position(33571, 31467, 9)
}

local zarganashTeleport = MoveEvent()

function zarganashTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local toPosition = setting[item.actionid]
	if not toPosition then
		return true
	end

	player:teleportTo(toPosition)
	toPosition:sendMagicEffect(CONST_ME_PURPLEENERGY)
	return true
end

zarganashTeleport:type("stepin")

for index, value in pairs(setting) do
	zarganashTeleport:aid(index)
end

zarganashTeleport:register()
