local function onMovementRemoveProtection(cid, oldPos, time)
	local player = Player(cid)
	if not player then
		return true
	end

	local playerPos = player:getPosition()
	if (playerPos.x ~= oldPos.x or playerPos.y ~= oldPos.y or playerPos.z ~= oldPos.z) or player:getTarget() then
		player:setStorageValue(Storage.combatProtectionStorage, 0)
		return true
	end

	addEvent(onMovementRemoveProtection, 1000, cid, oldPos, time - 1)
end

local function protectionZoneCheck(playerName)
    doRemoveCreature(playerName)
    return true
end

local playerLogin = CreatureEvent("PlayerLogin")

function playerLogin.onLogin(player)
	local items = {
		{2160, 5}
	}
	if player:getLastLoginSaved() == 0 then
		player:sendOutfitWindow()
		local backpack = player:addItem(1988)
		if backpack then
			for i = 1, #items do
				backpack:addItem(items[i][1], items[i][2])
			end
		end
		player:addItem(2050, 1, true, 1, CONST_SLOT_AMMO)
	else
		player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "Seja Bem Vindo ao OT Server  " .. SERVER_NAME .. "!")
		player:sendTextMessage(MESSAGE_STATUS_DEFAULT, string.format("Sua ultima visita no Ot Server ".. SERVER_NAME ..": %s.", os.date("%d. %b %Y %X", player:getLastLoginSaved())))
	end

	local playerId = player:getId()

	-- kick other players from account
	if configManager.getBoolean(configKeys.ONE_PLAYER_ON_ACCOUNT) then
		local resultId = db.storeQuery("SELECT players.name FROM `players` INNER JOIN `players_online` WHERE players_online.player_id=players.id and players_online.player_id!=" .. player:getGuid() .. " and players.account_id=" .. player:getAccountId())
		if resultId ~= false then
			repeat
				if player:getAccountType() <= ACCOUNT_TYPE_GOD and player:getGroup():getId() < GROUP_TYPE_GOD then
					local name = result.getDataString(resultId, "name")
					if getCreatureCondition(Player(name), CONDITION_INFIGHT) == false then
						Player(name):remove()
					else
						addEvent(protectionZoneCheck, 2000, player:getName())
						doPlayerPopupFYI(player, "You cant login now.")
					end
				end
			until not result.next(resultId)
				result.free(resultId)
		end
	end
	-- End kick other players from account
	if isPremium(player) then
		player:setStorageValue(Storage.PremiumAccount, 1)
	end
	-- Premium Ends Teleport to Temple, change addon (citizen) houseless
	local defaultTown = "Thais" -- default town where player is teleported if his home town is in premium area
	local freeTowns = {"Ab'Dendriel", "Carlin", "Kazordoon", "Thais", "Venore", "Rookgaard", "Dawnport", "Dawnport Tutorial", "Island of Destiny"} -- towns in free account area

	if isPremium(player) == false and isInArray(freeTowns, player:getTown():getName()) == false then
		local town = player:getTown()
		local sex = player:getSex()
		local home = getHouseByPlayerGUID(getPlayerGUID(player))
		town = isInArray(freeTowns, town:getName()) and town or Town(defaultTown)
		player:teleportTo(town:getTemplePosition())
		player:setTown(town)
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "Your premium time has expired.")
		player:setStorageValue(Storage.PremiumAccount, 0)
		if sex == 1 then
			player:setOutfit({lookType = 128, lookFeet = 114, lookLegs = 134, lookHead = 114,lookAddons = 0})
        elseif sex == 0 then
			player:setOutfit({lookType = 136, lookFeet = 114, lookLegs = 134, lookHead = 114, lookAddons = 0})
        end
        if home ~= nil and not isPremium(player) then
            setHouseOwner(home, 0)
            player:sendTextMessage(MESSAGE_STATUS_WARNING, 'You\'ve lost your house because you are not premium anymore.')
			player:sendTextMessage(MESSAGE_STATUS_WARNING, 'Your items from house are send to your inbox.')
        end
	end
	-- End 'Premium Ends Teleport to Temple'

	-- Recruiter system
	local resultId = db.storeQuery('SELECT `recruiter` from `accounts` where `id`='..getAccountNumberByPlayerName(getPlayerName(player)))
	local recruiterStatus = result.getNumber(resultId, 'recruiter')
	local sex = player:getSex()
	if recruiterStatus >= 1 then
		if sex == 1 then
			local outfit = player:hasOutfit(746)
			if outfit == false then
				player:addOutfit(746)
			end
		else
			local outfit = player:hasOutfit(745)
			if outfit == false then
				player:addOutfit(745)
			end
		end
	end
	if recruiterStatus >= 3 then
		if sex == 1 then
			local outfit = player:hasOutfit(746,1)
			if outfit == false then
				player:addOutfitAddon(746,1)
			end
		else
			local outfit = player:hasOutfit(745,1)
			if outfit == false then
				player:addOutfit(745,1)
			end
		end
	end
	if recruiterStatus >= 10 then
		if sex == 1 then
			local outfit = player:hasOutfit(746,2)
			if outfit == false then
				player:addOutfitAddon(746,2)
			end
		else
			local outfit = player:hasOutfit(745,2)
			if outfit == false then
				player:addOutfit(745,2)
			end
		end
	end
	-- End recruiter system

	DailyReward.init(playerId)

	player:loadSpecialStorage()

	if player:getGroup():getId() >= GROUP_TYPE_GAMEMASTER then
		player:setGhostMode(true)
	end
	-- Boosted creature
	player:sendTextMessage(MESSAGE_LOOT, "Today's boosted creature: " .. Game.getBoostedCreature() .. " \
	Boosted creatures yield more experience points, carry more loot than usual and respawn at a faster rate.")

	-- Stamina
	nextUseStaminaTime[playerId] = 1

	-- EXP Stamina
	nextUseXpStamina[playerId] = 1

	-- Prey Small Window
	for slot = CONST_PREY_SLOT_FIRST, CONST_PREY_SLOT_THIRD do
		player:sendPreyData(slot)
	end

	-- New prey
	nextPreyTime[playerId] = {
		[CONST_PREY_SLOT_FIRST] = 1,
		[CONST_PREY_SLOT_SECOND] = 1,
		[CONST_PREY_SLOT_THIRD] = 1
	}

	if (player:getAccountType() == ACCOUNT_TYPE_TUTOR) then
	local msg = [[:: Tutor Rules
		1 *> 3 Warnings you lose the job.
		2 *> Without parallel conversations with players in Help, if the player starts offending, you simply mute it.
		3 *> Be educated with the players in Help and especially in the Private, try to help as much as possible.
		4 *> Always be on time, if you do not have a justification you will be removed from the staff.
		5 *> Help is only allowed to ask questions related to tibia.
		6 *> It is not allowed to divulge time up or to help in quest.
		7 *> You are not allowed to sell items in the Help.
		8 *> If the player encounters a bug, ask to go to the website to send a ticket and explain in detail.
		9 *> Always keep the Tutors Chat open. (required).
		10 *> You have finished your schedule, you have no tutor online, you communicate with some CM in-game
		or ts and stay in the help until someone logs in, if you can.
		11 *> Always keep a good Portuguese in the Help, we want tutors who support, not that they speak a satanic ritual.
		12 *> If you see a tutor doing something that violates the rules, take a print and send it to your superiors. "
		- Commands -
		Mute Player: /mute nick, 90 (90 seconds)
		Unmute Player: /unmute nick.
		- Commands -]]
		player:popupFYI(msg)
	end
	
	-- [Quests]
	if player:getStorageValue(990000) < 1 then  
		-- Bigfoot's Burden
		player:setStorageValue(Storage.BigfootBurden.QuestLine, 2)
		player:setStorageValue(Storage.BigfootBurden.QuestLine, 4)
		player:setStorageValue(Storage.BigfootBurden.QuestLine, 7)
		player:setStorageValue(Storage.BigfootBurden.QuestLine, 9)
		player:setStorageValue(Storage.BigfootBurden.QuestLine, 12)
		player:setStorageValue(Storage.BigfootBurden.Shooting, 5)
		player:setStorageValue(Storage.BigfootBurden.QuestLine, 16)
		player:setStorageValue(Storage.BigfootBurden.QuestLine, 20)
		player:setStorageValue(Storage.BigfootBurden.QuestLine, 23)
		player:setStorageValue(Storage.BigfootBurden.QuestLineComplete, 2)
		player:setStorageValue(Storage.BigfootBurden.Rank, 999999)
		player:setStorageValue(Storage.BigfootBurden.Warzone1Access, 2)
		player:setStorageValue(Storage.BigfootBurden.Warzone2Access, 2)
		player:setStorageValue(Storage.BigfootBurden.Warzone3Access, 2)

		-- WZ 4, 5 e 6
		player:setStorageValue(Storage.DangerousDepths.Questline, 10)
		player:setStorageValue(Storage.DangerousDepths.Access.LavaPumpWarzoneVI, 10)
		player:setStorageValue(Storage.DangerousDepths.Access.LavaPumpWarzoneV, 10)
		player:setStorageValue(Storage.DangerousDepths.Access.LavaPumpWarzoneIV, 30)
		player:setStorageValue(Storage.DangerousDepths.Dwarves.Status, 10)
		player:setStorageValue(Storage.DangerousDepths.Scouts.Status, 10)
		player:setStorageValue(Storage.DangerousDepths.Gnomes.Status, 10)	

		--In Service of Yalahar 
		player:setStorageValue(Storage.InServiceofYalahar.Questline, 51)
		player:setStorageValue(Storage.InServiceofYalahar.Mission01, 6)
		player:setStorageValue(Storage.InServiceofYalahar.Mission02, 8)
 		player:setStorageValue(Storage.InServiceofYalahar.Mission03, 6)
		player:setStorageValue(Storage.InServiceofYalahar.Mission04, 6)
		player:setStorageValue(Storage.InServiceofYalahar.Mission05, 8)
		player:setStorageValue(Storage.InServiceofYalahar.Mission06, 5)
		player:setStorageValue(Storage.InServiceofYalahar.Mission07, 5)
		player:setStorageValue(Storage.InServiceofYalahar.Mission08, 4)
		player:setStorageValue(Storage.InServiceofYalahar.Mission09, 2)
		player:setStorageValue(Storage.InServiceofYalahar.Mission10, 1)
		-- part 2
		player:setStorageValue(Storage.InServiceofYalahar.SewerPipe01, 1)
		player:setStorageValue(Storage.InServiceofYalahar.SewerPipe02, 1)
		player:setStorageValue(Storage.InServiceofYalahar.SewerPipe03, 1)
		player:setStorageValue(Storage.InServiceofYalahar.SewerPipe04, 1)
		player:setStorageValue(Storage.InServiceofYalahar.DiseasedDan, 1)
		player:setStorageValue(Storage.InServiceofYalahar.DiseasedBill, 1)
		player:setStorageValue(Storage.InServiceofYalahar.DiseasedFred, 1)
		player:setStorageValue(Storage.InServiceofYalahar.AlchemistFormula, 1)
		player:setStorageValue(Storage.InServiceofYalahar.BadSide, 1)
		player:setStorageValue(Storage.InServiceofYalahar.GoodSide , 1)
		player:setStorageValue(Storage.InServiceofYalahar.MrWestDoor, 1)
		player:setStorageValue(Storage.InServiceofYalahar.MrWestStatus, 1)
		player:setStorageValue(Storage.InServiceofYalahar.TamerinStatus, 1)
		player:setStorageValue(Storage.InServiceofYalahar.MorikSummon, 1)
		player:setStorageValue(Storage.InServiceofYalahar.QuaraState, 1)
		player:setStorageValue(Storage.InServiceofYalahar.QuaraSplasher, 1)
		player:setStorageValue(Storage.InServiceofYalahar.QuaraSharptooth, 1)
		player:setStorageValue(Storage.InServiceofYalahar.QuaraInky, 1)
		player:setStorageValue(Storage.InServiceofYalahar.MatrixState, 1)
		player:setStorageValue(Storage.InServiceofYalahar.NotesPalimuth, 1)
		player:setStorageValue(Storage.InServiceofYalahar.NotesAzerus, 1)
		player:setStorageValue(Storage.InServiceofYalahar.DoorToAzerus, 1)
		player:setStorageValue(Storage.InServiceofYalahar.DoorToBog, 1)
		player:setStorageValue(Storage.InServiceofYalahar.DoorToLastFight, 1)
		player:setStorageValue(Storage.InServiceofYalahar.DoorToMatrix, 1)
		player:setStorageValue(Storage.InServiceofYalahar.DoorToQuara, 1)
		player:setStorageValue(Storage.InServiceofYalahar.SewerPipe01, 1)
		player:setStorageValue(Storage.InServiceofYalahar.SewerPipe02, 1)
		player:setStorageValue(Storage.InServiceofYalahar.SewerPipe03, 1)
		player:setStorageValue(Storage.InServiceofYalahar.SewerPipe04, 1)
		player:setStorageValue(Storage.InServiceofYalahar.DiseasedDan, 1)
		player:setStorageValue(Storage.InServiceofYalahar.DiseasedBill, 1)
		player:setStorageValue(Storage.InServiceofYalahar.DiseasedFred, 1)
		player:setStorageValue(Storage.InServiceofYalahar.AlchemistFormula, 1)
		player:setStorageValue(Storage.InServiceofYalahar.BadSide, 1)
		player:setStorageValue(Storage.InServiceofYalahar.GoodSide, 1)
		player:setStorageValue(Storage.InServiceofYalahar.MrWestDoor, 1)
		player:setStorageValue(Storage.InServiceofYalahar.MrWestStatus, 1)
		player:setStorageValue(Storage.InServiceofYalahar.TamerinStatus, 1)
		player:setStorageValue(Storage.InServiceofYalahar.MorikSummon, 1)
		player:setStorageValue(Storage.InServiceofYalahar.QuaraState, 1)
		player:setStorageValue(Storage.InServiceofYalahar.QuaraSplasher, 1)
		player:setStorageValue(Storage.InServiceofYalahar.QuaraSharptooth, 1)
		player:setStorageValue(Storage.InServiceofYalahar.QuaraInky, 1)	

		--Cults of Tibia Quest.
		player:setStorageValue(Storage.CultsOfTibia.Questline, 7)
		player:setStorageValue(Storage.CultsOfTibia.Minotaurs.jamesfrancisTask, 1)
		player:setStorageValue(Storage.CultsOfTibia.Minotaurs.Mission, 1)
		player:setStorageValue(Storage.CultsOfTibia.Minotaurs.bossTimer, 1)
		player:setStorageValue(Storage.CultsOfTibia.MotA.Mission, 1)
		player:setStorageValue(Storage.CultsOfTibia.MotA.Pedra1, 1)
		player:setStorageValue(Storage.CultsOfTibia.MotA.Pedra2, 1)
		player:setStorageValue(Storage.CultsOfTibia.MotA.Pedra3, 1)
		player:setStorageValue(Storage.CultsOfTibia.MotA.Respostas, 1)
		player:setStorageValue(Storage.CultsOfTibia.MotA.Perguntaid, 1)
		player:setStorageValue(Storage.CultsOfTibia.Barkless.Mission, 1)
		player:setStorageValue(Storage.CultsOfTibia.Barkless.sulphur, 1)
		player:setStorageValue(Storage.CultsOfTibia.Barkless.tar, 1)
		player:setStorageValue(Storage.CultsOfTibia.Barkless.ice, 1)
		player:setStorageValue(Storage.CultsOfTibia.Barkless.Objects, 1)
		player:setStorageValue(Storage.CultsOfTibia.Barkless.Temp, 1)
		player:setStorageValue(Storage.CultsOfTibia.Barkless.bossTimer, 1)
		player:setStorageValue(Storage.CultsOfTibia.Orcs.Mission, 1)
		player:setStorageValue(Storage.CultsOfTibia.Orcs.lookType, 1)
		player:setStorageValue(Storage.CultsOfTibia.Orcs.bossTimer, 1)
		player:setStorageValue(Storage.CultsOfTibia.Life.Mission, 1)
		player:setStorageValue(Storage.CultsOfTibia.Life.bossTimer, 1)
		player:setStorageValue(Storage.CultsOfTibia.Humans.Mission, 1)
		player:setStorageValue(Storage.CultsOfTibia.Humans.Vaporized, 1)
		player:setStorageValue(Storage.CultsOfTibia.Humans.Decaying, 1)
		player:setStorageValue(Storage.CultsOfTibia.Humans.bossTimer, 1)
		player:setStorageValue(Storage.CultsOfTibia.Misguided.Mission, 1)
		player:setStorageValue(Storage.CultsOfTibia.Misguided.Monsters, 1)
		player:setStorageValue(Storage.CultsOfTibia.Misguided.Exorcisms, 1)
		player:setStorageValue(Storage.CultsOfTibia.Misguided.Time, 1)
		player:setStorageValue(Storage.CultsOfTibia.Misguided.bossTimer, 1)

		-- The Explorer Society
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 1) -- Joining the Explorers
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 4)
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 7)
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 16)
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 26)
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 29)
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 32)
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 35)
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 38)
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 41)
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 43)
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 46)
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 47)
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 50)
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 55)
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 56)
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 58)
		player:setStorageValue(Storage.ExplorerSociety.QuestLine, 61)
		player:setStorageValue(Storage.ExplorerSociety.CalassaQuest, 2)

		-- The Forgotten Knowledge
		player:setStorageValue(Storage.ForgottenKnowledge.Tomes, 1)
		player:setStorageValue(Storage.ForgottenKnowledge.LastLoreKilled, 1)    
		player:setStorageValue(Storage.ForgottenKnowledge.TimeGuardianKilled, 1)
		player:setStorageValue(Storage.ForgottenKnowledge.HorrorKilled, 1)
		player:setStorageValue(Storage.ForgottenKnowledge.DragonkingKilled, 1)
		player:setStorageValue(Storage.ForgottenKnowledge.ThornKnightKilled, 1)
		player:setStorageValue(Storage.ForgottenKnowledge.LloydKilled, 1)
 		player:setStorageValue(Storage.ForgottenKnowledge.LadyTenebrisKilled, 1)
		player:setStorageValue(Storage.ForgottenKnowledge.AccessMachine, 1)

		-- Barbarian Test Quest.
		player:setStorageValue(Storage.BarbarianTest.Questline, 1)
		player:setStorageValue(Storage.BarbarianTest.Mission01, 3)
		player:setStorageValue(Storage.BarbarianTest.Mission02, 3)
		player:setStorageValue(Storage.BarbarianTest.Mission03, 3)
		player:setStorageValue(Storage.BarbarianTest.Mission03, 3)

		-- Children of the Revolution Quest.
		player:setStorageValue(Storage.ChildrenoftheRevolution.Questline, 21)
		player:setStorageValue(Storage.ChildrenoftheRevolution.Mission00, 2)
		player:setStorageValue(Storage.ChildrenoftheRevolution.Mission01, 3)
		player:setStorageValue(Storage.ChildrenoftheRevolution.Mission02, 5)
		player:setStorageValue(Storage.ChildrenoftheRevolution.Mission03, 3)
		player:setStorageValue(Storage.ChildrenoftheRevolution.Mission04, 6)
		player:setStorageValue(Storage.ChildrenoftheRevolution.Mission05, 3)
		player:setStorageValue(Storage.ChildrenoftheRevolution.SpyBuilding01, 1)
		player:setStorageValue(Storage.ChildrenoftheRevolution.SpyBuilding02, 1)
		player:setStorageValue(Storage.ChildrenoftheRevolution.SpyBuilding03, 1)
		player:setStorageValue(Storage.ChildrenoftheRevolution.StrangeSymbols, 1)

		-- Factions
		player:setStorageValue(Storage.DjinnWar.Faction.Greeting, 2)
		player:setStorageValue(Storage.DjinnWar.Faction.Marid, 2)
		player:setStorageValue(Storage.DjinnWar.Faction.Efreet, 2)
		-- Efreet
		player:setStorageValue(Storage.DjinnWar.EfreetFaction.Start, 1)
		player:setStorageValue(Storage.DjinnWar.EfreetFaction.Mission01, 3)
		player:setStorageValue(Storage.DjinnWar.EfreetFaction.Mission02, 3)
		player:setStorageValue(Storage.DjinnWar.EfreetFaction.Mission03, 3)
		-- Marid
		player:setStorageValue(Storage.DjinnWar.MaridFaction.Start, 1)
		player:setStorageValue(Storage.DjinnWar.MaridFaction.Mission01, 2)
		player:setStorageValue(Storage.DjinnWar.MaridFaction.Mission02, 2)
		player:setStorageValue(Storage.DjinnWar.MaridFaction.RataMari, 2)
		player:setStorageValue(Storage.DjinnWar.MaridFaction.Mission03, 3)

		-- The Way to Yalahar
		player:setStorageValue(Storage.TheWayToYalahar.Questline, 1)
		player:setStorageValue(Storage.SearoutesAroundYalahar.TownsCounter, 1)
		player:setStorageValue(Storage.SearoutesAroundYalahar.AbDendriel, 1)
		player:setStorageValue(Storage.SearoutesAroundYalahar.Darashia, 1)
		player:setStorageValue(Storage.SearoutesAroundYalahar.Venore, 1)
		player:setStorageValue(Storage.SearoutesAroundYalahar.Ankrahmun, 1)
		player:setStorageValue(Storage.SearoutesAroundYalahar.PortHope, 1)
		player:setStorageValue(Storage.SearoutesAroundYalahar.Thais, 1)
		player:setStorageValue(Storage.SearoutesAroundYalahar.LibertyBay, 1)
		player:setStorageValue(Storage.SearoutesAroundYalahar.Carlin, 1)

		-- The Hidden City of Beregar
		player:setStorageValue(Storage.HiddenCityOfBeregar.DefaultStart, 1)
		player:setStorageValue(Storage.HiddenCityOfBeregar.GoingDown, 1)

		-- The Ice Islands Quest
		player:setStorageValue(Storage.TheIceIslands.Questline, 12)
		player:setStorageValue(Storage.TheIceIslands.Mission01, 3)
		player:setStorageValue(Storage.TheIceIslands.Mission02, 5)
		player:setStorageValue(Storage.TheIceIslands.Mission03, 3)
		player:setStorageValue(Storage.TheIceIslands.Mission04, 2)
		player:setStorageValue(Storage.TheIceIslands.Mission05, 6)
		player:setStorageValue(Storage.TheIceIslands.Mission06, 8)
		player:setStorageValue(Storage.TheIceIslands.Mission07, 3)
		player:setStorageValue(Storage.TheIceIslands.Mission08, 4)
		player:setStorageValue(Storage.TheIceIslands.Mission09, 2)
		player:setStorageValue(Storage.TheIceIslands.Mission10, 2)
		player:setStorageValue(Storage.TheIceIslands.Mission11, 2)
		player:setStorageValue(Storage.TheIceIslands.Mission12, 6)

		-- The Inquisition
		player:setStorageValue(Storage.TheInquisition.Questline, 25)
		player:setStorageValue(Storage.TheInquisition.Mission01, 7)
		player:setStorageValue(Storage.TheInquisition.Mission02, 3)
		player:setStorageValue(Storage.TheInquisition.Mission03, 6)
		player:setStorageValue(Storage.TheInquisition.Mission04, 3)
		player:setStorageValue(Storage.TheInquisition.Mission05, 3)
		player:setStorageValue(Storage.TheInquisition.Mission06, 3)
		player:setStorageValue(Storage.TheInquisition.Mission07, 1)
		player:setStorageValue(Storage.TheInquisition.GrofGuard, 1)
		player:setStorageValue(Storage.TheInquisition.KulagGuard, 1)
		player:setStorageValue(Storage.TheInquisition.TimGuard, 1)
		player:setStorageValue(Storage.TheInquisition.WalterGuard, 1)
		player:setStorageValue(Storage.TheInquisition.StorkusVampiredust, 1)

		-- The New Frontier
		player:setStorageValue(Storage.TheNewFrontier.Questline, 28)
		player:setStorageValue(Storage.TheNewFrontier.Mission01, 3)
		player:setStorageValue(Storage.TheNewFrontier.Mission02, 6)
		player:setStorageValue(Storage.TheNewFrontier.Mission03, 3)
		player:setStorageValue(Storage.TheNewFrontier.Mission04, 2)
		player:setStorageValue(Storage.TheNewFrontier.Mission05, 7)
		player:setStorageValue(Storage.TheNewFrontier.Mission06, 3)
		player:setStorageValue(Storage.TheNewFrontier.Mission07, 3)
		player:setStorageValue(Storage.TheNewFrontier.Mission08, 2)
		player:setStorageValue(Storage.TheNewFrontier.Mission09, 3)
		player:setStorageValue(Storage.TheNewFrontier.Mission10, 1)
		player:setStorageValue(Storage.TheNewFrontier.TomeofKnowledge, 12)
		player:setStorageValue(Storage.TheNewFrontier.Beaver1, 1)
		player:setStorageValue(Storage.TheNewFrontier.Beaver2, 1)
		player:setStorageValue(Storage.TheNewFrontier.Beaver3, 1)
		player:setStorageValue(Storage.TheNewFrontier.BribeKing, 1)
		player:setStorageValue(Storage.TheNewFrontier.BribeLeeland, 1)
		player:setStorageValue(Storage.TheNewFrontier.BribeExplorerSociety, 1)
		player:setStorageValue(Storage.TheNewFrontier.BribeWydrin, 1)
		player:setStorageValue(Storage.TheNewFrontier.BribeTelas, 1)

		-- The ice islands
		player:setStorageValue(12200, 1) -- Storage through the Quest
		player:setStorageValue(12201, 3) -- Befriending the Musher
		player:setStorageValue(12202, 5) -- Nibelor 1: Breaking the Ice
		player:setStorageValue(12203, 3) -- Nibelor 2: Ecological Terrorism
		player:setStorageValue(12204, 2) -- Nibelor 3: Artful Sabotage
		player:setStorageValue(12205, 6) -- Nibelor 4: Berserk Brewery
		player:setStorageValue(12206, 8) -- Nibelor 5: Cure the Dogs
		player:setStorageValue(12207, 3) -- The Secret of Helheim
		player:setStorageValue(12208, 4) -- The Contact
		player:setStorageValue(12209, 2) -- Formorgar Mines 1: The Mission
		player:setStorageValue(12210, 2) -- Formorgar Mines 2: Ghostwhisperer
		player:setStorageValue(12211, 2) -- Formorgar Mines 3: The Secret
		player:setStorageValue(12212, 1) -- Formorgar Mines 4: Retaliation

		-- The Shattered Isles
		player:setStorageValue(Storage.TheShatteredIsles.DefaultStart, 3)
		player:setStorageValue(Storage.TheShatteredIsles.TheGovernorDaughter, 3)
		player:setStorageValue(Storage.TheShatteredIsles.TheErrand, 2)
		player:setStorageValue(Storage.TheShatteredIsles.AccessToMeriana, 1)
		player:setStorageValue(Storage.TheShatteredIsles.APoemForTheMermaid, 3)
		player:setStorageValue(Storage.TheShatteredIsles.ADjinnInLove, 5)
		player:setStorageValue(Storage.TheShatteredIsles.AccessToLagunaIsland, 1)
		player:setStorageValue(Storage.TheShatteredIsles.AccessToGoroma, 1)
		player:setStorageValue(Storage.TheShatteredIsles.Shipwrecked, 2)
		player:setStorageValue(Storage.TheShatteredIsles.DragahsSpellbook, 1)
		player:setStorageValue(Storage.TheShatteredIsles.TheCounterspell, 4)

		-- The Thieves Guild.
		player:setStorageValue(Storage.ThievesGuild.Quest, 1)
		player:setStorageValue(Storage.ThievesGuild.Mission01, 2)
		player:setStorageValue(Storage.ThievesGuild.Mission02, 3)
		player:setStorageValue(Storage.ThievesGuild.Mission03, 3)
		player:setStorageValue(Storage.ThievesGuild.Mission04, 8)
		player:setStorageValue(Storage.ThievesGuild.Mission05, 2)
		player:setStorageValue(Storage.ThievesGuild.Mission06, 4)
		player:setStorageValue(Storage.ThievesGuild.Mission07, 2)
		player:setStorageValue(Storage.ThievesGuild.Mission08, 1)
		
		-- The Travelling Trader Quest
		player:setStorageValue(Storage.TravellingTrader.Mission01, 1)
		player:setStorageValue(Storage.TravellingTrader.Mission01, 2)
		player:setStorageValue(Storage.TravellingTrader.Mission02, 5)
		player:setStorageValue(Storage.TravellingTrader.Mission03, 3)
		player:setStorageValue(Storage.TravellingTrader.Mission04, 3)
		player:setStorageValue(Storage.TravellingTrader.Mission05, 3)
		player:setStorageValue(Storage.TravellingTrader.Mission06, 2)
		player:setStorageValue(Storage.TravellingTrader.Mission07, 1)

		-- The Ultimate Challenges Quest.
		player:setStorageValue(Storage.SvargrondArena.QuestLogGreenhorn, 1)

		-- Tibia Tales.
		player:setStorageValue(Storage.TibiaTales.DefaultStart, 1)
		player:setStorageValue(Storage.TibiaTales.ToAppeaseTheMightyQuest, 1)

		-- The Postman
		player:setStorageValue(12450, 6) -- Mission 1 - Check Postal Routes
		player:setStorageValue(12451, 3) -- Mission 2 - Fix Mailbox
		player:setStorageValue(12452, 3) -- Mission 3 - Bill Delivery
		player:setStorageValue(12453, 2) -- Mission 4 - Aggressive Dogs
		player:setStorageValue(12454, 4) -- Mission 5 - Present Delivery
		player:setStorageValue(12455, 13) -- Mission 6 - New Uniforms
		player:setStorageValue(12456, 8) -- Mission 7 - Measurements
		player:setStorageValue(12457, 3) -- Mission 8 - Missing Courier
		player:setStorageValue(12458, 4) -- Mission 9 - Dear Santa
		player:setStorageValue(12459, 3) -- Mission 10 - Mintwallin
		player:setStorageValue(12460, 5)  -- Postman Rank

		-- Unnatural Selection
		player:setStorageValue(12330, 1) -- Storage through the Quest
		player:setStorageValue(12331, 3) -- Mission 1: Skulled
		player:setStorageValue(12332, 13) -- Mission 2: All Around the World
		player:setStorageValue(12333, 3) -- Mission 3: Dance Dance Evolution
		player:setStorageValue(12334, 2) -- Mission 4: Bits and Pieces
		player:setStorageValue(12335, 3) -- Mission 5: Ray of Light
		player:setStorageValue(12336, 3) -- Mission 6: Firewater Burn

		-- Friends and Traders
		player:setStorageValue(Storage.FriendsandTraders.DefaultStart, 1)
		player:setStorageValue(Storage.FriendsandTraders.TheSweatyCyclops, 2)
		player:setStorageValue(Storage.FriendsandTraders.TheMermaidMarina, 2)
		player:setStorageValue(Storage.FriendsandTraders.TheBlessedStake, 12)

		-- Killing in the Name of...
		player:setStorageValue(100157, 1)
		player:setStorageValue(2500, 0)		

		-- KilmareshQuest
		player:setStorageValue(22000, 5) -- Town Counter		
		
		-- Wrath of the Emperor
		player:setStorageValue(Storage.WrathoftheEmperor.Questline, 1)
		player:setStorageValue(Storage.WrathoftheEmperor.Mission01, 3)
		player:setStorageValue(Storage.WrathoftheEmperor.Mission02, 3)
		player:setStorageValue(Storage.WrathoftheEmperor.Mission03, 3)
		player:setStorageValue(Storage.WrathoftheEmperor.Mission04, 3)
		player:setStorageValue(Storage.WrathoftheEmperor.Mission05, 3)
		player:setStorageValue(Storage.WrathoftheEmperor.Mission06, 4)
		player:setStorageValue(Storage.WrathoftheEmperor.Mission07, 6)
		player:setStorageValue(Storage.WrathoftheEmperor.Mission08, 2)
		player:setStorageValue(Storage.WrathoftheEmperor.Mission09, 2)
		player:setStorageValue(Storage.WrathoftheEmperor.Mission10, 6)
		player:setStorageValue(Storage.WrathoftheEmperor.Mission11, 1)

		-- The Ape City Quest.
		player:setStorageValue(Storage.TheApeCity.Started, 1)
		player:setStorageValue(Storage.TheApeCity.Questline, 18)

		-- Oramond.
		player:setStorageValue(Storage.Oramond.QuestLine, 1)
		player:setStorageValue(Storage.Oramond.MissionToTakeRoots, 3000)

		-- Dangerous Depths.
		player:setStorageValue(Storage.DangerousDepths.Questline, 1)
		player:setStorageValue(Storage.DangerousDepths.Dwarves.Home, 2)
		player:setStorageValue(Storage.DangerousDepths.Dwarves.Subterranean, 2)
		player:setStorageValue(Storage.DangerousDepths.Gnomes.Measurements, 2)
		player:setStorageValue(Storage.DangerousDepths.Gnomes.Ordnance, 3)
		player:setStorageValue(Storage.DangerousDepths.Gnomes.Charting, 2)
		player:setStorageValue(Storage.DangerousDepths.Scouts.Growth, 2)
		player:setStorageValue(Storage.DangerousDepths.Scouts.Diremaw, 2)

		-- Threatened Dreams
		player:setStorageValue(Storage.ThreatenedDreams.Start, 1)
		player:setStorageValue(Storage.ThreatenedDreams.TroubledMission01, 4)

		-- Adventurers Guild.
		player:setStorageValue(Storage.AdventurersGuild.GreatDragonHunt.WarriorSkeleton, 1)
		player:setStorageValue(Storage.AdventurersGuild.GreatDragonHunt.WarriorSkeleton, 2)

		-- Dawnport
		player:setStorageValue(Storage.Quest.Dawnport.Questline, 1)
		player:setStorageValue(Storage.Quest.Dawnport.GoMain, 1)
		--
		player:setStorageValue(990000, 1)
	end
	-- [End of Quests]

	-- Open channels
	if table.contains({TOWNS_LIST.DAWNPORT, TOWNS_LIST.DAWNPORT_TUTORIAL}, player:getTown():getId())then
		player:openChannel(3) -- World chat
	else
		player:openChannel(3) -- World chat
		player:openChannel(5) -- Advertsing main
	end

	-- Rewards
	local rewards = #player:getRewardList()
	if(rewards > 0) then
		player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("You have %d %s in your reward chest.",
		rewards, rewards > 1 and "rewards" or "reward"))
	end

	-- Update player id
	local stats = player:inBossFight()
	if stats then
		stats.playerId = player:getId()
	end

	if player:getStorageValue(Storage.combatProtectionStorage) < 1 then
		player:setStorageValue(Storage.combatProtectionStorage, 1)
		onMovementRemoveProtection(playerId, player:getPosition(), 10)
	end
	-- Set Client XP Gain Rate
	local baseExp = 100
	if Game.getStorageValue(GlobalStorage.XpDisplayMode) > 0 then
		baseExp = getRateFromTable(experienceStages, player:getLevel(), configManager.getNumber(configKeys.RATE_EXP))
	end

	local staminaMinutes = player:getStamina()
	local doubleExp = false --Can change to true if you have double exp on the server
	local staminaBonus = (staminaMinutes > 2340) and 150 or ((staminaMinutes < 840) and 50 or 100)
	if doubleExp then
		baseExp = baseExp * 2
	end
	player:setStaminaXpBoost(staminaBonus)
	player:setBaseXpGain(baseExp)

	if player:getStorageValue(Storage.isTraining) == 1 then --Reset exercise weapon storage
		player:setStorageValue(Storage.isTraining,0)
	end
	return true
end
playerLogin:register()