Config = {}

Config.Markets = {
    {
        type = "legal",
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
            {name = "rubine", label = "Rubin", price = 2500, minPrice = 200, maxPrice = 350},
            {name = "erdoel", label = "Erdöl", price = 750, minPrice = 200, maxPrice = 350},
            {name = "gold", label = "Gold", price = 1500, minPrice = 200, maxPrice = 350},
            {name = "gummi", label = "Gummi", price = 300, minPrice = 200, maxPrice = 350},
            {name = "plastik", label = "Plastik", price = 400, minPrice = 200, maxPrice = 350},
            {name = "eisen", label = "Eisen", price = 1500, minPrice = 200, maxPrice = 700},
            {name = "diamond", label = "Diamanten", price = 2250, minPrice = 1500, maxPrice = 2500},
            {name = "milkbottle", label = "Milchflasche", price = 300, minPrice = 100, maxPrice = 450},
            {name = "melon", label = "Melone", price = 300, minPrice = 200, maxPrice = 400},
            {name = "pumpkin", label = "Kürbis", price = 300, minPrice = 200, maxPrice = 400},
            {name = "wheat", label = "Weizen", price = 200, minPrice = 100, maxPrice = 300},
        }
    },
    {
        type = "illegal",
        ped = {
            usePed = false, -- if true, use ped
            model = "mp_m_shopkeep_01",
            coords = vector3(241.67, 224.3, 106.29),
            heading = 0.0,
        },
        marker = {
            useMarker = true, -- if true, use marker
            type = 29,
            color = {r = 255, g = 0, b = 0},
            size = {x = 1.0, y = 1.0, z = 1.0},
            coords = vector3(1272.87, -1711.95, 54.77),
        },
        jobs = {}, -- allowed jobs for this market
        items = {
            {name = "vandiamond", label = "Diamantenbox", price = 1500, minPrice = 750, maxPrice = 1750},
            {name = "vanpanther", label = "Pantherstatue", price = 2000, minPrice = 1200, maxPrice = 2800},
            {name = "vannecklace", label = "Kette", price = 1200, minPrice = 800, maxPrice = 1600},
            {name = "vanbottle", label = "Flasche", price = 1000, minPrice = 500, maxPrice = 1300},
            {name = "vanpogo", label = "Affenstatue", price = 2000, minPrice = 1000, maxPrice = 2200},
            {name = "paintingf", label = "Bild F", price = 750, minPrice = 500, maxPrice = 1300},
            {name = "paintingg", label = "Bild G", price = 750, minPrice = 500, maxPrice = 1300},
            {name = "painting", label = "Gemälde", price = 750, minPrice = 500, maxPrice = 1300},
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
        jobs = {"ballas", "vagos"}, -- allowed jobs for this market
        items = {
            {name = "meth_baggy", label = "Meth", price = 150, minPrice = 80, maxPrice = 1050},
        }
    },
    {
        type = "shadow",
        ped = {
            usePed = false,
            model = "csb_vincent",
            coords = vector3(409.03, 4828.46, -55.0),
            heading = 193.54,
        },
        marker = {
            useMarker = true,
            type = 29,
            color = {r = 64, g = 64, b = 64},
            size = {x = 1.0, y = 1.0, z = 1.0},
            coords = vector3(408.88, 4829.41, -59.0),

        },
        jobs = {"shadow"}, -- allowed jobs for this market
        items = {
            {name = "lemonhaze_baggy", label = "Lemonhaze", price = 150, minPrice = 80, maxPrice = 1250},
            {name = "purplehaze_baggy", label = "Purplehaze", price = 150, minPrice = 80, maxPrice = 1250},
        }
    },
}

Config.SellShops = {
    {
        type = "legal",
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
        type = "illegal",
        ped = {
            usePed = true,
            model = "mp_m_exarmy_01",
            coords = vector3(-221.5, 6232.69, 30.79),
            heading = 40.96,
        },
        marker = {
            useMarker = false,
            type = 29,
            color = {r = 0, g = 255, b = 0},
            size = {x = 1.0, y = 1.0, z = 1.0},
            coords = vector3(-496.37, -2818.44, 5.97),
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
        jobs = {"ballas", "vagos"}, -- allowed jobs for this market

    },
    {
        type = "shadow",
        ped = {
            usePed = false,
            model = "a_m_m_og_boss_01",
            coords = vector3(555.58, -1758.69, 32.44),
            heading = 239.22,
        },
        marker = {
            useMarker = true,
            type = 29,
            color = {r = 64, g = 64, b = 64},
            size = {x = 1.0, y = 1.0, z = 1.0},
            coords = vector3(403.21, 4827.47, -59.0),
        },
        jobs = {"shadow"}, -- allowed jobs for this market

    },
}


Config.PriceChangeInterval = 3600000 --10000 -- 3600000 -> 1 hour in milliseconds
