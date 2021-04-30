local ebbTP = MoveEvent()
function ebbTP.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	if item.actionid == 59131 then
		if player:getStorageValue(14557) > os.time() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have to wait a while to challenge this boss again!")
				player:teleportTo(fromPosition)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		else
				player:teleportTo(Position(34100, 31063, 11))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end	
	end
	return true
end
ebbTP:type("stepin")
ebbTP:aid(59131)
ebbTP:register()