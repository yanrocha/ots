local portalTP = Action()
function portalTP.onUse(player, item, fromPosition, target, toPosition, isHotkey)
		if player:getStorageValue(14559) > os.time() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have to wait a while to challenge this boss again!")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
		else
				player:teleportTo(Position(34154, 30996, 11))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end		
	return true
end
portalTP:id(38820) -- id portal
portalTP:register()