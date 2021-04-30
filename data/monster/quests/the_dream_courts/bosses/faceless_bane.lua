local mType = Game.createMonsterType("Faceless Bane")
local monster = {}

monster.description = "a Faceless Bane"
monster.experience = 30000  
monster.outfit = {
	lookType = 1122,
	lookHead = 0,
	lookBody = 4,
	lookLegs = 95,
	lookFeet = 4,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 35000 
monster.maxHealth = 35000 
monster.race = "blood"
monster.corpse = 34651
monster.speed = 250
monster.manaCost = 0
monster.maxSummons = 2

monster.changeTarget = {
	interval = 4000,
	chance = 10
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
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
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
	chance = 10,
}

monster.loot = {
	{id = "platinum coin", chance = 90000, maxCount = 10},
	{id = "gold ingot", chance = 90000,  maxCount = 2},
	{id = "muck rod", chance = 90000},
	{id = "terra rod", chance = 90000},
	{id = "underworld rod", chance = 90000},
	{id = "hexagonal ruby", chance = 50000},
	{id = "twin hooks", chance = 50000},
	{id = "violet gem", chance = 50000},
	{id = "Book Backpack", chance = 4600},
	{id = "Ectoplasmic Shield", chance = 650},
	{id = "Spirit Guide", chance = 550},
	{id = "dream blossom staff", chance = 500000},
	{id = 34983, chance = 800}
}

monster.summons = {
	{name = "Burster Spectre", chance = 10, interval = 2000},
	{name = "Ripper Spectre", chance = 10, interval = 2000}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -10, maxDamage = -600},
	{name ="combat", interval = 3000, chance = 60, type = COMBAT_PHYSICALDAMAGE, minDamage = -330, maxDamage = -400, range = 4, shootEffect = CONST_ANI_LARGEROCK, target = false},
	{name ="combat", interval = 2500, chance = 60, type = COMBAT_PHYSICALDAMAGE, minDamage = -330, maxDamage = -350, range = 7, shootEffect = CONST_ANI_LARGEROCK, target = false},
	{name ="combat", interval = 2000, chance = 60, type = COMBAT_ENERGYDAMAGE, minDamage = -385, maxDamage = -535, range = 1, shootEffect = CONST_ANI_POISON, target = true}
}

monster.defenses = {
	defense = 5,
	armor = 10
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 50},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = -20},
	{type = COMBAT_LIFEDRAIN, percent = -20},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 50}
}

monster.heals = {
	{type = COMBAT_DEATHDAMAGE , percent = 100}
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