local infernoTP = MoveEvent()

function infernoTP.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	if item.actionid == 59134 then
		if player:getStorageValue(14560) > os.time() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have to wait a while to challenge this boss again!")
				player:teleportTo(fromPosition)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		else
				player:teleportTo(Position(34068, 30995, 11))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end	
	end
	return true
end
infernoTP:type("stepin")
infernoTP:aid(59134)
infernoTP:register()