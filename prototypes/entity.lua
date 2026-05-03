-- Kinetic Energy Storage System (KESS) Entity Definition
-- A high-capacity late-game accumulator for massive energy storage.

data:extend({
    {
        type = "accumulator",
        name = "kess-accumulator",
        icon = "__KESS__/graphics/entity/kess-entity.png",
        icon_size = 845,
        flags = {"placeable-neutral", "player-creation"},
        minable = {mining_time = 0.5, result = "kess-item"},
        max_health = 2000,
        corpse = "big-remnants",
        impact_category = "metal",
        collision_box = {{-1.4, -1.4}, {1.4, 1.4}}, -- 3x3 tiles footprint
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        
        energy_source = {
            type = "electric",
            buffer_capacity = "10GJ", -- Massive 10 Gigajoule capacity
            usage_priority = "tertiary",
            input_flow_limit = "100MW",
            output_flow_limit = "100MW"
        },

        -- Factorio 2.0 consolidated graphics table
        chargable_graphics = {
            picture = {
                layers = {
                    {
                        filename = "__KESS__/graphics/entity/kess-entity.png",
                        priority = "extra-high",
                        width = 845,
                        height = 845,
                        shift = {0.1, 0}, -- Centering the sprite (offset due to shadow)
                        scale = 0.113 -- (32px * 3 tiles) / 845px
                    }
                }
            },
            -- Static placeholder for animations (single frame)
            charge_animation = {
                layers = {
                    {
                        filename = "__KESS__/graphics/entity/kess-entity.png",
                        priority = "extra-high",
                        width = 845,
                        height = 845,
                        shift = {0.1, 0},
                        scale = 0.113
                    }
                }
            },
            discharge_animation = {
                layers = {
                    {
                        filename = "__KESS__/graphics/entity/kess-entity.png",
                        priority = "extra-high",
                        width = 845,
                        height = 845,
                        shift = {0.1, 0},
                        scale = 0.113
                    }
                }
            },
            charge_animation_is_looped = true,
            discharge_animation_is_looped = true
        },

        -- Factorio 2.0 Circuit Connector (Top-mounted on the dome)
        circuit_connector = {
            sprites = {
                connector_main = {
                    filename = "__base__/graphics/entity/circuit-connector/ccm-universal-04a-base-sequence.png",
                    priority = "extra-high",
                    width = 52,
                    height = 50,
                    x = 52 * 0, -- North orientation
                    shift = {0.1, -1.0},
                    scale = 0.5
                },
                connector_shadow = {
                    filename = "__base__/graphics/entity/circuit-connector/ccm-universal-04b-base-shadow-sequence.png",
                    priority = "extra-high",
                    width = 62,
                    height = 46,
                    x = 62 * 0,
                    shift = {0.3, -0.8},
                    scale = 0.5,
                    draw_as_shadow = true
                },
                wire_pins = {
                    filename = "__base__/graphics/entity/circuit-connector/ccm-universal-04c-wire-sequence.png",
                    priority = "extra-high",
                    width = 62,
                    height = 58,
                    x = 62 * 0,
                    shift = {0.1, -1.0},
                    scale = 0.5
                },
                wire_pins_shadow = {
                    filename = "__base__/graphics/entity/circuit-connector/ccm-universal-04d-wire-shadow-sequence.png",
                    priority = "extra-high",
                    width = 70,
                    height = 54,
                    x = 70 * 0,
                    shift = {0.3, -0.8},
                    scale = 0.5,
                    draw_as_shadow = true
                },
                led_red = {
                    filename = "__base__/graphics/entity/circuit-connector/ccm-universal-04i-red-LED-sequence.png",
                    priority = "extra-high",
                    width = 44,
                    height = 46,
                    x = 44 * 0,
                    shift = {0.1, -1.0},
                    scale = 0.5
                },
                led_green = {
                    filename = "__base__/graphics/entity/circuit-connector/ccm-universal-04h-green-LED-sequence.png",
                    priority = "extra-high",
                    width = 44,
                    height = 46,
                    x = 44 * 0,
                    shift = {0.1, -1.0},
                    scale = 0.5
                },
                led_blue = {
                    filename = "__base__/graphics/entity/circuit-connector/ccm-universal-04e-blue-LED-on-sequence.png",
                    priority = "extra-high",
                    width = 44,
                    height = 46,
                    x = 44 * 0,
                    shift = {0.1, -1.0},
                    scale = 0.5
                },
                led_light = {intensity = 0.5, size = 0.9, color = {r = 1.0, g = 1.0, b = 1.0}}
            },
            points = {
                wire = {
                    red = {0.05, -0.8}, -- Fine-tuned connection points
                    green = {-0.15, -0.8}
                },
                shadow = {
                    red = {0.25, -0.6},
                    green = {0.05, -0.6}
                }
            }
        },
        circuit_wire_max_distance = 9,
        default_output_signal = {type = "virtual", name = "signal-A"}, -- Match vanilla behavior

        -- Audio configuration
        working_sound = {
            sound = {
                filename = "__base__/sound/accumulator-working.ogg",
                volume = 0.5
            },
            idle_sound = {
                filename = "__base__/sound/accumulator-idle.ogg",
                volume = 0.3
            },
            max_sounds_per_type = 3
        },
        vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65}
    }
})
