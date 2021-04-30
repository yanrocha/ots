local mType = Game.createMonsterType("Drume")
local monster = {}

monster.description = "Drume"
monster.experience = 25000
monster.outfit = {
	lookType = 1317,
	lookHead = 0,
	lookBody = 78,
	lookLegs = 57,
	lookFeet = 57,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 35000
monster.maxHealth = 35000
monster.race = "blood"
monster.corpse = 33364
monster.speed = 260
monster.summonCost = 0
monster.maxSummons = 3

monster.faction = FACTION_LIONUSURPERS
monster.enemyFactions = {FACTION_LION, FACTION_PLAYER}

monster.summons = {
	{name = "preceptor lazare", chance = 10, interval = 8000},
	{name = "grand commander soeren", chance = 10, interval = 8000},
	{name = "grand chaplain gaunder", chance = 10, interval = 8000}
}

monster.changeTarget = {
	interval = 4000,
	chance = 25
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{id = "energy bar", chance = 100000},
	{id = "platinum coin", chance = 100000, maxCount = 5},
	{id = "supreme health potion", chance = 57831, maxCount = 20},
	{id = "ultimate mana potion", chance = 55723, maxCount = 20},
	{id = "yellow gem", chance = 35843, maxCount = 2},
	{id = "red gem", chance = 35542, maxCount = 2},
	{id = "ultimate spirit potion", chance = 31627, maxCount = 6},
	{id = "royal star", chance = 31325, maxCount = 100},
	{id = "bullseye potion", chance = 22590, maxCount = 10},
	{id = "berserk potion", chance = 21988, maxCount = 10},
	{id = "blue gem", chance = 21687, maxCount = 2},
	{id = "mastermind potion", chance = 17771, maxCount = 10},
	{id = "green gem", chance = 17470, maxCount = 2},
	{id = 7632, chance = 15060},
	{id = "gold ingot", chance = 7000},
	{id = "terra rod", chance = 7000},
	{id = "crystal coin", chance = 7000},
	{id = "stone skin amulet", chance = 7000},
	{id = "silver token", chance = 8735, maxCount = 3},
	{id = "terra legs", chance = 7000},
	{id = "terra mantle", chance = 7000},
	{id = "raw watermelon tourmaline", chance = 7000},
	{id = "wand of voodoo", chance = 6024},
	{id = "violet gem", chance = 5723},
	{id = "terra hood", chance = 4819},
	{id = "terra amulet", chance = 4518},
	{id = "giant sapphire", chance = 4217},
	{id = "giant ruby", chance = 3012},
	{id = "underworld rod", chance = 2410},
	{id = "Lion Spangenhelm", chance = 450},
	{id = "Lion Plate", chance = 450},
	{id = "Lion Shield", chance = 450},
	{id = "Lion Longsword", chance = 450},
	{id = "Lion Hammer", chance = 450},
	{id = "Lion Axe", chance = 450},
	{id = "Lion Longbow", chance = 450},
	{id = "Lion Spellbook", chance = 450},
	{id = "Lion Wand", chance = 450},
	{id = "Lion Amulet", chance = 450},
	{id = "Lion Rod", chance = 450}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -900, effect = CONST_ME_DRAWBLOOD},
	{name ="combat", interval = 6000, chance = 25, type = COMBAT_HOLYDAMAGE, minDamage = -650, maxDamage = -950, length = 8, spread = 3, effect = CONST_ME_HOLYAREA, target = false},
	{name ="combat", interval = 2750, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -600, maxDamage = -1000, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false},
	{name ="combat", interval = 2500, chance = 22, type = COMBAT_DEATHDAMAGE, minDamage = -600, maxDamage = -800, radius = 3, effect = CONST_ME_MORTAREA, target = false},
	{name ="combat", interval = 3300, chance = 24, type = COMBAT_ICEDAMAGE, minDamage = -500, maxDamage = -700, length = 4, spread = 0, effect = CONST_ME_ICEATTACK, target = false},
	{name ="singlecloudchain", interval = 6000, chance = 34, minDamage = -400, maxDamage = -900, range = 4, effect = CONST_ME_ENERGYHIT, target = true}
}

monster.defenses = {
	defense = 60,
	armor = 82,
	{name ="combat", interval = 4000, chance = 40, type = COMBAT_HEALING, minDamage = 300, maxDamage = 800, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 40},
	{type = COMBAT_ENERGYDAMAGE, percent = -20},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 40}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType:register(monster)