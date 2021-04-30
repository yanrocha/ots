-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 50,
		multiplier = 20000
	}, {
		minlevel = 51,
		maxlevel = 100,
		multiplier = 18000
	}, {
		minlevel = 101,
                maxlevel = 200,
		multiplier = 16000
        }, {
                minlevel = 201,
                maxlevel = 300,
		multiplier = 14000
        }, {
                minlevel = 301,
                maxlevel = 400,
		multiplier = 13000
        }, {
                minlevel = 401,
                maxlevel = 500,
		multiplier = 12500
         }, {
                minlevel = 501,
                maxlevel = 700,           
		multiplier = 12000
         }, {
                minlevel = 701,
                maxlevel = 1000,            
		multiplier = 11500
	},{
                minlevel = 1001,         
		multiplier = 11000
	}
}

skillsStages = {
	{
		minlevel = 0,
		maxlevel = 60,
		multiplier = 320
	}, {
		minlevel = 61,
		maxlevel = 80,
		multiplier = 240
	}, {
		minlevel = 81,
		maxlevel = 100,
		multiplier = 180
	}, {
		minlevel = 101,
		maxlevel = 110,
		multiplier = 135
	}, {
		minlevel = 111,
		multiplier = 100
	}
}

magicLevelStages = {
		{
		minlevel = 0,
		maxlevel = 60,
		multiplier = 320
	}, {
		minlevel = 61,
		maxlevel = 80,
		multiplier = 240
	}, {
		minlevel = 81,
		maxlevel = 100,
		multiplier = 180
	}, {
		minlevel = 101,
		maxlevel = 110,
		multiplier = 135
	}, {
		minlevel = 111,
		multiplier = 100
	}
}