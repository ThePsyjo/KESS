-- KESS Data Stage
require("prototypes.entity")
require("prototypes.item")
require("prototypes.recipe")
require("prototypes.technology")

-- Dynamically update the drain proxy based on settings
if settings.startup["kess-enable-decay"].value then
    local decay_percent = settings.startup["kess-decay-rate"].value
    local max_energy_joules = 10000000000 -- 10GJ
    local watts = (max_energy_joules * (decay_percent / 100)) / 3600

    local proxy = data.raw["electric-energy-interface"]["kess-drain-proxy"]
    if proxy then
        proxy.energy_usage = math.floor(watts) .. "W"
    end
else
    -- If disabled, set usage to 0
    local proxy = data.raw["electric-energy-interface"]["kess-drain-proxy"]
    if proxy then
        proxy.energy_usage = "0W"
    end
end
