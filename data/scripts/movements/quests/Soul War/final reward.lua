local rewardTP = MoveEvent()

function rewardTP.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	if player:getLevel() < 400 then 
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your level is less than 400.")
	player:teleportTo(fromPosition)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return false
	end
	
	if item.actionid == 59136 then
		if player:getStorageValue(14556) < 1 or player:getStorageValue(14557) < 1 or player:getStorageValue(14558) < 1 or player:getStorageValue(14559) < 1 or player:getStorageValue(14560) < 1 or player:getStorageValue(14561) < 1 then
			
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You did not kill all the bosses.")
			player:teleportTo(fromPosition)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			else
				player:teleportTo(Position(33627, 31406, 10))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end	
	end
	return true
end
rewardTP:type("stepin")
rewardTP:aid(59136)
rewardTP:register()