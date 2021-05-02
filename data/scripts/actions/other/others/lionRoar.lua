local lionPortalEntrance = Action()

local destinations = {
    [1] = Position(33122, 32251, 10),
    [2] = Position(33137, 32354, 5),
    [3] = Position(33089, 32283, 12),
    [4] = Position(33092, 32316, 11)
}


function lionPortalEntrance.onUse(player, item, position, fromPosition)

    if item:getPosition() == Position(33137,32352, 5) then
        player:teleportTo(destinations[1])
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        teleport:sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end

    if item:getPosition() == Position(33116,32252, 10) then
        player:teleportTo(destinations[2])
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        teleport:sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end

    if item:getPosition() == Position(33092, 32314, 11) then
        player:teleportTo(destinations[3])
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        teleport:sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end

    if item:getPosition() == Position(33090, 32279, 12) then
        player:teleportTo(destinations[4])
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        teleport:sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end
    return true
end

lionPortalEntrance:aid(65535)
lionPortalEntrance:register()