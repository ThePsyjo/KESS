-- Kinetic Energy Storage System (KESS) Control Logic
-- Manages shadow entities (drain proxy) for energy decay.

local function create_shadow_entities(entity)
    if not (entity and entity.valid) then return end
    
    local surface = entity.surface
    local position = entity.position
    local force = entity.force
    
    -- Create the drain proxy. It will share the electric network of any pole covering this spot.
    local proxy = surface.create_entity({
        name = "kess-drain-proxy",
        position = position,
        force = force
    })
    
    -- Link them to the main entity for easy cleanup
    storage.kess_shadows = storage.kess_shadows or {}
    storage.kess_shadows[entity.unit_number] = {
        proxy = proxy
    }
end

local function remove_shadow_entities(unit_number)
    if not storage.kess_shadows then return end
    local shadows = storage.kess_shadows[unit_number]
    if shadows then
        if shadows.proxy and shadows.proxy.valid then shadows.proxy.destroy() end
        storage.kess_shadows[unit_number] = nil
    end
end

-- Force sync all flywheels to ensure they have valid shadows
local function sync_all_shadows()
    storage.kess_shadows = storage.kess_shadows or {}
    local decay_enabled = settings.startup["kess-enable-decay"].value
    
    local current_flywheels = {}
    for _, surface in pairs(game.surfaces) do
        for _, entity in pairs(surface.find_entities_filtered({name = "kess-accumulator"})) do
            current_flywheels[entity.unit_number] = entity
        end
    end
    
    -- 1. Clean up shadows that no longer have a matching flywheel, OR if decay is disabled
    for unit_number, shadows in pairs(storage.kess_shadows) do
        if not current_flywheels[unit_number] or not decay_enabled then
            remove_shadow_entities(unit_number)
        end
    end
    
    -- 2. If decay is enabled, ensure every flywheel has valid shadows
    if decay_enabled then
        for unit_number, entity in pairs(current_flywheels) do
            local shadows = storage.kess_shadows[unit_number]
            local needs_recreate = false
            
            if not shadows or not (shadows.proxy and shadows.proxy.valid) then
                needs_recreate = true
            end
            
            if needs_recreate then
                remove_shadow_entities(unit_number)
                create_shadow_entities(entity)
            end
        end
    end
end

-- Entity created events
local function on_created(event)
    if not settings.startup["kess-enable-decay"].value then return end
    local entity = event.entity or event.created_entity
    if entity and entity.valid and entity.name == "kess-accumulator" then
        create_shadow_entities(entity)
    end
end

-- Entity removed events
local function on_removed(event)
    local entity = event.entity
    if entity and entity.valid and entity.name == "kess-accumulator" then
        remove_shadow_entities(entity.unit_number)
    end
end

-- Initialization / Migration
script.on_init(function()
    sync_all_shadows()
end)

script.on_configuration_changed(function()
    sync_all_shadows()
end)

-- Event Registration
local filters = {{filter = "name", name = "kess-accumulator"}}
script.on_event(defines.events.on_built_entity, on_created, filters)
script.on_event(defines.events.on_robot_built_entity, on_created, filters)
script.on_event(defines.events.script_raised_built, on_created, filters)
script.on_event(defines.events.script_raised_revive, on_created, filters)

script.on_event(defines.events.on_player_mined_entity, on_removed, filters)
script.on_event(defines.events.on_robot_mined_entity, on_removed, filters)
script.on_event(defines.events.on_entity_died, on_removed, filters)
script.on_event(defines.events.script_raised_destroy, on_removed, filters)
