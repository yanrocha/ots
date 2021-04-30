local mType = Game.createMonsterType("Goshnars Hatred")
local monster = {}

monster.description = "a Goshnars Hatred"
monster.experience = 120000
monster.outfit = {
	lookType = 1307,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 400000
monster.maxHealth = 400000
monster.race = "venom"
monster.corpse = 38710
monster.speed = 500
monster.manaCost = 0
monster.maxSummons = 2

monster.changeTarget = {
	interval = 4000,
	chance = 10
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
	interval = 5000,
	chance = 10,
}

monster.summons = {
	{name = "Dreadful Harvester", chance = 10, interval = 3000},
	{name = "Ashes of Burning Hatred", chance = 10, interval = 3000},
	{name = "Hateful Soul", chance = 10, interval = 3000}
}

monster.loot = {
	--{id = "hazardous heart", chance = 9000},
	--{id = "gold coin", chance = 50000, maxCount = 88}
	
	 --{id = "Crystal Coin", maxCount = 2,chance="9000"},
	 --{id = "Supreme Health Potion", maxCount = 20, chance="9000"},
	 --{id = "Ultimate Mana Potion", maxCount = 20, chance="9000"},
	 --{id = "Ultimate Spirit Potion",maxCount = 20,chance="9000"},
	 --{id = "Mastermind Potion", maxCount = 10, chance="9000"},
	 --{id = "Berserk Potion", maxCount = 10, chance="9000"},
	 --{id = "Bullseye Potion", maxCount = 10,chance="9000"},
	 --{id = "7633", chance="9000"},
	 --{id = "Giant Amethyst", chance="9000"},
	 --{id = "Giant Topaz", chance="9000"},
	 --{id = "Yellow Gem", maxCount = 3, chance="9000"},
	 --{id = "Blue Gem", maxCount = 3, chance="9000"},
	 --{id = "Green Gem", maxCount = 3, chance="9000"},
	 --{id = "Figurine of Malice", chance="1100"},
	 --{id = "Gold Ingot", chance="9000"},
	 --{id = "Giant Sapphire", chance="9000"},
	 --{id = "Malice's Horn", chance="800"},
	 --{id = "Malice's Spine", chance="800"},
	 --{id = "The Skull of a Beast", chance="500"},
	 --{id = "Bracelet of Strengthening", chance="400"},
	 {id = "Bag You Desire", chance="300"}
	 --{id = "Spectral Horseshoe", chance="400"}

}

monster.attacks = {
	--{name ="combat", interval = 3000, chance = 24, type = COMBAT_EARTHDAMAGE, minDamage = -900, maxDamage = -1300, range = 7, radius = 3, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = true},
	{name ="melee", interval = 2000, chance = 100, minDamage = -800, maxDamage = -1500},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_ENERGYDAMAGE, minDamage = -500, maxDamage = -1800, target = true},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -1000, maxDamage = -2000, target = true},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -1500, maxDamage = -2590, target = true},
	{name ="combat", interval = 3000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -1000, maxDamage = -2800, shootEffect = CONST_ANI_SUDDENDEATH, target = false}
}

monster.defenses = {
	defense = 25,
	armor = 78
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 20},
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


mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end


mType:register(monster)