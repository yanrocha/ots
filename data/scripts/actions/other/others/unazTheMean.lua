local positions = {
    ['entrance'] = Position(33566, 31475, 8),
    ['exit'] = Position(33562, 31492, 8),
    ['bossPosition'] = Position(33578, 31492, 8),
    ['centerRoom'] = Position(33571, 31492, 8),
    ['playerEntranceDestination'] = Position( 33562, 31494, 8),
    ['playerExitDestination'] = Position( 33564, 31475, 8)
}

local config = {
    centerRoom = positions['centerRoom'],
    bossPosition = positions['bossPosition'],
    newPosition = positions['playerEntranceDestination']
}

local function clearUnazTheMean()
    local spectators = Game.getSpectators(config.centerRoom, false, false, 15, 15, 15, 15)
    for i = 1, #spectators do
        local spectator = spectators[i]
        if spectator:isPlayer() then
            spectator:teleportTo(positions['playerExitDestination'])
            spectator:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            spectator:say('Time out! You were teleported out by strange forces.', TALKTYPE_MONSTER_SAY)
        elseif spectator:isMonster() then
            spectator:remove()
        end
    end
end

local GraveDangerLevel4 = MoveEvent()
function GraveDangerLevel4.onSetIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()

    if not player then
        return true
    end

    local specs, spec = Game.getSpectators(config.centerRoom, false, false, 15, 15, 15, 15)
    for i = 1, #specs do
        spec = specs[i]
        if spec:isPlayer() then
            player:teleportTo(positions['playerExitDestination'])
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone is fighting with Unaz the Mean.")
            return true
        end
    end

    if playerTile:getStorageValue(Storage.FeasterOfSouls.UnazTheMean) < os.time() then
        playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
        playerTile:teleportTo(config.newPosition)
        playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        playerTile:setStorageValue(Storage.FeasterOfSouls.UnazTheMean, os.time() + 10)
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to wait a while, recently someone challenge Unaz the Mean.")
        return true
    end

    Game.createMonster("Unaz the Mean", config.bossPosition, true, true)
    addEvent(clearUnazTheMean, 30 * 60 * 1000)

    return true
end

GraveDangerLevel4:aid(65534)
GraveDangerLevel4:register()