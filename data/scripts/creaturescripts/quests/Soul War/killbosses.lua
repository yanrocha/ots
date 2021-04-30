local bossesKill = CreatureEvent("bossesKill")
function bossesKill.onKill(player, creature)
	if not player:isPlayer() then
		return true
	end
	if not creature:isMonster() or creature:getMaster() then
		return true
	end
	
	local bosses = {
		["goshnars cruelty"] = {status = 1, storage = 14556},
		["goshnars spite"] = {status = 1, storage = 14557},
		["goshnars greed"] = {status = 1, storage = 14558},
		["goshnars hatred"] = {status = 1, storage = 14559},
		["goshnars malice"] = {status = 1, storage = 14560},
		["goshnar's megalomania"] = {status = 1, storage = 14561},
	}

	local monsterName = creature:getName():lower()
	local bossConfig = bosses[monsterName]
	if not bossConfig then
		return true
	end

	for playerid, damage in pairs(creature:getDamageMap()) do
		local p = Player(playerid)
		if p then
			if p:getStorageValue(bossConfig.storage) < 1 then
				p:setStorageValue(bossConfig.storage, bossConfig.status)
			end
		end
	end
	
	return true
end
bossesKill:register()