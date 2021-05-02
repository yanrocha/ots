local BossConfigs = {
    bossEvent = MoveEvent(),
    bossName = "Sharpclaw",
    bossTime = 600, -- time need to be set in seconds,
    bossAID = 65529,
    bossStorageTimer = Storage.WereAlphas.SharpclawTimer,
    bossRoomRange = 15,
    accessDoor = Position(33128, 31971, 9),
    exit = Position(33120, 31996, 9),
    bossPosition = Position(33119, 32005, 9),
    centerRoom = Position(33120, 32001, 9),
    playerEntranceDestination = Position(33120, 31998, 9),
    playerExitDestination = Position(33128, 31973, 9),
}

local function clearRoom()
    local spectators = Game.getSpectators(BossConfigs.centerRoom, false, false, BossConfigs.bossRoomRange, BossConfigs.bossRoomRange, BossConfigs.bossRoomRange, BossConfigs.bossRoomRange)
    for i = 1, #spectators do
        local spectator = spectators[i]
        if spectator:isPlayer() then
            spectator:teleportTo(BossConfigs.playerExitDestination)
            spectator:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            spectator:say('Time out! You were teleported out by strange forces.', TALKTYPE_MONSTER_SAY)
        elseif spectator:isMonster() then
            spectator:remove()
        end
    end
end

function BossConfigs.bossEvent.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()

    if not player then
        return true
    end

    if position == BossConfigs.accessDoor then
        local specs, spec = Game.getSpectators(BossConfigs.centerRoom, false, false, 15, 15, 15, 15)
        for i = 1, #specs do
            spec = specs[i]
            if spec:isPlayer() then
                player:teleportTo(BossConfigs.playerExitDestination)
                player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone is fighting with ".. BossConfigs.bossName ..".")
                return true
            end
        end

        if player:getStorageValue(BossConfigs.bossStorageTimer) < os.time() then
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            player:teleportTo(BossConfigs.playerEntranceDestination)
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:setStorageValue(BossConfigs.bossStorageTimer, os.time() + BossConfigs.bossTime)
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to wait ten minutes, to chalenge ".. BossConfigs.bossName .." again.")
            player:teleportTo(BossConfigs.playerExitDestination)
            return true
        end

        Game.createMonster(BossConfigs.bossName, BossConfigs.bossPosition, true, true)
        addEvent(clearRoom, 30 * 60 * 1000)

        return true

    elseif position == BossConfigs.exit then
        local spectators = Game.getSpectators(BossConfigs.centerRoom, false, false, 15, 15, 15, 15)
        for i = 1, #spectators do
            local spectator = spectators[i]
            if spectator:isPlayer() then
                spectator:teleportTo(BossConfigs.playerExitDestination)
                spectator:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            elseif spectator:isMonster() then
                spectator:remove()
            end
        end
        return true
    end
end

BossConfigs.bossEvent:aid(BossConfigs.bossAID)
BossConfigs.bossEvent:register()