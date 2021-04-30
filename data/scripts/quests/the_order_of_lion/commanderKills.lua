local config = {
	firstPlayerPosition = Position(32457, 32508, 6),
    centerPosition = Position(32439, 32523, 7), -- Center Room  
	exitPosition = Position(32453, 32503, 7), -- Exit Position
	newPosition = Position(32453, 32510, 7),
	rangeX = 22,
	rangeY = 16,
}

local lionCommanderDeath = CreatureEvent("lionCommanderDeath")
function lionCommanderDeath.onPrepareDeath(creature)
	local totalCommanders = Game.getStorageValue(Storage.TheOrderOfTheLion.Drume.TotalLionCommanders)
	if totalCommanders > 3 then
		Game.setStorageValue(Storage.TheOrderOfTheLion.Drume.TotalLionCommanders, totalCommanders - 1)
	else
		local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
		for _, cid in pairs(spectators) do
			if cid:isMonster() and not cid:getMaster() then
				cid:remove()
			elseif cid:isPlayer() then
				cid:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You lost the skirmish.")
				cid:teleportTo(config.exitPosition)
			end
		end
		config.exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
	end
	local monster = Game.createMonster("Drume", config.centerPosition, true, true)
	local monster = Game.createMonster("Kesar", config.centerPosition, true, true)
	--Game.createMonster("Kesar", config.centerPosition, false, true)
	--Game.createMonster("Drume", config.centerPosition, false, true)
    return true
end
lionCommanderDeath:register()