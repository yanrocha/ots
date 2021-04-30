local morreredTP = MoveEvent()
function morreredTP.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	if item.actionid == 59132 then
		if player:getStorageValue(14558) > os.time() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have to wait a while to challenge this boss again!")
				player:teleportTo(fromPosition)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		else
				player:teleportTo(Position(34096, 31091, 11))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end	
	end
	return true
end
morreredTP:type("stepin")
morreredTP:aid(59132)
morreredTP:register()