local staminaFull = 42 -- horas (stamina full)

local staminiarefil = Action()

function staminiarefil.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStamina() >= (staminaFull * 60) then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Ops, sua stamania ja esta cheia.")
	else
		player:setStamina(staminaFull * 60)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Pronto! Sua Staminia esta cheia.")
		fromPosition:sendMagicEffect(CONST_ME_GIFT_WRAPS)
		item:remove()
	end
	return true
end
staminiarefil:id(30183)
staminiarefil:register()