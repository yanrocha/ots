local mType = Game.createMonsterType("Rotten Golem")
local monster = {}

monster.description = "a rotten golem"
monster.experience = 23400
monster.outfit = {
	lookType = 1312,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 1939
monster.Bestiary = {
	class = "Construct",
	race = BESTY_RACE_CONSTRUCT,
	toKill = 5000,
	FirstUnlock = 25,
	SecondUnlock = 2500,
	CharmsPoints = 100,
	Stars = 5,
	Occurrence = 0,
	Locations = "Rotten Wasteland."
	}

monster.health = 28000
monster.maxHealth = 28000
monster.race = "venom"
monster.corpse = 38732
monster.speed = 200
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 4000,
	chance = 0
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10
}

monster.loot = {
	{id = "crystal coin", chance = 9000},
	{id = "great spirit potion", chance = 9000, maxCount = 7},
	{id = 7632, chance = 9000}, -- Giant shimmering pearl
	{id = 7633, chance = 9000}, -- Giant shimmering pearl
	{id = "terra amulet", chance = 9000},
	{id = "giant sword", chance = 9000},
	{id = "war axe", chance = 9000},
	{id = "mercenary sword", chance = 9000},
	{id = "titan axe", chance = 9000},
	{id = "underworld rod", chance = 9000},
	{id = "sacred tree amulet", chance = 9000},
	{id = "fur armor", chance = 9000},
	{id = "terra mantle", chance = 9000},
	{id = "wood cape", chance = 9000},
	{id = "rubber cap", chance = 9000},
	{id = "stone skin amulet", chance = 9000},
	{id = 38944, chance = 30} -- Bag you desire
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -950},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_HOLYDAMAGE, minDamage = -650, maxDamage = -900, range = 7, shootEffect = CONST_ANI_SMALLHOLY, effect = CONST_ME_HOLYAREA, target = true},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -750, maxDamage = -1200, radius = 7, effect = CONST_ME_BIGPLANTS, target = false}
	-- Chain: const_me-> CONST_ME_GREEN_ENERGY_SPARK, combat_t->COMBAT_EARTHDAMAGE
	-- Root
}

monster.defenses = {
	defense = 110,
	armor = 120
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 20},
	{type = COMBAT_ENERGYDAMAGE, percent = -15},
	{type = COMBAT_EARTHDAMAGE, percent = 40},
	{type = COMBAT_FIREDAMAGE, percent = -25},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 50},
	{type = COMBAT_DEATHDAMAGE , percent = -20}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = true},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)