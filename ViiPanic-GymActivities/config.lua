Config = {}

Config.EnableBlip = false
Config.MapBlip = {
    Pos     	= {x = -1203.3242,y = -1570.6184,z = 4.6115},
    Sprite  	= 311, --icon
    Display	= 4,
    Scale  	= 1.0,
    Colour  	= 26,
    Name        = 'Beach Gym',
}

Config.OneHandWeight = { 
    { x = -1209.9762, y = -1558.4160, z = 4.8379 },
    { x = -1203.2957, y = -1573.5851, z = 4.9189 },
    { x = -1198.0125, y = -1565.2007, z = 4.6202 }
}

Config.TwoHandWeight = {
    { x = -1203.0780, y = -1564.9979, z = 4.6117 },
    { x = -1210.5846, y = -1561.3026, z = 4.6080 },
    { x = -1196.7904, y = -1573.1229, z = 4.6128 },
    { x = -1198.9729, y = -1574.6727, z = 4.6097 }
}

Config.Bench = {
    [1] = {
      coords = vector3(-1207.0001, -1560.8286, 4.0178),
      entityCoords = vector3(-1206.9447, -1561.1111, 3.1063),
      heading = 218.0
    },
    [2] = {
      coords = vector3(-1200.5836, -1562.0752, 4.0097),
      entityCoords = vector3(-1200.5911, -1562.0846, 3.1063),
      heading = 126.4908
    },
    [3] = {
        coords = vector3(-1197.87, -1568.19, 4.0097), 
        entityCoords = vector3(-1198.06, -1568.32, 3.1063), 
        heading = 305.81
    }, 
    [4] = {
        coords = vector3(-1201.2, -1575.16, 4.0097), 
        entityCoords = vector3(-1201.32, -1574.97, 3.1063), 
        heading = 214.1,
    }
}

Config.Bike = {
    [1] = {
      coords = vector3(-1209.3685, -1562.9207, 4.0536),
      entityCoords = vector3(-1209.3424, -1562.9297, 4.1328),
      heading = 124.9282
    },
    [2] = {
      coords = vector3(-1208.1075, -1564.7186, 4.5407),
      entityCoords = vector3(-1208.1075, -1564.7186, 4.1328),
      heading = 123.3604
    },
    [3] = {
      coords = vector3(-1196.1495, -1570.3285, 4.1041),
      entityCoords = vector3(-1196.1278, -1570.3947, 4.1328),
      heading = 304.7292
    },
    [4] = {
      coords = vector3(-1194.8844, -1572.1680, 4.1050),
      entityCoords = vector3(-1194.8844, -1572.1680, 4.1328),
      heading = 308.8647
    },
}

Config.Chinups = {
    [1] = {
      coords = vector3(-1204.9618, -1563.9692, 4.6085),
      entityCoords = vector3(-1204.7554, -1564.3160, 3.6085),
      heading = 34.3727
    },
    [2] = {
      coords = vector3(-1199.9476, -1571.1968, 4.6096),
      entityCoords = vector3(-1199.8259, -1571.3915, 3.6085),
      heading = 34.3727
    },       
    [3] = {
        coords = vector3(-1251.18, -1604.95, 4.14),
        entityCoords = vector3(-1251.19, -1604.92, 3.14), 
        heading = 35.0,
    },
    [4] = {
        coords = vector3(-1252.29, -1603.43, 4.12), 
        entityCoords = vector3(-1252.34, -1603.27, 3.12), 
        heading = 35.0
    }, 
    [5] = {
        coords = vector3(-1253.31, -1601.89, 4.15), 
        entityCoords = vector3(-1253.38, -1601.79, 3.15), 
        heading = 35.0
    },     
}

Config.Situps = {
    [1] = {
      coords = vector3(-1204.9618, -1563.9692, 4.6085),
      entityCoords = vector3(-1201.2391, -1566.6486, 4.0158),
      heading = 218.7526
    },
    [2] = {
      coords = vector3(-1203.4559, -1567.7660, 4.0093),
      entityCoords = vector3(-1203.4559, -1567.7660, 4.0093),
      heading = 218.7526
    },
}

Config.Pushups = {
    { x = -1214.77, y = -1578.74, z = 4.15 },
}

Config.Squats = {
    { x = -1214.47, y = -1565.88, z = 4.27 },
}

Config.Yoga = {
    { x = -964.85, y = 297.05, z = 69.67 },
    { x = -501.47, y = -233.44, z = 36.35 },
    { x = -1477.87, y = -1474.1, z = 2.22 },
    { x = 1531.09, y = 6622.8, z = 2.43 },
}

Config.FinishString = '~g~Exercise finished! ~s~Take a deep breath before continuing.'
