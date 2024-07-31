Config = {
	Lan = "en",
	Debug = false, -- false to remove green boxes
	img = "lj-inventory/html/images/", -- Change this to your inventory's name and image folder (SET TO "" IF YOU HAVE DOUBLE IMAGES)
	PatHeal = 2, 			--how much you are healed by patting a cat, 2 hp seems resonable, enough not to be over powered and enough to draw people in.
							--set to 0 if you don't want to use this
	JimShop = false, 		-- Enable this to use jim-shops for buying ingredients
	CheckMarks = true, -- If true this will show the player if they have the correct items to be able to craft the items

	Notify = "qb",
	Locations = {
		{	zoneEnable = true,
			job = "realestate", -- Set this to the required job
			label = "Real Estate Office",
			zones = {
				vector2(-698.72, 268.22),
				vector2(-702.31, 275.25),
				vector2(-717.74, 258.99),
				vector2(-721.72, 271.39),
			},			
			blip = vector3(-698.35, 271.4, 83.11),
			blipcolor = 1,
		},
	},      
    ShellSpawn = vector3(-586.34, 254.34, -159.55)
}