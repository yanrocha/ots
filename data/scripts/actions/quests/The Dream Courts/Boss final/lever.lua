local config = {
    centerRoom = Position(32208, 32045, 15),
    bossPosition = Position(32208, 32045, 15),
    newPosition = Position(32208, 32052, 15),
	clearRoomTime = 5, -- In Minuts
	range = 10,
	exitPosition = {x = 33617, y = 32569, z = 13}
}

local bosses = {
    "The Nightmare Beast"
}

local function clearBosses()
    local spectators = Game.getSpectators(config.centerRoom, false, false, 15, 15, 15, 15)
    for i = 1, #spectators do
        local spectator = spectators
        if spectator:isPlayer() then    
            spectator:teleportTo(Position(32223, 32048, 14))
            spectator:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            spectator:say('Time out! You were teleported out by strange forces.', TALKTYPE_MONSTER_SAY)
        elseif spectator:isMonster() then
            spectator:remove()
        end
    end
end

local leverBoss = Action()
function leverBoss.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item.itemid == 9825 then
        if player:getPosition() ~= Position(32212, 32070, 15) then
		   player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Step on the tile in front of the lever to activate it.")
            return true
        end
    end
    if item.itemid == 9825 then
        local specs, spec = Game.getSpectators(config.centerRoom, false, false, 15, 15, 15, 15)
        for i = 1, #specs do
            spec = specs[i] 
            if spec:isPlayer() then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone is fighting white the Boss in the room.")
                return true
            end
        end

        for x = 32210, 32214 do
            local playerTile = Tile(Position(x, 32070, 15)):getTopCreature()
            if playerTile and playerTile:isPlayer() then
                if playerTile:getStorageValue(GlobalStorage.BossFinalDreamCourts) < os.time() then
                    playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
                    playerTile:teleportTo(config.newPosition)
                    playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
                    playerTile:setStorageValue(GlobalStorage.BossFinalDreamCourts, os.time() + 20 * 3600)
                else
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to wait a while, recently someone challenge The Nightmare Beast.")
                    return true
                end
            end
        end    
        local monster = Game.createMonster("The Nightmare Beast", config.bossPosition, true, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Monster created: The Nightmare Beast")
		addEvent(clearRoom, config.clearRoomTime * 60 * 1000, config.centerRoom, config.range, config.range, config.exitPosition)

        item:transform(9825)
    elseif item.itemid == 9825 then
        item:transform(9826)
    end
    return true
end

leverBoss:aid(7000)
leverBoss:register()