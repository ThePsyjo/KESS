-- Kinetic Energy Storage System (KESS) Recipe Definition

data:extend({
    {
        type = "recipe",
        name = "kess-recipe",
        enabled = false, -- Locked behind technology
        ingredients = {
            {type = "item", name = "steel-plate", amount = 5000}, -- High resource cost reflects massive capacity
            {type = "item", name = "copper-plate", amount = 2000},
            {type = "item", name = "electric-engine-unit", amount = 100},
            {type = "item", name = "advanced-circuit", amount = 100},
            {type = "item", name = "carbon-fiber", amount = 100} -- Integration with Space Age materials
        },
        results = {{type = "item", name = "kess-item", amount = 1}},
        energy_required = 60 -- Long crafting time
    }
})
