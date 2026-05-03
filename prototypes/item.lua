-- Kinetic Energy Storage System (KESS) Item Definition

data:extend({
    {
        type = "item",
        name = "kess-item",
        icon = "__KESS__/graphics/entity/kess-entity.png",
        icon_size = 845,
        subgroup = "energy", -- Placed in the energy subgroup (Production tab)
        order = "e[accumulator]-b[kess]", -- Order within the subgroup
        place_result = "kess-accumulator",
        stack_size = 10 -- High-value machine, small stack size
    }
})
