Config = {}

Config.Framework = "qb-core"            -- Name of the framework

Config.Target = true 					-- Enables using a Target or 3DText
Config.TargetName = 'qb-target' 		-- Name of Target aplication

Config.MinPoliceCount = 0               -- Minimum of police required
Config.PoliceJob = {'police'}             

-- Type and Position of the starting ped
Config.StartPed = {
    {
        coords = vector4(767.62, -1690.5, 36.55, 7.34), 
        pedModel = 'u_m_m_streetart_01',     
    }
}

-- Loot Spot Animation 
Config.animation = "idle_e"
Config.animDict = "random@train_tracks"
Config.animetime = math.random(5500, 7500)

-- Required Item To Start the Heist And The Engines Hacks
Config.RequiredItem = "decryptomatic"

-- MarkBill Item Name
Config.MarkedBillName = 'inkedbags'

-- Available Difficulty level
Config.Difficultly = {
    [1] = {level = "easy", minGuard = 2, maxGuard=5, nbLootSpot=7, hackDot=5, time=30, consolHackBlock=3, lootMinChance=75, lootMaxChance=100,  MarkedBillMin = 100, MarkedBillMax = 250},
    [2] = {level = "medium", minGuard = 5, maxGuard=10, nbLootSpot=10, hackDot=8, time=50, consolHackBlock=5, lootMinChance=35, lootMaxChance=100,  MarkedBillMin = 250, MarkedBillMax = 500},
    [3] = {level = "hard", minGuard = 10, maxGuard=17, nbLootSpot=15, hackDot=12, time=110, consolHackBlock=7, lootMinChance=1, lootMaxChance=100,  MarkedBillMin = 500, MarkedBillMax = 1000},
    --[4] = {level = "insane", minGuard = 17, maxGuard=17, nbLootSpot=15, hackDot=15, time=130, consolHackBlock=20, lootMinChance=1, lootMaxChance=100,  MarkedBillMin = 500, MarkedBillMax = 1000},
}

-- Available Yacht Heist Scenario
Config.YachtScenario = {
    [1] = {
        YachtCoords = vector3(-2017.29, -1040.04, 2.45), 
        Engines = {
            [1] = {coords = vector3(-2043.08, -1033.41, 2.57), text = vector3(-2040.32, -1036.54, 2.59), active = true, occupied=false},
            [2] = {coords = vector3(-2041.41, -1030.6, 2.57), text = vector3(-2037.9, -1029.63, 2.58), active = true, occupied=false},
            [3] = {coords = vector3(-2035.35, -1036.26, 2.56), text = vector3(-2030.55, -1032.09, 2.56), active = true, occupied=false},
            [4] = {coords = vector3(-2034.24, -1032.94, 2.56), text = vector3(-2032.85, -1038.91, 2.56), active = true, occupied=false},
        }, 
        SearchableSpots = {
            [1] = {coords = vector3(-2077.28, -1022.23, 5.88), active = false, looted = false},
            [2] = {coords = vector3(-2078.78, -1016.27, 5.88), active = false, looted = false},
            [3] = {coords = vector3(-2084.71, -1013.65, 5.88), active = false, looted = false},
            [4] = {coords = vector3(-2089.3, -1009.75, 5.88), active = false, looted = false},
            [5] = {coords = vector3(-2095.78, -1007.94, 5.88), active = false, looted = false},
            [6] = {coords = vector3(-2097.74, -1015.94, 5.88), active = false, looted = false},
            [7] = {coords = vector3(-2107.76, -1014.24, 5.89), active = false, looted = false},
            [8] = {coords = vector3(-2094.26, -1015.02, 8.98), active = false, looted = false},
            [9] = {coords = vector3(-2085.35, -1014.71, 8.97), active = false, looted = false},
            [10] = {coords = vector3(-2087.57, -1021.51, 8.97), active = false, looted = false},
            [11] = {coords = vector3(-2077.17, -1020.28, 8.97), active = false, looted = false},
            [12] = {coords = vector3(-2057.0, -1023.27, 11.91), active = false, looted = false},
            [13] = {coords = vector3(-2059.17, -1029.94, 11.91), active = false, looted = false},
            [14] = {coords = vector3(-2075.21, -1025.65, 11.91), active = false, looted = false},
            [15] = {coords = vector3(-2102.73, -1014.31, 5.88), active = false, looted = false},
        }, 
        GardianCoords = {
            [1] = {coords = vector4(-2027.63, -1034.09, 5.88, 42.54)},
            [2] = {coords = vector4(-2041.53, -1039.2, 5.88, 310.89)},
            [3] = {coords = vector4(-2079.13, -1019.98, 5.88, 336.54)},
            [4] = {coords = vector4(-2084.55, -1017.14, 5.88, 73.36)},
            [5] = {coords = vector4(-2088.64, -1015.86, 5.88, 242.95)},
            [6] = {coords = vector4(-2092.59, -1008.09, 5.88, 341.63)},
            [7] = {coords = vector4(-2099.55, -1007.27, 5.88, 246.86)},
            [8] = {coords = vector4(-2117.26, -1003.43, 7.9, 182.53)},
            [9] = {coords = vector4(-2112.86, -1009.68, 9.46, 62.61)},
            [10] = {coords = vector4(-2089.43, -1017.05, 8.97, 278.89)},
            [11] = {coords = vector4(-2078.85, -1023.96, 8.97, 37.63)},
            [12] = {coords = vector4(-2036.4, -1034.06, 8.97, 262.45)},
            [13] = {coords = vector4(-2048.72, -1032.54, 11.91, 286.25)},
            [14] = {coords = vector4(-2050.46, -1026.84, 11.91, 234.92)},
            [15] = {coords = vector4(-2068.97, -1026.93, 11.91, 324.6)},
            [16] = {coords = vector4(-2083.57, -1022.61, 12.78, 289.85)},
            [17] = {coords = vector4(-2081.04, -1015.63, 12.78, 195.39)},
        }, 
        Console = vector3(-2085.74, -1017.94, 12.78),
        Trolley = {
            [1] = {
                coords = vector4(-2051.54, -1025.68, 7.97, 251.63),
                active = false,
                looted = false,
                inUse = false,
                model = 269934519
            },
            [2] = {
                coords = vector4(-2055.65, -1031.03, 7.97, 224.24),
                active = false,
                looted = false,
                inUse = false,
                model = 269934519
            },
        }
    },
    [2] = {
        YachtCoords = vector3(-1363.5, 6734.05, 2.45), 
        Engines = {
            [1] = {coords = vector3(-1380.75, 6737.82, 2.56), text = vector3(-1380.75, 6737.82, 2.56), active = true, occupied=false},
            [2] = {coords = vector3(-1379.89, 6741.16, 2.56), text = vector3(-1379.89, 6741.16, 2.56), active = true, occupied=false},
            [3] = {coords = vector3(-1388.25, 6740.54, 2.57), text = vector3(-1388.25, 6740.54, 2.58), active = true, occupied=false},
            [4] = {coords = vector3(-1387.35, 6743.58, 2.57), text = vector3(-1387.35, 6743.58, 2.58), active = true, occupied=false},
        }, 
        SearchableSpots = {
            [1] = {coords = vector3(-1422.54, 6751.8, 5.88), active = false, looted = false},
            [2] = {coords = vector3(-1417.37, 6749.74, 5.88), active = false, looted = false},
            [3] = {coords = vector3(-1424.15, 6757.36, 5.88), active = false, looted = false},
            [4] = {coords = vector3(-1429.2, 6755.3, 5.88), active = false, looted = false},
            [5] = {coords = vector3(-1430.09, 6760.12, 5.88), active = false, looted = false},
            [6] = {coords = vector3(-1428.61, 6761.75, 5.88), active = false, looted = false},
            [7] = {coords = vector3(-1432.06, 6761.32, 5.88), active = false, looted = false},
            [8] = {coords = vector3(-1434.63, 6764.03, 5.88), active = false, looted = false},
            [9] = {coords = vector3(-1435.88, 6760.35, 5.88), active = false, looted = false},
            [10] = {coords = vector3(-1443.81, 6760.58, 5.88), active = false, looted = false},
            [11] = {coords = vector3(-1440.9, 6766.05, 5.88), active = false, looted = false},
            [12] = {coords = vector3(-1430.62, 6759.26, 8.97), active = false, looted = false},
            [13] = {coords = vector3(-1432.49, 6753.29, 8.97), active = false, looted = false},
            [14] = {coords = vector3(-1421.95, 6755.2, 8.97), active = false, looted = false},
            [15] = {coords = vector3(-1420.17, 6756.42, 11.91), active = false, looted = false},
        }, 
        GardianCoords = {
            [1] = {coords = vector4(-1381.45, 6740.36, 8.97, 258.14)},
            [2] = {coords = vector4(-1385.17, 6743.96, 12.04, 274.57)},
            [3] = {coords = vector4(-1387.01, 6738.66, 12.02, 176.85)},
            [4] = {coords = vector4(-1406.67, 6748.19, 11.91, 273.82)},
            [5] = {coords = vector4(-1393.52, 6743.8, 8.97, 268.31)},
            [6] = {coords = vector4(-1401.03, 6753.77, 8.97, 22.98)},
            [7] = {coords = vector4(-1406.21, 6740.7, 8.97, 136.3)},
            [8] = {coords = vector4(-1431.8, 6756.59, 8.97, 60.36)},
            [9] = {coords = vector4(-1448.5, 6763.25, 8.97, 53.1)},
            [10] = {coords = vector4(-1453.26, 6759.14, 8.97, 94.17)},
            [11] = {coords = vector4(-1467.7, 6768.1, 8.05, 40.17)},
            [12] = {coords = vector4(-1451.5, 6762.78, 5.89, 172.75)},
            [13] = {coords = vector4(-1437.36, 6752.79, 5.91, 232.52)},
            [14] = {coords = vector4(-1415.73, 6758.53, 5.88, 267.52)},
            [15] = {coords = vector4(-1421.25, 6745.59, 5.88, 233.62)},
            [16] = {coords = vector4(-1379.0, 6738.94, 5.88, 252.97)},
            [17] = {coords = vector4(-1377.37, 6745.13, 5.88, 330.07)},
        }, 
        Console = vector3(-1431.01, 6755.85, 12.78),
        Trolley = {
            [1] = {
                coords = vector4(-1396.27, 6748.92, 7.97, 135.12),
                active = false,
                model = 269934519, 
                looted = false,
                inUse = false
            },
            [2] = {
                coords = vector4(-1401.62, 6742.68, 7.97, 282.34),
                active = false,
                model = 269934519, 
                looted = false,
                inUse = false		
            },
        }
    }
}

--Reward Config
Config.RewardItem = {
    ["common"] = {
       ["chance"] = 100,
       [1] = {
        ["item"] = "samsungphone", 
        ["amount"] = {1,1}
       }, 
       [2] = {
        ["item"] = "iphone", 
        ["amount"] = {1,1}
       },
       [3] = {
        ["item"] = "rolex", 
        ["amount"] = {1,3}
       },
       [4] = {
        ["item"] = "joint", 
        ["amount"] = {1,5}
       },
       [5] = {
        ["item"] = "diamond_ring", 
        ["amount"] = {1,3}
       },
       [6] = {
        ["item"] = "ruby_earring",
        ["amount"] = {1,3}
       }
    }, 
    ["uncommon"] = {
       ["chance"] = 55,
       [1] = {
        ["item"] = "diamond_earring", 
        ["amount"] = {1,2}
       }, 
       [2] = {
        ["item"] = "10kgoldchain", 
        ["amount"] = {1,5}
       },
       [3] = {
        ["item"] = "goldchain", 
        ["amount"] = {1,5}
       },
       [4] = {
        ["item"] = "diamond", 
        ["amount"] = {1,2}
       }
       [5] = {
        ["item"] = "yellow-diamond", 
        ["amount"] = {1,2}
       }
    },
    ["rare"] = { ["chance"] = 35, 
        [1] = {
            ["item"] = "weapon_vintagepistol",
            ["amount"] = { 1, 1 },
        },
        [2] = {
            ["item"] = "goldbar",
            ["amount"] = { 1, 5 },
        },
        [3] = {
            ["item"] = "pistol_ammo",
            ["amount"] = { 1, 1 },
        },
        [4] = {
            ["item"] = "diamond_necklace",
            ["amount"] = { 1, 5 },
        }, 
        [5] = {
            ["item"] = "weapon_knuckle", 
            ["amount"] = {1, 1}, 
        }
    },
    ["noway"] = { ["chance"] = 15, 
        [1] = {
            ["item"] = "weapon_dp9",
            ["amount"] = { 1, 1 },
        },
        [2] = {
            ["item"] = "thermite",
            ["amount"] = { 1, 2 },
        },
        [3] = {
            ["item"] = "gmrstick",
            ["amount"] = { 1,1 },
        },
        [4] = {
            ["item"] = "safecracker",
            ["amount"] = { 1,1 },
        },
        [5] = {
            ["item"] = "weapon_dagger", 
            ["amount"] = { 1,1 },
        }
    },
}

-- Bonus Reward from Trolleys
Config.BonusTrolley = {
    chance = 10, 
    items = {
        "bobcatkeycard","laptop_brown","laptop_red","laptop_blue","captainskull"
    }
}

-- Yacht Guard Config
Config.YachtGuardPed = {"u_m_m_jewelsec_01","u_m_m_jewelthief","u_m_m_spyactor","s_m_y_westsec_01","s_m_y_clubbar_01","s_m_m_movprem_01","csb_tomcasino"}

Config.YachtGuardWeapon = {"weapon_bats", "weapon_combatpistol", "weapon_battleaxe", "weapon_poolcue", "weapon_switchblade"}

Config.YachtGuardArmour = 200 
