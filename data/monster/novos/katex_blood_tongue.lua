local mType = Game.createMonsterType("Katex Blood Tongue")
local monster = {}

monster.description = "a katex blood tongue"
monster.experience = 14900
monster.outfit = {
	lookType = 1300,
	lookHead = 114,
	lookBody = 38,
	lookLegs = 94,
	lookFeet = 94,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 16300
monster.maxHealth = monster.health
monster.race = "blood"
monster.corpse = 38656
monster.speed = 300
monster.summonCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 5000,
	chance = 0
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
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
	interval = 0,
	chance = 0
}

monster.loot = {
	{id = "platinum coin", chance = 32300, maxCount = 9},
    {id = "ultimate health potion", chance = 32300, maxCount = 3},
    
    {id = "blue gem", chance = 9970, maxCount = 3},
    {id = "giant sword", chance = 9970},
    {id = "gold ingot", chance = 9970},
    {id = "katex' blood", chance = 9970},
    {id = "violet gem", chance = 9970},
    {id = "war axe", chance = 9970},
    {id = "werehyaena nose", chance = 9970},
	{id = "werehyaena talisman", chance = 9970},
	
    {id = "assassin dagger", chance = 3970},
    {id = "demon shield", chance = 3970},
    {id = "demonrage sword", chance = 3970},
    {id = "gold ring", chance = 3970},
    {id = "golden armor", chance = 3970},
    {id = "jade hammer", chance = 3970},
    {id = "magic plate armor", chance = 3970},
    {id = "ornate crossbow", chance = 3970},
    {id = "ring of green plasma", chance = 3970},
    {id = "skull helmet", chance = 3970},
	{id = "werehyaena trophy", chance = 3970},
	
    {id = "raw watermelon tourmaline", chance = 250},
    {id = "red silk flower", chance = 250},
    -- {id = "moonlight crystals", chance = 250},
}

monster.attacks = {
	{name = "melee", type = COMBAT_PHYSICALDAMAGE, interval = 2*1000, minDamage = 0, maxDamage = -1400},
    {name = "combat", type = COMBAT_EARTHDAMAGE, interval = 2*1000, chance = 17, minDamage = -1275, maxDamage = -1355, radius = 3, effect = CONST_ME_HITBYPOISON},
    {name = "combat", type = COMBAT_DEATHDAMAGE, interval = 2*1000, chance = 15, minDamage = -1430, maxDamage = -1470, target = true, range = 5, radius = 1, shootEffect = CONST_ANI_LARGEROCK, effect = CONST_ME_MORTAREA},
    {name = "combat", type = COMBAT_DEATHDAMAGE, interval = 2*1000, chance = 13, minDamage = -1325, maxDamage = -1375, length = 3, spread = 0, effect = CONST_ME_MORTAREA}
}

monster.defenses = {
	{name = "speed", chance = 15, interval = 2*1000, speed = 300, duration = 5*1000, effect = CONST_ME_MAGIC_BLUE},
	defense = 0,
	armor = 38
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 100},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 95},
	{type = COMBAT_DEATHDAMAGE , percent = -5}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = true},
	{type = "invisible", condition = true},
	{type = "bleed", condition = true}
}

mType:register(monster)