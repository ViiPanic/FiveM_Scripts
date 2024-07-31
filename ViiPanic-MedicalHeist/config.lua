local QBCore = exports['qb-core']:GetCoreObject()
Config = {}

Config.Locale = 'en'

Config.MSG = function(msg) -- / Replace your own Notification in here
    QBCore.Functions.Notify(msg, "primary")
    --ESX.ShowNotification(msg)
    --exports['okokNotify']:Alert("Heist", msg, 3000, 'info')
end

Config.Progressbar = function(text, time)
    QBCore.Functions.Progressbar("medical_heist", text, time, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "",
        anim = "",
        flags = 79,
    }, {}, {}, function() -- Done
        
    end, function() -- Cancel
        
    end)
    --exports["esx_progressbar"]:Progressbar(text, time,{FreezePlayer = false, animation ={type = "",dict = "", lib =""},onFinish = function()end})
    --Citizen.Wait(time) -- If you use a only visual Progressbar, you can add this Wait | Not needed at esx_Progressbar
end

Config.Webhook = '' -- Your Webhook Link

Config.ShowBlip = false -- Start Blip

Config.AfterHeistCooldown = 300 -- Seconds |  How long after someone did a heist should the cooldown be active (Global Cooldown)

Config.RequiredItem = 'laptop_brown' -- RequiredItem to Start Heist | Set to nil if not needed

Config.WarnPolice = 30 -- random in percent 0-100 | 0 equals no Notify to Police

Config.UseMinigame = {
    enable = true, 
    lifes = 3,
    --pure-minigame
    gameData = {
        totalNumbers = 15,
        seconds = 30,
        timesToChangeNumbers = 3,
        amountOfGames = 2,
        incrementByAmount = 5,
    }
    -- / UTK Fingerprint https://github.com/utkuali/Finger-Print-Hacking-Game
    -- levels = 4, -- min 1 Max 4 (How many Levels you have to solve)
    -- lifes = 3, -- How many Lifes you have until fail
    -- time = 2, -- How many Time do you have for all (in minutes)
}

Config.SpawnProps = false -- / If you want to spawn Props at Hackingcoords (Table with Computers)

Config.Start = {
    {
        coords = vector4(-25.28, -1490.61, 29.36, 144.06), -- / Start Heist Coords
        pedname = 'u_m_m_fibarchitect',
        propname = 'reh_prop_reh_b_computer_04b' -- / for hackingingcoords / If Config.SpawnProps = true, otherwise no function / if prop dont work try "xm_prop_base_computer_01"
    }
}

Config.RewardItem = { --  / Each Difficulty has different Rewards
    easy    =   {[1] = 'iv_bag',[2] = 'pill_bottle'}, -- / itemname -> You can add as much Items as you want
    normal  =   {[1] = 'iv_bag',[2] = 'medical_supplies',[3] = 'pill_bottle'}, -- To Get The Best Experience, use this Script with Phoenix_Bloodtypes
    hard    =   {[1] = 'blood_0n',[2] = 'iv_bag',[3] = 'medical_supplies',[4] = 'pill_bottle',[5] = 'vaccine_box'}             -- https://forum.cfx.re/t/free-esx-bloodtypes-system/5172677
}

Config.Buyers = {
    {
        coords = vector4(-176.16, 406.4, 110.77, 28.21), -- / Start Heist Coords
        pedname = 's_m_m_scientist_01',
        propname = 'reh_prop_reh_b_computer_04b' -- / for hackingingcoords / If Config.SpawnProps = true, otherwise no function / if prop dont work try "xm_prop_base_computer_01"
    }
    -- [1] = {
    --     ["spawn"] = vector3(-176.16, 406.4, 109.77),
    --     ["heading"] = 28.21,
    --     ["model"] = "s_m_m_scientist_01",
    --     ["distance"] = 15,
    --     ["busy"] = false,
    -- },
}

--item and price info
Config.MedicalSupplies = {  
    [1] = {
        ["itemName"] = "pill_bottle",
        ["itemWorth"] = { 200, 300 },
        ["dirtyCash"] = false,
        ["dirtyCashName"] = "markedbills"
    },
    [2] = {
        ["itemName"] = "iv_bag",
        ["itemWorth"] = { 400, 500 },
        ["dirtyCash"] = false,
        ["dirtyCashName"] = "markedbills"
    },
    [3] = {
        ["itemName"] = "medical_supplies",
        ["itemWorth"] = { 500, 600 },
        ["dirtyCash"] = false,
        ["dirtyCashName"] = "markedbills"
    },
    [4] = {
        ["itemName"] = "vaccine_box",
        ["itemWorth"] = { 700, 800 },
        ["dirtyCash"] = false,
        ["dirtyCashName"] = "markedbills"
    },
    [5] = {
        ["itemName"] = "blood_0n",
        ["itemWorth"] = { 900, 1000 },
        ["dirtyCash"] = false,
        ["dirtyCashName"] = "markedbills"
    },         
}

Config.RewardMoney = {
    easy    = {account = 'rolls',    amount = 1000},
    normal  = {account = 'rolls',    amount = 2500},
    hard    = {account = 'bands',    amount = 5000},
}

Config.Difficulty = {
    easy = {
        propname = 'xm_prop_x17_bag_med_01a', -- For the Prop that the Player has to steal
        weaponname = 'weapon_pistol', -- Weapons that Enemys carrying
        maxped = 3,
        minped = 1
    },
    normal = {
        propname = 'sm_prop_smug_crate_s_medical',
        weaponname = 'weapon_pistol',
        maxped = 6,
        minped = 4
    },
    hard = {
        propname = 'ba_prop_battle_crate_m_medical', -- ba_prop_battle_crate_med_bc
        weaponname = 'weapon_pistol',
        maxped = 10,
        minped = 7
    },
}

Config.HackingAnim = { 
    dict = 'anim@heists@prison_heiststation@cop_reactions',
    anim = 'cop_b_idle',
    freeze = true
}

Config.HackingCoords = { -- One Random Location will be chosen (+ RadiusBlip on Map)
    vector4(1164.8937, -1578.6326, 34.8437, 180.4212), -- / St. Fiacre Hospital 
    vector4(1184.84, -1550.02, 39.6, 180.3),
    vector4(1113.64, -1565.82, 34.89, 296.74),
    vector4(1112.01, -1518.82, 34.82, 94.91),
    vector4(1121.16, -1475.37, 34.84, 282.46),
    vector4(1128.57, -1511.94, 39.73, 180.51),
    vector4(1141.86, -1595.59, 48.15, 5.31),
    vector4(-242.01, 6339.95, 32.53, 317.44), -- / Paleto Care Center
    vector4(-236.58, 6314.58, 31.47, 142.79),
    vector4(1865.79, 3716.77, 33.07, 25.03), -- / Sandy Shores Medical Center
    vector4(1838.69, 3693.66, 34.27, 121.47),
    vector4(-1832.5, -330.97, 49.14, 132.96), -- / Ocean Medical Center
    vector4(-1862.98, -310.12, 49.15, 107.6),
    vector4(-1871.41, -299.16, 49.14, 151.71),
    vector4(-1901.94, -314.6, 49.32, 274.79),
    vector4(-1817.08, -337.02, 43.83, 139.72),
    vector4(302.25, -1429.67, 29.97, 313.04), -- / Central LS Medical Center
    vector4(382.38, -1443.12, 29.43, 48.26),
    vector4(387.55, -1441.6, 29.44, 33.43),
    vector4(408.12, -1412.47, 29.4, 49.87),
    vector4(404.31, -1401.23, 29.5, 304.8),
    vector4(349.2, -1348.33, 32.42, 325.04),
    vector4(-730.55, 315.68, 85.1, 276.85), -- / Eclipse Medical Tower
    vector4(-731.97, 306.72, 85.08, 263.69),
    vector4(-703.13, 315.58, 83.16, 76.8),
    vector4(-651.76, 298.08, 81.69, 267.93),
    vector4(-623.66, 297.02, 82.19, 106.75),
    vector4(-623.35, 306.83, 82.25, 65.19),
    vector4(-620.31, 320.51, 82.26, 179.2),
    vector4(-621.73, 322.19, 82.26, 80.55),
    vector4(-460.76, -352.54, 34.5, 167.14), -- / Mount Zonah Medical Center
    vector4(-495.9, -354.29, 34.83, 2.81),
    vector4(-374.69, -327.08, 32.3, 332.23),
    vector4(-383.17, -369.21, 31.64, 359.57),
}

Config.EnemyLocations = { --  One Random Location will be chosen
    [1] = {
        propcoords = vector4(1020.3384, -3088.1587, 5.9010, 174.8354),-- For the Prop that the Player has to steal
        peds = {
            [1] = { pedname = 's_m_m_dockwork_01', pedcoords = vector4(1028.5258, -3088.1541, 5.9010, 268.5558)}, -- Haven
            [2] = { pedname = 's_m_y_dockwork_01', pedcoords = vector4(1014.4518, -3088.1206, 5.9010, 269.2204)},
            [3] = { pedname = 'cs_floyd', pedcoords = vector4(1020.4756, -3094.2913, 5.9010, 178.5306)},
            [4] = { pedname = 's_m_y_garbage', pedcoords = vector4(1020.6971, -3079.6003, 5.9011, 357.6030)},
            [5] = { pedname = 's_m_m_gardener_01', pedcoords = vector4(1020.3227, -3071.5667, 5.9010, 75.2597)},
            [6] = { pedname = 'ig_josef', pedcoords = vector4(1019.7717, -3104.1599, 5.9010, 229.5597)}, 
            [7] = { pedname = 's_m_y_dockwork_01', pedcoords = vector4(1034.86, -3100.13, 5.9, 166.88)},
            [8] = { pedname = 'cs_floyd', pedcoords = vector4(1034.66, -3076.84, 5.9, 1.36)},
            [9] = { pedname = 's_m_y_dockwork_01', pedcoords = vector4(1048.33, -3079.5, 5.9, 353.98)},
            [10] = { pedname = 's_m_y_garbage', pedcoords = vector4(1048.28, -3096.94, 5.9, 165.83)}
        }
    },
    [2] = {
        propcoords = vector4(67.7807, 122.3321, 79.1339, 151.4554),
        peds = {
            [1] = { pedname = 'cs_casey', pedcoords = vector4(60.6152, 122.7902, 79.2074, 186.2358)}, -- GoPostal
            [2] = { pedname = 'mp_s_m_armoured_01', pedcoords = vector4(73.3031, 119.8118, 79.1833, 123.2094)},
            [3] = { pedname = 's_m_m_armoured_02', pedcoords = vector4(54.7237, 109.3735, 79.1649, 194.1402)},
            [4] = { pedname = 'csb_prolsec', pedcoords = vector4(68.2230, 105.5584, 79.1971, 107.4728)},
            [5] = { pedname = 'ig_prolsec_02', pedcoords = vector4(52.8696, 117.9050, 79.0971, 250.0484)},
            [6] = { pedname = 's_m_m_security_01', pedcoords = vector4(75.5617, 109.1718, 79.1331, 68.2805)},
            [7] = { pedname = 's_m_m_security_01', pedcoords = vector4(45.97, 95.81, 78.71, 229.82)},
            [8] = { pedname = 'csb_prolsec', pedcoords = vector4(68.2230, 105.5584, 79.1971, 107.4728)},
            [9] = { pedname = 'mp_s_m_armoured_01', pedcoors = vector4(68.77, 86.39, 78.81, 17.56)},
            [10] = { pedname = 's_m_m_security_01', pedcoors = vector4(56.64, 86.28, 78.16, 142.38)},     
        }   
    },
    [3] = {
        propcoords = vector4(1731.0537, 3310.9392, 41.2235, 188.8684),
        peds = {
            [1] = { pedname = 'ig_cletus', pedcoords = vector4(1724.9072, 3310.2043, 41.2235, 216.2237)}, -- Sandy Airport
            [2] = { pedname = 'csb_mweather', pedcoords = vector4(1737.0353, 3313.6724, 41.2235, 158.7431)},
            [3] = { pedname = 's_m_y_blackops_01', pedcoords = vector4(1742.7037, 3302.6306, 41.2235, 162.5909)},
            [4] = { pedname = 's_m_y_blackops_02', pedcoords = vector4(1727.1899, 3297.6187, 41.2235, 219.6367)},
            [5] = { pedname = 'mp_m_exarmy_01', pedcoords = vector4(1726.5182, 3288.7524, 41.1617, 232.9704)},
            [6] = { pedname = 's_m_y_armymech_01', pedcoords = vector4(1745.0753, 3294.8186, 41.1056, 157.3524)},
            [7] = { pedname = 'mp_m_exarmy_01', pedcoords = vector4(1718.11, 3290.07, 41.19, 249.6)},
            [8] = { pedname = 'ig_cletus', pedcoords = vector4(1724.9072, 3310.2043, 41.2235, 216.2237)}, -- Sandy Airport
            [9] = { pedname = 'mp_m_exarmy_01', pedcoords = vector4(1699.67, 3287.09, 48.92, 221.2)},
            [10] = { pedname = 's_m_y_blackops_02', pedcoords = vector4(1705.3, 3292.18, 48.92, 206.16)},        
        }
    },
    [4] = {
        propcoords = vector4(2135.3267, 4779.2964, 40.9703, 19.6624),
        peds = {
            [1] = { pedname = 'ig_joeminuteman', pedcoords = vector4(2140.5002, 4784.6855, 40.9703, 53.8158)}, -- Grapeseed Airport
            [2] = { pedname = 'g_m_y_korean_02', pedcoords = vector4(2130.0806, 4778.9634, 40.9703, 359.9076)},
            [3] = { pedname = 'cs_lestercrest', pedcoords = vector4(2124.7583, 4784.0923, 40.9703, 348.7881)},
            [4] = { pedname = 'csb_maude', pedcoords = vector4(2137.3735, 4790.6567, 40.9703, 60.6791)},
            [5] = { pedname = 'g_m_y_pologoon_01', pedcoords = vector4(2137.5068, 4797.0786, 41.1316, 24.5085)},
            [6] = { pedname = 'cs_ashley', pedcoords = vector4(2122.1567, 4789.8203, 41.1162, 346.2051)},
            [7] = { pedname = 'cs_lestercrest', pedcoords = vector4(2104.75, 4781.69, 41.24, 330.31)},
            [8] = { pedname = 'g_m_y_pologoon_01', pedcoords = vector4(2145.49, 4795.24, 41.13, 304.26)},
            [9] = { pedname = 'ig_joeminuteman', pedcoords = vector4(2141.78, 4806.11, 41.19, 73.87)},
            [10] = { pedname = 'csb_maude', pedcoords = vector4(2114.39, 4798.59, 41.1, 45.82)},
        }
    },
    [5] = {
        propcoords = vector4(880.19, -959.1, 27.86, 100.84), 
        peds = {
            [1] = { pedname = 'ig_joeminuteman', pedcoords = vector4(880.24, -961.8, 26.86, 96.56)}, -- industrial area
            [2] = { pedname = 'g_m_y_korean_02', pedcoords = vector4(879.46, -955.57, 26.86, 90.32)},
            [3] = { pedname = 'cs_lestercrest', pedcoords = vector4(877.95, -959.49, 25.29, 93.28)},
            [4] = { pedname = 'csb_maude', pedcoords = vector4(873.45, -963.67, 25.29, 9.84)},
            [5] = { pedname = 'g_m_y_pologoon_01', pedcoords = vector4(873.96, -965.72, 26.86, 9.01)},
            [6] = { pedname = 'cs_ashley', pedcoords = vector4(864.75, -946.72, 25.28, 291.12)},
            [7] = { pedname = 'cs_lestercrest', pedcoords = vector4(879.68, -936.89, 26.86, 60.66)},
            [8] = { pedname = 'g_m_y_pologoon_01', pedcoords = vector4(880.38, -934.24, 29.78, 69.71)},
            [9] = { pedname = 'ig_joeminuteman', pedcoords = vector4(882.89, -925.16, 25.28, 100.42)},
            [10] = { pedname = 'csb_maude', pedcoords = vector4(860.31, -926.51, 25.27, 350.11)},
        }
    },
    [6] = {
        propcoords = vector4(849.04, -2496.92, 28.33, 80.08), 
        peds = {
            [1] = { pedname = 'ig_joeminuteman', pedcoords = vector4(839.37, -2486.14, 28.78, 74.9)}, -- old oxy pickup
            [2] = { pedname = 'g_m_y_korean_02', pedcoords = vector4(858.24, -2488.64, 27.42, 357.84)},
            [3] = { pedname = 'cs_lestercrest', pedcoords = vector4(839.84, -2499.56, 27.42, 74.54)},
            [4] = { pedname = 'csb_maude', pedcoords = vector4(823.36, -2493.99, 22.99, 51.29)},
            [5] = { pedname = 'g_m_y_pologoon_01', pedcoords = vector4(828.85, -2485.18, 23.04, 75.3)},
            [6] = { pedname = 'cs_ashley', pedcoords = vector4(808.66, -2471.69, 21.41, 102.66)},
            [7] = { pedname = 'cs_lestercrest', pedcoords = vector4(859.67, -2478.0, 25.55, 279.52)},
            [8] = { pedname = 'g_m_y_pologoon_01', pedcoords = vector4(803.74, -2500.16, 27.48, 25.01)},
            [9] = { pedname = 'ig_joeminuteman', pedcoords = vector4(802.88, -2505.91, 33.21, 61.35)},
            [10] = { pedname = 'csb_maude', pedcoords = vector4(822.44, -2505.9, 35.44, 357.15)},
        }
    },
    [7] = {
        propcoords = vector4(-1172.56, -2918.57, 13.95, 324.16),
        peds = {
            [1] = { pedname = 'ig_joeminuteman', pedcoords = vector4(-1167.6, -2917.23, 13.95, 278.35)}, -- old oxy pickup
            [2] = { pedname = 'g_m_y_korean_02', pedcoords = vector4(-1168.35, -2909.21, 13.95, 324.26)},
            [3] = { pedname = 'cs_lestercrest', pedcoords = vector4(-1175.84, -2901.68, 13.95, 271.93)},
            [4] = { pedname = 'csb_maude', pedcoords = vector4(-1163.03, -2929.94, 13.94, 254.81)},
            [5] = { pedname = 'g_m_y_pologoon_01', pedcoords = vector4(-1168.97, -2936.37, 13.94, 219.17)},
            [6] = { pedname = 'cs_ashley', pedcoords = vector4(-1172.81, -2941.63, 13.94, 188.47)},
            [7] = { pedname = 'cs_lestercrest', pedcoords = vector4(-1191.25, -2939.86, 13.94, 111.51)},
            [8] = { pedname = 'g_m_y_pologoon_01', pedcoords = vector4(-1205.42, -2919.1, 13.94, 55.67)},
            [9] = { pedname = 'ig_joeminuteman', pedcoords = vector4(-1196.92, -2902.97, 13.95, 358.88)},
            [10] = { pedname = 'csb_maude', pedcoords = vector4(-1187.46, -2892.14, 13.95, 339.8)},
        }
    }
}

Translation = {
    -- ['de'] = {
    --     ['press_e'] = 'Dr�cke ~p~[E]~w~ um mit Scott Randal zu reden',
    --     ['press_e_to_hack'] = 'Dr�cke ~p~[E]~w~ um das System zu hacken',
    --     ['press_e_to_loot'] = 'Dr�cke ~p~[E]~w~ um die Ladung zu stehlen',
    --     ['need_item'] = 'Du brauchst ein Hacker Laptop',
    --     ['started_message'] = 'Ich habe einen Job f�r dich. Suche auf deinem GPS nach der makierten Zone & hacke dich ins System.',
    --     ['hack_success'] = 'Du hast den geheimen Ort gehackt. GPS �bermittlung aktiv.',
    --     ['hack_failed'] = 'Hack fehlgeschlagen',
    --     ['difficulty'] = 'Modus: ',
    --     ['server_cdactive'] = 'Servercooldown aktiv',
    --     ['heist_failed'] = 'Heist fehlgeschlagen',
    --     ['already_started'] = 'Du hast die Heist bereits gestartet',
    --     ['all_eleminated'] = 'Du hast alle Gegner eleminiert',
    --     ['blipname'] = 'Heist',
    --     ['hack_in_progress'] = 'System wird gehackt...',
    --     ['target_blip'] = 'Ziel',
    --     ['police_blipname'] = 'Meldung',
    --     ['eleminate_all'] = 'Eleminiere alle Gegner',
    --     ['loot_in_progress'] = 'Stehle Ladung...',
    --     ['received_reward'] = 'Du hast alles erbeutet',
    --     ['heist_successfull'] = 'Die heist wurde erfolgreich abgeschlossen',
    --     ['police_notify'] = 'Verd�chtige Aktivit�ten wurden gemeldet. GPS �bermittlung aktiv',
    --     ['easy'] = 'Einfach',
    --     ['normal'] = 'Normal',
    --     ['hard'] = 'Schwer',
    -- },
    ['en'] = {
        ['press_e'] = 'Press ~p~[E]~w~ to talk with Scott Randal',
        ['press_e_to_hack'] = 'Press ~p~[E]~w~ to hack the System',
        ['press_e_to_loot'] = 'Press ~p~[E]~w~ to steal',
        ['need_item'] = 'You need the medical laptop',
        ['started_message'] = 'Go to the marked Area and hack into the Medical System.',
        ['hack_success'] = 'You hacked the secret Location. GPS is set',
        ['hack_failed'] = 'Hack failed',
        ['difficulty'] = 'Type: ',
        ['server_cdactive'] = 'No shipment for the moment, come back later',
        ['heist_failed'] = 'Fail to retreive the shipment. Try it next Time',
        ['heist_canceled'] = 'The job has been canceled',
        ['already_started'] = 'You already have a shipment to retreive',
        ['all_eleminated'] = 'The area seems clear! Time to get the shipment!',
        ['blipname'] = 'Heist',
        ['hack_in_progress'] = 'Hack in Progress...',
        ['target_blip'] = 'Target Location',
        ['police_blipname'] = 'Report',
        ['eleminate_all'] = 'Kill  all Enemies',
        ['loot_in_progress'] = 'Picking up Shipment...',
        ['received_reward'] = 'You received your Reward',
        ['heist_successfull'] = 'Congrats! You got the shipment! Get it to the buyer!',
        ['police_notify'] = 'Suspicious activity were reported. Location set',
        ['easy'] = 'light Shipment',
        ['normal'] = 'Small Shipment',
        ['hard'] = 'Big Shipment',
        ['shipment'] = "Get Medical Shipment",
        ['cancel'] = "Cancel Job", 
        ['need_group'] = "Talk to me when you will be a group leader",
    }
}
