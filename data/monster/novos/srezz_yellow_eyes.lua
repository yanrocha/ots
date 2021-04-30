local mType = Game.createMonsterType("Srezz Yellow Eyes")
local monster = {}

monster.description = "a srezz yellow eyes"
monster.experience = 14800
monster.outfit = {
	lookType = 220,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 16200
monster.maxHealth = monster.health
monster.race = "venom"
monster.corpse = 6061
monster.speed = 300
monster.summonCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 70,
	health = 30,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 80,
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
	{text = "Sssssouls for the one", yell = false},
	{text = "HISSSS", yell = true},
	{text = "Tsssse one will risssse again", yell = false},
	{text = "I bring you deathhhh, mortalssss", yell = false}
}

monster.loot = {
	{id = "platinum coin", chance = 32300, maxCount = 9},
	{id = "snake skin", chance = 32300, maxCount = 3},
	{id = "ultimate health potion", chance = 32300, maxCount = 3},
	{id = "mastermind potion", chance = 32300},

	{id = "black pearl", chance = 9970},
	{id = "blue crystal shard", chance = 9970},
	{id = "blue gem", chance = 9970},
	{id = "gemmed figurine", chance = 9970},
	{id = "giant sword", chance = 9970},
	{id = "glacier kilt", chance = 9970},
	{id = "glacier robe", chance = 9970},
	{id = "gold ingot", chance = 9970},
	{id = "green gem", chance = 9970},
	{id = "srezz' eye", chance = 9970},
	{id = "violet gem", chance = 9970},
	{id = "war axe", chance = 9970},
	
	{id = "demonrage sword", chance = 3970},
	{id = "gold nugget", chance = 3970},
	{id = "ring of green plasma", chance = 3970},
	{id = "skull helmet", chance = 3970},
	
	{id = "raw watermelon tourmaline", chance = 250},
    {id = "red silk flower", chance = 250},
	
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1352},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -1180, maxDamage = -1400, range = 7, shootEffect = CONST_ANI_POISON, target = false},
	{name ="outfit", interval = 2000, chance = 1, range = 7, effect = CONST_ME_MAGIC_BLUE, target = false, duration = 3000, outfitItem = 3976},
	{name ="speed", interval = 2000, chance = 25, speedChange = -1850, range = 7, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_GREEN_RINGS, target = true, duration = 12000},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -1300, maxDamage = -1600, length = 8, spread = 3, effect = CONST_ME_SOUND_RED, target = false},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -1300, maxDamage = -1600, length = 8, spread = 3, effect = CONST_ME_POISONAREA, target = false}
}

monster.defenses = {
	defense = 35,
	armor = 35,
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 1350, maxDamage = 1600, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 15, speedChange = 1340, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = -10},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 20},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)