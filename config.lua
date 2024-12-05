Config = {}

Config.Markets = {
    {
        type = "type1", --Must Be Uniqe Name!
        ped = {
            usePed = false, -- if true, use ped
            model = "mp_m_shopkeep_01",
            coords = vector3(241.67, 224.3, 106.29),
            heading = 0.0,
        },
        marker = {
            useMarker = true, -- if true, use marker
            type = 29,
            color = {r = 0, g = 255, b = 0},
            size = {x = 1.0, y = 1.0, z = 1.0},
            coords = vector3(241.67, 224.3, 106.29),
        },
        jobs = {}, -- allowed jobs for this market
        items = {
            {name = "kupfer", label = "Kupfer", price = 1000, minPrice = 200, maxPrice = 350},
        }
    },
    {
        type = "ballas",
        ped = {
            usePed = false,
            model = "mp_m_exarmy_01",
            coords = vector3(-496.44, -2811.89, 6.0),
            heading = 180.0,
        },
        marker = {
            useMarker = true,
            type = 29,
            color = {r = 102, g = 255, b = 255},
            size = {x = 1.0, y = 1.0, z = 1.0},
            coords = vector3(564.52, -1749.11, 29.32),

        },
        jobs = {"ballas"}, -- allowed jobs for this market
        items = {
            {name = "meth_baggy", label = "Meth", price = 150, minPrice = 80, maxPrice = 1050},
        }
    },
}

Config.SellShops = {
    {
        type = "type1",
        ped = {
            usePed = true,
            model = "mp_m_shopkeep_01",
            coords = vector3(1197.05, -3253.92, 6.1),
            heading = 97.71,
        },
        marker = {
            useMarker = false,
            type = 29,
            color = {r = 0, g = 255, b = 0},
            size = {x = 1.0, y = 1.0, z = 1.0},
            coords = vector3(1197.05, -3253.92, 7.1),
        },
        jobs = {}, -- allowed jobs for this market
    },
    {
        type = "ballas",
        ped = {
            usePed = true,
            model = "a_m_m_og_boss_01",
            coords = vector3(555.58, -1758.69, 32.44),
            heading = 239.22,
        },
        marker = {
            useMarker = false,
            type = 29,
            color = {r = 0, g = 255, b = 0},
            size = {x = 1.0, y = 1.0, z = 1.0},
            coords = vector3(-496.37, -2818.44, 5.97),
        },
        jobs = {"ballas"}, -- allowed jobs for this market

    },
}


Config.PriceChangeInterval = 3600000 --in milliseconds
