local netherWorld = MoveEvent()

local destinations = {
    [1] = Position( 32883, 32518, 7),    -- entrada por port hope
    [2] = Position( 32884, 32518, 7),    -- entrada por port hope
    [3] = Position( 33615, 31415, 8),    -- entrada cave
    [4] = Position( 33544, 31444, 8),    -- passagem part 1 -> part 2
    [5] = Position( 33533, 31444, 8),    -- destino passagem part 1 -> part 2
    [6] = Position( 33535, 31444, 8),    -- passagem part 2 -> part 1
    [7] = Position( 33546, 31444, 8),    -- destino passagem part 2 -> part 1
    [8] = Position( 33484, 31435, 8),    -- passagem part 2 -> part 3
    [9] = Position( 33485, 31452, 9),    -- destino passagem part 2 -> part 3
    [10] = Position( 33481, 31452, 9),    -- passagem part 3 -> part 2
    [11] = Position( 33486, 31435, 8),    -- destino passagem part 3 -> part 2
}


function netherWorld.onStepIn(creature, item, position, fromPosition)

    local player = creature:getPlayer();
    local itemPosition = item:getPosition()

    if not player then
        return true
    end

    if itemPosition == destinations[1] or itemPosition == destinations[2] then
        player:teleportTo(destinations[3])
        itemPosition:sendMagicEffect(CONST_ME_TELEPORT)
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end

    if itemPosition == destinations[4] then
        player:teleportTo(destinations[5])
        itemPosition:sendMagicEffect(CONST_ME_TELEPORT)
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end
    if itemPosition == destinations[6] then
        player:teleportTo(destinations[7])
        itemPosition:sendMagicEffect(CONST_ME_TELEPORT)
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end

    if itemPosition == destinations[8] then
        player:teleportTo(destinations[9])
        itemPosition:sendMagicEffect(CONST_ME_TELEPORT)
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end
    if itemPosition == destinations[10] then
        player:teleportTo(destinations[11])
        itemPosition:sendMagicEffect(CONST_ME_TELEPORT)
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end

    return true
end

netherWorld:aid(14519)
netherWorld:register()