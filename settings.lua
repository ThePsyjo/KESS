-- KESS Settings

data:extend({
    {
        type = "bool-setting",
        name = "kess-enable-decay",
        setting_type = "startup",
        default_value = true,
        order = "a"
    },
    {
        type = "double-setting",
        name = "kess-decay-rate",
        setting_type = "startup",
        default_value = 0.5,
        minimum_value = 0.0,
        maximum_value = 100.0,
        order = "b"
    }
})
