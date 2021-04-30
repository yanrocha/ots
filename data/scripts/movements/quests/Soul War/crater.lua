local craterTP = MoveEvent()
function craterTP.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	if item.actionid == 59130 then
		if player:getStorageValue(14556) > os.time() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have to wait a while to challenge this boss again!")
				player:teleportTo(fromPosition)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		else
				player:teleportTo(Position(33875, 31874, 6))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end	
	end
	return true
end
craterTP:type("stepin")
craterTP:aid(59130)
craterTP:register()