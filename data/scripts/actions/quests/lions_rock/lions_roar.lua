local lionRoarPortal = GlobalEvent("serverstartup")

function lionRoarPortal.onStartup()
	local portal = Game.createItem(27721, 1, {x = 33137, y = 32353, z = 5})
	portal. = 130001
	return true
end

lionRoarPortal:register()


local lionPortalEntrance = MoveEvent()

function lionPortalEntrance.onStepIn(creature, item, position, fromPosition)

	creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, item.id)
	creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, item.uid)
	creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, item.aid)
	creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, item.cid)

	return true
end

lionPortalEntrance:id(27721)
lionPortalEntrance:register()
