local transform = {
	[9825] = 9826,
	[9826] = 9825
}

local leverInfo = {
	-- A partir daqui, os bosses são por dia
	-- A alavanca não funciona com os dias certos ainda pq alguns dias estão faltando
	--PRONTO!!
	[1] = {bossName = "Goshnars Cruelty", bossPosition = Position(33860, 31873, 7), leverPosition = Position(33858, 31861, 6),  -- Furious Crater
	pushPosition = Position(33859, 31861, 6), leverFromPos = Position(33859, 31861, 6), leverToPos = Position(33863, 31861, 6),
	storageTimer = 14556, roomFromPosition = Position(33844, 31856, 7),
	roomToPosition = Position(33867, 31875, 7), teleportTo = Position(33863, 31879, 7), typePush = "x", exitPosition = Position(33627, 31420, 10)},
	
	--PRONTO!!
	[2] = {bossName = "Goshnars Spite", bossPosition = Position(34062, 31062, 11), leverPosition = Position(34092, 31063, 11),  -- Ebb and Flow
	pushPosition = Position(34093, 31063, 11), leverFromPos = Position(34093, 31063, 11), leverToPos = Position(34097, 31063, 11),
	storageTimer = 14557, roomFromPosition = Position(33734, 31624, 14),
	roomToPosition = Position(33758, 31643, 14), teleportTo = Position(34062, 31066, 11), typePush = "x", exitPosition = Position(33627, 31420, 10)},
	
	--PRONTO!!
	[3] = {bossName = "Goshnars Greed", bossPosition = Position(34060, 31093, 11), leverPosition = Position(34089, 31091, 11), -- Mirrored Nightmare
	pushPosition = Position(34090, 31091, 11), leverFromPos = Position(34090, 31091, 11), leverToPos = Position(34094, 31091, 11),
	storageTimer = 14558, roomFromPosition = Position(33735, 31657, 14),
	roomToPosition = Position(33758, 31676, 14), teleportTo = Position(34062, 31097, 11), typePush = "x", exitPosition = Position(33627, 31420, 10)},
	
	--PRONTO!!
	[4] = {bossName = "Goshnars Hatred", bossPosition = Position(34125, 30995, 11), leverPosition = Position(34146, 30996, 11), -- Rotten Wasteland
	pushPosition = Position(34147, 30996, 11), leverFromPos = Position(34147, 30996, 11), leverToPos = Position(34151, 30996, 11),
	storageTimer = 14559, roomFromPosition = Position(33732, 31591, 14),
	roomToPosition = Position(33755, 31609, 14), teleportTo = Position(34127, 30998, 11), typePush = "x", exitPosition = Position(33621, 31429, 10)},
	
	--PRONTO !!!
	[5] = {bossName = "Goshnars Malice", bossPosition = Position(34093, 30994, 11), leverPosition = Position(34061, 30995, 11), -- Claustrophobic Inferno
	pushPosition = Position(34062, 30995, 11), leverFromPos = Position(34062, 30995, 11), leverToPos = Position(34066, 30995, 11),
	storageTimer = 14560, roomFromPosition = Position(33696, 31588, 14),
	roomToPosition = Position(33721, 31610, 14), teleportTo = Position(34094, 31001, 11), typePush = "x", exitPosition = Position(33627, 31420, 10)},
	
	[6] = {bossName = "Goshnar's Megalomania", bossPosition = Position(34093, 31030, 11), leverPosition = Position(34058, 31030, 11), -- Boss Final
	pushPosition = Position(34059, 31030, 11), leverFromPos = Position(34059, 31030, 11), leverToPos = Position(34063, 31030, 11),
	storageTimer = 14561, roomFromPosition = Position(33696, 31624, 14),
	roomToPosition = Position(33724, 31645, 14), teleportTo = Position(34094, 31036, 11), typePush = "x", exitPosition = Position(33621, 31429, 10)},
	
}

local leverBoss = Action()

function leverBoss.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then
		return true
	end
	local playersTable = {}
	local iPos = item:getPosition()
	local pPos = player:getPosition()
	if item.itemid == 9825 then
			for i = 1, #leverInfo do
				if iPos == leverInfo[i].leverPosition then
					local leverTable = leverInfo[i]
					if pPos == leverTable.pushPosition then	
							if leverTable.typePush == "x" then
								for i = leverTable.leverFromPos.x, leverTable.leverToPos.x do
									local newPos = Position(i, leverTable.leverFromPos.y, leverTable.leverFromPos.z)
									local creature = Tile(newPos):getTopCreature()
									if creature and creature:isPlayer() then
										creature:teleportTo(leverTable.teleportTo, true)
										creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
										creature:setStorageValue(leverTable.storageTimer, os.time() + 20*60*60)
										table.insert(playersTable, creature:getId())
										if leverTable.bossName == "Goshnar's Megalomania" then
											player:addCondition(CONDITION_GOSHNAR1)
											player:addCondition(CONDITION_GOSHNAR2)
											player:addCondition(CONDITION_GOSHNAR3)
											player:addCondition(CONDITION_GOSHNAR4)
											player:addCondition(CONDITION_GOSHNAR5)	
										end
									end
								end
							elseif leverTable.typePush == "y" then
								for i = leverTable.leverFromPos.y, leverTable.leverToPos.y do
									local newPos = Position(leverTable.leverFromPos.x, i, leverTable.leverFromPos.z)
									local creature = Tile(newPos):getTopCreature()
									if creature and creature:isPlayer() then
										creature:teleportTo(leverTable.teleportTo, true)
										creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
										creature:setStorageValue(leverTable.storageTimer, os.time() + 20*60*60)	
										table.insert(playersTable, creature:getId())
										if leverTable.bossName == "Goshnar's Megalomania" then
											player:addCondition(CONDITION_GOSHNAR1)
											player:addCondition(CONDITION_GOSHNAR2)
											player:addCondition(CONDITION_GOSHNAR3)
											player:addCondition(CONDITION_GOSHNAR4)
											player:addCondition(CONDITION_GOSHNAR5)	
										end
									end
								end					
							end
							local monster = Game.createMonster(leverTable.bossName, leverTable.bossPosition, true, true)
							addEvent(kickPlayersAfterTime, 30*60*1000, playersTable, leverTable.roomFromPosition, leverTable.roomToPosition, leverTable.exitPosition)
							end
					end
				end
			end
	item:transform(transform[item.itemid])	
	return true
end

leverBoss:aid(38448)
leverBoss:register()