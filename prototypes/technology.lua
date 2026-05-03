-- Kinetic Energy Storage System (KESS) Technology Definition

data:extend({
    {
        type = "technology",
        name = "kess-technology",
        icons = {
            {
                icon = "__KESS__/graphics/entity/kess-entity.png",
                icon_size = 845,
                scale = 128 / 845 -- Properly scale the large sprite for the technology tree UI
            }
        },
        effects = {
            {
                type = "unlock-recipe",
                recipe = "kess-recipe"
            }
        },
        prerequisites = {
            "electric-energy-distribution-2",
            "electric-engine",
            "carbon-fiber"
        },
        unit = {
            count = 500,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1}
            },
            time = 45
        },
        order = "e-g-c"
    }
})
