local mType = Game.createMonsterType("The Source Of Corruption")
local monster = {}

monster.description = "The Source Of Corruption"
monster.experience = 0
monster.outfit = {
	lookType = 979,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 500000
monster.maxHealth = 500000
monster.race = "undead"
monster.corpse = 26223
monster.speed = 120
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 5000,
	chance = 20
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
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 95,
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
	{id = "small amethyst", chance = 21000, maxCount = 20},
	{id = "small emerald", chance = 19000, maxCount = 20},
	{id = "platinum coin", chance = 68299, maxCount = 30},
	{id = "gold coin", chance = 100000, maxCount = 200},
	{id = "Crystallized Anger", chance = 21000, maxCount = 10},
	{id = "Gemmed Figurine", chance = 12000, maxCount = 10},
	{id = "gold ingot", chance = 35000},
	{id = "gold token", chance = 6000, maxCount = 4},
	{id = "ultimate health potion", chance = 28230, maxCount = 10},
	{id = "Magic Sulphur", chance = 2500, maxCount = 3},
	{id = "gold token", chance = 1532, maxCount = 10},
	{id = "Onyx Chip", chance = 11520},
	{id = "Silver Token", chance = 10000, maxCount = 3},
	{id = "Solid Rage", chance = 29460},
	{id = "White Piece of Cloth", chance = 18920, maxCount = 4},
	{id = "Crude Umbral Slayer", chance = 2000},
	{id = "Enchanted Chicken Wing", chance = 2000},
	{id = "Heavy Mace", chance = 2500},
	{id = "Magic Plate Armor", chance = 3000},
	{id = "Rift Bow", chance = 2500},
	{id = "Ring of Red Plasma", chance = 7360},
	{id = "Sapphire Hammer", chance = 3000},
	{id = "Silkweaver Bow", chance = 4000},
	{id = "Skullcracker Armor", chance = 5000},
	{id = "Skull Staff", chance = 5000},
	{id = "Umbral Slayer", chance = 2000},
	{id = "Wand of Everblazing", chance = 5000},
	{id = "Demonwing Axe", chance = 1000},
	{id = "Yalahari Figurine", chance = 500}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1500},
	{name ="source of corruption wave", interval = 2000, chance = 15, target = false}
}

monster.defenses = {
	defense = 30,
	armor = 30
}

monster.reflects = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 15},
	{type = COMBAT_ENERGYDAMAGE, percent = 15},
	{type = COMBAT_EARTHDAMAGE, percent = 15},
	{type = COMBAT_FIREDAMAGE, percent = 15},
	{type = COMBAT_LIFEDRAIN, percent = 15},
	{type = COMBAT_MANADRAIN, percent = 15},
	{type = COMBAT_DROWNDAMAGE, percent = 15},
	{type = COMBAT_ICEDAMAGE, percent = 15},
	{type = COMBAT_HOLYDAMAGE , percent = 15},
	{type = COMBAT_DEATHDAMAGE , percent = 15}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType.onThink = function(monster, interval)
end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature)
end

mType.onMove = function(monster, creature, fromPosition, toPosition)
end

mType.onSay = function(monster, creature, type, message)
end

mType:register(monster)