local config = {
    centerRoom = Position(32207, 32048, 14),
    bossPosition = Position(32207, 32048, 14),
    newPosition = Position(32223, 32048, 14),
	clearRoomTime = 5, -- In Minuts
	range = 10,
	exitPosition = {x = 33617, y = 32569, z = 13}
}

local bosses = {
    "Plagueroot", 
    "Malofur Mangrinder",
    "Maxxenius",
    "Alptramun",
    "Izcandar The Banished"
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
        if player:getPosition() ~= Position(32208, 32021, 13) then
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

        for y = 32021, 32025 do
            local playerTile = Tile(Position(32208, y, 13)):getTopCreature()
            if playerTile and playerTile:isPlayer() then
                if playerTile:getStorageValue(GlobalStorage.BossesDreamCourtsTimer) < os.time() then
                    playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
                    playerTile:teleportTo(config.newPosition)
                    playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
                    playerTile:setStorageValue(GlobalStorage.BossesDreamCourtsTimer, os.time() + 20 * 3600)
                else
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to wait a while, recently someone challenge Boss.")
                    return true
                end
            end
        end    
    	local randomBoss = bosses[math.random(#bosses)]
        local monster = Game.createMonster(randomBoss, config.bossPosition, true, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Monster created: " .. randomBoss)
		addEvent(clearRoom, config.clearRoomTime * 60 * 1000, config.centerRoom, config.range, config.range, config.exitPosition)
        
        --addEvent(clearBosses, 30 * 60 * 1000)
        item:transform(9825)
    elseif item.itemid == 9825 then
        item:transform(9826)
    end
    return true
end

leverBoss:aid(65500)
leverBoss:register()