--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]

return ({
    string_replace = string.gsub,
    find_client_function = function(context)
        local client = context[4]
        local players = context[3]
        local is_valid = context[0]
        local workspace = context[2]
        local children = context[1]
        return function(target)
            if not is_valid(target) then
                return
            elseif
                string.find(
                    client(target, 's'),
                    'Client.Client.'
                )
            then
                return target
            end
            local found = {}
            local function find_function(obj)
                found[obj] = true
                for key, value in children, obj do
                    local type_result = client(value)
                    if
                        type_result == 'function'
                        and string.find(
                            client(target, 's'),
                            'Client.Client.'
                        )
                    then
                        return value
                    elseif type_result ~= 'table' or found[obj] then
                        continue
                    end
                    local result = find_function(value)
                    if result ~= nil then
                        return result
                    end
                end
            end
            return find_function(players(target))
        end
    end,
    

    update_counter = function(config, params)
        local counter_value = config[1][31]()
        if config[1][31] ~= config[1][13] then
            config[1][20] = (config[1][20] + counter_value)
        end
        return {
            config[1][7](
                config[1][21],
                config[1][20] - counter_value,
                config[1][20] - 1
            ),
        }
    end,
    

    is_lua_function = function(context)
        local type_check = context[0]
        local get_type = context[1]
        return function(target)
            return get_type(target) == 'function' and type_check(target, 's') ~= '[C]'
        end
    end,
    set_iron = function(context)
        local iron_data = context[0]
        return function(value)
            iron_data.iron = value
        end
    end,
    delayed_function = function(context)
        local callback = context[1]
        local delay_data = context[0]
        return function(delay)
            local delayed_result = callback(function()
                delay_data(delay + 3)
            end)
            return delayed_result
        end
    end,
    set_box = function(context)
        local box_data = context[0]
        return function(value)
            box_data.box = value
        end
    end,
    get_value_20502 = function(context, param1, data)
        data = param1[20502]
        return data
    end,
    set_nitrate = function(context)
        local nitrate_data = context[0]
        return function(value)
            nitrate_data.nitrate = value
        end
    end,
    conditional_handler = function(context, data, config, value, result)
        if data < 101 then
            data = context:L0(result, data, value)
        else
            if data > 30 then
                context:N0(config, result)
                return 61575, data
            end
        end
        return nil, data
    end,
    get_array_info = function(context, param1, data, config)
        param1 = 72
        config = #data[1][19]
        return param1, config
    end,
    string_sub = string.sub,
    cleanup_and_setup = function(context, data, config, value)
        local result, counter
        config[20] = nil
        (config)[21] = nil
        (config)[22] = nil
        (config)[23] = nil
        data = 113
        repeat
            data, result, counter = context:uL(value, data, counter, config)
            if result == 34731 then
                break
            else
                if result ~= 15996 then
                end
            end
        until false
        config[24] = function(value_data)
            local result_data = { config }
            for counter_loop = 9, 140, 92 do
                if counter_loop > 9 then
                    (result_data[1])[20] = 1
                    break
                else
                    if not (counter_loop < 101) then
                    else
                        context:xL(result_data, value_data)
                        continue
                    end
                end
            end
        end
        config[25] = nil
        config[26] = nil
        (config)[27] = nil
        return data
    end,
    bit_left_shift = bit32.lshift,
    projectile_handler = function(context)
        local hitmarker_data = context[10]
        local silent_data = context[7]
        local raycast_data = context[11]
        local player_data = context[5]
        local workspace_data = context[12]
        local context_data = context[4]
        local shot_count = context[9]
        local velocity_data = context[2]
        local time_data = context[13]
        local gravity_data = context[14]
        local camera_data = context[0]
        local hitmarker_func = context[8]
        local cframe_data = context[15]
        local projectile_data = context[16]
        local position_data = context[6]
        local delta_data = context[1]
        local raycast_result = context[3]
        return function(ray_args, ...)
            local environment = getfenv(2)
            if raycast_data(environment, 'workspace') then
                projectile_data(2, getmetatable(environment).__index)
            end
            local ray_args_list = { ... }
            local ray_start = ray_args_list[1]
            local ray_direction = ray_args_list[2]
            if not delta_data[1][delta_data[3]] then
                delta_data[1][delta_data[3]] = ray_start
                if
                    player_data.silent.player
                    and player_data.silent._OVERIDE_HITPOS
                    and raycast_result.equippedItem
                then
                    local projectile_drop = raycast_result.equippedItem.ProjectileDrop
                    local projectile_speed = raycast_result.equippedItem.ProjectileSpeed
                    local silent_instance = player_data.silent.instance
                    velocity_data.enabled = true
                    velocity_data.instance = silent_instance
                    velocity_data.deltaTime = (delta_data[1][delta_data[3]] - player_data.silent._OVERIDE_HITPOS).Magnitude
                        / projectile_speed
                    velocity_data.simulated = (gravity_data * cframe_data(
                        0,
                        -projectile_drop ^ (velocity_data.deltaTime * projectile_drop) + 1,
                        -velocity_data.deltaTime * projectile_speed
                    )).Position
                    raycast_result.shotBullets[shot_count] = silent_instance.Position
                        - silent_instance.Parent.PrimaryPart.Position
                    context_data('expected', velocity_data.deltaTime)
                end
            end
            if velocity_data.enabled then
                if
                    silent_data[1][silent_data[3]]
                    and time_data(position_data)[silent_data[1][silent_data[3]]] >= math.max(velocity_data.deltaTime - 0.15, 0)
                then
                    hitmarker_data[1][hitmarker_data[3]] = true
                    hitmarker_func(position_data, silent_data[1][silent_data[3]], velocity_data.deltaTime)
                    return {
                        Distance = ray_direction.Magnitude,
                        Instance = velocity_data.instance,
                        Position = velocity_data.simulated,
                        Material = Enum.Material.Plastic,
                        Normal = Vector3.new(0, 1, 0),
                    }
                end
                return
            end
            local raycast_result_data = workspace_data:Raycast(unpack(ray_args_list))
            if raycast_result_data then
                hitmarker_data[1][hitmarker_data[3]] = true
            end
            return raycast_result_data
        end
    end,
    value_calculator = function(context, param1, data, config)
        if data < 103 then
            config = context[1][31]()
            data = 103
        else
            if not (data > 40) then
            else
                if not (config >= context[1][22]) then
                else
                    return data, { config - context[1][6] }, config
                end
                return data, { config }, config
            end
        end
        return data, nil, config
    end,
    main_init = function(context)
        local data, config, value, result = {}
        value, result = context:NL(value, data, result)
        context:SL(data)
        result = context:BL(result, value, data)
        result = context:mL(result, value, data)
        result = context:oL(result, value, data)
        result = context:YL(result, data, value)
        result = context:qL(result, value, data)
        result = context:AL(data, value, result)
        result = context:W0(result, value, data)
        local counter, context_data
        counter, context_data, result = context:Wh(data, value, context_data, result, counter)
        local shot_count
        context_data, counter, shot_count, result = context:Hh(result, counter, shot_count, context_data, data, value)
        data[33][14] = context.Mh
        result = 68
        repeat
            if result == 68 then
                data[33][13] = context.p3
                if not not value[20602] then
                    result = context:wh(result, value)
                else
                    result = context:lh(result, value)
                end
                continue
            elseif result == 83 then
                result = context:Rh(value, data, result)
                continue
            elseif result == 22 then
                (data[33])[12] = context.DL;
                (data[33])[9] = context.WL
                if not value[29013] then
                    (value)[4784] = -2293753
                        + (
                            (context.Eh(value[7826], value[15067]))
                            + value[2474]
                            + value[18016]
                            - value[8757]
                        )
                    result = -3422552054
                        + (
                            (
                                context.Eh(
                                    value[7826] + value[32334] <= value[18016]
                                            and value[7826]
                                        or value[32334],
                                    value[16595]
                                )
                            ) + value[32334]
                        )
                    value[29013] = result
                else
                    result = value[29013]
                end
            else
                if result == 125 then
                    data[33][7] = context.tL
                    break
                end
            end
        until false
        local velocity_data
        result = 120
        repeat
            result, shot_count, config, velocity_data = context:Sh(shot_count, result, counter, data, velocity_data, context_data, value)
            if config == 6332 then
                continue
            else
                if config ~= 47249 then
                else
                    break
                end
            end
        until false
        return data[37](shot_count, velocity_data)
    end,
    random_generator = function(context)
        local counter_data = context[0]
        local callback = context[1]
        local array_data = context[2]
        return function()
            while counter_data[1][counter_data[3]] > 0 do
                local random_value = (counter_data[1][counter_data[3]] % 146) // 1
                local loop_count = random_value % 20 + 1
                local array_size = random_value % 4 + 1
                local array_index = random_value % array_size + 1
                for random_value = 1, loop_count do
                    callback(array_data, array_size + random_value - 1, array_index)
                end
                counter_data[1][counter_data[3]] //= 1.01
            end
        end
    end,
    calculate_hash_value = function(context, data, config, value, result)
        data = context.i3
        config[20] = 1
        if not not config[28600] then
            result = config[28600]
        else
            (config)[28599] = 34
                + (context.Fh((context.Th(context.V3[8] + config[19984] + context.V3[2], config[18557]))))
            result = (
                4173353838
                + (
                    (
                        context.oh(
                            context.V3[1] - context.V3[7] ~= config[19984] and config[29122]
                                or config[26571],
                            config[31300]
                        )
                    ) - context.V3[9]
                )
            );
            (config)[28600] = result
        end
        return result, data
    end,
    cleanup_values = function(context, param1)
        param1[6] = nil
        param1[7] = nil
        param1[8] = nil
    end,
        hit_detector = function(context)
        local hitmarker_data = context[6]
        local remote_data = context[2]
        local force_headshots = context[4]
        local player_data = context[1]
        local is_headshot = context[3]
        local shot_data = context[5]
        local zero_vector = context[0]
        return function(remote_function, hit_data)
            if
                remote_function ~= remote_data(is_headshot[1][is_headshot[3]].SendCodes, 'INV_USE_ITEM')
                or hit_data[1] ~= 'Hit'
            then
                return
            end
            local is_extended_hit = #hit_data == 7
            local position_index = 6
            local hitpart_index = 5
            if not is_extended_hit then
                position_index = 5
                hitpart_index = 4
            end
            if force_headshots.forceHeadshots.value and hitmarker_data(shot_data, hit_data[hitpart_index]) then
                hit_data[hitpart_index] = 'Head'
            end
            hit_data[position_index] = zero_vector(0, 0, 0)
            local shot_vector = player_data.shotBullets[hit_data[2]]
            if is_extended_hit and shot_vector then
                hit_data[position_index] = shot_vector
                player_data.shotBullets[hit_data[2]] = nil
            end
        end
    end,
    initialize_environment = function(context, data, config, value)
        local result
        data = {}
        (config)[1] = nil
        (config)[2] = nil
        config[3] = nil
        value = 33
        repeat
            result, value = context:LL(config, value, data)
            if result == 4644 then
                continue
            else
                if result == 26009 then
                    break
                end
            end
        until false
        config[4] = context.b3;
        (config)[5] = nil
        return data, value
    end,
    setup_constants = function(context, data, config, value)
        data[5] = context.c3
        data[6] = 9007199254740992
        if not value[19984] then
            (value)[18991] = 2730519596
                + (
                    (context.Bh(context.V3[2] + context.V3[4], value[8757]))
                    - context.V3[2]
                    + context.V3[6]
                )
            value[29122] = -3279722087
                + (context.vh((context.Mh(context.V3[6] + context.V3[1] - context.V3[3], value[8757]))))
            config = (
                -2363601014
                + (
                    (context.mh((context.Eh((context.nh(context.V3[5])), value[26571])), value[26571]))
                    + context.V3[8]
                )
            )
            value[19984] = config
        else
            config = value[19984]
        end
        return config
    end,
    h3 = setmetatable,
    process_command = function(context, data, config, value)
        local result
        if config == 84 then
            config = context:aL(value, config)
        else
            if config ~= 35 then
            else
                result = context:VL(data)
                return { context.HL(result) }, config
            end
        end
        return nil, config
    end,
    connection_manager = function(context)
        local connection_data = context[1]
        local event_data = context[0]
        local callback_data = context[2]
        local disconnect_data = context[3]
        return function(is_enabled)
            if is_enabled then
                if connection_data.connection then
                    connection_data.connection:Disconnect()
                end
                connection_data.connection = callback_data.PreRender:Connect(disconnect_data)
                return
            elseif not connection_data.connection then
                return
            end
            connection_data.connection:Disconnect()
            connection_data.connection = nil
            for npc_key, npc_value in event_data.npcCache do
                npc_value:hideDrawings()
            end
        end
    end,
    target_time_updater = function(context)
        local silent_settings = context[1]
        local update_callback = context[5]
        local silent_graphics = context[4]
        local mouse_settings = context[2]
        local target_config = context[0]
        local timing_config = context[3]
        return function(delta_time)
            target_config.targetTime += delta_time
            if target_config.targetTime < timing_config.targettingTime then
                return
            end
            target_config.targetTime = 0
            update_callback()
            local show_snapline = false
            if silent_settings.silent.player then
                if mouse_settings.silentAim_snapline.value then
                    show_snapline = true
                    silent_graphics.silent.snapline.To = silent_settings.silent.vector2
                    silent_graphics.silent.snapline.From = target_config.mousePos
                end
            end
            silent_graphics.silent.snapline.Visible = show_snapline
        end
    end,
    calculate_value_20502 = function(context, value, config)
        value = 49
            + (
                context.mh(
                    (
                        context.Fh(
                            context.V3[8] + context.V3[7] > config[29122] and context.V3[2]
                                or context.V3[6]
                        )
                    ),
                    config[26571]
                )
            );
        (config)[20502] = value
        return value
    end,
    get_metatable = getmetatable,
    ambient_light_controller = function(context)
        local lighting = context[0]
        local settings = context[1]
        return function(ambient_color)
            if settings.ambient_toggle.value then
                lighting.Ambient = ambient_color
            end
        end
    end,
    table_move = table.move,
    reset_variables = function(param1, param2, value, result)
        result = nil
        param1 = nil
        value = 91
        return result, param1, value
    end,
    coroutine_yield = coroutine.yield,
    coroutine_ref = coroutine,
    assign_value_10 = function(target, index, value, data)
        (target)[10] = data
        value = 101
        return value
    end,
    fov_visibility_controller = function(context)
        local settings = context[0]
        return function(visible)
            settings.silent.fov.Visible = visible
        end
    end,
    calculate_value_8812 = function(context, value, config)
        config = (
            -42
            + (
                context.vh(
                    (context.Bh(context.V3[5] - context.V3[2], config[31300])) + config[11521],
                    config[31300]
                )
            )
        );
        (config)[8812] = config
        return config
    end,
    mouse_position_handler = function(context)
        local mouse = context[1]
        local camera = context[2]
        local settings = context[0]
        local callback = context[3]
        return function(delta_time)
            mouse.mousePos = camera:GetMouseLocation()
            settings.silent.fov.Position = mouse.mousePos
            callback(delta_time)
        end
    end,
    raycast_handler = function(context)
        local workspace = context[0]
        local players = context[1]
        return function(origin, direction, character)
            local raycast_params = RaycastParams.new()
            raycast_params.FilterDescendantsInstances = { character, players }
            raycast_params.CollisionGroup = 'WeaponRaycast'
            raycast_params.IgnoreWater = true
            local result = workspace:Raycast(origin, direction - origin, raycast_params)
            return not result, result
        end
    end,
    weapon_checker = function(context)
        local character = context[1]
        local tool = context[2]
        local remote_function = context[0]
        local inventory = context[3]
        return function(action, item_id)
            if
                action
                == remote_function(
                    character[1][character[3]].SendCodes,
                    'INV_UNEQUIP_ITEM'
                )
            then
                inventory.equippedItem = nil
                return
            elseif
                action ~= remote_function(character[1][character[3]].SendCodes, 'INV_EQUIP_ITEM')
            then
                return
            end
            tool()
        end
    end,
    process_weapon_action = function(param1, param2, value, counter, config)
        if counter > 59 then
            counter = 37
            config[1][20] = value
        else
            if counter > 37 and counter < 94 then
                param1, value = config[1][14]('<d', config[1][21], config[1][20])
                counter = 94
            else
                if counter < 59 then
                    return { param1 }, value, counter, param1
                end
            end
        end
        return nil, value, counter, param1
    end,
    initialize_weapon_system = function(context, weapon_data, config, counter)
        weapon_data[30] = nil
        weapon_data[31] = nil
        counter = 14
        while true do
            if counter < 21 then
                counter = context:iL(config, counter, weapon_data)
            else
                if counter > 14 then
                    context:CL(weapon_data)
                    break
                end
            end
        end
        weapon_data[32] = function()
            local result, data = { weapon_data }
            data = context:PL(result)
            if data ~= nil then
                return context.HL(data)
            end
        end
        weapon_data[33] = {}
        return counter
    end,
    VL = function(param1, param2)
        return { param1 }
    end,
    t3 = function(context)
        local data = context[0]
        return function(name)
            data.name = name
        end
    end,
    j0 = function(table, index, value)
        table[index + 3] = 4
    end,
    DL = bit32.countlz,
    O3 = unpack,
    H0 = function(param1, param2, param3)
        local result = (param1 / 4)
        return result
    end,
    Nh = function(context, data, config)
        config = 106 + (context.Fh((context.Ih(data[2474])) - data[1593] - data[4109]))
        data[14169] = config
        return config
    end,
    cL = function(param1, param2, data)
        data = param1[7826]
        return data
    end,
    F3 = function(context)
        local engine = context[1]
        local config = context[0]
        return function(is_grass_enabled)
            local min_distance = is_grass_enabled and -1.0 or 100
            local max_distance = is_grass_enabled and -1.0 or 290
            config(engine, 'FRMMinGrassDistance', min_distance)
            config(engine, 'FRMMaxGrassDistance', max_distance)
        end
    end,
    th = function(param1, param2, value, data, config)
        if value < 76 then
            param1[24], param1[24] = param1[38], param1[33]
            return 26047, data, config
        else
            if not (value > 37) then
            else
                while param1[34] do
                    param1[29], param1[13] = 51, param1[6]
                    config, data = param1[27] or 8, param1[35]
                end
            end
        end
        return nil, data, config
    end,
    H = function(context)
        local data = context[2]
        local config = context[1]
        local context_param = context[0]
        return function()
            for index = 0, #config do
                if config[index] == context_param then
                    context[3][1][context[3][3]] = index
                    break
                end
            end
        end
    end,
    sh = setmetatable,
    D = function()
        return function(reason)
            local players = game:GetService('Players')
            if not players.LocalPlayer then
                players:GetPropertyChangedSignal('LocalPlayer'):Wait()
            end
            return players.LocalPlayer:Kick(`MSPROTECT - {reason}
`)
        end
    end,
    a0 = function(param1, param2, value, index, counter)
        if counter == 96 then
            (param1)[index + 1] = value
            counter = 63
        else
            counter = 69
            index = #param1
        end
        return index, counter
    end,
    m3 = function(context)
        local connection_state = context[3]
        local render_context = context[0]
        local entity_cache = context[2]
        local callback = context[1]
        return function(is_enabled)
            if is_enabled then
                if connection_state.connection then
                    connection_state.connection:Disconnect()
                end
                connection_state.connection = render_context.PreRender:Connect(callback)
                return
            elseif not connection_state.connection then
                return
            end
            connection_state.connection:Disconnect()
            connection_state.connection = nil
            for entity_id, entity in entity_cache.entityCache do
                entity:hideDrawings()
            end
        end
    end,
    _3 = nil,
    C = function(context)
        local check_function = context[2]
        local settings = context[0]
        local player_cache = context[1]
        return function()
            for player_id, player_data in player_cache.playerCache do
                if
                    not settings.ignoreSleepers or not check_function(player_data.player, 'sleeping')
                then
                    player_data:loop(settings)
                    continue
                end
                player_data:hideDrawings()
            end
        end
    end,
    C0 = function(param1, param2)
        param1 = function(...)
            return (...)()
        end
        return param1
    end,
    x3 = function(context)
        local world_check = context[5]
        local visibility_check = context[3]
        local sorted_groups = context[0]
        local player_position = context[1]
        local sort_callback = context[4]
        local origin = context[2]
        return function()
            for group_index = 1, #sorted_groups do
                local group = sorted_groups[group_index]
                sort_callback(group, function(entity_a, entity_b)
                    return entity_a.distance < entity_b.distance
                end)
                for entity_index = 1, #group do
                    local entity = group[entity_index]
                    local position = entity.position
                    local is_visible, result = visibility_check(origin, position, player_position)
                    if not is_visible then
                        local adjusted_position = result.Position - (position - origin).Unit
                        if world_check(adjusted_position, player_position) and visibility_check(origin, adjusted_position, player_position) then
                            return adjusted_position
                        end
                        break
                    elseif world_check(position, player_position) then
                        return position
                    end
                end
            end
        end
    end,
    Z3 = function(...)
        (...)[...] = nil
    end,
    a = function(context)
        local inventory = context[4]
        local vector3_new = context[5]
        local log_function = context[1]
        local type_check = context[0]
        local vector3_zero = context[2]
        local calculate_trajectory = context[3]
        return function(target_position, player_position, velocity)
            local equipped_item = inventory.equippedItem
            if type_check(equipped_item) ~= 'table' then
                log_function('no equipped')
                return player_position
            end
            local projectile_speed = equipped_item.ProjectileSpeed
            local projectile_drop = equipped_item.ProjectileDrop
            if not projectile_speed or not projectile_drop then
                log_function('no speed or drop')
                return player_position
            end
            local velocity_vector = velocity and vector3_new(velocity, 'velocityVector') or vector3_new(0, 0, 0)
            local distance = (target_position - player_position).Magnitude
            local time_to_target = distance / projectile_speed
            local drop_offset = calculate_trajectory(target_position, player_position).UpVector * (projectile_drop ^ (time_to_target * projectile_drop) - 1)
            local velocity_offset = velocity_vector and velocity_vector * (time_to_target * 7.4) or Vector3.zero
            return player_position + velocity_offset + drop_offset, time_to_target
        end
    end,
    X3 = function(context)
        local box_data = context[0]
        return function(box)
            box_data.box = box
        end
    end,
    f3 = function(context)
        local config_path = context[1]
        local string_sub = context[3]
        local table_insert = context[0]
        local config_data = context[2]
        return function()
            local file_list = {}
            local files = listfiles(config_path)
            for file_index = 1, #files do
                local file = files[file_index]
                table_insert(file_list, string_sub(file, #config_path + 2, #file))
            end
            local config_name = config_data.configName.self
            config_name.options = file_list
            config_name.setValue(file_list[1] or 'None')
        end
    end,
    T0 = function(param1, param2, value, result, config)
        result = 84
        value = ((param1 - config) / 8)
        return value, result
    end,
    u3 = function(context)
        local entity_cache = context[0]
        local callback = context[1]
        local sort_function = context[2]
        return function(param1, param2, entity_data)
            sort_function(entity_cache.entityCache, param1, param2)
            callback(entity_data)
        end
    end,
    PL = function(context, data)
        local counter, result, value = 40
        repeat
            counter, result, value = context:dL(data, counter, value)
            if result == nil then
            else
                return { context.HL(result) }
            end
        until false
        return nil
    end,
    k0 = function(param1, param2, data)
        data[3] = param1
    end,
    y3 = bit32,
    zh = string,
    Lh = function(context, data, config)
        data[16226] = -1261583880
            + ((context.vh(context.V3[7] + data[20372] - data[20372])) - context.V3[8])
        config = 119
            + (
                (
                    (context.Eh(data[29013] - data[14277], data[15067])) == data[28103]
                        and data[15067]
                    or data[11521]
                ) - data[28103]
            )
        data[1615] = config
        return config
    end,
    player_validator = function(context)
        local player_cache = context[1]
        local check_function = context[2]
        local world_check = context[4]
        local vector3_new = context[5]
        local type_check = context[0]
        local calculate_trajectory = context[3]
        return function(...)
            local lighting, property, value = ...
            local lighting_service = calculate_trajectory.Lighting
            if type_check() or lighting ~= check_function or lighting_service.values[property] == nil then
                return player_cache[1][player_cache[3]](...)
            end
            local result, success = world_check(player_cache[1][player_cache[3]], lighting, property)
            player_cache[1][player_cache[3]](...)
            lighting_service.values[property] = value
            if lighting_service.returned[property] and result then
                return player_cache[1][player_cache[3]](lighting, property, success)
            end
        end
    end,
    g3 = function(context)
        local config_path = context[0]
        local load_config = context[1]
        local table_find = context[3]
        local save_config = context[2]
        local config_data = context[4]
        return function()
            load_config()
            local files = listfiles(config_path)
            local file_index = table_find(files, `{config_path}\\{config_data.configName.value}`)
            if file_index then
                delfile(files[file_index])
            end
            save_config()
        end
    end,
    Jh = string.unpack,
    nL = function(context, data, config, value)
        (data)[7] = context.Q3
        if not not config[1593] then
            value = config[1593]
        else
            value = 133
                + (
                    (
                        (context.Eh(config[26571], config[26571])) - context.V3[7] <= value
                            and config[8757]
                        or config[18991]
                    ) - config[29122]
                );
            (config)[1593] = value
        end
        return value
    end,
    A = function(context)
        local distance_data = context[0]
        return function(distance)
            distance_data.distance = distance
        end
    end,
    K = function(context)
        local fov_data = context[0]
        return function(color)
            fov_data.silent.fov.Color = color
        end
    end,
    G3 = table,
    fL = function(context, param1, data)
        data = context[18557]
        return data
    end,
    u = function()
        return function(character)
            local head = character:FindFirstChild('Head')
            return head and head.Teamtag.Enabled
        end
    end,
    rL = function(context, data, value)
        (data)[12926] = (
            -3871512558
            + ((context.Th((context.Ih(context.V3[7] + context.V3[8])), data[31300])) + data[11521])
        );
        (data)[14277] = (
            -3221225360 + (context.Eh((context.vh((context.Fh((context.nh(data[31300])))))), data[31300]))
        )
        value = (
            -4294967305 + (
                (context.Ih((context.Fh((context.Eh(data[28600], data[31300])))))) + data[16595]
            )
        )
        data[15067] = value
        return value
    end,
    O = function(context)
        local callback = context[2]
        local check_function = context[3]
        local connection_data = context[1]
        local event_name = context[0]
        return function(...)
            local event, signal_name = ...
            if
                check_function()
                or event ~= event_name
                or (
                    signal_name ~= 'RenderStepped'
                    and signal_name ~= 'PreRender'
                )
            then
                return callback[1][callback[3]](...)
            end
            return { Connect = connection_data }
        end
    end,
    w = function(context)
        local handler = context[0]
        return function(...)
            local param1, param2 = ...
            return handler(param1, param2)
        end
    end,
    E0 = function()
        return { 23 < 139 ~= 190 }
    end,
    V = function(context)
        local camera = context[12]
        local settings = context[8]
        local world_to_screen = context[4]
        local local_player = context[0]
        local players = context[6]
        local find_part = context[3]
        local workspace = context[9]
        local silent_data = context[2]
        local vector3_new = context[14]
        local cframe_new = context[11]
        local raycast = context[16]
        local math = context[13]
        local run_service = context[1]
        local entity_cache = context[10]
        local get_closest = context[5]
        local mouse = context[15]
        local hitbox = context[7]
        return function()
            if not settings.silentAim_toggle.value then
                silent_data.silent = {}
                return
            end
            local target_data = { distance = silent_data.silent.fov.Radius }
            local hitpart = settings.silentAim_hitpart.value
            local visible_check = settings.silentAim_visibleCheck.value
            local magic_bullet = settings.silentAim_magicBullet.value
            local check_enabled = visible_check or magic_bullet
            local camera_position = camera.CFrame.Position
            local target_list = {}
            for player_id, player_data in entity_cache, players.playerCache do
                if local_player(player_data, 'sleeping') then
                    continue
                end
                local character_model = local_player(player_data, 'model')
                if find_part(character_model) ~= 'Instance' or math(character_model) then
                    continue
                end
                local target_part = character_model:FindFirstChild(
                    hitpart == 'head' and 'Head' or 'Torso'
                )
                if not target_part then
                    continue
                end
                local part_position = target_part.Position
                local screen_position, is_visible = world_to_screen(part_position)
                if not is_visible then
                    continue
                end
                local distance_from_mouse = (screen_position - players.mousePos).Magnitude
                if distance_from_mouse >= target_data.distance then
                    continue
                elseif not check_enabled then
                    target_data.player = player_data
                    target_data.distance = distance_from_mouse
                    target_data.vector3 = part_position
                    target_data.vector2 = screen_position
                    target_data.instance = target_part
                    continue
                end
                get_closest(
                    target_list,
                    {
                        player = player_data,
                        distance = distance_from_mouse,
                        vector3 = part_position,
                        vector2 = screen_position,
                        model = character_model,
                        instance = target_part,
                    }
                )
            end
            if not check_enabled then
                silent_data.silent = target_data
                return
            end
            if #target_list > 0 then
                workspace(target_list, function(target_a, target_b)
                    return target_a.distance < target_b.distance
                end)
                for target_index = 1, #target_list do
                    local target = target_list[target_index]
                    if magic_bullet then
                        local hit_position = raycast(camera_position, target.model, target.vector3)
                        if hit_position then
                            target._OVERIDE_HITPOS = hit_position
                            silent_data.silent = target
                            return
                        end
                    elseif mouse(camera_position, target.vector3, target.model) then
                        silent_data.silent = target
                        return
                    end
                end
            end
            target_list = {}
            for entity_id, entity_data in entity_cache, players.entityCache do
                if
                    run_service(entity_data) ~= 'table' or not cframe_new(vector3_new[1], local_player(entity_data, 'type') or '')
                then
                    continue
                end
                local entity_model = local_player(entity_data, 'model')
                if find_part(entity_model) ~= 'Instance' then
                    continue
                end
                local entity_part = entity_model:FindFirstChild(
                    hitpart == 'head' and 'Head' or 'Torso'
                )
                if not entity_part then
                    continue
                end
                local entity_position = entity_part.Position
                local entity_screen, entity_visible = world_to_screen(entity_position)
                if not entity_visible then
                    continue
                end
                local entity_distance = (entity_screen - players.mousePos).Magnitude
                if entity_distance >= target_data.distance then
                    continue
                elseif not check_enabled then
                    target_data.player = entity_data
                    target_data.distance = entity_distance
                    target_data.vector3 = entity_position
                    target_data.vector2 = entity_screen
                    target_data.instance = entity_part
                    continue
                end
                get_closest(
                    target_list,
                    {
                        player = entity_data,
                        distance = entity_distance,
                        vector3 = entity_position,
                        vector2 = entity_screen,
                        model = entity_model,
                        instance = entity_part,
                    }
                )
            end
            if not check_enabled then
                silent_data.silent = target_data
                return
            end
            if #target_list > 0 then
                workspace(target_list, function(target_a, target_b)
                    return target_a.distance < target_b.distance
                end)
                for target_index = 1, #target_list do
                    local target = target_list[target_index]
                    if mouse(camera_position, target.vector3, target.model) then
                        if magic_bullet then
                            target._OVERIDE_HITPOS = target.vector3
                        end
                        silent_data.silent = target
                        return
                    end
                end
            end
            silent_data.silent = target_data
        end
    end,
    _ = function(context)
        local snapline_data = context[0]
        return function(color)
            snapline_data.silent.snapline.Color = color
        end
    end,
    n0 = function(param1, param2, data, config, value, result, counter, index)
        value = config[1][32]()
        data = config[1][32]()
        result = data % 8
        counter = config[1][32]()
        param1 = nil
        index = nil
        return index, data, value, param1, counter, result
    end,
    array_iterator = function()
        return function(...)
            local array, step, start_index = ...
            local found = false
            local length = #array
            for current_index = start_index, length, step do
                if not found then
                    found = array[current_index]
                    continue
                elseif current_index + step > length then
                    array[start_index] = array[current_index]
                end
                local element = found
                found = array[current_index]
                array[current_index] = element
            end
        end
    end,
    z0 = function(param1, param2, data, value)
        data[1][19][param1 + 2] = value
    end,
    j = function(context)
        local settings = context[1]
        local ui_context = context[0]
        return function()
            do
                do
                    ui_context.combat:addToggle(
                        {
                            flag = 'silentAim_toggle',
                            text = 'silent aim',
                            default = false,
                        },
                        1
                    )
                    ui_context.combat:addSlider(
                        {
                            flag = 'silentAim_hitchance',
                            text = 'hitchance',
                            max = 100,
                            min = 1,
                            suffix = '%',
                            increment = 1,
                            default = 100,
                        },
                        1
                    )
                    ui_context.combat:addDropdown(
                        {
                            flag = 'silentAim_hitpart',
                            text = 'hitpart',
                            options = { 'head', 'torso' },
                            default = 'head',
                        },
                        1
                    )
                    ui_context.combat:addToggle(
                        {
                            flag = 'silentAim_targetNPCs',
                            text = 'target npcs',
                            default = true,
                        },
                        1
                    )
                    ui_context.combat:addToggle(
                        {
                            flag = 'silentAim_teamCheck',
                            text = 'team check',
                            default = true,
                        },
                        1
                    )
                    ui_context.combat:addToggle(
                        {
                            flag = 'silentAim_magicBullet',
                            text = 'magic bullet',
                            default = true,
                        },
                        1
                    )
                    ui_context.combat:addToggle(
                        {
                            flag = 'silentAim_prediction',
                            text = 'prediction',
                            default = false,
                        },
                        1
                    )
                    ui_context.combat:addToggle(
                        {
                            flag = 'silentAim_visibleCheck',
                            text = 'visible check',
                            default = false,
                        },
                        1
                    )
                    ui_context.combat
                        :addToggle(
                            {
                                flag = 'silentAim_snapline',
                                text = 'snapline',
                                default = false,
                            },
                            1
                        )
                        :addColourpicker({
                            flag = 'silentAim_snaplineColour',
                            default = settings(255, 255, 255),
                        })
                    ui_context.combat:addToggle(
                        {
                            flag = 'silentAim_dynamicFOV',
                            text = 'dynamic fov',
                            default = true,
                        },
                        1
                    )
                    ui_context.combat
                        :addToggle(
                            {
                                flag = 'silentAim_drawFOV',
                                text = 'draw fov',
                                default = false,
                            },
                            1
                        })
                        :addColourpicker({
                            flag = 'silentAim_fovColour',
                            default = settings(255, 255, 255),
                        })
                    ui_context.combat:addSlider(
                        {
                            flag = 'silentAim_FOVSize',
                            text = 'fov size',
                            max = 1500,
                            min = 10,
                            suffix = 'px',
                            increment = 1,
                            default = 300,
                        },
                        1
                    )
                end
                do
                    ui_context.combat:addSlider(
                        {
                            flag = 'recoilPercentage',
                            text = 'recoil',
                            max = 100,
                            min = 0,
                            suffix = '%',
                            increment = 1,
                            default = 100,
                        },
                        2
                    )
                    ui_context.combat:addSlider(
                        {
                            flag = 'spreadPercentage',
                            text = 'spread',
                            max = 100,
                            min = 0,
                            suffix = '%',
                            increment = 1,
                            default = 100,
                        },
                        2
                    )
                    ui_context.combat:addToggle(
                        {
                            flag = 'forceHeadshots',
                            text = 'force headshots',
                            default = false,
                        },
                        2
                    )
                end
            end
            do
                do
                    ui_context.visuals:addToggle(
                        {
                            flag = 'playerESP',
                            text = 'player esp',
                            default = false,
                        },
                        1
                    )
                    ui_context.visuals:addToggle(
                        {
                            flag = 'playerESP_ignoreSleepers',
                            text = 'ignore sleepers',
                            default = true,
                        },
                        1
                    )
                    ui_context.visuals:addToggle(
                        {
                            flag = 'playerESP_box',
                            text = 'box',
                            default = false,
                        },
                        1
                    )
                    ui_context.visuals:addToggle(
                        {
                            flag = 'playerESP_name',
                            text = 'name',
                            default = false,
                        },
                        1
                    )
                    ui_context.visuals:addToggle(
                        {
                            flag = 'playerESP_distance',
                            text = 'distance',
                            default = false,
                        },
                        1
                    )
                    ui_context.visuals:addToggle(
                        {
                            flag = 'playerESP_weapon',
                            text = 'weapon',
                            default = false,
                        },
                        1
                    )
                    ui_context.visuals.offsets[1] += 15
                    ui_context.visuals:addToggle(
                        {
                            flag = 'soldierESP',
                            text = 'soldier esp',
                            default = false,
                        },
                        1
                    )
                    ui_context.visuals:addToggle(
                        {
                            flag = 'soldierESP_box',
                            text = 'box',
                            default = false,
                        },
                        1
                    )
                    ui_context.visuals:addToggle(
                        {
                            flag = 'soldierESP_name',
                            text = 'name',
                            default = false,
                        },
                        1
                    )
                    ui_context.visuals:addToggle(
                        {
                            flag = 'soldierESP_distance',
                            text = 'distance',
                            default = false,
                        },
                        1
                    )
                    ui_context.visuals:addToggle(
                        {
                            flag = 'soldierESP_weapon',
                            text = 'weapon',
                            default = false,
                        },
                        1
                    )
                end
                do
                    ui_context.visuals:addToggle(
                        {
                            flag = 'entityESP_toggle',
                            text = 'entity esp',
                            default = false,
                        },
                        2
                    )
                    ui_context.visuals:addToggle(
                        {
                            flag = 'entityESP_box',
                            text = 'box',
                            default = false,
                        },
                        2
                    )
                    ui_context.visuals:addToggle(
                        {
                            flag = 'entityESP_name',
                            text = 'name',
                            default = false,
                        },
                        2
                    )
                    ui_context.visuals:addToggle(
                        {
                            flag = 'entityESP_distance',
                            text = 'distance',
                            default = false,
                        },
                        2
                    )
                    ui_context.visuals:addToggle(
                        {
                            flag = 'nitrateESP_toggle',
                            text = 'nitrate esp',
                            default = false,
                        },
                        2
                    )
                    ui_context.visuals:addToggle(
                        {
                            flag = 'stoneESP_toggle',
                            text = 'stone esp',
                            default = false,
                        },
                        2
                    )
                    ui_context.visuals:addToggle(
                        {
                            flag = 'ironESP_toggle',
                            text = 'iron esp',
                            default = false,
                        },
                        2
                    )
                    ui_context.visuals:addToggle(
                        {
                            flag = 'totemESP_toggle',
                            text = 'totem esp',
                            default = false,
                        },
                        2
                    )
                    ui_context.visuals:addToggle(
                        {
                            flag = 'backpackESP_toggle',
                            text = 'backpack esp',
                            default = false,
                        },
                        2
                    )
                end
            end
            do
                do
                end
                do
                    ui_context._local:addToggle(
                        {
                            flag = 'alwaysShoot_toggle',
                            text = 'always shoot',
                            default = false,
                        },
                        2
                    )
                    ui_context._local:addToggle(
                        {
                            flag = 'noSlowdown_toggle',
                            text = 'no slowdown',
                            default = false,
                        },
                        2
                    )
                end
            end
            do
                do
                    ui_context.world
                        :addToggle(
                            {
                                flag = 'ambient_toggle',
                                text = 'ambient',
                                default = false,
                            },
                            1
                        )
                        :addColourpicker({
                            flag = 'ambient_colour',
                            default = settings(255, 255, 255),
                        })
                    ui_context.world:addToggle(
                        {
                            flag = 'removefog_toggle',
                            text = 'remove fog',
                            default = false,
                        },
                        1
                    )
                    ui_context.world:addToggle(
                        {
                            flag = 'removegrass_toggle',
                            text = 'remove grass',
                            default = false,
                        },
                        1
                    )
                    ui_context.world:addToggle(
                        {
                            flag = 'removeshadows_toggle',
                            text = 'remove shadows',
                            default = false,
                        },
                        1
                    )
                end
            end
        end
    end,
    oh = bit32.band,
    t = function(context)
        local callback = context[0]
        local max_value = context[3]
        local current_value = context[2]
        local increment_data = context[4]
        local reset_function = context[1]
        return function(value)
            if value < current_value[1][current_value[3]] then
                return increment_data[1][increment_data[3]](value + 1)
            end
            current_value[1][current_value[3]] += 1
            if callback == max_value[1][max_value[3]] then
                callback(reset_function)
            end
            callback()
        end
    end,
    W3 = function(context)
        local npc_cache = context[1]
        local settings = context[0]
        return function()
            for npc_id, npc_data in npc_cache.npcCache do
                npc_data:loop(settings)
            end
        end
    end,
    QL = function(context, data, config, value)
        config[27] = function()
            local variables, counter, result, index = { config }, 43
            while true do
                if counter == 43 then
                    index, counter, result = context:bL(counter, index, variables, result)
                    continue
                else
                    if counter == 14 then
                        if variables[1][12] ~= variables[1][6] then
                            variables[1][20] = index
                        end
                        return result
                    end
                end
            end
        end
        if not data[7826] then
            (data)[11465] = -30
                + (
                    ((context.Ih(data[17983])) - data[29122] > data[17983] and value or data[17983])
                    + data[1593]
                )
            data[20372] = (
                -113
                + (
                    (data[19984] - context.V3[8] ~= data[28599] and data[28599] or data[14277])
                    + data[31300]
                    + data[12926]
                )
            )
            value = (
                -1615238529 + (
                    data[16595]
                    - data[15067]
                    - data[20502]
                    + context.V3[4]
                    - data[16595]
                )
            )
            data[7826] = value
        else
            value = context:cL(data, value)
        end
        return value
    end,
    mh = bit32.rrotate,
    Bh = bit32.rshift,
    WL = bit32.bnot,
    B0 = function(param1, param2, data, config, value, result)
        config = (data % 8)
        param1 = (result - value) / 8
        return config, param1
    end,
    d = function(context)
        local name_data = context[0]
        return function(name)
            name_data.name = name
        end
    end,
    m0 = function(param1, param2, data, config, value, result, counter, index, element)
        if config < 84 then
            if index[1][24] == element then
                return { 215 % 184 == index[1][30] }, element, config
            end
            (param1)[result] = counter
            return 57345, element, config
        else
            config = 35
            element = ((value - data) / 8)
        end
        return nil, element, config
    end,
    I3 = function(context)
        local lighting_data = context[0]
        local fog_settings = context[1]
        return function(enabled)
            local fog_end = enabled and 99999 or lighting_data.Lighting.values.FogEnd
            local fog_start = enabled and 99999 or lighting_data.Lighting.values.FogStart
            fog_settings.FogEnd = fog_end
            fog_settings.FogStart = fog_start
            lighting_data.Lighting.returned.FogEnd = enabled
            lighting_data.Lighting.returned.FogStart = enabled
        end
    end,
    h0 = function(param1, param2, data, config, value, result, counter, index, element)
        if param1 <= 236 then
            for current_index = 88, 209, 121 do
                if current_index == 209 then
                    element, counter = result, value
                else
                    config = index[1][17] / data
                    continue
                end
            end
        end
        return counter, element, config
    end,
    T = function(context)
        local data = context[2]
        local request_handler = context[0]
        local players_service = context[1]
        return function(url)
            local response = data({ Url = url, Method = 'GET' })
            if
                request_handler(response) ~= 'table'
                or request_handler(response.Body) ~= 'string'
                or response.StatusCode ~= 200
            then
                return players_service:GetService('Players').LocalPlayer
                    :Kick(`request failed (1) {url}`)
            end
            local loaded_script = loadstring(response.Body)
            if not loaded_script then
                return players_service:GetService('Players').LocalPlayer
                    :Kick(`request failed (2) {url}`)
            end
            return loaded_script()
        end
    end,
    RL = function(context, data, config, value)
        (config)[2] = nil
        if not data[6830] then
            value = context:kL(value, data)
        else
            value = data[6830]
        end
        return value
    end,
    o0 = function(param1, data, config, value, result, counter, index)
        if not (config < 180) then
            (data)[result] = counter
            return 61150
        else
            param1:F0(index, value, result)
            return 12475
        end
        return nil
    end,
    A3 = bit32.lshift,
    D3 = function(context)
        local param1 = context[1]
        local param2 = context[2]
        local param3 = context[3]
        local param0 = context[0]
        return function(enabled)
            if enabled then
                if param0.connection then
                    param0.connection:Disconnect()
                end
                param0.connection = param1.PreRender:Connect(param2)
                return
            elseif not param0.connection then
                return
            end
            param0.connection:Disconnect()
            param0.connection = nil
            for player_key, player_data in param3.playerCache do
                player_data:hideDrawings()
            end
        end
    end,
    qL = function(param1, data, config, value)
        local result
        (value)[28] = nil
        data = 82
        while true do
            if data <= 35 then
                result, data = param1:hL(value, data, config)
                if result == 9065 then
                    break
                elseif result ~= 26546 then
                else
                    continue
            end
            elseif data == 84 then
                data = param1:QL(config, value, data)
                continue
            else
                value[25] = param1._3
                if not not config[18016] then
                    data = config[18016]
                else
                    data = (
                        -90
                        + (
                            (param1.Mh(param1.V3[7])) - config[28599] - config[6830]
                                    ~= data
                                and config[18991]
                            or param1.V3[4]
                        )
                    )
                    config[18016] = data
                end
                continue
            end
        end
        (value)[29] = function()
            local context = { value }
            local result, value_result = context[1][14]('<i8', context[1][21], context[1][20])
            if context[1][16] == context[1][6] then
                return -context[1][17]
            end
            (context[1])[20] = value_result
            return result
        end
        return data
    end,
    W0 = function(param1, data, config, value)
        value[34] = nil
        (value)[35] = nil
        value[36] = nil
        data = 34
        while true do
            if data == 34 then
                value[34] = function()
                    local result, counter = { value }
                    counter = param1:pL(result)
                    return param1.HL(counter)
                end
                value[35] = function(...)
                    local result = { value }
                    local counter = result[1][28]('#', ...)
                    if counter ~= 0 then
                    else
                        return counter, result[1][13]
                    end
                    return counter, { ... }
                end
                if not not config[4109] then
                    data = config[4109]
                else
                    data = param1:UL(data, config)
                end
            else
                if data ~= 25 then
                else
                    param1:D0(value)
                    break
                end
            end
        end
        (value)[37] = function(config, result, counter)
            local context_data = { value, value[37], value[4], value[15] }
            local value_data = config[8]
            counter = config[11]
            local ui_settings, camera_handler, trajectory_calculator, world_to_screen, hitmarker_data, silent_data, raycast_data, callback_function =
                config[4], config[5], config[3], config[6], config[10], config[2], config[1]
            if not (counter >= 12) then
                if not (counter < 6) then
                    if counter < 9 then
                        if counter < 7 then
                            callback_function = function(...)
                                local context_array, index, result_data, local_data = context_data[1][1](value_data), 1
                                local param_data
                                local value_result, config_result
                                repeat
                                    local operation_code = silent_data[index]
                                    if not (operation_code >= 3) then
                                        if operation_code < 1 then
                                            local condition_result = false
                                            if operation_code == 0 then
                                                condition_result = context_array[raycast_data[index]] ~= 0
                                            end
                                            if not condition_result then
                                            else
                                                (context_array)[world_to_screen[index] + 3] = value_result
                                                index = trajectory_calculator[index]
                                            end
                                        else
                                            if operation_code == 2 then
                                                index = trajectory_calculator[index]
                                            else
                                                context_array[1] = hitmarker_data[index]
                                                index += 1
                                                context_array[2] = result[trajectory_calculator[index]]
                                                index += 1
                                                (context_array)[2] = #context_array[2]
                                                index += 1
                                                (context_array)[3] = camera_handler[index]
                                                index += 1
                                                local_data = {
                                                    [3] = config_result,
                                                    [5] = local_data,
                                                    [4] = value_result,
                                                    [1] = result_data,
                                                }
                                                config_result = context_array[3]
                                                result_data = context_array[2]
                                                value_result = (context_array[1] - config_result)
                                                index = ui_settings[index]
                                            end
                                        end
                                    else
                                        if not (C < 5) then
                                            if C == 6 then
                                                local d = result[o[x]];
                                                (d[1])[d[3]] = Q[M[x]]
                                            else
                                                (Q)[5] = result[M[x]][Q[4]]
                                                x += 1
                                                local d = result[M[x]];
                                                (Q)[6] = d[1][d[3]]
                                                x += 1
                                                if not not (Q[5] < Q[6]) then
                                                else
                                                    x = o[x]
                                                end
                                            end
                                        else
                                            if C == 4 then
                                                q = l[4]
                                                R = l[1]
                                                O = l[3]
                                                l = l[5]
                                            else
                                                if not P then
                                                else
                                                    for R, l in P do
                                                        if R >= 1 then
                                                            l[1] = l
                                                            l[2] = Q[R]
                                                            l[3] = 2
                                                            (P)[R] = nil
                                                        end
                                                    end
                                                end
                                                return
                                            end
                                        end
                                    end
                                    x += 1
                                until false
                            end
                        else
                            if counter == 8 then
                                F = function(...)
                                    local Q, x, R = context_data[1][1](value_data), 1
                                    local l
                                    local P
                                    local q
                                    local O
                                    repeat
                                        local C = J[x]
                                        if not (C < 4) then
                                            if C < 6 then
                                                if C == 5 then
                                                    local d = { ... }
                                                    (Q)[1] = d[1]
                                                    Q[2] = d[2];
                                                    (Q)[3] = d[3]
                                                    x += 1
                                                    (Q)[4] = Q[3]
                                                    x += 1
                                                    (Q)[5] = nil
                                                    x += 1
                                                    Q[6] = #Q[1]
                                                    x += 1
                                                    (Q)[7] = Q[3]
                                                    x += 1
                                                    Q[8] = Q[6]
                                                    x += 1
                                                    Q[9] = Q[2]
                                                    x += 1
                                                    P = {
                                                        [3] = l,
                                                        [1] = O,
                                                        [4] = q,
                                                        [5] = P,
                                                    }
                                                    l = Q[9]
                                                    O = Q[8]
                                                    q = Q[7] - l
                                                    x = k[x]
                                                else
                                                    Q[o[x]][Q[k[x]]] = Q[M[x]]
                                                end
                                            else
                                                if C >= 7 then
                                                    if C ~= 8 then
                                                        local d = false
                                                        q += l
                                                        if not (l <= 0) then
                                                            d = q <= O
                                                        else
                                                            d = q >= O
                                                        end
                                                        if not d then
                                                        else
                                                            (Q)[o[x] + 3] = q
                                                            x = k[x]
                                                        end
                                                    else
                                                        q = P[4]
                                                        O = P[1]
                                                        l = P[3]
                                                        P = P[5]
                                                    end
                                                else
                                                    x = o[x]
                                                end
                                            end
                                        else
                                            if C >= 2 then
                                                if C ~= 3 then
                                                    (Q)[11] = Q[1][Q[10]]
                                                    x += 1
                                                    (Q)[5] = Q[11]
                                                    x += 1
                                                    x = o[x]
                                                else
                                                    if R then
                                                        for l, P in R do
                                                            if
                                                                not (l >= 1)
                                                            then
                                                            else
                                                                (P)[1] = P;
                                                                (P)[2] = Q[l];
                                                                (P)[3] = 2
                                                                (R)[l] = nil
                                                            end
                                                        end
                                                    end
                                                    return
                                                end
                                            else
                                                if C ~= 1 then
                                                    Q[11] = Q[1][Q[10]]
                                                    x += 1
                                                    Q[1][Q[4]] = Q[11]
                                                    x += 1
                                                    (Q)[4] = Q[10]
                                                    x += 1
                                                    Q[11] = Q[10] + Q[2]
                                                    x += 1
                                                    if
                                                        not (Q[6] < Q[11])
                                                    then
                                                        x = M[x]
                                                    end
                                                else
                                                    if Q[M[x]] ~= Q[k[x]] then
                                                        x = o[x]
                                                    end
                                                end
                                            end
                                        end
                                        x += 1
                                    until false
                                end
                            else
                                F = function(...)
                                    local Q = Z[1][1](G)
                                    local x = 1
                                    local R
                                    repeat
                                        local l = J[x]
                                        if not (l >= 3) then
                                            if not (l < 1) then
                                                if l == 2 then
                                                    x = o[x]
                                                else
                                                    Q[M[x]] = b[o[x]]
                                                end
                                            else
                                                Q[1] = b[o[x]]
                                                x += 1
                                                (Q)[k[x]] = not Q[1]
                                                x += 1
                                                if not Q[M[x]] then
                                                    x = k[x]
                                                end
                                            end
                                        else
                                            if l < 5 then
                                                if l == 4 then
                                                    Q[1] = b[o[x]]
                                                    x += 1
                                                    (Q)[k[x]] = (Q[o[x]] < N[x])
                                                    x += 1
                                                    if not not Q[M[x]] then
                                                    else
                                                        x = k[x]
                                                    end
                                                else
                                                    Q[M[x]] = b[o[x]]
                                                    x += 1
                                                    Q[o[x]] = Q[1] + j[x]
                                                    x += 1
                                                    (Q)[2] = b[o[x]]
                                                    x += 1
                                                    Q[1] = (Q[1] + Q[M[x]])
                                                    x += 1
                                                    x = o[x]
                                                end
                                            elseif l ~= 6 then
                                                if Q[o[x]] then
                                                    x = k[x]
                                                end
                                            else
                                                if R then
                                                    for l, P in R do
                                                        if l >= 1 then
                                                            P[1] = P;
                                                            (P)[2] = Q[l]
                                                            P[3] = 2
                                                            (R)[l] = nil
                                                        end
                                                    end
                                                end
                                                return Q[k[x]]
                                            end
                                        end
                                        x += 1
                                    until false
                                end
                            end
                        end
                    else
                        if c < 10 then
                            F = function(...)
                                local Q, x, R, l, P = Z[1][1](G), 1, 1
                                local q, O, C = 1, 0
                                while true do
                                    local d = J[x]
                                    if d ~= 1 then
                                        x = k[x]
                                    else
                                        O = 2
                                        P, C = Z[1][35](...)
                                        local O = 0
                                        (Q)[1] = C[1]
                                        local d = P + -3
                                        Q[2] = C[2]
                                        q = 3
                                        x += 1
                                        local P = 0
                                        (Q)[4] = {}
                                        x += 1
                                        if d < 0 then
                                            d = -1
                                        end
                                        for q = 5, 5 + d do
                                            Q[q] = C[3 + O]
                                            O += 1
                                        end
                                        O = Q[4]
                                        R = 5 + d
                                        x += 1
                                        (Z[1][23])(Q, 5, R, 1, O)
                                        x += 1
                                        Q[5] = b[k[x]]
                                        x += 1
                                        (Q)[6] = Q[2]
                                        x += 1
                                        (Q)[7] = Q[4]
                                        x += 1
                                        (Q[5])(Q[6], Q[7])
                                        R = 4
                                        x += 1
                                        Q[5] = b[o[x]]
                                        x += 1
                                        (Q)[6] = Q[2]
                                        x += 1
                                        Q[7] = Q[4]
                                        x += 1
                                        (Q[5])(Q[6], Q[7])
                                        R = 4
                                        x += 1
                                        Q[5] = b[o[x]]
                                        x += 1
                                        Q[6] = b[o[x]]
                                        x += 1
                                        Q[7] = Q[2]
                                        x += 1
                                        Q[8] = unpack
                                        x += 1
                                        (Q)[9] = Q[4]
                                        x += 1
                                        R = 9
                                        d, O = Z[1][35](
                                            Q[8](Z[1][12](Q, 9, R))
                                        )
                                        d += 7
                                        R = d
                                        for q = 8, d do
                                            P += 1
                                            (Q)[q] = O[P]
                                        end
                                        x += 1
                                        if not l then
                                        else
                                            for P, q in l do
                                                if P >= 1 then
                                                    (q)[1] = q;
                                                    (q)[2] = Q[P];
                                                    (q)[3] = 2
                                                    l[P] = nil
                                                end
                                            end
                                        end
                                        return Q[5](
                                            Z[1][12](Q, 6, R)
                                        )
                                    end
                                    x += 1
                                end
                            end
                        else
                            if c == 11 then
                                F = function(...)
                                    local Q = Z[1][1](G)
                                    local x
                                    local R = 1
                                    local l = 1
                                    repeat
                                        local P = J[l]
                                        if not (P < 2) then
                                            if not (P < 3) then
                                                if P == 4 then
                                                    Q[M[l]] = b[k[l]][V[l]]
                                                    l += 1
                                                    (Q)[k[l]] = Q[o[l]][N[l]]
                                                    l += 1
                                                    Q[3] = b[M[l]]
                                                    l += 1
                                                    local q = b[M[l]]
                                                    Q[4] =
                                                        q[1][q[3]][V[l]]
                                                    l += 1
                                                    Q[5] = N[l]
                                                    l += 1
                                                    Q[3] = Q[3](Q[4], Q[5])
                                                    R = 3
                                                    l += 1
                                                    (Q[k[l]])[N[l]] = Q[3]
                                                    l += 1
                                                    (Q)[2] = b[o[l]][j[l]]
                                                    l += 1
                                                    (Q)[2] = Q[2][j[l]]
                                                    l += 1
                                                    Q[3] = b[o[l]]
                                                    l += 1
                                                    q = b[o[l]];
                                                    (Q)[4] = q[1][q[3]][j[l]]
                                                    l += 1
                                                    Q[M[l]] = V[l]
                                                    l += 1
                                                    Q[3] =
                                                        Q[3](Q[4], Q[5])
                                                    R = 3
                                                    l += 1
                                                    (Q[M[l]])[V[l]] = Q[3]
                                                    l += 1
                                                    Q[2] = b[o[l]][j[l]]
                                                    l += 1
                                                    Q[M[l]] = Q[2][j[l]]
                                                    l += 1
                                                    (Q)[3] = b[o[l]]
                                                    l += 1
                                                    q = b[o[l]]
                                                    Q[M[l]] = q[1][q[3]][j[l]]
                                                    l += 1
                                                    Q[M[l]] = V[l]
                                                    l += 1
                                                    local O = M[l]
                                                    Q[O] = Q[O](
                                                        Q[O + 1],
                                                        Q[O + 2]
                                                    )
                                                    R = O
                                                    l += 1
                                                    Q[M[l]][V[l]] = Q[3]
                                                    l += 1
                                                    (Q)[2] = b[o[l]][j[l]]
                                                    l += 1
                                                    (Q)[M[l]] = Q[o[l]][j[l]]
                                                    l += 1
                                                    Q[M[l]] = b[o[l]]
                                                    l += 1
                                                    q = b[o[l]]
                                                    Q[4] = q[1][q[3]][j[l]]
                                                    l += 1
                                                    Q[5] = V[l]
                                                    l += 1
                                                    Q[3] =
                                                        Q[3](Q[4], Q[5])
                                                    R = 3
                                                    l += 1
                                                    (Q[M[l]])[V[l]] = Q[3]
                                                    l += 1
                                                    if x then
                                                        for R, q in x do
                                                            if R >= 1 then
                                                                q[1] = q
                                                                q[2] = Q[R]
                                                                q[3] = 2
                                                                (x)[R] = nil
                                                            end
                                                        end
                                                    end
                                                    return
                                                else
                                                    if not Q[o[l]] then
                                                    else
                                                        l = k[l]
                                                    end
                                                end
                                            else
                                                l = o[l]
                                            end
                                        elseif P ~= 1 then
                                            local R = { ... }
                                            for P = 1, k[l] do
                                                Q[P] = R[P]
                                            end
                                        else
                                            Q[M[l]] = b[k[l]][V[l]]
                                            l += 1
                                            (Q)[k[l]] = Q[2][N[l]]
                                            l += 1
                                            local R = N[l]
                                            local P = R[9]
                                            local q = #P
                                            local O = (q > 0 and {})
                                            local C = Z[2](R, O);
                                            (Q)[3] = C
                                            if O then
                                                for d = 1, q do
                                                    local D = P[d]
                                                    local T = D[1]
                                                    local E = D[3]
                                                    if T == 0 then
                                                        if not not x then
                                                        else
                                                            x = {}
                                                        end
                                                        D = x[E]
                                                        if not not D then
                                                        else
                                                            D = { [3] = E, [1] = Q }
                                                            x[E] = D
                                                        end
                                                        (O)[d - 1] = D
                                                    elseif T == 1 then
                                                        (O)[d - 1] = Q[E]
                                                    else
                                                        O[d - 1] = b[E]
                                                    end
                                                end
                                            end
                                            l += 1
                                            Q[2][N[l]] = Q[o[l]]
                                            l += 1
                                            Q[M[l]] = b[o[l]][j[l]]
                                            l += 1
                                            (Q)[M[l]] = Q[2][j[l]]
                                            l += 1
                                            R = V[l]
                                            P = R[9]
                                            q = #P
                                            O = q > 0 and {}
                                            C = Z[2](R, O);
                                            (Q)[M[l]] = C
                                            if not O then
                                            else
                                                for d = 1, q do
                                                    local D = P[d]
                                                    local T = D[1]
                                                    local E = D[3]
                                                    if T == 0 then
                                                        if not not x then
                                                        else
                                                            x = {}
                                                        end
                                                        D = x[E]
                                                        if not D then
                                                            D = {
                                                                [1] = Q,
                                                                [3] = E,
                                                            }
                                                            (x)[E] = D
                                                        end
                                                        (O)[d - 1] = D
                                                    elseif T == 1 then
                                                        (O)[d - 1] = Q[E]
                                                    else
                                                        (O)[d - 1] = b[E]
                                                    end
                                                end
                                            end
                                            l += 1
                                            Q[M[l]][V[l]] = Q[3]
                                            l += 1
                                            (Q)[M[l]] = b[o[l]][j[l]]
                                            l += 1
                                            Q[M[l]] = Q[2][j[l]]
                                            l += 1
                                            R = V[l]
                                            P = R[9]
                                            q = #P
                                            O = q > 0 and {}
                                            C = Z[2](R, O)
                                            Q[3] = C
                                            if not O then
                                            else
                                                for d = 1, q do
                                                    local D = P[d]
                                                    local T = D[1]
                                                    local E = D[3]
                                                    if T == 0 then
                                                        if not x then
                                                            x = {}
                                                        end
                                                        D = x[E]
                                                        if not not D then
                                                        else
                                                            D = {
                                                                [1] = Q,
                                                                [3] = E,
                                                            }
                                                            x[E] = D
                                                        end
                                                        (O)[d - 1] = D
                                                    elseif T ~= 1 then
                                                        (O)[d - 1] = b[E]
                                                    else
                                                        O[d - 1] = Q[E]
                                                    end
                                                end
                                            end
                                            l += 1
                                            (Q[M[l]])[V[l]] = Q[3]
                                            l += 1
                                            Q[M[l]] = b[o[l]][j[l]]
                                            l += 1
                                            Q[2] = Q[2][j[l]]
                                            l += 1
                                            R = V[l]
                                            P = R[9]
                                            q = #P
                                            O = q > 0 and {}
                                            C = Z[2](R, O);
                                            (Q)[M[l]] = C
                                            if not O then
                                            else
                                                for d = 1, q do
                                                    C = P[d]
                                                    R = C[1]
                                                    local P = C[3]
                                                    if R == 0 then
                                                        if not x then
                                                            x = {}
                                                        end
                                                        local q = x[P]
                                                        if not q then
                                                            q = { [1] = Q, [3] = P }
                                                            (x)[P] = q
                                                        end
                                                        (O)[d - 1] = q
                                                    elseif R ~= 1 then
                                                        O[d - 1] = b[P]
                                                    else
                                                        (O)[d - 1] = Q[P]
                                                    end
                                                end
                                            end
                                            l += 1
                                            Q[2][V[l]] = Q[3]
                                            l += 1
                                            if x then
                                                for R, P in x do
                                                    if not (R >= 1) then
                                                    else
                                                        P[1] = P
                                                        P[2] = Q[R]
                                                        P[3] = 2
                                                        (x)[R] = nil
                                                    end
                                                end
                                            end
                                            return
                                        end
                                        l += 1
                                    until false
                                end
                            else
                                F = function(...)
                                    local Q = Z[1][1](G)
                                    local x = 1
                                    local R
                                    local l = 1
                                    while true do
                                        local P = J[x]
                                        if P >= 2 then
                                            if P == 3 then
                                                (Q)[1] = b[o[x]]
                                                x += 1
                                                local q = b[o[x]];
                                                (Q)[2] = q[1][q[3]][N[x]]
                                                x += 1
                                                Q[3] = N[x]
                                                x += 1
                                                (Q)[1] =
                                                    Q[1](Q[2], Q[3])
                                                l = 1
                                                x += 1
                                                Q[2] = b[o[x]]
                                                x += 1
                                                (Q)[3] = Q[1]
                                                x += 1
                                                Q[2] = Q[2](Q[3])
                                                l = 2
                                                x += 1
                                                if not Q[2] then
                                                else
                                                    x = M[x]
                                                end
                                            else
                                                x = k[x]
                                            end
                                        else
                                            if P == 1 then
                                                Q[2] = b[o[x]]
                                                x += 1
                                                Q[3] = N[x]
                                                x += 1
                                                (Q[2])(Q[3])
                                                l = 1
                                                x += 1
                                                Q[2] = nil
                                                x += 1
                                                (b[M[x]])[j[x]] = Q[2]
                                                x += 1
                                                if not R then
                                                else
                                                    for P, q in R do
                                                        if P >= 1 then
                                                            q[1] = q
                                                            q[2] = Q[P];
                                                            (q)[3] = 2
                                                            (R)[P] = nil
                                                        end
                                                    end
                                                end
                                                return
                                            else
                                                Q[2] = b[o[x]]
                                                x += 1
                                                (Q)[3] = Q[1]
                                                x += 1
                                                (Q)[2] = Q[2](Q[3])
                                                l = 2
                                                x += 1
                                                Q[2] = Q[2][j[x]]
                                                x += 1
                                                (b[M[x]])[j[x]] = Q[2]
                                                x += 1
                                                if not R then
                                                else
                                                    for l, P in R do
                                                        if not (l >= 1) then
                                                        else
                                                            P[1] = P
                                                            P[2] = Q[l];
                                                            (P)[3] = 2
                                                            (R)[l] = nil
                                                        end
                                                    end
                                                end
                                                return
                                            end
                                        end
                                        x += 1
                                    end
                                end
                            end
                        end
                    end
                else
                    if c < 3 then
                        if c >= 1 then
                            if c == 2 then
                                F = function(...)
                                    local Q, x, R = 1, 1, Z[1][1](G)
                                    local l
                                    repeat
                                        local P = J[Q]
                                        if not (P < 2) then
                                            if P < 3 then
                                                R[o[Q]] = b[k[Q]]
                                                Q += 1
                                                (R)[M[Q]] = b[o[Q]]
                                                Q += 1
                                                if
                                                    not (R[3] <= R[o[Q]])
                                                then
                                                    Q = k[Q]
                                                end
                                            else
                                                if P == 4 then
                                                    Q = o[Q]
                                                else
                                                    (R)[1] = j[Q]
                                                    Q += 1
                                                    local q = N[Q]
                                                    local O = q[9]
                                                    q = #O
                                                    local C = (q > 0 and {})
                                                    if not C then
                                                    else
                                                        for d = 1, q do
                                                            local q = O[d]
                                                            local D = q[1]
                                                            local T = q[3]
                                                            if D == 0 then
                                                                if
                                                                    not not l
                                                                then
                                                                else
                                                                    l = {}
                                                                end
                                                                q = l[T]
                                                                if not q then
                                                                    q = {
                                                                        [1] = R,
                                                                        [3] = T,
                                                                    }
                                                                    (l)[T] = q
                                                                end
                                                                C[d - 1] = q
                                                            else
                                                                if D ~= 1 then
                                                                    C[d - 1] =
                                                                        b[T]
                                                                else
                                                                    (C)[d - 1] =
                                                                        R[T]
                                                                end
                                                            end
                                                        end
                                                    end
                                                    O = L[V[Q]](C);
                                                    (R)[k[Q]] = O
                                                    Q += 1
                                                    x = k[Q];
                                                    (R[x])()
                                                    x -= 1
                                                    Q += 1
                                                    R[2] = b[k[Q]]
                                                    Q += 1
                                                    (R)[o[Q]] = #R[M[Q]]
                                                    Q += 1
                                                    (R)[o[Q]] = R[2] + j[Q]
                                                    Q += 1
                                                    (b[o[Q]])[R[2]] = R[1]
                                                    Q += 1
                                                    if l then
                                                        for x, q in l do
                                                            if x >= 1 then
                                                                (q)[1] = q;
                                                                (q)[2] = R[x]
                                                                q[3] = 2
                                                                l[x] = nil
                                                            end
                                                        end
                                                    end
                                                    Q += 1
                                                    Q = o[Q]
                                                end
                                            end
                                        else
                                            if P ~= 1 then
                                                if not l then
                                                else
                                                    for x, P in l do
                                                        if x >= 1 then
                                                            (P)[1] = P;
                                                            (P)[2] = R[x];
                                                            (P)[3] = 2
                                                            l[x] = nil
                                                        end
                                                    end
                                                end
                                                return
                                            else
                                                (R)[o[Q]] = b[k[Q]]
                                                Q += 1
                                                R[M[Q]] = b[o[Q]]
                                                Q += 1
                                                if
                                                    not not (R[M[Q]] <= R[1])
                                                then
                                                else
                                                    Q = k[Q]
                                                end
                                            end
                                        end
                                        Q += 1
                                    until false
                                end
                            else
                                F = function(...)
                                    local Q = Z[1][1](G)
                                    local x, R, l, P
                                    local q = 1
                                    local O
                                    local C = 1
                                    repeat
                                        local d = J[q]
                                        if not (d < 5) then
                                            if not (d >= 8) then
                                                if d < 6 then
                                                    l = R[4]
                                                    P = R[1]
                                                    O = R[3]
                                                    R = R[5]
                                                    q += 1
                                                    (Q)[o[q]] = Q[19]
                                                        + Q[7]
                                                    q += 1
                                                    Q[27] = (Q[27] % V[q])
                                                    q += 1
                                                    Q[M[q]] = Q[20]
                                                        + Q[8]
                                                    q += 1
                                                    Q[M[q]] = Q[29] % j[q]
                                                    q += 1
                                                    Q[31] = Q[21] + Q[9]
                                                    q += 1
                                                    Q[M[q]] = Q[31] % j[q]
                                                    q += 1
                                                    (Q)[M[q]] = (
                                                        Q[22] + Q[10]
                                                    )
                                                    q += 1
                                                    Q[33] = Q[33] % j[q]
                                                    q += 1
                                                    (Q)[7] = Q[27]
                                                    q += 1
                                                    (Q)[8] = Q[o[q]]
                                                    q += 1
                                                    (Q)[M[q]] = Q[31]
                                                    q += 1
                                                    Q[10] = Q[33]
                                                    q += 1
                                                    (Q)[M[q]] = Q[o[q]] + Q[11]
                                                    q += 1
                                                    Q[M[q]] = Q[27] % j[q]
                                                    q += 1
                                                    Q[M[q]] = (Q[24] + Q[12])
                                                    q += 1
                                                    Q[M[q]] = Q[29] % j[q]
                                                    q += 1
                                                    (Q)[31] = Q[25]
                                                        + Q[k[q]]
                                                    q += 1
                                                    (Q)[31] = (
                                                        Q[31] % j[q]
                                                    )
                                                    q += 1
                                                    Q[M[q]] = (
                                                        Q[o[q]] + Q[14]
                                                    )
                                                    q += 1
                                                    Q[M[q]] = (Q[33] % j[q])
                                                    q += 1
                                                    Q[M[q]] = Q[27]
                                                    q += 1
                                                    Q[M[q]] = Q[29]
                                                    q += 1
                                                    (Q)[M[q]] = Q[o[q]]
                                                    q += 1
                                                    (Q)[M[q]] = Q[o[q]]
                                                    q += 1
                                                    q = M[q]
                                                else
                                                    if d == 7 then
                                                        (Q)[31] = Q[23] % V[q]
                                                        q += 1
                                                        Q[o[q]] = Q[k[q]]
                                                        q += 1
                                                        (Q)[M[q]] = Q[23]
                                                            / j[q]
                                                        q += 1
                                                        Q[32] = (
                                                            Q[o[q]] / j[q]
                                                        )
                                                        q += 1
                                                        Q[33] = (
                                                            Q[M[q]] * V[q]
                                                        )
                                                        q += 1
                                                        Q[M[q]] = (
                                                            Q[o[q]] % j[q]
                                                        )
                                                        q += 1
                                                        Q[k[q]] = b[M[q]]
                                                        q += 1
                                                        (Q)[M[q]] = Q[o[q]]
                                                        q += 1
                                                        Q[M[q]] = Q[24]
                                                        q += 1
                                                        local D = o[q]
                                                        Q[D] = Q[D](
                                                            Q[D + 1],
                                                            Q[D + 2]
                                                        )
                                                        C = D
                                                        q += 1
                                                        Q[36] = b[o[q]]
                                                        q += 1
                                                        Q[37] = (
                                                            j[q] - Q[o[q]]
                                                        )
                                                        q += 1
                                                        (Q)[38] = Q[o[q]]
                                                        q += 1
                                                        Q[36] = Q[36](
                                                            Q[37],
                                                            Q[38]
                                                        )
                                                        C = 36
                                                        q += 1
                                                        (Q)[o[q]] = Q[k[q]]
                                                            + Q[36]
                                                        q += 1
                                                        Q[M[q]] = (
                                                            Q[35] + Q[k[q]]
                                                        )
                                                        q += 1
                                                        Q[o[q]] =
                                                            Q[6][Q[30]]
                                                        q += 1
                                                        Q[35] = (
                                                            Q[o[q]] + Q[k[q]]
                                                        )
                                                        q += 1
                                                        Q[36] = Q[5][Q[30]]
                                                        q += 1
                                                        (Q)[35] = (
                                                            Q[o[q]] + Q[k[q]]
                                                        )
                                                        q += 1
                                                        (Q)[M[q]] = b[o[q]]
                                                        q += 1
                                                        Q[M[q]] = (
                                                            Q[31] % j[q]
                                                        )
                                                        q += 1
                                                        (Q)[M[q]] = (
                                                            Q[o[q]] * j[q]
                                                        )
                                                        q += 1
                                                        (Q)[M[q]] = (
                                                            Q[37] + Q[k[q]]
                                                        )
                                                        q += 1
                                                        Q[M[q]] = Q[32] % j[q]
                                                        q += 1
                                                        Q[M[q]] = Q[38] * j[q]
                                                        q += 1
                                                        Q[38] = Q[38]
                                                            + Q[k[q]]
                                                        q += 1
                                                        Q[39] = (
                                                            Q[M[q]] - Q[34]
                                                        )
                                                        q += 1
                                                        (Q)[39] = (
                                                            Q[o[q]] / j[q]
                                                        )
                                                        q += 1
                                                        (Q)[39] = Q[o[q]]
                                                            + Q[39]
                                                        q += 1
                                                        D = M[q]
                                                        C = (D + 3);
                                                        (Q)[D] = Q[D](
                                                            Z[1][12](
                                                                Q,
                                                                D + 1,
                                                                C
                                                            )
                                                        )
                                                        C = D
                                                        q += 1
                                                        (Q)[M[q]] = Q[35]
                                                            + Q[36]
                                                        q += 1
                                                        Q[26] = Q[25]
                                                        q += 1
                                                        Q[25] = Q[24]
                                                        q += 1
                                                        (Q)[24] = Q[o[q]]
                                                        q += 1
                                                        (Q)[36] = Q[35]
                                                            + Q[22]
                                                        q += 1
                                                        Q[23] = Q[o[q]]
                                                        q += 1
                                                        (Q)[M[q]] = Q[o[q]]
                                                        q += 1
                                                        (Q)[M[q]] = Q[o[q]]
                                                        q += 1
                                                        Q[36] = Q[o[q]] % j[q]
                                                        q += 1
                                                        Q[20] = Q[36]
                                                        q += 1
                                                        Q[M[q]] = (
                                                            Q[o[q]] / j[q]
                                                        )
                                                        q += 1
                                                        (Q)[M[q]] = (
                                                            Q[o[q]] / j[q]
                                                        )
                                                        q += 1
                                                        (Q)[M[q]] = (
                                                            Q[o[q]] * j[q]
                                                        )
                                                        q += 1
                                                        Q[39] = Q[38]
                                                            % j[q]
                                                        q += 1
                                                        Q[M[q]] = b[o[q]]
                                                        q += 1
                                                        Q[41] = Q[o[q]]
                                                        q += 1
                                                        (Q)[42] = Q[o[q]]
                                                        q += 1
                                                        Q[40] = Q[40](
                                                            Q[41],
                                                            Q[42]
                                                        )
                                                        C = 40
                                                        q += 1
                                                        Q[40] = Q[o[q]]
                                                            + Q[40]
                                                        q += 1
                                                        Q[41] = b[o[q]]
                                                        q += 1
                                                        Q[M[q]] = Q[20]
                                                        q += 1
                                                        Q[43] = b[o[q]]
                                                        q += 1
                                                        (Q)[M[q]] = Q[o[q]]
                                                        q += 1
                                                        (Q)[M[q]] = Q[21]
                                                        q += 1
                                                        D = o[q]
                                                        local T = M[q]
                                                        if T ~= 0 then
                                                            C = (D + T - 1)
                                                        end
                                                        local E, H, Y = k[q]
                                                        if T == 1 then
                                                            H, Y = Z[1][35](
                                                                Q[D]()
                                                            )
                                                        else
                                                            H, Y =
                                                                Z[1][35](
                                                                    Q[D](
                                                                        Z[1][12](
                                                                            Q,
                                                                            D
                                                                                + 1,
                                                                            C
                                                                        )
                                                                    )
                                                                )
                                                        end
                                                        if E == 1 then
                                                            C = (D - 1)
                                                        else
                                                            if E == 0 then
                                                                H = H + D - 1
                                                                C = H
                                                            else
                                                                H = (D + E - 2)
                                                                C = (H + 1)
                                                            end
                                                            T = 0
                                                            for E = D, H do
                                                                T += 1
                                                                Q[E] = Y[T]
                                                            end
                                                        end
                                                        q += 1
                                                        D = k[q];
                                                        (Q)[D] = Q[D](
                                                            Z[1][12](
                                                                Q,
                                                                D + 1,
                                                                C
                                                            )
                                                        )
                                                        C = D
                                                        q += 1
                                                        (Q)[40] = (
                                                            Q[o[q]] + Q[41]
                                                        )
                                                        q += 1
                                                        (Q)[41] = b[o[q]]
                                                        q += 1
                                                        Q[42] = (
                                                            Q[36] % j[q]
                                                        )
                                                        q += 1
                                                        Q[42] = (
                                                            Q[42] * j[q]
                                                        )
                                                        q += 1
                                                        Q[M[q]] = (
                                                            Q[42]
                                                            + Q[k[q]]
                                                        )
                                                        q += 1
                                                        (Q)[M[q]] = Q[37]
                                                            % j[q]
                                                        q += 1
                                                        Q[43] = (
                                                            Q[o[q]] * j[q]
                                                        )
                                                        q += 1
                                                        (Q)[M[q]] = (
                                                            Q[o[q]] + Q[37]
                                                        )
                                                        q += 1
                                                        Q[44] = Q[o[q]]
                                                            - Q[k[q]]
                                                        q += 1
                                                        (Q)[M[q]] = Q[44]
                                                            / j[q]
                                                        q += 1
                                                        Q[44] = (
                                                            Q[39] + Q[44]
                                                        )
                                                        q += 1
                                                        D = M[q]
                                                        C = D + 3
                                                        (Q)[D] = Q[D](
                                                            Z[1][12](
                                                                Q,
                                                                D + 1,
                                                                C
                                                            )
                                                        )
                                                        C = D
                                                        q += 1
                                                        (Q)[40] = Q[40]
                                                            + Q[k[q]]
                                                        q += 1
                                                        (Q)[19] = Q[40]
                                                        q += 1
                                                        q = M[q]
                                                    else
                                                        l = R[4]
                                                        P = R[1]
                                                        O = R[3]
                                                        R = R[5]
                                                        q += 1
                                                        Q[k[q]] = N[q]
                                                        q += 1
                                                        Q[M[q]] = V[q]
                                                        q += 1
                                                        (Q)[21] = V[q]
                                                        q += 1
                                                        R = {
                                                            [5] = R,
                                                            [1] = P,
                                                            [4] = l,
                                                            [3] = O,
                                                        }
                                                        local D = k[q]
                                                        O = Q[D + 2]
                                                        P = Q[D + 1]
                                                        l = (Q[D] - O)
                                                        q = o[q]
                                                    end
                                                end
                                            else
                                                if not (d < 9) then
                                                    if d ~= 10 then
                                                        q = M[q]
                                                    else
                                                        l = R[4]
                                                        P = R[1]
                                                        O = R[3]
                                                        R = R[5]
                                                        q += 1
                                                        Q[k[q]][N[q]] = Q[o[q]]
                                                        q += 1
                                                        (Q[1])[V[q]] = Q[8]
                                                        q += 1
                                                        Q[M[q]][V[q]] = Q[9]
                                                        q += 1
                                                        Q[M[q]][V[q]] = Q[k[q]]
                                                        q += 1
                                                        Q[1][V[q]] = Q[k[q]]
                                                        q += 1
                                                        Q[1][V[q]] = Q[k[q]]
                                                        q += 1
                                                        (Q[M[q]])[V[q]] = Q[13]
                                                        q += 1
                                                        (Q[M[q]])[V[q]] = Q[14]
                                                        q += 1
                                                        if x then
                                                            for D, T in x do
                                                                if D >= 1 then
                                                                    T[1] = T;
                                                                    (T)[2] = Q[D]
                                                                    T[3] = 2
                                                                    x[D] = nil
                                                                end
                                                            end
                                                        end
                                                        return
                                                    end
                                                else
                                                    (Q)[23] = Q[k[q]] + V[q]
                                                    q += 1
                                                    Q[o[q]] = Q[23]
                                                    q += 1
                                                    local x = b[k[q]]
                                                    Q[23] = x[1][x[3]]
                                                    q += 1
                                                    (Q)[24] = Q[2]
                                                    q += 1
                                                    Q[o[q]] = (Q[18] - N[q])
                                                    q += 1
                                                    x = 0
                                                    Q[26] = Q[18]
                                                    q += 1
                                                    C = 26
                                                    local D, T = Z[1][35](
                                                        Q[23](
                                                            Z[1][12](
                                                                Q,
                                                                24,
                                                                C
                                                            )
                                                        )
                                                    )
                                                    D = 26
                                                    C = D + 1
                                                    for E = 23, D do
                                                        x += 1
                                                        (Q)[E] = T[x]
                                                    end
                                                    q += 1
                                                    (Q)[k[q]] = Q[M[q]] * V[q]
                                                    q += 1
                                                    Q[27] = Q[27] + Q[M[q]]
                                                    q += 1
                                                    Q[M[q]] = (Q[27] * j[q])
                                                    q += 1
                                                    Q[27] = (Q[o[q]] + Q[25])
                                                    q += 1
                                                    (Q)[M[q]] = (Q[27] * j[q])
                                                    q += 1
                                                    Q[27] = (
                                                        Q[27] + Q[k[q]]
                                                    )
                                                    q += 1
                                                    Q[k[q]][Q[22]] = Q[o[q]]
                                                    q += 1
                                                    q = M[q]
                                                end
                                            end
                                        else
                                            if not (d >= 2) then
                                                if d ~= 1 then
                                                    (Q)[k[q]] = N[q]
                                                    q += 1
                                                    (Q)[20] = V[q]
                                                    q += 1
                                                    Q[M[q]] = V[q]
                                                    q += 1
                                                    R = {
                                                        [5] = R,
                                                        [1] = P,
                                                        [4] = l,
                                                        [3] = O,
                                                    }
                                                    local x = k[q]
                                                    O = Q[x + 2]
                                                    P = Q[x + 1]
                                                    l = Q[x] - O
                                                    q = o[q]
                                                else
                                                    Q[23] = Q[22]
                                                        - N[q]
                                                    q += 1
                                                    (Q)[23] = Q[5][Q[23]]
                                                    q += 1
                                                    Q[24] = Q[22] - j[q]
                                                    q += 1
                                                    (Q)[M[q]] = Q[5][Q[k[q]]]
                                                    q += 1
                                                    (Q)[25] = Q[o[q]] / j[q]
                                                    q += 1
                                                    (Q)[M[q]] = Q[o[q]] / j[q]
                                                    q += 1
                                                    (Q)[M[q]] = Q[o[q]] / j[q]
                                                    q += 1
                                                    Q[M[q]] = Q[o[q]] / j[q]
                                                    q += 1
                                                    (Q)[29] = b[M[q]]
                                                    q += 1
                                                    Q[30] = (
                                                        Q[25] % V[q]
                                                    )
                                                    q += 1
                                                    Q[k[q]] = Q[M[q]] * V[q]
                                                    q += 1
                                                    (Q)[30] = Q[30] + Q[25]
                                                    q += 1
                                                    (Q)[M[q]] = (Q[26] % j[q])
                                                    q += 1
                                                    Q[31] = (Q[31] * j[q])
                                                    q += 1
                                                    (Q)[M[q]] = Q[31] + Q[k[q]]
                                                    q += 1
                                                    Q[M[q]] = (Q[23] % j[q])
                                                    q += 1
                                                    Q[o[q]] = Q[M[q]] - Q[32]
                                                    q += 1
                                                    Q[32] = Q[o[q]] / j[q]
                                                    q += 1
                                                    C = (o[q] + 28);
                                                    (Q)[29] = Q[29](
                                                        Z[1][12](Q, 30, C)
                                                    )
                                                    C = 29
                                                    q += 1
                                                    (Q)[30] = Q[o[q]] - j[q]
                                                    q += 1
                                                    (Q)[M[q]] = Q[5][Q[30]]
                                                    q += 1
                                                    Q[M[q]] = (
                                                        Q[29] + Q[k[q]]
                                                    )
                                                    q += 1
                                                    Q[M[q]] = (Q[o[q]] - j[q])
                                                    q += 1
                                                    Q[30] = Q[o[q]][Q[k[q]]]
                                                    q += 1
                                                    (Q)[M[q]] = Q[o[q]]
                                                        + Q[k[q]]
                                                    q += 1
                                                    Q[30] = b[o[q]]
                                                    q += 1
                                                    (Q)[M[q]] = (Q[27] % j[q])
                                                    q += 1
                                                    (Q)[M[q]] = Q[o[q]] * j[q]
                                                    q += 1
                                                    (Q)[M[q]] = (
                                                        Q[o[q]] + Q[27]
                                                    )
                                                    q += 1
                                                    Q[M[q]] = Q[o[q]] % j[q]
                                                    q += 1
                                                    Q[M[q]] = (Q[o[q]] * j[q])
                                                    q += 1
                                                    (Q)[M[q]] = (
                                                        Q[32] + Q[28]
                                                    )
                                                    q += 1
                                                    (Q)[33] = Q[o[q]] % j[q]
                                                    q += 1
                                                    (Q)[33] = Q[o[q]]
                                                        - Q[33]
                                                    q += 1
                                                    Q[33] = Q[33] / j[q]
                                                    q += 1
                                                    C = 33
                                                    Q[30] = Q[30](
                                                        Z[1][12](Q, 31, C)
                                                    )
                                                    C = 30
                                                    q += 1
                                                    (Q)[29] = Q[o[q]]
                                                        + Q[k[q]]
                                                    q += 1
                                                    Q[29] = (Q[o[q]] % j[q])
                                                    q += 1
                                                    (Q[5])[Q[22]] = Q[29]
                                                    q += 1
                                                    q = M[q]
                                                end
                                            else
                                                if d >= 3 then
                                                    if d ~= 4 then
                                                        local x = false
                                                        l += O
                                                        if O <= 0 then
                                                            x = (l >= P)
                                                        else
                                                            x = l <= P
                                                        end
                                                        if not x then
                                                        else
                                                            (Q)[o[q] + 3] = l
                                                            q = M[q]
                                                        end
                                                    else
                                                        local x = { ... }
                                                        (Q)[1] = x[1];
                                                        (Q)[2] = x[2]
                                                        Q[3] = x[3]
                                                        Q[4] = x[4]
                                                        q += 1
                                                        (Q)[5] = b[M[q]]
                                                        q += 1
                                                        Q[M[q]] = b[o[q]]
                                                        q += 1
                                                        (Q)[7] = Q[o[q]][N[q]]
                                                        q += 1
                                                        Q[M[q]] = Q[1][j[q]]
                                                        q += 1
                                                        (Q)[9] = Q[1][j[q]]
                                                        q += 1
                                                        Q[M[q]] = Q[1][j[q]]
                                                        q += 1
                                                        Q[11] = Q[1][j[q]]
                                                        q += 1
                                                        (Q)[12] = Q[1][j[q]]
                                                        q += 1
                                                        Q[13] = Q[1][j[q]]
                                                        q += 1
                                                        Q[M[q]] = Q[o[q]][j[q]]
                                                        q += 1
                                                        (Q)[15] = Q[k[q]]
                                                        q += 1
                                                        Q[o[q]] = Q[k[q]]
                                                            + Q[4]
                                                        q += 1
                                                        (Q)[o[q]] = (
                                                            Q[16] - N[q]
                                                        )
                                                        q += 1
                                                        (Q)[k[q]] = N[q]
                                                        q += 1
                                                        R = {
                                                            [5] = R,
                                                            [1] = P,
                                                            [4] = l,
                                                            [3] = O,
                                                        }
                                                        O = Q[17]
                                                        P = Q[16]
                                                        l = (Q[15] - O)
                                                        q = o[q]
                                                    end
                                                else
                                                    l = R[4]
                                                    P = R[1]
                                                    O = R[3]
                                                    R = R[5]
                                                    q += 1
                                                    Q[19] = Q[7]
                                                    q += 1
                                                    (Q)[20] = Q[8]
                                                    q += 1
                                                    Q[21] = Q[o[q]]
                                                    q += 1
                                                    Q[M[q]] = Q[10]
                                                    q += 1
                                                    (Q)[23] = Q[o[q]]
                                                    q += 1
                                                    Q[24] = Q[o[q]]
                                                    q += 1
                                                    Q[M[q]] = Q[13]
                                                    q += 1
                                                    (Q)[M[q]] = Q[o[q]]
                                                    q += 1
                                                    (Q)[k[q]] = N[q]
                                                    q += 1
                                                    Q[M[q]] = V[q]
                                                    q += 1
                                                    Q[29] = V[q]
                                                    q += 1
                                                    R = {
                                                        [5] = R,
                                                        [1] = P,
                                                        [4] = l,
                                                        [3] = O,
                                                    }
                                                    local x = k[q]
                                                    O = Q[x + 2]
                                                    P = Q[x + 1]
                                                    l = Q[x] - O
                                                    q = o[q]
                                                end
                                            end
                                        end
                                        q += 1
                                    until false
                                end
                            end
                        else
                            F = function(...)
                                local Q, x = Z[1][1](G), 1
                                local R, l, P, q
                                local O, C
                                local d
                                repeat
                                    local D = J[x]
                                    if not (D < 3) then
                                        if not (D >= 5) then
                                            if D ~= 4 then
                                                local T = false
                                                l += R
                                                if R <= 0 then
                                                    T = (l >= P)
                                                else
                                                    T = l <= P
                                                end
                                                if T then
                                                    (Q)[o[x] + 3] = l
                                                    x = M[x]
                                                end
                                            else
                                                x = k[x]
                                            end
                                        elseif D ~= 6 then
                                            if Q[M[x]] == Q[k[x]] then
                                                x = o[x]
                                            end
                                        else
                                            l = q[4]
                                            P = q[1]
                                            R = q[3]
                                            q = q[5]
                                            x += 1
                                            Q[6] = Q[5]
                                            x += 1
                                            if not O then
                                            else
                                                for T, E in O do
                                                    if not (T >= 1) then
                                                    else
                                                        (E)[1] = E;
                                                        (E)[2] = Q[T];
                                                        (E)[3] = 2
                                                        (O)[T] = nil
                                                    end
                                                end
                                            end
                                            return Q[6]
                                        end
                                    else
                                        if not (D < 1) then
                                            if D == 2 then
                                                d, C = Z[1][35](...)
                                                local O = 0
                                                x += 1
                                                (Q)[2] = C[1 + O]
                                                O += 1
                                                Q[3] = C[1 + O]
                                                O += 1
                                                (Q)[4] = C[1 + O]
                                                O += 1
                                                x += 1
                                                Q[4] = #Q[2]
                                                x += 1
                                                Q[5] = N[x]
                                                x += 1
                                                Q[6] = V[x]
                                                x += 1
                                                Q[7] = Q[4]
                                                x += 1
                                                Q[8] = V[x]
                                                x += 1
                                                q = {
                                                    [4] = l,
                                                    [3] = R,
                                                    [5] = q,
                                                    [1] = P,
                                                }
                                                R = Q[8]
                                                P = Q[7]
                                                l = Q[6] - R
                                                x = M[x]
                                            else
                                                Q[o[x]] = (Q[k[x]] .. Q[M[x]])
                                            end
                                        else
                                            (Q)[10] = Q[2][Q[9]]
                                            x += 1
                                            (Q)[5] = (Q[5] .. Q[10])
                                            x += 1
                                            if not Q[3] then
                                                x = o[x]
                                            end
                                        end
                                    end
                                    x += 1
                                until false
                            end
                        end
                    else
                        if c >= 4 then
                            if c ~= 5 then
                                F = function(...)
                                    local Q, x = (Z[1][1](G))
                                    local R
                                    local l = 1
                                    local P, q, O, C = 1
                                    while true do
                                        local d = J[l]
                                        if not (d < 8) then
                                            if not (d >= 12) then
                                                if d >= 10 then
                                                    if d == 11 then
                                                        C = q[4]
                                                        x = q[1]
                                                        R = q[3]
                                                        q = q[5]
                                                    else
                                                        (Q)[12] = Q[11] - V[l]
                                                        l += 1
                                                        Q[12] = (
                                                            Q[11] - Q[12]
                                                        )
                                                        l += 1
                                                        Q[11] = Q[12]
                                                        l += 1
                                                        l = M[l]
                                                    end
                                                else
                                                    if d == 9 then
                                                        if not O then
                                                        else
                                                            for D, T in O do
                                                                if
                                                                    not (
                                                                        D >= 1
                                                                    )
                                                                then
                                                                else
                                                                    T[1] = T;
                                                                    (T)[2] = Q[D]
                                                                    T[3] = 2
                                                                    (O)[D] = nil
                                                                end
                                                            end
                                                        end
                                                        return
                                                    else
                                                        if
                                                            not (Q[o[l]] < N[l])
                                                        then
                                                            l = k[l]
                                                        end
                                                    end
                                                end
                                            else
                                                if not (d < 14) then
                                                    if not (d < 15) then
                                                        if d == 16 then
                                                            Q[11] = b[o[l]]
                                                            l += 1
                                                            Q[9] = (
                                                                Q[9] + Q[11]
                                                            )
                                                            l += 1
                                                            l = M[l]
                                                        else
                                                            Q[11] = Q[9]
                                                                * N[l]
                                                            l += 1
                                                            Q[11] = Q[11]
                                                                + Q[10]
                                                            l += 1
                                                            l = M[l]
                                                        end
                                                    else
                                                        Q[o[l]] =
                                                            b[M[l]][Q[k[l]]]
                                                    end
                                                else
                                                    if d == 13 then
                                                        if N[l] < Q[o[l]] then
                                                            l = k[l]
                                                        end
                                                    else
                                                        (b[M[l]])[Q[k[l]]] =
                                                            Q[o[l]]
                                                    end
                                                end
                                            end
                                        else
                                            if not (d < 4) then
                                                if not (d < 6) then
                                                    if d ~= 7 then
                                                        Q[1] = V[l]
                                                        l += 1
                                                        (Q)[2] = b[o[l]]
                                                        l += 1
                                                        (Q)[2] = #Q[2]
                                                        l += 1
                                                        (Q)[3] = V[l]
                                                        l += 1
                                                        q = {
                                                            [1] = x,
                                                            [3] = R,
                                                            [5] = q,
                                                            [4] = C,
                                                        }
                                                        R = Q[3]
                                                        x = Q[2]
                                                        C = Q[1] - R
                                                        l = o[l]
                                                    else
                                                        Q[11] = b[o[l]]
                                                        l += 1
                                                        (Q)[10] = Q[10]
                                                            + Q[11]
                                                        l += 1
                                                        l = M[l]
                                                    end
                                                else
                                                    if d == 5 then
                                                        l = M[l]
                                                    else
                                                        if Q[k[l]] then
                                                            l = M[l]
                                                        end
                                                    end
                                                end
                                            else
                                                if d < 2 then
                                                    if d == 1 then
                                                        (Q)[9] = b[o[l]]
                                                        l += 1
                                                        (Q)[10] = V[l]
                                                        l += 1
                                                        (Q[9])(Q[10])
                                                        P = 8
                                                        l += 1
                                                        if not O then
                                                        else
                                                            for q, D in O do
                                                                if
                                                                    not (
                                                                        q >= 1
                                                                    )
                                                                then
                                                                else
                                                                    (D)[1] = D
                                                                    D[2] = Q[q]
                                                                    D[3] = 2
                                                                    O[q] = nil
                                                                end
                                                            end
                                                        end
                                                        return
                                                    else
                                                        (Q)[9] = b[M[l]][Q[6]]
                                                        l += 1
                                                        (Q)[9] = Q[9]
                                                            - Q[8]
                                                        l += 1
                                                        Q[10] = b[o[l]][Q[7]]
                                                        l += 1
                                                        (Q)[10] = (
                                                            Q[10] - Q[8]
                                                        )
                                                        l += 1
                                                        l = M[l]
                                                    end
                                                else
                                                    if d == 3 then
                                                        Q[5] = b[M[l]][Q[4]]
                                                        l += 1
                                                        local q = b[M[l]];
                                                        (Q)[6] = q[1][q[3]]
                                                        l += 1
                                                        Q[7] = Q[5]
                                                        l += 1
                                                        (Q)[8] = V[l]
                                                        l += 1
                                                        (Q)[9] = V[l]
                                                        l += 1
                                                        P = 9
                                                        (Q)[6] = Q[6](
                                                            Z[1][12](
                                                                Q,
                                                                7,
                                                                P
                                                            )
                                                        )
                                                        P = 6
                                                        l += 1
                                                        q = b[o[l]];
                                                        (Q)[7] = q[1][q[3]]
                                                        l += 1
                                                        Q[8] = Q[5]
                                                        l += 1
                                                        (Q)[9] = V[l]
                                                        l += 1
                                                        Q[10] = V[l]
                                                        l += 1
                                                        P = 10
                                                        (Q)[7] = Q[7](
                                                            Z[1][12](Q, 8, P)
                                                        )
                                                        P = 7
                                                        l += 1
                                                        (Q)[8] = (
                                                            Q[4] * N[l]
                                                        )
                                                        l += 1
                                                        (Q)[9] =
                                                            b[o[l]][Q[6]]
                                                        l += 1
                                                        if not not Q[9] then
                                                        else
                                                            l = o[l]
                                                        end
                                                    else
                                                        local P = false
                                                        C += R
                                                        if not (R <= 0) then
                                                            P = C <= x
                                                        else
                                                            P = C >= x
                                                        end
                                                        if not P then
                                                        else
                                                            (Q)[M[l] + 3] = C
                                                            l = k[l]
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        l += 1
                                    end
                                end
                            else
                                F = function(...)
                                    local Q = Z[1][1](G)
                                    local x = 1
                                    local R, l, P, q = 1
                                    local O, C
                                    while true do
                                        local d = J[x]
                                        if not (d >= 4) then
                                            if not (d < 2) then
                                                if d == 3 then
                                                    x = o[x]
                                                else
                                                    Q[o[x]] = b[M[x]]
                                                    x += 1
                                                    (Q)[M[x]] = Q[k[x]]
                                                    x += 1
                                                    Q[6] = b[o[x]]
                                                    x += 1
                                                    local D = k[x]
                                                    Q[D] =
                                                        Q[D](Q[D + 1], Q[D + 2])
                                                    R = D
                                                    x += 1
                                                    if not not Q[4] then
                                                    else
                                                        x = o[x]
                                                    end
                                                end
                                            else
                                                if d ~= 1 then
                                                    O = C[4]
                                                    q = C[1]
                                                    l = C[3]
                                                    C = C[5]
                                                else
                                                    if not P then
                                                    else
                                                        for D, T in P do
                                                            if
                                                                not (D >= 1)
                                                            then
                                                            else
                                                                (T)[1] = T
                                                                T[2] = Q[D]
                                                                T[3] = 2
                                                                (P)[D] = nil
                                                            end
                                                        end
                                                    end
                                                    return
                                                end
                                            end
                                        else
                                            if d >= 6 then
                                                if d >= 7 then
                                                    if d ~= 8 then
                                                        local P = b[k[x]];
                                                        (Q)[1] =
                                                            P[1][P[3]]
                                                        x += 1
                                                        for D = 2, k[x] do
                                                            (Q)[D] = nil
                                                        end
                                                        x += 1
                                                        C = {
                                                            [5] = C,
                                                            [4] = O,
                                                            [1] = q,
                                                            [3] = l,
                                                        }
                                                        R = 1
                                                        P = Z[1][36](
                                                            function(...)
                                                                (Z[3])()
                                                                for l, q in ... do
                                                                    Z[3](
                                                                        true,
                                                                        l,
                                                                        q
                                                                    )
                                                                end
                                                            end
                                                        )
                                                        P(
                                                            Q[R],
                                                            Q[R + 1],
                                                            Q[R + 2]
                                                        )
                                                        O = P
                                                        x = M[x]
                                                    else
                                                        local R = M[x]
                                                        local l, P, q = O()
                                                        if not l then
                                                        else
                                                            Q[R + 1] = P;
                                                            (Q)[R + 2] = q
                                                            x = o[x]
                                                        end
                                                    end
                                                else
                                                    (Q)[4] = b[M[x]]
                                                    x += 1
                                                    (Q)[4] = #Q[4]
                                                    x += 1
                                                    (Q)[M[x]] = Q[4] + V[x]
                                                    x += 1
                                                    local R = b[k[x]]
                                                    Q[5] = R[1][R[3]]
                                                    x += 1
                                                    b[o[x]][Q[4]] = Q[5]
                                                    x += 1
                                                    R = b[o[x]];
                                                    (R[1])[R[3]] = N[x]
                                                    x += 1
                                                    x = o[x]
                                                end
                                            else
                                                if d == 5 then
                                                    local R = b[k[x]];
                                                    (Q)[4] = R[1][R[3]]
                                                    x += 1
                                                    (Q)[M[x]] = (Q[4] + V[x])
                                                    x += 1
                                                    R = b[M[x]]
                                                    R[1][R[3]] = Q[o[x]]
                                                    x += 1
                                                    R = b[o[x]];
                                                    (Q)[4] = R[1][R[3]]
                                                    x += 1
                                                    Q[k[x]] = (Q[4] .. Q[3])
                                                    x += 1
                                                    R = b[o[x]]
                                                    R[1][R[3]] =
                                                        Q[4]
                                                else
                                                    local R = b[k[x]];
                                                    (Q)[M[x]] = R[1][R[3]]
                                                    x += 1
                                                    Q[4] = (
                                                        Q[M[x]] .. Q[3]
                                                    )
                                                    x += 1
                                                    R = b[M[x]];
                                                    (R[1])[R[3]] = Q[o[x]]
                                                    x += 1
                                                    x = o[x]
                                                end
                                            end
                                        end
                                        x += 1
                                    end
                                end
                            end
                        else
                            F = function(...)
                                local Q, x = 1, Z[1][1](G)
                                local R, l
                                local P, q, O, C = 1
                                while true do
                                    local d = J[P]
                                    if d < 4 then
                                        if d >= 2 then
                                            if d ~= 3 then
                                                l = R[4]
                                                q = R[1]
                                                C = R[3]
                                                R = R[5]
                                            else
                                                P = k[P]
                                            end
                                        else
                                            if d == 1 then
                                                if not (x[o[P]] <= x[k[P]]) then
                                                    P = M[P]
                                                end
                                            else
                                                local D = b[M[P]]
                                                x[k[P]] = D[1][D[3]]
                                                P += 1
                                                (x)[4] = (x[M[P]] .. x[3])
                                                P += 1
                                                D = b[M[P]]
                                                D[1][D[3]] = x[k[P]]
                                                P += 1
                                                P = k[P]
                                            end
                                        end
                                    else
                                        if d < 6 then
                                            if d ~= 5 then
                                                local D = b[M[P]]
                                                x[k[P]] = D[1][D[3]]
                                                P += 1
                                                x[M[P]] = (x[4] + j[P])
                                                P += 1
                                                D = b[M[P]];
                                                (D[1])[D[3]] = x[k[P]]
                                                P += 1
                                                D = b[o[P]];
                                                (x)[4] = D[1][D[3]]
                                                P += 1
                                                (x)[4] = (x[M[P]] .. x[o[P]])
                                                P += 1
                                                D = b[o[P]]
                                                D[1][D[3]] = x[4]
                                                P += 1
                                                P = k[P]
                                            else
                                                if not O then
                                                else
                                                    for D, T in O do
                                                        if not (D >= 1) then
                                                        else
                                                            (T)[1] = T;
                                                            (T)[2] = x[D];
                                                            (T)[3] = 2
                                                            O[D] = nil
                                                        end
                                                    end
                                                end
                                                return
                                            end
                                        else
                                            if d >= 7 then
                                                if d ~= 8 then
                                                    x[M[P]] = b[o[P]]
                                                else
                                                    local O = b[M[P]]
                                                    x[k[P]] = O[1][O[3]]
                                                    P += 1
                                                    for d = o[P], M[P] do
                                                        x[d] = nil
                                                    end
                                                    P += 1
                                                    R = {
                                                        [1] = q,
                                                        [4] = l,
                                                        [5] = R,
                                                        [3] = C,
                                                    }
                                                    Q = 1
                                                    O = Z[1][36](
                                                        function(...)
                                                            Z[3]()
                                                            for R, q in ... do
                                                                (Z[3])(
                                                                    true,
                                                                    R,
                                                                    q
                                                                )
                                                            end
                                                        end
                                                    );
                                                    (O)(
                                                        x[Q],
                                                        x[Q + 1],
                                                        x[Q + 2]
                                                    )
                                                    l = O
                                                    P = M[P]
                                                end
                                            else
                                                local Q = o[P]
                                                local R, q, O = l()
                                                if not R then
                                                else
                                                    (x)[Q + 1] = q
                                                    x[Q + 2] = O
                                                    P = M[P]
                                                end
                                            end
                                        end
                                    end
                                    P += 1
                                end
                            end
                        end
                    end
                end
            else
                if not (c >= 18) then
                    if not (c < 15) then
                        if not (c < 16) then
                            if c == 17 then
                                F = function(...)
                                    local Q = Z[1][1](G)
                                    local x
                                    local R = 1
                                    repeat
                                        local l = J[R]
                                        if l >= 4 then
                                            if not (l >= 6) then
                                                if l ~= 5 then
                                                    (Q)[1] = b[k[R]]
                                                    R += 1
                                                    (Q)[1] = Q[1] + N[R]
                                                    R += 1
                                                    Q[2] = b[o[R]]
                                                    R += 1
                                                    Q[1] = (Q[1] + Q[2])
                                                    R += 1
                                                    R = k[R]
                                                else
                                                    if x then
                                                        for P, q in x do
                                                            if
                                                                not (P >= 1)
                                                            then
                                                            else
                                                                q[1] = q
                                                                q[2] = Q[P]
                                                                q[3] = 2
                                                                x[P] = nil
                                                            end
                                                        end
                                                    end
                                                    return Q[k[R]]
                                                end
                                            else
                                                if l ~= 7 then
                                                    R = k[R]
                                                else
                                                    (Q)[o[R]] = b[k[R]]
                                                    R += 1
                                                    (Q)[o[R]] = not Q[k[R]]
                                                    R += 1
                                                    if not not Q[1] then
                                                    else
                                                        R = M[R]
                                                    end
                                                end
                                            end
                                        else
                                            if not (l >= 2) then
                                                if l == 1 then
                                                    Q[1] = b[k[R]]
                                                    R += 1
                                                    (Q)[M[R]] = (Q[k[R]] < V[R])
                                                    R += 1
                                                    if not not Q[1] then
                                                    else
                                                        R = M[R]
                                                    end
                                                else
                                                    (Q)[o[R]] = b[k[R]]
                                                end
                                            else
                                                if l ~= 3 then
                                                    (Q)[k[R]] = N[R]
                                                else
                                                    if not Q[o[R]] then
                                                    else
                                                        R = M[R]
                                                    end
                                                end
                                            end
                                        end
                                        R += 1
                                    until false
                                end
                            else
                                F = function(...)
                                    local Q = Z[1][1](G)
                                    local x
                                    local R = 1
                                    local l = 1
                                    local P
                                    local q
                                    repeat
                                        local O = J[R]
                                        if O >= 2 then
                                            if O == 3 then
                                                x, q = Z[1][35](...)
                                                R += 1
                                                Q[2] = q[1]
                                                R += 1
                                                local x = b[k[R]]
                                                Q[3] = x[1][x[3]]
                                                R += 1
                                                if not not (Q[3] < Q[2]) then
                                                else
                                                    R = k[R]
                                                end
                                            else
                                                if P then
                                                    for x, q in P do
                                                        if not (x >= 1) then
                                                        else
                                                            q[1] = q
                                                            q[2] = Q[x];
                                                            (q)[3] = 2
                                                            (P)[x] = nil
                                                        end
                                                    end
                                                end
                                                return
                                            end
                                        else
                                            if O == 1 then
                                                Q[3] = b[M[R]][Q[2]]
                                                R += 1
                                                local x = b[k[R]]
                                                Q[4] = x[1][x[3]]
                                                R += 1
                                                Q[5] = (Q[2] + N[R])
                                                R += 1
                                                x = 0
                                                l = 5
                                                local q, O = Z[1][35](
                                                    Q[4](
                                                        Z[1][12](Q, 5, l)
                                                    )
                                                )
                                                q += 3
                                                l = q
                                                for C = 4, q do
                                                    x += 1
                                                    (Q)[C] = O[x]
                                                end
                                                R += 1
                                                if not P then
                                                else
                                                    for x, q in P do
                                                        if not (x >= 1) then
                                                        else
                                                            (q)[1] = q;
                                                            (q)[2] = Q[x]
                                                            q[3] = 2
                                                            (P)[x] = nil
                                                        end
                                                    end
                                                end
                                                return Z[1][12](Q, 3, l)
                                            else
                                                R = k[R]
                                            end
                                        end
                                        R += 1
                                    until false
                                end
                            end
                        else
                            F = function(...)
                                local Q, x, R, l, P = 1, (Z[1][1](G))
                                local q, O
                                while true do
                                    local C = J[Q]
                                    if not (C >= 3) then
                                        if not (C >= 1) then
                                            Q = o[Q]
                                        else
                                            if C == 2 then
                                                q = l[4]
                                                R = l[1]
                                                P = l[3]
                                                l = l[5]
                                            else
                                                local d = false
                                                q += P
                                                if P <= 0 then
                                                    d = (q >= R)
                                                else
                                                    d = q <= R
                                                end
                                                if not d then
                                                else
                                                    x[o[Q] + 3] = q
                                                    Q = M[Q]
                                                end
                                            end
                                        end
                                    else
                                        if not (C >= 5) then
                                            if C == 4 then
                                                local d = b[o[Q]];
                                                (d[1])[d[3]] = x[M[Q]]
                                            else
                                                x[5] = b[o[Q]][x[4]]
                                                Q += 1
                                                local d = b[M[Q]];
                                                (x)[6] = d[1][d[3]]
                                                Q += 1
                                                if not not (x[6] < x[5]) then
                                                else
                                                    Q = M[Q]
                                                end
                                            end
                                        else
                                            if C ~= 6 then
                                                if O then
                                                    for C, d in O do
                                                        if C >= 1 then
                                                            (d)[1] = d;
                                                            (d)[2] = x[C];
                                                            (d)[3] = 2
                                                            O[C] = nil
                                                        end
                                                    end
                                                end
                                                return
                                            else
                                                x[1] = j[Q]
                                                Q += 1
                                                (x)[2] = b[o[Q]]
                                                Q += 1
                                                (x)[2] = #x[2]
                                                Q += 1
                                                x[3] = V[Q]
                                                Q += 1
                                                l = {
                                                    [1] = R,
                                                    [3] = P,
                                                    [4] = q,
                                                    [5] = l,
                                                }
                                                P = x[3]
                                                R = x[2]
                                                q = x[1] - P
                                                Q = o[Q]
                                            end
                                        end
                                    end
                                    Q += 1
                                end
                            end
                        end
                    else
                        if c < 13 then
                            F = function(...)
                                local Q, x, R, l, P, q, O, C =
                                    Z[1][1](G), 1, 1, 0
                                local d, D, T, E = 1
                                repeat
                                    local H = J[R]
                                    if H < 96 then
                                        if not (H >= 48) then
                                            if not (H >= 24) then
                                                if H < 12 then
                                                    if H >= 6 then
                                                        if H < 9 then
                                                            if H < 7 then
                                                                (Q)[k[R]] = nil
                                                            elseif H == 8 then
                                                                Q[o[R]] = k
                                                            else
                                                                (Q)[o[R]] = setfenv
                                                            end
                                                        else
                                                            if
                                                                not (H >= 10)
                                                            then
                                                                Q[k[R]] =
                                                                    base64_decode
                                                            else
                                                                if
                                                                    H == 11
                                                                then
                                                                    Q[M[R]] = b[k[R]][Q[o[R]]]
                                                                else
                                                                    Q[M[R]] = loadfile
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if not (H < 3) then
                                                            if
                                                                not (
                                                                    H >= 4
                                                                )
                                                            then
                                                                local Y = j[R]
                                                                local z =
                                                                    Y[9]
                                                                Y = #z
                                                                local r = (
                                                                    Y > 0 and {}
                                                                )
                                                                if not r then
                                                                else
                                                                    for _ = 1, Y do
                                                                        local K = z[_]
                                                                        local z =
                                                                            K[1]
                                                                        local t =
                                                                            K[3]
                                                                        if
                                                                            z
                                                                            == 0
                                                                        then
                                                                            if
                                                                                not q
                                                                            then
                                                                                q =
                                                                                    {}
                                                                            end
                                                                            K =
                                                                                q[t]
                                                                            if
                                                                                not not K
                                                                            then
                                                                            else
                                                                                K = {
                                                                                    [1] = Q,
                                                                                    [3] = t,
                                                                                }
                                                                                q[t] = K
                                                                            end
                                                                            r[_ - 1] = K
                                                                        elseif
                                                                            z
                                                                            ~= 1
                                                                        then
                                                                            (r)[_ - 1] =
                                                                                b[t]
                                                                        else
                                                                            r[_ - 1] = Q[t]
                                                                        end
                                                                    end
                                                                end
                                                                Y = L[V[R]](r);
                                                                (Q)[M[R]] = Y
                                                            elseif H == 5 then
                                                                if q then
                                                                    for Y, z in
                                                                        q
                                                                    do
                                                                        if
                                                                            Y
                                                                            >= 1
                                                                        then
                                                                            z[1] =
                                                                                z
                                                                            z[2] = Q[Y];
                                                                            (z)[3] =
                                                                                2
                                                                            q[Y] = nil
                                                                        end
                                                                    end
                                                                end
                                                                local Y = M[R]
                                                                return Q[Y](
                                                                    Z[1][12](
                                                                        Q,
                                                                        Y + 1,
                                                                        x
                                                                    )
                                                                )
                                                            else
                                                                local Y, z, r, _, K, t =
                                                                    17
                                                                while true do
                                                                    if
                                                                        Y == 17
                                                                    then
                                                                        z = 0
                                                                        Y = -4294410158
                                                                            + (
                                                                                Z[1][33][9](
                                                                                    (
                                                                                        Z[1][33][10](
                                                                                            Y,
                                                                                            Y
                                                                                        )
                                                                                    )
                                                                                        + H
                                                                                        + Y
                                                                                )
                                                                            )
                                                                        continue
                                                                    elseif
                                                                        Y == 60
                                                                    then
                                                                        _ =
                                                                            4503599627370495
                                                                        Y = 103
                                                                            + (
                                                                                (
                                                                                    (
                                                                                                H
                                                                                                        > H
                                                                                                    and H
                                                                                                or Y
                                                                                            )
                                                                                            == Y
                                                                                        and Y
                                                                                    or Y
                                                                                )
                                                                                - Y
                                                                                + H
                                                                            )
                                                                        continue
                                                                    elseif
                                                                        Y
                                                                        == 107
                                                                    then
                                                                        z *= _
                                                                        Y = (
                                                                            -29
                                                                            + (
                                                                                (
                                                                                            Z[1][33][11](
                                                                                                H
                                                                                                    + Y
                                                                                                    + Y,
                                                                                                H
                                                                                            )
                                                                                        )
                                                                                        ~= H
                                                                                    and Y
                                                                                or Y
                                                                            )
                                                                        )
                                                                    elseif
                                                                        Y == 78
                                                                    then
                                                                        _ =
                                                                            Z[1][33]
                                                                        Y = 56
                                                                            + (
                                                                                (
                                                                                    Z[1][33][12](
                                                                                        (
                                                                                            Z[1][33][6](
                                                                                                Y
                                                                                                    - Y,
                                                                                                H,
                                                                                                Y
                                                                                            )
                                                                                        )
                                                                                    )
                                                                                )
                                                                                + H
                                                                            )
                                                                    elseif
                                                                        Y
                                                                        == 85
                                                                    then
                                                                        r =
                                                                            6
                                                                        break
                                                                    end
                                                                end
                                                                Y = 70
                                                                while true do
                                                                    if
                                                                        Y == 70
                                                                    then
                                                                        _ = _[r]
                                                                        Y = 39
                                                                            + (
                                                                                (
                                                                                            Z[1][33][11](
                                                                                                (
                                                                                                    Z[1][33][8](
                                                                                                        Y
                                                                                                    )
                                                                                                )
                                                                                                    - Y,
                                                                                                H
                                                                                            )
                                                                                        )
                                                                                        <= H
                                                                                    and H
                                                                                or Y
                                                                            )
                                                                    elseif
                                                                        Y
                                                                        == 109
                                                                    then
                                                                        r =
                                                                            Z[1][33]
                                                                        Y = 108
                                                                            + (
                                                                                (
                                                                                    Z[1][33][7](
                                                                                        (
                                                                                            Z[1][33][12](
                                                                                                Y
                                                                                            )
                                                                                        )
                                                                                                    >= Y
                                                                                                and H
                                                                                            or H,
                                                                                        H
                                                                                    )
                                                                                )
                                                                                - H
                                                                            )
                                                                        continue
                                                                    elseif
                                                                        Y == 104
                                                                    then
                                                                        K =
                                                                            7
                                                                        Y = 39
                                                                            + (
                                                                                Z[1][33][13](
                                                                                    (
                                                                                        Z[1][33][13](
                                                                                            H,
                                                                                            Y,
                                                                                            H
                                                                                        )
                                                                                    )
                                                                                        - H
                                                                                        + H,
                                                                                    Y,
                                                                                    H
                                                                                )
                                                                            )
                                                                        continue
                                                                    elseif
                                                                        Y == 39
                                                                    then
                                                                        r = r[K]
                                                                        break
                                                                    end
                                                                end
                                                                Y = 53
                                                                while true do
                                                                    if
                                                                        Y
                                                                        == 53
                                                                    then
                                                                        K = Z[1][33]
                                                                        Y = -4294967231
                                                                            + (
                                                                                Z[1][33][14](
                                                                                    (
                                                                                        Z[1][33][9](
                                                                                            (
                                                                                                Z[1][33][9](
                                                                                                    H
                                                                                                )
                                                                                            )
                                                                                                + Y
                                                                                        )
                                                                                    )
                                                                                )
                                                                            )
                                                                    elseif
                                                                        Y == 16
                                                                    then
                                                                        t = 8
                                                                        Y = -1310689
                                                                            + (
                                                                                Z[1][33][6](
                                                                                    (
                                                                                        Z[1][33][11](
                                                                                            (
                                                                                                Y
                                                                                                        > H
                                                                                                    and H
                                                                                                or Y
                                                                                            )
                                                                                                + Y,
                                                                                            Y
                                                                                        )
                                                                                    ),
                                                                                    Y
                                                                                )
                                                                            )
                                                                    elseif
                                                                        Y == 47
                                                                    then
                                                                        K = K[t]
                                                                        Y = 66
                                                                            + (
                                                                                Z[1][33][13](
                                                                                    (
                                                                                        Z[1][33][13](
                                                                                            (
                                                                                                Z[1][33][14](
                                                                                                    H
                                                                                                        + H
                                                                                                )
                                                                                            ),
                                                                                            H
                                                                                        )
                                                                                    )
                                                                                )
                                                                            )
                                                                        continue
                                                                    elseif
                                                                        Y ~= 66
                                                                    then
                                                                    else
                                                                        t = H
                                                                        break
                                                                    end
                                                                end
                                                                local s = H
                                                                Y = 108
                                                                while true do
                                                                    if
                                                                        Y ~= 108
                                                                    then
                                                                        s = J[R]
                                                                        break
                                                                    else
                                                                        t += s
                                                                        Y = -4294967105
                                                                            + (
                                                                                Z[1][33][6](
                                                                                    (
                                                                                        (
                                                                                                    H
                                                                                                            == Y
                                                                                                        and H
                                                                                                    or H
                                                                                                )
                                                                                                >= Y
                                                                                            and H
                                                                                        or H
                                                                                    )
                                                                                        - Y,
                                                                                    H
                                                                                )
                                                                            )
                                                                        continue
                                                                    end
                                                                end
                                                                local u =
                                                                    126
                                                                t += s
                                                                s = J[R]
                                                                t += s
                                                                Y = 25
                                                                while true do
                                                                    if
                                                                        Y > 25
                                                                    then
                                                                        t = J[R]
                                                                        break
                                                                    elseif
                                                                        not (
                                                                            Y < 36
                                                                        )
                                                                    then
                                                                    else
                                                                        K = K(t)
                                                                        Y = (
                                                                            3
                                                                            + (
                                                                                H
                                                                                + H
                                                                                + Y
                                                                                + H
                                                                                - H
                                                                            )
                                                                        )
                                                                    end
                                                                end
                                                                r = r(K, t)
                                                                K = J[R]
                                                                r += K
                                                                K = J[R]
                                                                t = J[R]
                                                                Y = 124
                                                                while true do
                                                                    if
                                                                        Y
                                                                        == 124
                                                                    then
                                                                        _ = _(
                                                                            r,
                                                                            K,
                                                                            t
                                                                        )
                                                                        Y = 43
                                                                            + (
                                                                                Z[1][33][8](
                                                                                    (
                                                                                        Z[1][33][12](
                                                                                            H
                                                                                        )
                                                                                    )
                                                                                        + Y
                                                                                        + H
                                                                                )
                                                                            )
                                                                        continue
                                                                    elseif
                                                                        Y == 43
                                                                    then
                                                                        r = H
                                                                        Y = (
                                                                            14
                                                                            + (
                                                                                Z[1][33][11](
                                                                                    H
                                                                                        - H
                                                                                        - Y
                                                                                        + Y,
                                                                                    H
                                                                                )
                                                                            )
                                                                        )
                                                                        continue
                                                                    elseif
                                                                        Y
                                                                        == 14
                                                                    then
                                                                        _ += r
                                                                        break
                                                                    end
                                                                end
                                                                z += _
                                                                u += z
                                                                Y = 94
                                                                while true do
                                                                    if
                                                                        Y
                                                                        == 94
                                                                    then
                                                                        (J)[R] = u
                                                                        Y = -53
                                                                            + (
                                                                                Z[1][33][13](
                                                                                    (
                                                                                        Z[1][33][6](
                                                                                            (
                                                                                                Z[1][33][14](
                                                                                                    H,
                                                                                                    Y,
                                                                                                    H
                                                                                                )
                                                                                            ),
                                                                                            Y
                                                                                        )
                                                                                    )
                                                                                        - H,
                                                                                    Y,
                                                                                    Y
                                                                                )
                                                                            )
                                                                        continue
                                                                    elseif
                                                                        Y == 37
                                                                    then
                                                                        u = Q
                                                                        break
                                                                    end
                                                                end
                                                                z = M[R]
                                                                Y = 7
                                                                while true do
                                                                    if
                                                                        Y == 7
                                                                    then
                                                                        _ = Q
                                                                        Y = -111
                                                                            + (
                                                                                Z[1][33][13](
                                                                                    (
                                                                                        Z[1][33][11](
                                                                                            H
                                                                                                + Y,
                                                                                            H
                                                                                        )
                                                                                    )
                                                                                        - Y
                                                                                )
                                                                            )
                                                                    elseif
                                                                        Y == 58
                                                                    then
                                                                        r = o[R]
                                                                        break
                                                                    end
                                                                end
                                                                _ = _[r]
                                                                Y = 94
                                                                while true do
                                                                    if
                                                                        Y < 94
                                                                    then
                                                                        u[z] = _
                                                                        break
                                                                    elseif
                                                                        not (
                                                                            Y
                                                                            > 37
                                                                        )
                                                                    then
                                                                    else
                                                                        _ = #_
                                                                        Y = 129
                                                                            + (
                                                                                (
                                                                                    Z[1][33][8](
                                                                                        (
                                                                                            Z[1][33][11](
                                                                                                H,
                                                                                                H
                                                                                            )
                                                                                        )
                                                                                            + H
                                                                                    )
                                                                                )
                                                                                - Y
                                                                            )
                                                                        continue
                                                                    end
                                                                end
                                                            end
                                                        else
                                                            if not (H >= 1) then
                                                                (Q)[k[R]] = isfolder
                                                            else
                                                                if H == 2 then
                                                                    Q[k[R]] =
                                                                        checkcaller
                                                                else
                                                                    local Y =
                                                                        o[R];
                                                                    (Q)[Y] =
                                                                        Q[Y](
                                                                            Q[Y + 1],
                                                                            Q[Y + 2]
                                                                        )
                                                                    x = Y
                                                                end
                                                            end
                                                        end
                                                    end
                                                else
                                                    if H >= 18 then
                                                        if H < 21 then
                                                            if H >= 19 then
                                                                if
                                                                    H
                                                                    == 20
                                                                then
                                                                    Q[o[R]] = j[R]
                                                                        <= N[R]
                                                                else
                                                                    Q[o[R]] =
                                                                        newcclosure
                                                                end
                                                            else
                                                                Q[o[R]] = error
                                                            end
                                                        else
                                                            if H >= 22 then
                                                                if
                                                                    H
                                                                    == 23
                                                                then
                                                                    if
                                                                        not q
                                                                    then
                                                                    else
                                                                        for Y, z in
                                                                            q
                                                                        do
                                                                            if
                                                                                Y
                                                                                >= 1
                                                                            then
                                                                                z[1] =
                                                                                    z
                                                                                z[2] = Q[Y]
                                                                                z[3] =
                                                                                    2
                                                                                (
                                                                                    q
                                                                                )[Y] = nil
                                                                            end
                                                                        end
                                                                    end
                                                                    return Q[o[R]]()
                                                                else
                                                                    Q[o[R]] = makefolder
                                                                end
                                                            else
                                                                Q[k[R]] = Q[M[R]]
                                                                    + Q[o[R]]
                                                            end
                                                        end
                                                    elseif
                                                        not (H >= 15)
                                                    then
                                                        if not (H < 13) then
                                                            if H ~= 14 then
                                                                Q[M[R]] = j[R]
                                                                    * Q[o[R]]
                                                            else
                                                                (Q)[k[R]] = compareinstances
                                                            end
                                                        else
                                                            Q[M[R]][Q[o[R]]] = Q[k[R]]
                                                        end
                                                    else
                                                        if H < 16 then
                                                            local Y = b[o[R]];
                                                            (Y[1][Y[3]])[Q[k[R]]] =
                                                                Q[M[R]]
                                                        else
                                                            if H ~= 17 then
                                                                (Q)[M[R]] =
                                                                    setfflag
                                                            else
                                                                local Y =
                                                                    b[k[R]];
                                                                (Q)[o[R]] =
                                                                    Y[1][Y[3]][Q[M[R]]]
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if not (H >= 36) then
                                                    if H < 30 then
                                                        if not (H >= 27) then
                                                            if
                                                                not (H >= 25)
                                                            then
                                                                (Q)[k[R]] =
                                                                    http_request
                                                            else
                                                                if
                                                                    H == 26
                                                                then
                                                                    Q[o[R]] =
                                                                        Q[k[R]]
                                                                else
                                                                    local Y =
                                                                        b[k[R]];
                                                                    (Y[1])[Y[3]] = Q[M[R]]
                                                                end
                                                            end
                                                        else
                                                            if not (H < 28) then
                                                                if H == 29 then
                                                                    local Y, z =
                                                                        o[R],
                                                                        0
                                                                    for r = Y, Y + (M[R] - 1) do
                                                                        (Q)[r] =
                                                                            P[d + z]
                                                                        z += 1
                                                                    end
                                                                else
                                                                    (Q)[k[R]] = (
                                                                        N[R]
                                                                        % V[R]
                                                                    )
                                                                end
                                                            else
                                                                if
                                                                    Q[M[R]]
                                                                    == V[R]
                                                                then
                                                                else
                                                                    R = k[R]
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if not (H >= 33) then
                                                            if H >= 31 then
                                                                if
                                                                    H == 32
                                                                then
                                                                    (Q)[M[R]] =
                                                                        unpack
                                                                else
                                                                    if q then
                                                                        for Y, z in
                                                                            q
                                                                        do
                                                                            if
                                                                                not (
                                                                                    Y
                                                                                    >= 1
                                                                                )
                                                                            then
                                                                            else
                                                                                (
                                                                                    z
                                                                                )[1] = z;
                                                                                (
                                                                                    z
                                                                                )[2] = Q[Y]
                                                                                z[3] =
                                                                                    2
                                                                                (
                                                                                    q
                                                                                )[Y] =
                                                                                    nil
                                                                            end
                                                                        end
                                                                    end
                                                                    local Y = M[R]
                                                                    return Z[1][12](
                                                                        Q,
                                                                        Y,
                                                                        Y
                                                                            + o[R]
                                                                            - 2
                                                                    )
                                                                end
                                                            else
                                                                (Q)[M[R]] = (
                                                                    Q[o[R]]
                                                                    * Q[k[R]]
                                                                )
                                                            end
                                                        else
                                                            if H >= 34 then
                                                                if
                                                                    H ~= 35
                                                                then
                                                                    Q[o[R]] = ypcall
                                                                else
                                                                    for Y = o[R], k[R] do
                                                                        Q[Y] = nil
                                                                    end
                                                                end
                                                            else
                                                                local Y, z =
                                                                    o[R], k[R]
                                                                local r = Q[Y]
                                                                Z[1][23](
                                                                    Q,
                                                                    Y + 1,
                                                                    Y + M[R],
                                                                    z + 1,
                                                                    r
                                                                )
                                                            end
                                                        end
                                                    end
                                                else
                                                    if H < 42 then
                                                        if not (H < 39) then
                                                            if H >= 40 then
                                                                if H ~= 41 then
                                                                    (Q)[o[R]] =
                                                                        tostring
                                                                else
                                                                    (Q)[k[R]] = (
                                                                        Q[o[R]]
                                                                        ~= Q[M[R]]
                                                                    )
                                                                end
                                                            else
                                                                (Q)[o[R]] = (
                                                                    Z[4](
                                                                        Q[k[R]],
                                                                        Q[M[R]]
                                                                    )
                                                                )
                                                            end
                                                        else
                                                            if H >= 37 then
                                                                if
                                                                    H ~= 38
                                                                then
                                                                    local Y =
                                                                        b[k[R]];
                                                                    (Y[1])[Y[3]] =
                                                                        N[R]
                                                                else
                                                                    Q[k[R]] = (
                                                                        N[R]
                                                                        + V[R]
                                                                    )
                                                                end
                                                            else
                                                                (Q)[o[R]] = (
                                                                    N[R] > Q[k[R]]
                                                                )
                                                            end
                                                        end
                                                    else
                                                        if H >= 45 then
                                                            if
                                                                not (
                                                                    H < 46
                                                                )
                                                            then
                                                                if
                                                                    H ~= 47
                                                                then
                                                                    if
                                                                        Q[k[R]]
                                                                        ~= Q[M[R]]
                                                                    then
                                                                        R = o[R]
                                                                    end
                                                                else
                                                                    if
                                                                        not Q[k[R]]
                                                                    then
                                                                    else
                                                                        R = o[R]
                                                                    end
                                                                end
                                                            else
                                                                (Q)[o[R]] =
                                                                    not Q[k[R]]
                                                            end
                                                        else
                                                            if
                                                                not (H >= 43)
                                                            then
                                                                if q then
                                                                    for Y, z in
                                                                        q
                                                                    do
                                                                        if
                                                                            not (
                                                                                Y
                                                                                >= 1
                                                                            )
                                                                        then
                                                                        else
                                                                            z[1] = z
                                                                            z[2] = Q[Y]
                                                                            z[3] =
                                                                                2
                                                                            (q)[Y] =
                                                                                nil
                                                                        end
                                                                    end
                                                                end
                                                                local Y = k[R]
                                                                return Q[Y](
                                                                    Q[Y + 1]
                                                                )
                                                            else
                                                                if
                                                                    H
                                                                    ~= 44
                                                                then
                                                                    (Q)[M[R]] =
                                                                        L.jh
                                                                else
                                                                    Q[o[R]] =
                                                                        sethiddenproperty
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if not (H >= 72) then
                                                if H < 60 then
                                                    if not (H < 54) then
                                                        if
                                                            not (H < 57)
                                                        then
                                                            if
                                                                not (
                                                                    H < 58
                                                                )
                                                            then
                                                                if H == 59 then
                                                                    Q[o[R]] = rawequal
                                                                else
                                                                    if
                                                                        not q
                                                                    then
                                                                    else
                                                                        for Y, z in
                                                                            q
                                                                        do
                                                                            if
                                                                                not (
                                                                                    Y
                                                                                    >= 1
                                                                                )
                                                                            then
                                                                            else
                                                                                (
                                                                                    z
                                                                                )[1] = z
                                                                                z[2] = Q[Y];
                                                                                (
                                                                                    z
                                                                                )[3] = 2
                                                                                q[Y] = nil
                                                                            end
                                                                        end
                                                                    end
                                                                    return
                                                                end
                                                            else
                                                                Q[k[R]] = {}
                                                            end
                                                        elseif not (H < 55) then
                                                            if
                                                                H == 56
                                                            then
                                                                Q[k[R]] = Q[o[R]]
                                                                    - N[R]
                                                            else
                                                                (Q)[o[R]] = readfile
                                                            end
                                                        else
                                                            Q[M[R]] = Q[o[R]]
                                                                >= Q[k[R]]
                                                        end
                                                    else
                                                        if not (H < 51) then
                                                            if H < 52 then
                                                                local Y = o[R]
                                                                x = (
                                                                    Y
                                                                    + k[R]
                                                                    - 1
                                                                )
                                                                Q[Y](
                                                                    Z[1][12](
                                                                        Q,
                                                                        Y + 1,
                                                                        x
                                                                    )
                                                                )
                                                                x = (Y - 1)
                                                            else
                                                                if
                                                                    H ~= 53
                                                                then
                                                                    Q[M[R]] = (
                                                                        j[R]
                                                                        < V[R]
                                                                    )
                                                                else
                                                                    Q[o[R]] =
                                                                        getsenv
                                                                end
                                                            end
                                                        else
                                                            if
                                                                not (H >= 49)
                                                            then
                                                                (Q)[k[R]] = tonumber
                                                            elseif
                                                                H ~= 50
                                                            then
                                                                Q[M[R]] = Q[k[R]]
                                                                    * V[R]
                                                            else
                                                                (Q)[k[R]] = (
                                                                    Q[M[R]] < V[R]
                                                                )
                                                            end
                                                        end
                                                    end
                                                else
                                                    if not (H >= 66) then
                                                        if not (H < 63) then
                                                            if H >= 64 then
                                                                if
                                                                    H
                                                                    == 65
                                                                then
                                                                    Q[M[R]] = (
                                                                        j[R]
                                                                        - Q[o[R]]
                                                                    )
                                                                else
                                                                    if
                                                                        not (
                                                                            Q[M[R]]
                                                                            < Q[o[R]]
                                                                        )
                                                                    then
                                                                        R = k[R]
                                                                    end
                                                                end
                                                            else
                                                                Q[o[R]] = L.sh
                                                            end
                                                        elseif
                                                            not (H >= 61)
                                                        then
                                                            (Q)[o[R]] = (
                                                                Q[M[R]] <= j[R]
                                                            )
                                                        else
                                                            if
                                                                H == 62
                                                            then
                                                                (Q)[k[R]] = (
                                                                    Z[4](
                                                                        Q[M[R]],
                                                                        V[R]
                                                                    )
                                                                )
                                                            else
                                                                (Q)[M[R]] = (
                                                                    Q[k[R]]
                                                                    == Q[o[R]]
                                                                )
                                                            end
                                                        end
                                                    else
                                                        if H < 69 then
                                                            if H >= 67 then
                                                                if
                                                                    H
                                                                    ~= 68
                                                                then
                                                                    Q[k[R]] =
                                                                        Z[1][1](
                                                                            o[R]
                                                                        )
                                                                else
                                                                    Q[k[R]] =
                                                                        request
                                                                end
                                                            else
                                                                (Q)[M[R]] = j[R]
                                                                    == V[R]
                                                            end
                                                        else
                                                            if
                                                                not (H >= 70)
                                                            then
                                                                local Y = k[R]
                                                                local z, r, _ =
                                                                    T()
                                                                if not z then
                                                                else
                                                                    (Q)[Y + 1] = r
                                                                    Q[Y + 2] =
                                                                        _
                                                                    R = M[R]
                                                                end
                                                            elseif
                                                                H ~= 71
                                                            then
                                                                (Q)[o[R]] = j[R]
                                                                    ^ Q[M[R]]
                                                            else
                                                                Q[k[R]] = L.gh
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if not (H < 84) then
                                                    if not (H >= 90) then
                                                        if not (H < 87) then
                                                            if H < 88 then
                                                                (Q)[M[R]] = print
                                                            else
                                                                if
                                                                    H ~= 89
                                                                then
                                                                    Q[o[R]] = Q[M[R]][j[R]]
                                                                else
                                                                    (Q)[k[R]] = V[R]
                                                                        * N[R]
                                                                end
                                                            end
                                                        elseif
                                                            H < 85
                                                        then
                                                            (Q)[k[R]] = L.fh
                                                        else
                                                            if H ~= 86 then
                                                                Q[M[R]] = setrawmetatable
                                                            else
                                                                (Q)[k[R]] = Q[o[R]][Q[M[R]]]
                                                            end
                                                        end
                                                    else
                                                        if not (H >= 93) then
                                                            if
                                                                not (H < 91)
                                                            then
                                                                if
                                                                    H == 92
                                                                then
                                                                    (Q)[M[R]] = Q[k[R]]
                                                                        / V[R]
                                                                else
                                                                    local Y = M[R];
                                                                    (Q)[Y] =
                                                                        Q[Y](
                                                                            Z[1][12](
                                                                                Q,
                                                                                Y
                                                                                    + 1,
                                                                                x
                                                                            )
                                                                        )
                                                                    x = Y
                                                                end
                                                            else
                                                                local Y = b[k[R]];
                                                                (Q)[M[R]] = Y[1][Y[3]]
                                                            end
                                                        else
                                                            if H < 94 then
                                                                Q[o[R]] = (
                                                                    Q[M[R]]
                                                                    <= Q[k[R]]
                                                                )
                                                            else
                                                                if
                                                                    H ~= 95
                                                                then
                                                                    (Q)[o[R]] =
                                                                        CFrame
                                                                else
                                                                    (Q)[M[R]] = j[R]
                                                                        >= V[R]
                                                                end
                                                            end
                                                        end
                                                    end
                                                else
                                                    if not (H >= 78) then
                                                        if H >= 75 then
                                                            if H >= 76 then
                                                                if
                                                                    H ~= 77
                                                                then
                                                                    Q[o[R]] = game
                                                                else
                                                                    Q[M[R]] =
                                                                        setreadonly
                                                                end
                                                            else
                                                                (
                                                                    Z[1][33]
                                                                )[o[R]] =
                                                                    Q[M[R]]
                                                            end
                                                        else
                                                            if
                                                                not (H >= 73)
                                                            then
                                                                (Q[k[R]])[Q[M[R]]] =
                                                                    V[R]
                                                            else
                                                                if H ~= 74 then
                                                                    (Q)[o[R]] = P[d]
                                                                else
                                                                    if
                                                                        not (
                                                                            N[R]
                                                                            < Q[k[R]]
                                                                        )
                                                                    then
                                                                        R = o[R]
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if H < 81 then
                                                            if H >= 79 then
                                                                if
                                                                    H == 80
                                                                then
                                                                    local Y = M[R]
                                                                    Q[Y] = Q[Y](
                                                                        Q[Y + 1]
                                                                    )
                                                                    x = Y
                                                                else
                                                                    Q[o[R]] = writefile
                                                                end
                                                            else
                                                                local Y, z =
                                                                    O - l - 1,
                                                                    k[R]
                                                                if Y < 0 then
                                                                    Y = -1
                                                                end
                                                                local r = 0
                                                                for _ = z, z + Y do
                                                                    (Q)[_] = P[d + r]
                                                                    r += 1
                                                                end
                                                                x = (z + Y)
                                                            end
                                                        else
                                                            if not (H < 82) then
                                                                if
                                                                    H == 83
                                                                then
                                                                    (Q)[M[R]] =
                                                                        getrawmetatable
                                                                else
                                                                    (Q[k[R]])[V[R]] = N[R]
                                                                end
                                                            else
                                                                l = k[R]
                                                                O, P =
                                                                    Z[1][35](
                                                                        ...
                                                                    )
                                                                for Y = 1, l do
                                                                    Q[Y] = P[Y]
                                                                end
                                                                d = (l + 1)
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if not (H >= 144) then
                                            if not (H >= 120) then
                                                if H >= 108 then
                                                    if not (H >= 114) then
                                                        if
                                                            not (H < 111)
                                                        then
                                                            if H < 112 then
                                                                Q[M[R]] =
                                                                    getcallingscript
                                                            else
                                                                if H == 113 then
                                                                    local l =
                                                                        { ... }
                                                                    for d = 1, k[R] do
                                                                        Q[d] =
                                                                            l[d]
                                                                    end
                                                                else
                                                                    Q[k[R]] = task
                                                                end
                                                            end
                                                        else
                                                            if
                                                                not (H >= 109)
                                                            then
                                                                local l, d, Y, z, r, _, K, t =
                                                                    3, 15
                                                                while true do
                                                                    if
                                                                        l
                                                                            < 103
                                                                        and l
                                                                            > 40
                                                                    then
                                                                        K = Z[1][33]
                                                                        l = (
                                                                            -1073741892
                                                                            + (
                                                                                Z[1][33][6](
                                                                                    (
                                                                                        Z[1][33][14](
                                                                                            (
                                                                                                Z[1][33][15](
                                                                                                    l,
                                                                                                    o[R]
                                                                                                )
                                                                                            )
                                                                                                + H,
                                                                                            l,
                                                                                            l
                                                                                        )
                                                                                    )
                                                                                )
                                                                            )
                                                                        )
                                                                    elseif
                                                                        l
                                                                        > 45
                                                                    then
                                                                        _ =
                                                                            Z[1][33]
                                                                        break
                                                                    else
                                                                        if
                                                                            l
                                                                            < 6
                                                                        then
                                                                            Y = 77
                                                                            l = -4294967289
                                                                                + (
                                                                                    Z[1][33][6](
                                                                                        (
                                                                                            Z[1][33][7](
                                                                                                l
                                                                                                            >= l
                                                                                                        and l
                                                                                                    or l,
                                                                                                l
                                                                                            )
                                                                                        )
                                                                                            - l,
                                                                                        H,
                                                                                        o[R]
                                                                                    )
                                                                                )
                                                                        else
                                                                            if
                                                                                l
                                                                                    > 6
                                                                                and l
                                                                                    < 45
                                                                            then
                                                                                _ = 8
                                                                                K = K[_]
                                                                                l = -4294967170
                                                                                    + (
                                                                                        Z[1][33][14](
                                                                                            (
                                                                                                Z[1][33][9](
                                                                                                    (
                                                                                                        Z[1][33][8](
                                                                                                            l
                                                                                                                - l
                                                                                                        )
                                                                                                    )
                                                                                                )
                                                                                            ),
                                                                                            o[R],
                                                                                            l
                                                                                        )
                                                                                    )
                                                                            else
                                                                                if
                                                                                    l
                                                                                        > 3
                                                                                    and l
                                                                                        < 40
                                                                                then
                                                                                    r =
                                                                                        0
                                                                                    K = 4503599627370495
                                                                                    r *= K
                                                                                    l = (
                                                                                        39
                                                                                        + (
                                                                                            (
                                                                                                            H
                                                                                                                    < H
                                                                                                                and H
                                                                                                            or H
                                                                                                        )
                                                                                                        + H
                                                                                                        - l
                                                                                                    == l
                                                                                                and o[R]
                                                                                            or l
                                                                                        )
                                                                                    )
                                                                                    continue
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                                local s = 7
                                                                _ = _[s]
                                                                l = 104
                                                                while true do
                                                                    if
                                                                        l
                                                                        >= 104
                                                                    then
                                                                        s = Z[1][33]
                                                                        z = 10
                                                                        l = 39
                                                                            + (
                                                                                Z[1][33][15](
                                                                                    (
                                                                                        Z[1][33][10](
                                                                                            (
                                                                                                H
                                                                                                        ~= l
                                                                                                    and l
                                                                                                or o[R]
                                                                                            )
                                                                                                - l,
                                                                                            o[R]
                                                                                        )
                                                                                    ),
                                                                                    o[R]
                                                                                )
                                                                            )
                                                                        continue
                                                                    else
                                                                        s = s[z]
                                                                        break
                                                                    end
                                                                end
                                                                z = Z[1][33]
                                                                z = z[d]
                                                                l = 49
                                                                while true do
                                                                    if
                                                                        l == 49
                                                                    then
                                                                        d = J[R]
                                                                        l = 13
                                                                            + (
                                                                                (
                                                                                    (
                                                                                                    l
                                                                                                            ~= l
                                                                                                        and l
                                                                                                    or o[R]
                                                                                                )
                                                                                                - H
                                                                                            == l
                                                                                        and l
                                                                                    or l
                                                                                )
                                                                                + o[R]
                                                                            )
                                                                    else
                                                                        if
                                                                            l
                                                                            == 92
                                                                        then
                                                                            t = J[R]
                                                                            break
                                                                        end
                                                                    end
                                                                end
                                                                d -= t
                                                                l = 26
                                                                repeat
                                                                    if
                                                                        not (
                                                                            l
                                                                            <= 26
                                                                        )
                                                                    then
                                                                        if
                                                                            l
                                                                            ~= 92
                                                                        then
                                                                            t = o[R]
                                                                            l = -77
                                                                                + (
                                                                                    (
                                                                                        Z[1][33][10](
                                                                                            (
                                                                                                Z[1][33][14](
                                                                                                    o[R]
                                                                                                                >= H
                                                                                                            and l
                                                                                                        or H,
                                                                                                    H,
                                                                                                    o[R]
                                                                                                )
                                                                                            ),
                                                                                            o[R]
                                                                                        )
                                                                                    )
                                                                                    + l
                                                                                )
                                                                        else
                                                                            z =
                                                                                z(
                                                                                    d,
                                                                                    t
                                                                                )
                                                                            break
                                                                        end
                                                                    else
                                                                        t = o[R]
                                                                        d += t
                                                                        l = 19
                                                                            + (
                                                                                (
                                                                                            Z[1][33][11](
                                                                                                (
                                                                                                    Z[1][33][7](
                                                                                                        l
                                                                                                                    > H
                                                                                                                and H
                                                                                                            or l,
                                                                                                        o[R]
                                                                                                    )
                                                                                                ),
                                                                                                l
                                                                                            )
                                                                                        )
                                                                                        < H
                                                                                    and o[R]
                                                                                or l
                                                                            )
                                                                        continue
                                                                    end
                                                                until false
                                                                d = o[R]
                                                                l = 86
                                                                repeat
                                                                    if
                                                                        l < 86
                                                                    then
                                                                        z = o[R]
                                                                        l = (
                                                                            -368
                                                                            + (
                                                                                Z[1][33][10](
                                                                                    (
                                                                                        H
                                                                                                    + o[R]
                                                                                                > H
                                                                                            and l
                                                                                        or H
                                                                                    )
                                                                                        + l,
                                                                                    o[R]
                                                                                )
                                                                            )
                                                                        )
                                                                        continue
                                                                    else
                                                                        if
                                                                            l
                                                                            > 119
                                                                        then
                                                                            s = (
                                                                                s
                                                                                > z
                                                                            )
                                                                            l = 119
                                                                                + (
                                                                                    Z[1][33][7](
                                                                                        (
                                                                                            Z[1][33][13](
                                                                                                o[R]
                                                                                                    + l
                                                                                            )
                                                                                        )
                                                                                            - o[R],
                                                                                        o[R]
                                                                                    )
                                                                                )
                                                                            continue
                                                                        elseif
                                                                            l
                                                                                > 61
                                                                            and l
                                                                                < 119
                                                                        then
                                                                            s =
                                                                                s(
                                                                                    z,
                                                                                    d
                                                                                )
                                                                            l = -57
                                                                                + (
                                                                                    (
                                                                                        Z[1][33][13](
                                                                                            (
                                                                                                Z[1][33][12](
                                                                                                    (
                                                                                                        Z[1][33][7](
                                                                                                            l,
                                                                                                            o[R]
                                                                                                        )
                                                                                                    )
                                                                                                )
                                                                                            )
                                                                                        )
                                                                                    )
                                                                                    + l
                                                                                )
                                                                            continue
                                                                        else
                                                                            if
                                                                                l
                                                                                    < 120
                                                                                and l
                                                                                    > 86
                                                                            then
                                                                                if
                                                                                    s
                                                                                then
                                                                                    s = o[R]
                                                                                end
                                                                                break
                                                                            end
                                                                        end
                                                                    end
                                                                until false
                                                                if not s then
                                                                    s = o[R]
                                                                end
                                                                l = 30
                                                                while true do
                                                                    if
                                                                        not (
                                                                            l
                                                                            > 50
                                                                        )
                                                                    then
                                                                        if
                                                                            not (
                                                                                l
                                                                                > 0
                                                                            )
                                                                        then
                                                                            s = H
                                                                            l = -4294966768
                                                                                + (
                                                                                    Z[1][33][10](
                                                                                        (
                                                                                            Z[1][33][9](
                                                                                                (
                                                                                                    Z[1][33][13](
                                                                                                        l
                                                                                                                    ~= l
                                                                                                                and o[R]
                                                                                                            or H
                                                                                                    )
                                                                                                )
                                                                                            )
                                                                                        ),
                                                                                        o[R]
                                                                                    )
                                                                                )
                                                                        else
                                                                            if
                                                                                l
                                                                                ~= 50
                                                                            then
                                                                                z = o[R]
                                                                                l = (
                                                                                    71
                                                                                    + (
                                                                                        (
                                                                                                    Z[1][33][9](
                                                                                                        (
                                                                                                            Z[1][33][10](
                                                                                                                l,
                                                                                                                l
                                                                                                            )
                                                                                                        )
                                                                                                                    > l
                                                                                                                and l
                                                                                                            or H
                                                                                                    )
                                                                                                )
                                                                                                < l
                                                                                            and H
                                                                                        or o[R]
                                                                                    )
                                                                                )
                                                                                continue
                                                                            else
                                                                                K =
                                                                                    K(
                                                                                        _
                                                                                    )
                                                                                l = 105
                                                                                    + (
                                                                                        Z[1][33][7](
                                                                                            (
                                                                                                Z[1][33][13](
                                                                                                    l,
                                                                                                    l,
                                                                                                    o[R]
                                                                                                )
                                                                                            )
                                                                                                - o[R]
                                                                                                + l,
                                                                                            o[R]
                                                                                        )
                                                                                    )
                                                                                continue
                                                                            end
                                                                        end
                                                                    else
                                                                        if
                                                                            l
                                                                            <= 95
                                                                        then
                                                                            if
                                                                                l
                                                                                > 52
                                                                            then
                                                                                _ -= s
                                                                                l = (
                                                                                    50
                                                                                    + (
                                                                                        Z[1][33][7](
                                                                                            (
                                                                                                Z[1][33][14](
                                                                                                    H
                                                                                                                < H
                                                                                                            and H
                                                                                                        or l
                                                                                                )
                                                                                            )
                                                                                                - o[R],
                                                                                            o[R]
                                                                                        )
                                                                                    )
                                                                                )
                                                                                continue
                                                                            else
                                                                                Y += r
                                                                                break
                                                                            end
                                                                        else
                                                                            if
                                                                                not (
                                                                                    l
                                                                                    < 105
                                                                                )
                                                                            then
                                                                                r += K
                                                                                l = (
                                                                                    49
                                                                                    + (
                                                                                        (
                                                                                            Z[1][33][14](
                                                                                                H
                                                                                                    + l
                                                                                            )
                                                                                        )
                                                                                        - l
                                                                                        - l
                                                                                    )
                                                                                )
                                                                            else
                                                                                _ =
                                                                                    _(
                                                                                        s,
                                                                                        z
                                                                                    )
                                                                                l = -404
                                                                                    + (
                                                                                        (
                                                                                            Z[1][33][14](
                                                                                                (
                                                                                                    Z[1][33][10](
                                                                                                        l,
                                                                                                        o[R]
                                                                                                    )
                                                                                                )
                                                                                            )
                                                                                        )
                                                                                        - l
                                                                                        + l
                                                                                    )
                                                                                continue
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                                (J)[R] = Y
                                                                l = 25
                                                                repeat
                                                                    if
                                                                        l
                                                                        == 25
                                                                    then
                                                                        Y = Q
                                                                        l = 36
                                                                            + (
                                                                                Z[1][33][6](
                                                                                    (
                                                                                        Z[1][33][8](
                                                                                            (
                                                                                                Z[1][33][8](
                                                                                                    l
                                                                                                        + l
                                                                                                )
                                                                                            )
                                                                                        )
                                                                                    )
                                                                                )
                                                                            )
                                                                        continue
                                                                    elseif
                                                                        l == 36
                                                                    then
                                                                        r = o[R]
                                                                        K =
                                                                            writefile
                                                                        l = -213
                                                                            + (
                                                                                Z[1][33][13](
                                                                                    (
                                                                                        Z[1][33][10](
                                                                                            (
                                                                                                Z[1][33][6](
                                                                                                    o[R]
                                                                                                )
                                                                                            )
                                                                                                + l,
                                                                                            o[R]
                                                                                        )
                                                                                    )
                                                                                )
                                                                            )
                                                                        continue
                                                                    else
                                                                        if
                                                                            l
                                                                            ~= 51
                                                                        then
                                                                        else
                                                                            Y[r] = K
                                                                            break
                                                                        end
                                                                    end
                                                                until false
                                                            else
                                                                if
                                                                    H ~= 110
                                                                then
                                                                    O, P =
                                                                        Z[1][35](
                                                                            ...
                                                                        )
                                                                else
                                                                    if
                                                                        Q[o[R]]
                                                                        ~= N[R]
                                                                    then
                                                                    else
                                                                        R = k[R]
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if not (H >= 117) then
                                                            if
                                                                not (H >= 115)
                                                            then
                                                                Q[M[R]] = rawset
                                                            else
                                                                if
                                                                    H
                                                                    == 116
                                                                then
                                                                    (Q)[k[R]] = M
                                                                else
                                                                    Q[o[R]] = (
                                                                        Q[M[R]]
                                                                        .. Q[k[R]]
                                                                    )
                                                                end
                                                            end
                                                        else
                                                            if H < 118 then
                                                                Q[M[R]] = tick
                                                            else
                                                                if
                                                                    H == 119
                                                                then
                                                                    (Q)[k[R]] = -Q[M[R]]
                                                                else
                                                                    local l = N[R]
                                                                    local P =
                                                                        l[9]
                                                                    local O = #P
                                                                    local d = O
                                                                            > 0
                                                                        and {}
                                                                    local Y =
                                                                        Z[2](
                                                                            l,
                                                                            d
                                                                        );
                                                                    (Q)[o[R]] = Y
                                                                    if
                                                                        not d
                                                                    then
                                                                    else
                                                                        for z = 1, O do
                                                                            l = P[z]
                                                                            Y = l[1]
                                                                            local P = l[3]
                                                                            if
                                                                                Y
                                                                                == 0
                                                                            then
                                                                                if
                                                                                    not not q
                                                                                then
                                                                                else
                                                                                    q = {}
                                                                                end
                                                                                local l =
                                                                                    q[P]
                                                                                if
                                                                                    not not l
                                                                                then
                                                                                else
                                                                                    l = {
                                                                                        [1] = Q,
                                                                                        [3] = P,
                                                                                    }
                                                                                    (
                                                                                        q
                                                                                    )[P] =
                                                                                        l
                                                                                end
                                                                                (
                                                                                    d
                                                                                )[z - 1] = l
                                                                            else
                                                                                if
                                                                                    Y
                                                                                    ~= 1
                                                                                then
                                                                                    d[z - 1] =
                                                                                        b[P]
                                                                                else
                                                                                    (
                                                                                        d
                                                                                    )[z - 1] = Q[P]
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                else
                                                    if not (H < 102) then
                                                        if H < 105 then
                                                            if H < 103 then
                                                                (Q)[M[R]] = V[R]
                                                                    ~= j[R]
                                                            else
                                                                if
                                                                    H ~= 104
                                                                then
                                                                    (Q)[o[R]] = Ray
                                                                else
                                                                    (Q)[o[R]] = (
                                                                        Q[M[R]]
                                                                        - Q[k[R]]
                                                                    )
                                                                end
                                                            end
                                                        else
                                                            if H < 106 then
                                                                if
                                                                    Q[M[R]]
                                                                    ~= Q[o[R]]
                                                                then
                                                                else
                                                                    R = k[R]
                                                                end
                                                            else
                                                                if
                                                                    H == 107
                                                                then
                                                                    (Q)[M[R]] = Q[o[R]]
                                                                        % Q[k[R]]
                                                                else
                                                                    Q[o[R]] =
                                                                        workspace
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if not (H < 99) then
                                                            if H < 100 then
                                                                Q[M[R]] = (
                                                                    Q[o[R]]
                                                                    == j[R]
                                                                )
                                                            else
                                                                if
                                                                    H == 101
                                                                then
                                                                    (Q)[o[R]] = j[R]
                                                                else
                                                                    local l =
                                                                        false
                                                                    T += C
                                                                    if
                                                                        not (
                                                                            C
                                                                            <= 0
                                                                        )
                                                                    then
                                                                        l = T
                                                                            <= E
                                                                    else
                                                                        l = (
                                                                            T >= E
                                                                        )
                                                                    end
                                                                    if
                                                                        not l
                                                                    then
                                                                    else
                                                                        Q[k[R] + 3] = T
                                                                        R = o[R]
                                                                    end
                                                                end
                                                            end
                                                        else
                                                            if H >= 97 then
                                                                if
                                                                    H
                                                                    == 98
                                                                then
                                                                    Q[k[R]] =
                                                                        b[M[R]][V[R]]
                                                                else
                                                                    Q[M[R]] = (
                                                                        Q[o[R]]
                                                                        < Q[k[R]]
                                                                    )
                                                                end
                                                            else
                                                                (Q)[o[R]] =
                                                                    hookfunction
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if not (H < 132) then
                                                    if not (H < 138) then
                                                        if
                                                            H >= 141
                                                        then
                                                            if H < 142 then
                                                                Q[k[R]] =
                                                                    Z[1][33][M[R]]
                                                            else
                                                                if
                                                                    H
                                                                    == 143
                                                                then
                                                                    (Q)[o[R]] = Drawing
                                                                else
                                                                    Q[k[R]] =
                                                                        Vector3
                                                                end
                                                            end
                                                        else
                                                            if
                                                                H >= 139
                                                            then
                                                                if
                                                                    H ~= 140
                                                                then
                                                                    if
                                                                        not Q[k[R]]
                                                                    then
                                                                        R = M[R]
                                                                    end
                                                                else
                                                                    x = k[R];
                                                                    (Q[x])()
                                                                    x -= 1
                                                                end
                                                            else
                                                                Q[o[R]] = f
                                                            end
                                                        end
                                                    else
                                                        if H >= 135 then
                                                            if
                                                                not (H < 136)
                                                            then
                                                                if
                                                                    H ~= 137
                                                                then
                                                                    (Q)[M[R]] = V[R]
                                                                        .. Q[k[R]]
                                                                else
                                                                    (Q)[k[R]] =
                                                                        next
                                                                end
                                                            else
                                                                Q[o[R]] = loadstring
                                                            end
                                                        elseif
                                                            not (H >= 133)
                                                        then
                                                            Q[M[R]] = xpcall
                                                        else
                                                            if
                                                                H ~= 134
                                                            then
                                                                (Q)[o[R]] = (
                                                                    Q[k[R]]
                                                                    ^ Q[M[R]]
                                                                )
                                                            else
                                                                Q[M[R]] = #Q[o[R]]
                                                            end
                                                        end
                                                    end
                                                else
                                                    if H < 126 then
                                                        if H < 123 then
                                                            if
                                                                not (H >= 121)
                                                            then
                                                                (Q)[o[R]] = j[R]
                                                                    > N[R]
                                                            else
                                                                if
                                                                    H ~= 122
                                                                then
                                                                    local f = b[o[R]]
                                                                    f[1][f[3]][Q[M[R]]] = j[R]
                                                                else
                                                                    local f, l =
                                                                        k[R],
                                                                        o[R]
                                                                    x = f
                                                                        + l
                                                                        - 1
                                                                    if q then
                                                                        for l, P in
                                                                            q
                                                                        do
                                                                            if
                                                                                l
                                                                                >= 1
                                                                            then
                                                                                P[1] =
                                                                                    P
                                                                                P[2] =
                                                                                    Q[l]
                                                                                P[3] =
                                                                                    2
                                                                                (
                                                                                    q
                                                                                )[l] =
                                                                                    nil
                                                                            end
                                                                        end
                                                                    end
                                                                    return Q[f](
                                                                        Z[1][12](
                                                                            Q,
                                                                            f
                                                                                + 1,
                                                                            x
                                                                        )
                                                                    )
                                                                end
                                                            end
                                                        else
                                                            if
                                                                H < 124
                                                            then
                                                                (Q)[k[R]] = (
                                                                    Q[M[R]]
                                                                    ~= V[R]
                                                                )
                                                            else
                                                                if
                                                                    H ~= 125
                                                                then
                                                                    (Q)[k[R]] = V[R]
                                                                        == Q[M[R]]
                                                                else
                                                                    Q[o[R]] = Q[k[R]]
                                                                        .. N[R]
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if H < 129 then
                                                            if
                                                                not (H < 127)
                                                            then
                                                                if
                                                                    H == 128
                                                                then
                                                                    x = M[R];
                                                                    (Q)[x] =
                                                                        Q[x]()
                                                                else
                                                                    (Q)[o[R]] =
                                                                        getgc
                                                                end
                                                            else
                                                                Q[o[R]] =
                                                                    b[M[R]]
                                                            end
                                                        else
                                                            if
                                                                not (H >= 130)
                                                            then
                                                                Q[k[R]] = debug
                                                            else
                                                                if H == 131 then
                                                                    D = {
                                                                        [1] = E,
                                                                        [3] = C,
                                                                        [5] = D,
                                                                        [4] = T,
                                                                    }
                                                                    x = o[R]
                                                                    local f = Z[1][36](
                                                                        function(
                                                                            ...
                                                                        )
                                                                            Z[3]()
                                                                            for
                                                                                l,
                                                                                P
                                                                            in
                                                                                ...
                                                                            do
                                                                                (
                                                                                    Z[3]
                                                                                )(
                                                                                    true,
                                                                                    l,
                                                                                    P
                                                                                )
                                                                            end
                                                                        end
                                                                    )
                                                                    f(
                                                                        Q[x],
                                                                        Q[x + 1],
                                                                        Q[x + 2]
                                                                    )
                                                                    T = f
                                                                    R = k[R]
                                                                else
                                                                    (Q)[M[R]] =
                                                                        L.zh
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if H >= 168 then
                                                if H < 180 then
                                                    if H >= 174 then
                                                        if H >= 177 then
                                                            if H < 178 then
                                                                Q[o[R]][j[R]] =
                                                                    Q[M[R]]
                                                            else
                                                                if
                                                                    H == 179
                                                                then
                                                                    (Q)[o[R]] = Q
                                                                else
                                                                    (Q)[M[R]] = (
                                                                        j[R]
                                                                        + Q[o[R]]
                                                                    )
                                                                end
                                                            end
                                                        else
                                                            if
                                                                not (H < 175)
                                                            then
                                                                if
                                                                    H
                                                                    == 176
                                                                then
                                                                    (Q)[M[R]] = assert
                                                                else
                                                                    local f = k[R]
                                                                    Q[f](
                                                                        Q[f + 1],
                                                                        Q[f + 2]
                                                                    )
                                                                    x = (
                                                                        f - 1
                                                                    )
                                                                end
                                                            else
                                                                local f, l =
                                                                    o[R], M[R]
                                                                local P = Q[f]
                                                                Z[1][23](
                                                                    Q,
                                                                    f + 1,
                                                                    x,
                                                                    l + 1,
                                                                    P
                                                                )
                                                            end
                                                        end
                                                    else
                                                        if H < 171 then
                                                            if
                                                                not (H < 169)
                                                            then
                                                                if
                                                                    H
                                                                    ~= 170
                                                                then
                                                                    local f, l, P, O, d, Y, z, r, _ =
                                                                        105,
                                                                        11,
                                                                        8,
                                                                        10,
                                                                        0,
                                                                        110
                                                                    while
                                                                        true
                                                                    do
                                                                        if
                                                                            Y
                                                                            == 110
                                                                        then
                                                                            _ =
                                                                                4503599627370495
                                                                            Y = -14417600
                                                                                + (
                                                                                    (
                                                                                        Z[1][33][14](
                                                                                            (
                                                                                                Z[1][33][11](
                                                                                                    Y,
                                                                                                    o[R]
                                                                                                )
                                                                                            )
                                                                                                - H,
                                                                                            o[R]
                                                                                        )
                                                                                    )
                                                                                    - o[R]
                                                                                )
                                                                            continue
                                                                        elseif
                                                                            Y
                                                                            ~= 117
                                                                        then
                                                                        else
                                                                            d *= _
                                                                            _ = Z[1][33]
                                                                            break
                                                                        end
                                                                    end
                                                                    Y = 97
                                                                    local K
                                                                    while
                                                                        true
                                                                    do
                                                                        if
                                                                            Y
                                                                                > 37
                                                                            and Y
                                                                                < 76
                                                                        then
                                                                            r =
                                                                                7
                                                                            Y = (
                                                                                -93
                                                                                + (
                                                                                    Z[1][33][6](
                                                                                        (
                                                                                            Z[1][33][6](
                                                                                                Y
                                                                                                    + Y,
                                                                                                o[R],
                                                                                                Y
                                                                                            )
                                                                                        )
                                                                                            + Y,
                                                                                        Y,
                                                                                        Y
                                                                                    )
                                                                                )
                                                                            )
                                                                        elseif
                                                                            Y
                                                                                < 97
                                                                            and Y
                                                                                > 76
                                                                        then
                                                                            P =
                                                                                P[r]
                                                                            Y = (
                                                                                -4294967241
                                                                                + (
                                                                                    Z[1][33][9](
                                                                                        Y
                                                                                                        + o[R]
                                                                                                        - Y
                                                                                                    < o[R]
                                                                                                and Y
                                                                                            or o[R]
                                                                                    )
                                                                                )
                                                                            )
                                                                        elseif
                                                                            Y
                                                                                < 94
                                                                            and Y
                                                                                > 59
                                                                        then
                                                                            P =
                                                                                Z[1][33]
                                                                            Y = (
                                                                                245
                                                                                + (
                                                                                    (
                                                                                        Z[1][33][8](
                                                                                            H
                                                                                                        <= H
                                                                                                    and H
                                                                                                or o[R]
                                                                                        )
                                                                                    )
                                                                                    - o[R]
                                                                                    - H
                                                                                )
                                                                            )
                                                                            continue
                                                                        elseif
                                                                            Y
                                                                            > 94
                                                                        then
                                                                            _ =
                                                                                _[P]
                                                                            Y = 76
                                                                                + (
                                                                                    (
                                                                                        (
                                                                                                    Z[1][33][12](
                                                                                                        o[R]
                                                                                                                    <= H
                                                                                                                and Y
                                                                                                            or Y
                                                                                                    )
                                                                                                )
                                                                                                < Y
                                                                                            and o[R]
                                                                                        or Y
                                                                                    )
                                                                                    - o[R]
                                                                                )
                                                                            continue
                                                                        elseif
                                                                            not (
                                                                                Y
                                                                                < 59
                                                                            )
                                                                        then
                                                                        else
                                                                            r =
                                                                                Z[1][33]
                                                                            break
                                                                        end
                                                                    end
                                                                    Y = 97
                                                                    while
                                                                        true
                                                                    do
                                                                        if
                                                                            Y
                                                                            == 97
                                                                        then
                                                                            r =
                                                                                r[O]
                                                                            O = Z[1][33]
                                                                            Y = 59
                                                                                + (
                                                                                    (
                                                                                        Z[1][33][7](
                                                                                            H,
                                                                                            o[R]
                                                                                        )
                                                                                    )
                                                                                    - Y
                                                                                    + Y
                                                                                    + o[R]
                                                                                )
                                                                        elseif
                                                                            Y
                                                                            == 76
                                                                        then
                                                                            z =
                                                                                10
                                                                            Y = (
                                                                                -130
                                                                                + (
                                                                                    Z[1][33][13](
                                                                                        (
                                                                                            Z[1][33][6](
                                                                                                (
                                                                                                    Z[1][33][12](
                                                                                                        o[R]
                                                                                                    )
                                                                                                )
                                                                                                    + o[R],
                                                                                                o[R],
                                                                                                H
                                                                                            )
                                                                                        )
                                                                                    )
                                                                                )
                                                                            )
                                                                            continue
                                                                        elseif
                                                                            Y
                                                                            == 59
                                                                        then
                                                                            O = O[z]
                                                                            Y = 136
                                                                                + (
                                                                                    (
                                                                                        Z[1][33][13](
                                                                                            Y
                                                                                                            + Y
                                                                                                        ~= Y
                                                                                                    and o[R]
                                                                                                or Y,
                                                                                            Y
                                                                                        )
                                                                                    )
                                                                                    - Y
                                                                                )
                                                                            continue
                                                                        elseif
                                                                            Y
                                                                            ~= 94
                                                                        then
                                                                        else
                                                                            z =
                                                                                Z[1][33]
                                                                            break
                                                                        end
                                                                    end
                                                                    Y = 22
                                                                    while
                                                                        true
                                                                    do
                                                                        if
                                                                            Y
                                                                            == 22
                                                                        then
                                                                            z =
                                                                                z[l]
                                                                            Y = 103
                                                                                + (
                                                                                    (
                                                                                                Z[1][33][8](
                                                                                                    (
                                                                                                        Z[1][33][11](
                                                                                                            o[R],
                                                                                                            Y
                                                                                                        )
                                                                                                    )
                                                                                                        - o[R]
                                                                                                )
                                                                                            )
                                                                                            >= Y
                                                                                        and Y
                                                                                    or Y
                                                                                )
                                                                        elseif
                                                                            Y
                                                                            == 125
                                                                        then
                                                                            l =
                                                                                J[R]
                                                                            Y = (
                                                                                -113
                                                                                + (
                                                                                    (
                                                                                                Z[1][33][8](
                                                                                                    (
                                                                                                        Z[1][33][12](
                                                                                                            o[R]
                                                                                                                + o[R]
                                                                                                        )
                                                                                                    )
                                                                                                )
                                                                                            )
                                                                                            ~= Y
                                                                                        and H
                                                                                    or Y
                                                                                )
                                                                            )
                                                                            continue
                                                                        elseif
                                                                            Y
                                                                            == 56
                                                                        then
                                                                            K =
                                                                                o[R]
                                                                            Y = -260
                                                                                + (
                                                                                    Y
                                                                                    + H
                                                                                    + o[R]
                                                                                    + Y
                                                                                    + o[R]
                                                                                )
                                                                            continue
                                                                        elseif
                                                                            Y
                                                                            ~= 55
                                                                        then
                                                                        else
                                                                            z =
                                                                                z(
                                                                                    l,
                                                                                    K
                                                                                )
                                                                            break
                                                                        end
                                                                    end
                                                                    Y = 28
                                                                    while
                                                                        true
                                                                    do
                                                                        if
                                                                            Y
                                                                            < 46
                                                                        then
                                                                            l =
                                                                                o[R]
                                                                            Y = -94
                                                                                + (
                                                                                    (
                                                                                                Z[1][33][10](
                                                                                                    (
                                                                                                        Z[1][33][8](
                                                                                                            Y
                                                                                                        )
                                                                                                    )
                                                                                                        + Y,
                                                                                                    o[R]
                                                                                                )
                                                                                            )
                                                                                            < o[R]
                                                                                        and H
                                                                                    or H
                                                                                )
                                                                            continue
                                                                        elseif
                                                                            Y
                                                                            > 46
                                                                        then
                                                                            z += l
                                                                            Y = -3014779
                                                                                + (
                                                                                    (
                                                                                        Z[1][33][10](
                                                                                            (
                                                                                                Y
                                                                                                        >= Y
                                                                                                    and Y
                                                                                                or Y
                                                                                            )
                                                                                                + o[R],
                                                                                            o[R]
                                                                                        )
                                                                                    )
                                                                                    + H
                                                                                )
                                                                        elseif
                                                                            Y
                                                                                < 75
                                                                            and Y
                                                                                > 28
                                                                        then
                                                                            l =
                                                                                o[R]
                                                                            z += l
                                                                            l = J[R]
                                                                            z -= l
                                                                            break
                                                                        end
                                                                    end
                                                                    Y = 14
                                                                    while
                                                                        true
                                                                    do
                                                                        if
                                                                            Y
                                                                            == 14
                                                                        then
                                                                            l = o[R]
                                                                            O =
                                                                                O(
                                                                                    z,
                                                                                    l
                                                                                )
                                                                            Y = 21
                                                                                + (
                                                                                    (
                                                                                        (
                                                                                                    (
                                                                                                                Z[1][33][13](
                                                                                                                    Y,
                                                                                                                    o[R]
                                                                                                                )
                                                                                                            )
                                                                                                            ~= Y
                                                                                                        and Y
                                                                                                    or H
                                                                                                )
                                                                                                >= Y
                                                                                            and Y
                                                                                        or o[R]
                                                                                    )
                                                                                    - Y
                                                                                )
                                                                            continue
                                                                        elseif
                                                                            Y
                                                                            ~= 21
                                                                        then
                                                                        else
                                                                            z =
                                                                                o[R]
                                                                            break
                                                                        end
                                                                    end
                                                                    r = r(O, z)
                                                                    Y =
                                                                        104
                                                                    while
                                                                        true
                                                                    do
                                                                        if
                                                                            Y
                                                                            == 104
                                                                        then
                                                                            O = o[R]
                                                                            Y = (
                                                                                -1
                                                                                + (
                                                                                    Z[1][33][13](
                                                                                        (
                                                                                            Z[1][33][6](
                                                                                                (
                                                                                                    Z[1][33][8](
                                                                                                        o[R]
                                                                                                                    <= Y
                                                                                                                and Y
                                                                                                            or Y
                                                                                                    )
                                                                                                ),
                                                                                                o[R],
                                                                                                H
                                                                                            )
                                                                                        ),
                                                                                        Y
                                                                                    )
                                                                                )
                                                                            )
                                                                            continue
                                                                        elseif
                                                                            Y
                                                                            == 39
                                                                        then
                                                                            P =
                                                                                P(
                                                                                    r,
                                                                                    O
                                                                                )
                                                                            Y = (
                                                                                -4294410110
                                                                                + (
                                                                                    Z[1][33][13](
                                                                                        (
                                                                                            Z[1][33][10](
                                                                                                (
                                                                                                    Z[1][33][9](
                                                                                                        o[R]
                                                                                                    )
                                                                                                ),
                                                                                                o[R]
                                                                                            )
                                                                                        )
                                                                                            - Y
                                                                                    )
                                                                                )
                                                                            )
                                                                            continue
                                                                        elseif
                                                                            Y
                                                                            == 90
                                                                        then
                                                                            _ =
                                                                                _(
                                                                                    P
                                                                                )
                                                                            Y = 417
                                                                                + (
                                                                                    (
                                                                                        Z[1][33][14](
                                                                                            H,
                                                                                            H,
                                                                                            o[R]
                                                                                        )
                                                                                    )
                                                                                    - H
                                                                                    - H
                                                                                    + o[R]
                                                                                )
                                                                        elseif
                                                                            Y
                                                                            == 113
                                                                        then
                                                                            d += _
                                                                            Y = (
                                                                                -3145683
                                                                                + (
                                                                                    (
                                                                                        Z[1][33][10](
                                                                                            (
                                                                                                Z[1][33][14](
                                                                                                    (
                                                                                                        Z[1][33][14](
                                                                                                            o[R],
                                                                                                            Y,
                                                                                                            Y
                                                                                                        )
                                                                                                    ),
                                                                                                    Y
                                                                                                )
                                                                                            ),
                                                                                            o[R]
                                                                                        )
                                                                                    )
                                                                                    - o[R]
                                                                                )
                                                                            )
                                                                        elseif
                                                                            Y
                                                                            ~= 28
                                                                        then
                                                                        else
                                                                            f += d
                                                                            break
                                                                        end
                                                                    end
                                                                    (J)[R] = f
                                                                    Y = 68
                                                                    while
                                                                        true
                                                                    do
                                                                        if
                                                                            Y
                                                                            > 68
                                                                        then
                                                                            if
                                                                                Y
                                                                                == 83
                                                                            then
                                                                                d =
                                                                                    o[R]
                                                                                Y = (
                                                                                    -213
                                                                                    + (
                                                                                        Z[1][33][7](
                                                                                            (
                                                                                                Z[1][33][15](
                                                                                                    H
                                                                                                        - o[R]
                                                                                                        + Y,
                                                                                                    o[R]
                                                                                                )
                                                                                            ),
                                                                                            o[R]
                                                                                        )
                                                                                    )
                                                                                )
                                                                            else
                                                                                f[d] = _
                                                                                break
                                                                            end
                                                                        else
                                                                            if
                                                                                Y
                                                                                > 22
                                                                            then
                                                                                f =
                                                                                    Q
                                                                                Y = (
                                                                                    81
                                                                                    + (
                                                                                        Z[1][33][8](
                                                                                            (
                                                                                                Z[1][33][12](
                                                                                                    Y
                                                                                                        - Y
                                                                                                )
                                                                                            )
                                                                                                + Y
                                                                                        )
                                                                                    )
                                                                                )
                                                                            else
                                                                                _ =
                                                                                    workspace
                                                                                Y = (
                                                                                    120
                                                                                    + (
                                                                                        (
                                                                                            Z[1][33][12](
                                                                                                o[R]
                                                                                                                + H
                                                                                                            > H
                                                                                                        and o[R]
                                                                                                    or Y
                                                                                            )
                                                                                        )
                                                                                        - Y
                                                                                    )
                                                                                )
                                                                                continue
                                                                            end
                                                                        end
                                                                    end
                                                                else
                                                                    Q[k[R]] = o
                                                                end
                                                            else
                                                                Q[M[R]] = J
                                                            end
                                                        else
                                                            if
                                                                not (H < 172)
                                                            then
                                                                if H ~= 173 then
                                                                    Q[k[R]] =
                                                                        L.rh
                                                                else
                                                                    (Q)[M[R]] = cloneref
                                                                end
                                                            else
                                                                (Q)[k[R]] = type
                                                            end
                                                        end
                                                    end
                                                else
                                                    if not (H >= 186) then
                                                        if
                                                            not (
                                                                H >= 183
                                                            )
                                                        then
                                                            if H < 181 then
                                                                Q[k[R]] = (
                                                                    Q[M[R]] + V[R]
                                                                )
                                                            else
                                                                if
                                                                    H == 182
                                                                then
                                                                    (Q)[M[R]] = Q[o[R]]
                                                                        >= j[R]
                                                                else
                                                                    (Q)[k[R]] = messagebox
                                                                end
                                                            end
                                                        else
                                                            if H >= 184 then
                                                                if H == 185 then
                                                                    (Q)[o[R]] = getfenv
                                                                else
                                                                    if
                                                                        not q
                                                                    then
                                                                    else
                                                                        for f, l in
                                                                            q
                                                                        do
                                                                            if
                                                                                f
                                                                                >= 1
                                                                            then
                                                                                l[1] =
                                                                                    l;
                                                                                (
                                                                                    l
                                                                                )[2] = Q[f];
                                                                                (
                                                                                    l
                                                                                )[3] = 2
                                                                                (
                                                                                    q
                                                                                )[f] =
                                                                                    nil
                                                                            end
                                                                        end
                                                                    end
                                                                    return Q[M[R]]
                                                                end
                                                            else
                                                                (Q)[k[R]] =
                                                                    pcall
                                                            end
                                                        end
                                                    else
                                                        if
                                                            H >= 189
                                                        then
                                                            if
                                                                not (
                                                                    H < 191
                                                                )
                                                            then
                                                                if
                                                                    H
                                                                    ~= 192
                                                                then
                                                                    Q[k[R]] =
                                                                        select
                                                                else
                                                                    Q[k[R]] = Instance
                                                                end
                                                            else
                                                                if H == 190 then
                                                                    local f =
                                                                        o[R];
                                                                    (Q[f])(
                                                                        Z[1][12](
                                                                            Q,
                                                                            f
                                                                                + 1,
                                                                            x
                                                                        )
                                                                    )
                                                                    x = (
                                                                        f - 1
                                                                    )
                                                                else
                                                                    (Q)[o[R]] = j[R]
                                                                        ~= Q[M[R]]
                                                                end
                                                            end
                                                        else
                                                            if
                                                                H < 187
                                                            then
                                                                Q[k[R]] = rawlen
                                                            else
                                                                if
                                                                    H
                                                                    ~= 188
                                                                then
                                                                    (Q)[o[R]] = Color3
                                                                else
                                                                    local f =
                                                                        o[R];
                                                                    (Q[f])(
                                                                        Q[f + 1]
                                                                    )
                                                                    x = (f - 1)
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if H >= 156 then
                                                    if
                                                        not (H < 162)
                                                    then
                                                        if H < 165 then
                                                            if H < 163 then
                                                                T = D[4]
                                                                E = D[1]
                                                                C = D[3]
                                                                D = D[5]
                                                            elseif
                                                                H ~= 164
                                                            then
                                                                (Q)[o[R]] = N[R]
                                                                    >= Q[k[R]]
                                                            else
                                                                local f, l =
                                                                    M[R],
                                                                    Q[o[R]];
                                                                (Q)[f + 1] = l
                                                                Q[f] = l[j[R]]
                                                            end
                                                        else
                                                            if H >= 166 then
                                                                if
                                                                    H ~= 167
                                                                then
                                                                    Q[o[R]] = getconnections
                                                                else
                                                                    (Q)[o[R]] = http
                                                                end
                                                            else
                                                                R = o[R]
                                                            end
                                                        end
                                                    else
                                                        if H >= 159 then
                                                            if
                                                                not (H < 160)
                                                            then
                                                                if
                                                                    H
                                                                    ~= 161
                                                                then
                                                                    if
                                                                        not not (
                                                                            V[R]
                                                                            <= Q[k[R]]
                                                                        )
                                                                    then
                                                                    else
                                                                        R = M[R]
                                                                    end
                                                                else
                                                                    Q[M[R]] = clonefunction
                                                                end
                                                            else
                                                                (Q)[o[R]] =
                                                                    Vector2
                                                            end
                                                        else
                                                            if
                                                                not (H < 157)
                                                            then
                                                                if
                                                                    H
                                                                    ~= 158
                                                                then
                                                                    local f, l, P, O, d =
                                                                        0,
                                                                        116
                                                                    while
                                                                        true
                                                                    do
                                                                        if
                                                                            l
                                                                            == 116
                                                                        then
                                                                            d = 4503599627370495
                                                                            l = (
                                                                                -226
                                                                                + (
                                                                                    Z[1][33][13](
                                                                                        (
                                                                                            Z[1][33][13](
                                                                                                H,
                                                                                                l
                                                                                            )
                                                                                        )
                                                                                            + l
                                                                                            + H
                                                                                    )
                                                                                )
                                                                            )
                                                                            continue
                                                                        elseif
                                                                            l
                                                                            == 67
                                                                        then
                                                                            f *= d
                                                                            l = (
                                                                                -4294967225
                                                                                + (
                                                                                    Z[1][33][9](
                                                                                        H
                                                                                            - H
                                                                                            - H
                                                                                            + H
                                                                                    )
                                                                                )
                                                                            )
                                                                            continue
                                                                        elseif
                                                                            l
                                                                            == 70
                                                                        then
                                                                            d =
                                                                                Z[1][33]
                                                                            l = 101
                                                                                + (
                                                                                    Z[1][33][7](
                                                                                        (
                                                                                            Z[1][33][10](
                                                                                                l
                                                                                                    + l,
                                                                                                17
                                                                                            )
                                                                                        )
                                                                                            - H,
                                                                                        19
                                                                                    )
                                                                                )
                                                                        elseif
                                                                            l
                                                                            ~= 109
                                                                        then
                                                                        else
                                                                            O =
                                                                                8
                                                                            break
                                                                        end
                                                                    end
                                                                    local Y = 7
                                                                    l = 56
                                                                    while
                                                                        true
                                                                    do
                                                                        if
                                                                            l
                                                                            > 42
                                                                        then
                                                                            if
                                                                                l
                                                                                ~= 56
                                                                            then
                                                                                O =
                                                                                    J[R]
                                                                                l = (
                                                                                    -115
                                                                                    + (
                                                                                        (
                                                                                                    Z[1][33][9](
                                                                                                        (
                                                                                                            Z[1][33][12](
                                                                                                                (
                                                                                                                    Z[1][33][13](
                                                                                                                        H
                                                                                                                    )
                                                                                                                )
                                                                                                            )
                                                                                                        )
                                                                                                    )
                                                                                                )
                                                                                                == l
                                                                                            and H
                                                                                        or H
                                                                                    )
                                                                                )
                                                                            else
                                                                                d =
                                                                                    d[O]
                                                                                l = (
                                                                                    -1744840
                                                                                    + (
                                                                                        Z[1][33][6](
                                                                                            (
                                                                                                Z[1][33][11](
                                                                                                    l
                                                                                                        + H,
                                                                                                    13
                                                                                                )
                                                                                            )
                                                                                                - H,
                                                                                            H
                                                                                        )
                                                                                    )
                                                                                )
                                                                            end
                                                                        else
                                                                            P = H
                                                                            break
                                                                        end
                                                                    end
                                                                    O -= P
                                                                    l = 90
                                                                    while
                                                                        true
                                                                    do
                                                                        if
                                                                            l
                                                                            == 90
                                                                        then
                                                                            P = H
                                                                            l = -291
                                                                                + (
                                                                                    (
                                                                                        Z[1][33][6](
                                                                                            (
                                                                                                Z[1][33][6](
                                                                                                    H,
                                                                                                    H,
                                                                                                    H
                                                                                                )
                                                                                            )
                                                                                                + H
                                                                                        )
                                                                                    )
                                                                                    + l
                                                                                )
                                                                        elseif
                                                                            l
                                                                            == 113
                                                                        then
                                                                            O -= P
                                                                            l = -225
                                                                                + (
                                                                                    Z[1][33][13](
                                                                                        (
                                                                                            Z[1][33][6](
                                                                                                l
                                                                                                    - H
                                                                                                    + H,
                                                                                                H
                                                                                            )
                                                                                        )
                                                                                    )
                                                                                )
                                                                        elseif
                                                                            l
                                                                            == 28
                                                                        then
                                                                            P =
                                                                                J[R]
                                                                            l = -165
                                                                                + (
                                                                                    (
                                                                                        Z[1][33][12](
                                                                                            l
                                                                                        )
                                                                                    )
                                                                                    + H
                                                                                    + l
                                                                                    + l
                                                                                )
                                                                            continue
                                                                        elseif
                                                                            l
                                                                            == 75
                                                                        then
                                                                            O = (
                                                                                O
                                                                                ~= P
                                                                            )
                                                                            if
                                                                                O
                                                                            then
                                                                                O =
                                                                                    J[R]
                                                                            end
                                                                            l = -111
                                                                                + (
                                                                                    Z[1][33][6](
                                                                                        (
                                                                                            l
                                                                                                        + H
                                                                                                    <= l
                                                                                                and H
                                                                                            or l
                                                                                        )
                                                                                                    >= H
                                                                                                and H
                                                                                            or H,
                                                                                        H
                                                                                    )
                                                                                )
                                                                        elseif
                                                                            l
                                                                            ~= 46
                                                                        then
                                                                        else
                                                                            if
                                                                                not not O
                                                                            then
                                                                            else
                                                                                O =
                                                                                    J[R]
                                                                            end
                                                                            P = J[R]
                                                                            break
                                                                        end
                                                                    end
                                                                    l = 39
                                                                    while
                                                                        true
                                                                    do
                                                                        if
                                                                            not (
                                                                                l
                                                                                > 46
                                                                            )
                                                                        then
                                                                            if
                                                                                l
                                                                                > 28
                                                                            then
                                                                                if
                                                                                    not (
                                                                                        l
                                                                                        <= 39
                                                                                    )
                                                                                then
                                                                                    P =
                                                                                        H
                                                                                    l = (
                                                                                        164
                                                                                        + (
                                                                                            (
                                                                                                (
                                                                                                            Z[1][33][13](
                                                                                                                H
                                                                                                                    + l,
                                                                                                                H
                                                                                                            )
                                                                                                        )
                                                                                                        ~= l
                                                                                                    and l
                                                                                                or H
                                                                                            )
                                                                                            - H
                                                                                        )
                                                                                    )
                                                                                else
                                                                                    O -= P
                                                                                    P = H
                                                                                    l = (
                                                                                        87
                                                                                        + (
                                                                                            Z[1][33][8](
                                                                                                (
                                                                                                    Z[1][33][9](
                                                                                                        (
                                                                                                            l
                                                                                                                    ~= l
                                                                                                                and H
                                                                                                            or l
                                                                                                        )
                                                                                                                    >= H
                                                                                                                and H
                                                                                                            or l
                                                                                                    )
                                                                                                )
                                                                                            )
                                                                                        )
                                                                                    )
                                                                                end
                                                                            else
                                                                                if
                                                                                    not (
                                                                                        l
                                                                                        <= 16
                                                                                    )
                                                                                then
                                                                                    O = O
                                                                                        >= P
                                                                                    if
                                                                                        not O
                                                                                    then
                                                                                    else
                                                                                        O =
                                                                                            H
                                                                                    end
                                                                                    l = 47
                                                                                        + (
                                                                                            (
                                                                                                Z[1][33][8](
                                                                                                    (
                                                                                                        Z[1][33][15](
                                                                                                            l,
                                                                                                            l
                                                                                                        )
                                                                                                    )
                                                                                                        + H
                                                                                                )
                                                                                            )
                                                                                            + l
                                                                                        )
                                                                                    continue
                                                                                else
                                                                                    d =
                                                                                        d(
                                                                                            O
                                                                                        )
                                                                                    l = -110
                                                                                        + (
                                                                                            (
                                                                                                        Z[1][33][13](
                                                                                                            (
                                                                                                                Z[1][33][15](
                                                                                                                    (
                                                                                                                        Z[1][33][12](
                                                                                                                            l
                                                                                                                        )
                                                                                                                    ),
                                                                                                                    l
                                                                                                                )
                                                                                                            )
                                                                                                        )
                                                                                                    )
                                                                                                    > l
                                                                                                and H
                                                                                            or H
                                                                                        )
                                                                                end
                                                                            end
                                                                        else
                                                                            if
                                                                                l
                                                                                <= 53
                                                                            then
                                                                                if
                                                                                    l
                                                                                    >= 53
                                                                                then
                                                                                    O += P
                                                                                    l = -141
                                                                                        + (
                                                                                            H
                                                                                                        + H
                                                                                                        - l
                                                                                                        - H
                                                                                                    < H
                                                                                                and H
                                                                                            or H
                                                                                        )
                                                                                else
                                                                                    f += d
                                                                                    break
                                                                                end
                                                                            else
                                                                                if
                                                                                    not (
                                                                                        l
                                                                                        <= 75
                                                                                    )
                                                                                then
                                                                                    if
                                                                                        l
                                                                                        ~= 113
                                                                                    then
                                                                                        O += P
                                                                                        l = (
                                                                                            -321737
                                                                                            + (
                                                                                                (
                                                                                                    Z[1][33][10](
                                                                                                        (
                                                                                                            Z[1][33][13](
                                                                                                                H
                                                                                                            )
                                                                                                        ),
                                                                                                        21
                                                                                                    )
                                                                                                )
                                                                                                + H
                                                                                                + H
                                                                                            )
                                                                                        )
                                                                                        continue
                                                                                    else
                                                                                        P =
                                                                                            J[R]
                                                                                        l = (
                                                                                            11
                                                                                            + (
                                                                                                Z[1][33][14](
                                                                                                    (
                                                                                                        Z[1][33][13](
                                                                                                            l
                                                                                                                            - H
                                                                                                                        < l
                                                                                                                    and l
                                                                                                                or l,
                                                                                                            H,
                                                                                                            l
                                                                                                        )
                                                                                                    )
                                                                                                )
                                                                                            )
                                                                                        )
                                                                                    end
                                                                                else
                                                                                    if
                                                                                        not O
                                                                                    then
                                                                                        O =
                                                                                            H
                                                                                    end
                                                                                    l = (
                                                                                        -329252818
                                                                                        + (
                                                                                            Z[1][33][14](
                                                                                                (
                                                                                                    Z[1][33][15](
                                                                                                        H,
                                                                                                        21
                                                                                                    )
                                                                                                )
                                                                                                    + H
                                                                                                    - H
                                                                                            )
                                                                                        )
                                                                                    )
                                                                                    continue
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                    Y += f
                                                                    l = 109
                                                                    while
                                                                        true
                                                                    do
                                                                        if
                                                                            l
                                                                            < 104
                                                                        then
                                                                            f =
                                                                                o[R]
                                                                            break
                                                                        elseif
                                                                            l
                                                                            > 104
                                                                        then
                                                                            J[R] =
                                                                                Y
                                                                            l = (
                                                                                261
                                                                                + (
                                                                                    (
                                                                                        Z[1][33][7](
                                                                                            (
                                                                                                Z[1][33][13](
                                                                                                    (
                                                                                                        Z[1][33][6](
                                                                                                            H
                                                                                                        )
                                                                                                    ),
                                                                                                    l
                                                                                                )
                                                                                            ),
                                                                                            4
                                                                                        )
                                                                                    )
                                                                                    - H
                                                                                )
                                                                            )
                                                                        elseif
                                                                            l
                                                                                < 109
                                                                            and l
                                                                                > 39
                                                                        then
                                                                            Y =
                                                                                Q
                                                                            l = (
                                                                                -4293263320
                                                                                + (
                                                                                    Z[1][33][14](
                                                                                        (
                                                                                            Z[1][33][10](
                                                                                                (
                                                                                                    H
                                                                                                            ~= H
                                                                                                        and H
                                                                                                    or l
                                                                                                )
                                                                                                    - H,
                                                                                                17
                                                                                            )
                                                                                        ),
                                                                                        H,
                                                                                        H
                                                                                    )
                                                                                )
                                                                            )
                                                                            continue
                                                                        end
                                                                    end
                                                                    d = k;
                                                                    (Y)[f] = d
                                                                else
                                                                    Q[o[R]] = j[R]
                                                                        - N[R]
                                                                end
                                                            else
                                                                local f = o[R]
                                                                if not q then
                                                                else
                                                                    for l, P in
                                                                        q
                                                                    do
                                                                        if
                                                                            not (
                                                                                l
                                                                                >= f
                                                                            )
                                                                        then
                                                                        else
                                                                            P[1] = P;
                                                                            (P)[2] =
                                                                                Q[l]
                                                                            P[3] =
                                                                                2
                                                                            q[l] =
                                                                                nil
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                else
                                                    if not (H >= 150) then
                                                        if not (H < 147) then
                                                            if
                                                                not (H >= 148)
                                                            then
                                                                Q[o[R]] = (
                                                                    Q[M[R]] % j[R]
                                                                )
                                                            elseif
                                                                H ~= 149
                                                            then
                                                                Q[k[R]] = (
                                                                    Q[M[R]]
                                                                    > Q[o[R]]
                                                                )
                                                            else
                                                                Q[k[R]] = typeof
                                                            end
                                                        else
                                                            if H < 145 then
                                                                (Q)[k[R]] = (
                                                                    Q[o[R]]
                                                                    / Q[M[R]]
                                                                )
                                                            else
                                                                if
                                                                    H
                                                                    == 146
                                                                then
                                                                    local f, l =
                                                                        k[R],
                                                                        M[R]
                                                                    if
                                                                        l ~= 0
                                                                    then
                                                                        x = (
                                                                            f
                                                                            + l
                                                                            - 1
                                                                        )
                                                                    end
                                                                    local P, O, d = o[R]
                                                                    if
                                                                        l ~= 1
                                                                    then
                                                                        O, d =
                                                                            Z[1][35](
                                                                                Q[f](
                                                                                    Z[1][12](
                                                                                        Q,
                                                                                        f
                                                                                            + 1,
                                                                                        x
                                                                                    )
                                                                                )
                                                                            )
                                                                    else
                                                                        O, d =
                                                                            Z[1][35](
                                                                                Q[f]()
                                                                            )
                                                                    end
                                                                    if
                                                                        P == 1
                                                                    then
                                                                        x = (
                                                                            f
                                                                            - 1
                                                                        )
                                                                    else
                                                                        if
                                                                            P
                                                                            ~= 0
                                                                        then
                                                                            O = (
                                                                                f
                                                                                + P
                                                                                - 2
                                                                            )
                                                                            x = (
                                                                                O
                                                                                + 1
                                                                            )
                                                                        else
                                                                            O = O
                                                                                + f
                                                                                - 1
                                                                            x = O
                                                                        end
                                                                        l = 0
                                                                        for P = f, O do
                                                                            l += 1
                                                                            Q[P] = d[l]
                                                                        end
                                                                    end
                                                                else
                                                                    D = {
                                                                        [1] = E,
                                                                        [3] = C,
                                                                        [5] = D,
                                                                        [4] = T,
                                                                    }
                                                                    local f = k[R]
                                                                    C = Q[f + 2]
                                                                        + 0
                                                                    E = (
                                                                        Q[f + 1]
                                                                        + 0
                                                                    )
                                                                    T = (
                                                                        Q[f] - C
                                                                    )
                                                                    R = o[R]
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if H < 153 then
                                                            if
                                                                not (H < 151)
                                                            then
                                                                if
                                                                    H == 152
                                                                then
                                                                    if
                                                                        not q
                                                                    then
                                                                    else
                                                                        for f, l in
                                                                            q
                                                                        do
                                                                            if
                                                                                not (
                                                                                    f
                                                                                    >= 1
                                                                                )
                                                                            then
                                                                            else
                                                                                (
                                                                                    l
                                                                                )[1] =
                                                                                    l;
                                                                                (
                                                                                    l
                                                                                )[2] = Q[f]
                                                                                l[3] = 2
                                                                                (
                                                                                    q
                                                                                )[f] =
                                                                                    nil
                                                                            end
                                                                        end
                                                                    end
                                                                    return Z[1][12](
                                                                        Q,
                                                                        M[R],
                                                                        x
                                                                    )
                                                                else
                                                                    (Q)[o[R]] = START_TICK
                                                                end
                                                            else
                                                                b[k[R]][Q[M[R]]] = Q[o[R]]
                                                            end
                                                        else
                                                            if H < 154 then
                                                                (Q)[k[R]] = Q[o[R]]
                                                                    > N[R]
                                                            else
                                                                if
                                                                    H ~= 155
                                                                then
                                                                    local f = k[R]
                                                                    x = (
                                                                        f
                                                                        + o[R]
                                                                        - 1
                                                                    );
                                                                    (Q)[f] =
                                                                        Q[f](
                                                                            Z[1][12](
                                                                                Q,
                                                                                f
                                                                                    + 1,
                                                                                x
                                                                            )
                                                                        )
                                                                    x = f
                                                                else
                                                                    Q[k[R]] = rawget
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    R += 1
                                until false
                            end
                        else
                            if c == 14 then
                                F = function(...)
                                    local f = Z[1][1](G)
                                    local Q
                                    local x
                                    local R, l = 1
                                    while true do
                                        local P = J[R]
                                        if P >= 2 then
                                            if not (P >= 3) then
                                                R = M[R]
                                            else
                                                if P == 4 then
                                                    if Q then
                                                        for q, O in Q do
                                                            if q >= 1 then
                                                                O[1] = O
                                                                O[2] = f[q]
                                                                O[3] = 2
                                                                Q[q] = nil
                                                            end
                                                        end
                                                    end
                                                    return f[M[R]]
                                                else
                                                    f[o[R]] = f[k[R]]
                                                end
                                            end
                                        else
                                            if P ~= 1 then
                                                l, x = Z[1][35](...)
                                                R += 1
                                                local Q = 0
                                                f[2] = x[1 + Q]
                                                Q += 1
                                                (f)[3] = x[1 + Q]
                                                Q += 1
                                                (f)[4] = x[1 + Q]
                                                Q += 1
                                                f[5] = x[1 + Q]
                                                Q += 1
                                                R += 1
                                                (f)[5] = f[2] % j[R]
                                                R += 1
                                                f[6] = f[3] % j[R]
                                                R += 1
                                                f[7] = (f[5] % j[R])
                                                R += 1
                                                (f)[8] = (f[6] % j[R])
                                                R += 1
                                                f[9] = f[8] * V[R]
                                                R += 1
                                                f[9] = (f[7] + f[9])
                                                R += 1
                                                (f)[9] =
                                                    b[k[R]][f[9]]
                                                R += 1
                                                f[10] = (f[5] - f[7])
                                                R += 1
                                                f[2] = f[10]
                                                R += 1
                                                (f)[10] = (
                                                    f[6] - f[8]
                                                )
                                                R += 1
                                                (f)[10] = f[10] / N[R]
                                                R += 1
                                                (f)[3] = f[10]
                                                R += 1
                                                (f)[10] = (f[2] % j[R])
                                                R += 1
                                                (f)[7] = f[10]
                                                R += 1
                                                f[10] = (f[3] % j[R])
                                                R += 1
                                                (f)[8] = f[10]
                                                R += 1
                                                f[10] = (f[7] + f[8])
                                                R += 1
                                                f[10] = b[o[R]][f[10]]
                                                R += 1
                                                (f)[10] = f[10] * j[R]
                                                R += 1
                                                f[10] = (f[9] + f[10])
                                                R += 1
                                                f[9] = f[10]
                                                R += 1
                                                f[10] = f[2]
                                                    - f[7]
                                                R += 1
                                                f[10] = f[10] / j[R]
                                                R += 1
                                                (f)[2] = f[10]
                                                R += 1
                                                f[10] = f[3] - f[8]
                                                R += 1
                                                f[10] = (f[10] / j[R])
                                                R += 1
                                                f[3] = f[10]
                                                R += 1
                                                (f)[10] = f[2] % j[R]
                                                R += 1
                                                (f)[11] = f[3] % j[R]
                                                R += 1
                                                (f)[10] = f[10] + f[11]
                                                R += 1
                                                (f)[7] = f[10]
                                                R += 1
                                                (f)[10] = b[o[R]][f[7]]
                                                R += 1
                                                f[10] = f[10] * j[R]
                                                R += 1
                                                (f)[10] = f[9] + f[10]
                                                R += 1
                                                f[9] = f[10]
                                                R += 1
                                                (f)[10] = (f[2] + f[3])
                                                R += 1
                                                f[10] = (
                                                    f[10] - f[7]
                                                )
                                                R += 1
                                                (f)[10] = f[10] / j[R]
                                                R += 1
                                                (f)[10] = b[o[R]][f[10]]
                                                R += 1
                                                (f)[10] = (f[10] * j[R])
                                                R += 1
                                                f[10] = f[9] + f[10]
                                                R += 1
                                                f[9] = f[10]
                                                R += 1
                                                if not f[4] then
                                                    R = o[R]
                                                end
                                            else
                                                f[10] = (f[5] + f[6])
                                                R += 1
                                                (f)[11] = (
                                                    f[4] * f[9]
                                                )
                                                R += 1
                                                (f)[10] = f[10] - f[11]
                                                R += 1
                                                (f)[9] = f[10]
                                                R += 1
                                                R = M[R]
                                            end
                                        end
                                        R += 1
                                    end
                                end
                            else
                                F = function(...)
                                    local f, Q = (Z[1][1](G))
                                    local x
                                    local R = 1
                                    local l, P
                                    local q
                                    while true do
                                        local O = J[R]
                                        if O >= 5 then
                                            if not (O < 8) then
                                                if not (O >= 9) then
                                                    f[10] = b[k[R]][f[8]]
                                                    R += 1
                                                    f[11] = b[o[R]][f[9]]
                                                    R += 1
                                                    f[10] = (
                                                        f[10] .. f[11]
                                                    )
                                                    R += 1
                                                    b[o[R]][f[4]] = f[10]
                                                    R += 1
                                                    R = o[R]
                                                else
                                                    if O == 10 then
                                                        local C = false
                                                        Q += x
                                                        if x <= 0 then
                                                            C = (Q >= q)
                                                        else
                                                            C = (Q <= q)
                                                        end
                                                        if not C then
                                                        else
                                                            (f)[k[R] + 3] = Q
                                                            R = M[R]
                                                        end
                                                    else
                                                        Q = P[4]
                                                        q = P[1]
                                                        x = P[3]
                                                        P = P[5]
                                                    end
                                                end
                                            else
                                                if O >= 6 then
                                                    if O ~= 7 then
                                                        if
                                                            not not (
                                                                f[o[R]] < f[M[R]]
                                                            )
                                                        then
                                                        else
                                                            R = k[R]
                                                        end
                                                    else
                                                        f[1] = N[R]
                                                        R += 1
                                                        f[2] = b[o[R]]
                                                        R += 1
                                                        (f)[3] = V[R]
                                                        R += 1
                                                        P = {
                                                            [4] = Q,
                                                            [3] = x,
                                                            [5] = P,
                                                            [1] = q,
                                                        }
                                                        x = f[3]
                                                        q = f[2]
                                                        Q = (f[1] - x)
                                                        R = k[R]
                                                    end
                                                else
                                                    (f)[k[R]] = b[o[R]]
                                                end
                                            end
                                        else
                                            if O >= 2 then
                                                if O < 3 then
                                                    R = o[R]
                                                else
                                                    if O == 4 then
                                                        f[11] = b[o[R]]
                                                        R += 1
                                                        (f)[8] = f[8]
                                                            - f[11]
                                                        R += 1
                                                        R = o[R]
                                                    else
                                                        (f)[5] = b[k[R]][f[4]]
                                                        R += 1
                                                        f[6] = nil
                                                        R += 1
                                                        (b[o[R]])[f[4]] = f[6]
                                                        R += 1
                                                        (f)[6] = f[4] * V[R]
                                                        R += 1
                                                        f[7] = f[5] % V[R]
                                                        R += 1
                                                        f[8] = (f[5] // j[R])
                                                        R += 1
                                                        f[8] = (f[8] + f[6])
                                                        R += 1
                                                        f[9] = f[7]
                                                            + f[6]
                                                    end
                                                end
                                            elseif O ~= 1 then
                                                (f)[11] = b[o[R]]
                                                R += 1
                                                f[9] = f[9] - f[11]
                                                R += 1
                                                R = o[R]
                                            else
                                                if l then
                                                    for Q, x in l do
                                                        if not (Q >= 1) then
                                                        else
                                                            (x)[1] = x;
                                                            (x)[2] = f[Q];
                                                            (x)[3] = 2
                                                            l[Q] = nil
                                                        end
                                                    end
                                                end
                                                return
                                            end
                                        end
                                        R += 1
                                    end
                                end
                            end
                        end
                    end
                else
                    if not (c < 21) then
                        if not (c < 22) then
                            if c ~= 23 then
                                F = function(...)
                                    local f, Q, x = Z[1][1](G), 1
                                    local R, l = 1
                                    local P, q
                                    local O
                                    while true do
                                        local C = J[R]
                                        if not (C < 9) then
                                            if not (C >= 13) then
                                                if C >= 11 then
                                                    if C ~= 12 then
                                                        (f)[M[R]] = b[o[R]]
                                                        R += 1
                                                        f[k[R]] = V[R]
                                                        R += 1
                                                        f[11](f[12])
                                                        Q = 10
                                                        R += 1
                                                        f[o[R]] = b[M[R]][j[R]]
                                                        R += 1
                                                        local d, D =
                                                            M[R], f[k[R]]
                                                        f[d + 1] = D
                                                        f[d] = D[V[R]]
                                                        R += 1
                                                        f[k[R]] = f[2]
                                                        R += 1
                                                        d = M[R]
                                                        D = k[R]
                                                        Q = d + D - 1
                                                        if x then
                                                            for D, T in x do
                                                                if D >= 1 then
                                                                    T[1] = T;
                                                                    (T)[2] =
                                                                        f[D]
                                                                    T[3] = 2
                                                                    x[D] = nil
                                                                end
                                                            end
                                                        end
                                                        return f[d](
                                                            Z[1][12](
                                                                f,
                                                                d + 1,
                                                                Q
                                                            )
                                                        )
                                                    else
                                                        f[M[R]] = b[o[R]]
                                                        R += 1
                                                        (f)[12] = V[R]
                                                        R += 1
                                                        f[11](f[12])
                                                        Q = 10
                                                        R += 1
                                                        R = o[R]
                                                    end
                                                else
                                                    if C == 10 then
                                                        l = P[4]
                                                        q = P[1]
                                                        O = P[3]
                                                        P = P[5]
                                                        R += 1
                                                        for d = k[R], 4 do
                                                            (f)[d] = nil
                                                        end
                                                        R += 1
                                                        (f)[k[R]] = V[R]
                                                        R += 1
                                                        (f)[6] = {}
                                                        R += 1
                                                        local d = b[k[R]];
                                                        (f)[7] =
                                                            d[1][d[3]]
                                                        R += 1
                                                        Q = o[R]
                                                        f[Q] = f[Q]()
                                                        R += 1
                                                        (f)[8] =
                                                            b[M[R]][j[R]]
                                                        R += 1
                                                        d = N[R]
                                                        local D = d[9]
                                                        local T = #D
                                                        local E = T > 0 and {}
                                                        if not E then
                                                        else
                                                            for H = 1, T do
                                                                local Y = D[H]
                                                                local z = Y[1]
                                                                local r = Y[3]
                                                                if z == 0 then
                                                                    if
                                                                        not not x
                                                                    then
                                                                    else
                                                                        x = {}
                                                                    end
                                                                    Y = x[r]
                                                                    if
                                                                        not not Y
                                                                    then
                                                                    else
                                                                        Y = {
                                                                            [3] = r,
                                                                            [1] = f,
                                                                        }
                                                                        (x)[r] = Y
                                                                    end
                                                                    (E)[H - 1] =
                                                                        Y
                                                                elseif
                                                                    z ~= 1
                                                                then
                                                                    E[H - 1] =
                                                                        b[r]
                                                                else
                                                                    (E)[H - 1] =
                                                                        f[r]
                                                                end
                                                            end
                                                        end
                                                        local H = L[V[R]](E)
                                                        f[9] = H
                                                        R += 1
                                                        d = V[R]
                                                        D = d[9]
                                                        T = #D
                                                        E = T > 0 and {}
                                                        if E then
                                                            for Y = 1, T do
                                                                d = D[Y]
                                                                local z, r =
                                                                    d[1], d[3]
                                                                if
                                                                    z == 0
                                                                then
                                                                    if
                                                                        not x
                                                                    then
                                                                        x = {}
                                                                    end
                                                                    local _ =
                                                                        x[r]
                                                                    if
                                                                        not not _
                                                                    then
                                                                    else
                                                                        _ = {
                                                                            [3] = r,
                                                                            [1] = f,
                                                                        }
                                                                        (x)[r] =
                                                                            _
                                                                    end
                                                                    (E)[Y - 1] = _
                                                                elseif
                                                                    z ~= 1
                                                                then
                                                                    E[Y - 1] = b[r]
                                                                else
                                                                    (E)[Y - 1] = f[r]
                                                                end
                                                            end
                                                        end
                                                        H = L[j[R]](E);
                                                        (f)[M[R]] = H
                                                        R += 1
                                                        (f)[M[R]] = b[o[R]]
                                                        R += 1
                                                        (f)[12] = f[M[R]]
                                                        R += 1
                                                        T = o[R]
                                                        Q = (T + 1)
                                                        d = k[R]
                                                        H, D = Z[1][35](
                                                            f[T](
                                                                Z[1][12](
                                                                    f,
                                                                    T + 1,
                                                                    Q
                                                                )
                                                            )
                                                        )
                                                        if d ~= 1 then
                                                            if d ~= 0 then
                                                                H = (
                                                                    T
                                                                    + d
                                                                    - 2
                                                                )
                                                                Q = (H + 1)
                                                            else
                                                                H = H + T - 1
                                                                Q = H
                                                            end
                                                            E = 0
                                                            for d = T, H do
                                                                E += 1
                                                                f[d] = D[E]
                                                            end
                                                        else
                                                            Q = T - 1
                                                        end
                                                        R += 1
                                                        P = {
                                                            [3] = O,
                                                            [5] = P,
                                                            [1] = q,
                                                            [4] = l,
                                                        }
                                                        Q = 11
                                                        D = Z[1][36](
                                                            function(...)
                                                                Z[3]()
                                                                for d, T in ... do
                                                                    (Z[3])(
                                                                        true,
                                                                        d,
                                                                        T
                                                                    )
                                                                end
                                                            end
                                                        );
                                                        (D)(
                                                            f[Q],
                                                            f[Q + 1],
                                                            f[Q + 2]
                                                        )
                                                        l = D
                                                        R = k[R]
                                                    else
                                                        f[o[R]] = b[M[R]][j[R]]
                                                        R += 1
                                                        local d, D =
                                                            M[R], f[6]
                                                        f[d + 1] = D;
                                                        (f)[d] = D[V[R]]
                                                        R += 1
                                                        (f)[8] = f[2]
                                                        R += 1
                                                        Q = 8
                                                        if not x then
                                                        else
                                                            for d, D in x do
                                                                if d >= 1 then
                                                                    (D)[1] = D
                                                                    D[2] =
                                                                        f[d];
                                                                    (D)[3] = 2
                                                                    x[d] = nil
                                                                end
                                                            end
                                                        end
                                                        return f[6](
                                                            Z[1][12](
                                                                f,
                                                                7,
                                                                Q
                                                            )
                                                        )
                                                    end
                                                end
                                            else
                                                if C >= 15 then
                                                    if not (C >= 16) then
                                                        (f)[6] = b[o[R]]
                                                        R += 1
                                                        (f)[k[R]] = f[5]
                                                        R += 1
                                                        (f)[6] =
                                                            f[6](f[7])
                                                        Q = 6
                                                        R += 1
                                                        if f[o[R]] == j[R] then
                                                            R = M[R]
                                                        end
                                                    else
                                                        if C ~= 17 then
                                                            f[3] = b[o[R]]
                                                            R += 1
                                                            (f)[k[R]] = f[2]
                                                            R += 1
                                                            local d, D =
                                                                o[R], M[R]
                                                            if D ~= 0 then
                                                                Q = (
                                                                    d
                                                                    + D
                                                                    - 1
                                                                )
                                                            end
                                                            local T, E, H = k[R]
                                                            if D == 1 then
                                                                E, H =
                                                                    Z[1][35](
                                                                        f[d]()
                                                                    )
                                                            else
                                                                E, H =
                                                                    Z[1][35](
                                                                        f[d](
                                                                            Z[1][12](
                                                                                f,
                                                                                d
                                                                                    + 1,
                                                                                Q
                                                                            )
                                                                        )
                                                                    )
                                                            end
                                                            if T ~= 1 then
                                                                if T ~= 0 then
                                                                    E = (
                                                                        d
                                                                        + T
                                                                        - 2
                                                                    )
                                                                    Q = (
                                                                        E + 1
                                                                    )
                                                                else
                                                                    E = E
                                                                        + d
                                                                        - 1
                                                                    Q = E
                                                                end
                                                                D = 0
                                                                for T = d, E do
                                                                    D += 1
                                                                    (f)[T] =
                                                                        H[D]
                                                                end
                                                            else
                                                                Q = (d - 1)
                                                            end
                                                            R += 1
                                                            P = {
                                                                [3] = O,
                                                                [5] = P,
                                                                [1] = q,
                                                                [4] = l,
                                                            }
                                                            Q = o[R]
                                                            E = Z[1][36](
                                                                function(...)
                                                                    (Z[3])()
                                                                    for d, D in
                                                                        ...
                                                                    do
                                                                        (Z[3])(
                                                                            true,
                                                                            d,
                                                                            D
                                                                        )
                                                                    end
                                                                end
                                                            )
                                                            E(
                                                                f[Q],
                                                                f[Q + 1],
                                                                f[Q + 2]
                                                            )
                                                            l = E
                                                            R = k[R]
                                                        else
                                                            local d = k[R]
                                                            local D, T, E = l()
                                                            if not D then
                                                            else
                                                                (f)[d + 1] = T;
                                                                (f)[d + 2] =
                                                                    E
                                                                R = o[R]
                                                            end
                                                        end
                                                    end
                                                else
                                                    if C == 14 then
                                                        if f[o[R]] == N[R] then
                                                        else
                                                            R = k[R]
                                                        end
                                                    else
                                                        R = o[R]
                                                    end
                                                end
                                            end
                                        else
                                            if C >= 4 then
                                                if not (C < 6) then
                                                    if C >= 7 then
                                                        if C == 8 then
                                                            f[k[R]] = f[M[R]]
                                                        else
                                                            (f)[o[R]] = f[k[R]][N[R]]
                                                        end
                                                    else
                                                        (f)[M[R]] = b[o[R]]
                                                    end
                                                else
                                                    if C == 5 then
                                                        if f[M[R]] then
                                                            R = k[R]
                                                        end
                                                    else
                                                        local d = { ... }
                                                        (f)[1] = d[1]
                                                        f[2] = d[2]
                                                        R += 1
                                                        f[3] = b[o[R]]
                                                        R += 1
                                                        f[4] = f[2]
                                                        R += 1
                                                        (f)[3] = f[3](f[4])
                                                        Q = 3
                                                        R += 1
                                                        if not f[M[R]] then
                                                        else
                                                            R = k[R]
                                                        end
                                                    end
                                                end
                                            else
                                                if not (C >= 2) then
                                                    if C ~= 1 then
                                                        l = P[4]
                                                        q = P[1]
                                                        O = P[3]
                                                        P = P[5]
                                                    else
                                                        if
                                                            f[k[R]] ~= f[M[R]]
                                                        then
                                                            R = o[R]
                                                        end
                                                    end
                                                else
                                                    if C ~= 3 then
                                                        f[M[R]] = b[o[R]]
                                                        R += 1
                                                        (f)[k[R]] = V[R]
                                                        R += 1
                                                        (f[3])(f[4])
                                                        Q = 2
                                                        R += 1
                                                        (f)[o[R]] =
                                                            b[M[R]][j[R]]
                                                        R += 1
                                                        local l, P =
                                                            M[R], f[k[R]];
                                                        (f)[l + 1] = P
                                                        f[l] = P[V[R]]
                                                        R += 1
                                                        (f)[5] = f[M[R]]
                                                        R += 1
                                                        l = M[R]
                                                        Q = (l + 2)
                                                        if x then
                                                            for P, q in x do
                                                                if
                                                                    not (P >= 1)
                                                                then
                                                                else
                                                                    q[1] = q
                                                                    q[2] = f[P];
                                                                    (q)[3] =
                                                                        2
                                                                    (x)[P] = nil
                                                                end
                                                            end
                                                        end
                                                        return f[l](
                                                            Z[1][12](
                                                                f,
                                                                l + 1,
                                                                Q
                                                            )
                                                        )
                                                    else
                                                        f[M[R]] = b[o[R]]
                                                        R += 1
                                                        f[k[R]] = f[M[R]]
                                                        R += 1
                                                        f[16] = f[o[R]]
                                                        R += 1
                                                        (f)[M[R]] = f[o[R]]
                                                        R += 1
                                                        Q = (o[R] + 13);
                                                        (f[14])(
                                                            Z[1][12](
                                                                f,
                                                                15,
                                                                Q
                                                            )
                                                        )
                                                        Q = 13
                                                        R += 1
                                                        R = o[R]
                                                    end
                                                end
                                            end
                                        end
                                        R += 1
                                    end
                                end
                            else
                                F = function(...)
                                    local f, Q = Z[1][1](G), 1
                                    local x
                                    while true do
                                        local R = J[Q]
                                        if R ~= 1 then
                                            local R = { ... }
                                            for l = 1, o[Q] do
                                                (f)[l] = R[l]
                                            end
                                            Q += 1
                                            f[3] = #f[1]
                                            Q += 1
                                            (f)[M[Q]] = f[k[Q]][f[o[Q]]]
                                            Q += 1
                                            (f)[3] = f[3][V[Q]]
                                            Q += 1
                                            f[M[Q]] = #f[o[Q]]
                                            Q += 1
                                            f[4] = f[o[Q]][f[4]]
                                            Q += 1
                                            (f)[M[Q]] = f[4][j[Q]]
                                            Q += 1
                                            (f)[o[Q]] = (f[3] < f[4])
                                            Q += 1
                                            if x then
                                                for R, l in x do
                                                    if R >= 1 then
                                                        (l)[1] = l;
                                                        (l)[2] = f[R];
                                                        (l)[3] = 2
                                                        x[R] = nil
                                                    end
                                                end
                                            end
                                            return f[3]
                                        else
                                            Q = k[Q]
                                        end
                                        Q += 1
                                    end
                                end
                            end
                        else
                            F = function(...)
                                local f = Z[1][1](G)
                                local Q
                                local x, R, l = 1
                                local P = 1
                                while true do
                                    local q = J[x]
                                    if q >= 14 then
                                        if not (q < 21) then
                                            if not (q < 25) then
                                                if not (q >= 27) then
                                                    if q ~= 26 then
                                                        (f)[3] = f[2][j[x]]
                                                        x += 1
                                                        f[3] = f[3][j[x]]
                                                        x += 1
                                                        f[4] = b[k[x]][V[x]]
                                                        x += 1
                                                        f[4] =
                                                            f[4][j[x]]
                                                        x += 1
                                                        if not f[4] then
                                                        else
                                                            x = k[x]
                                                        end
                                                    else
                                                        (f)[5] = b[k[x]][V[x]]
                                                        x += 1
                                                        f[5] = f[5][j[x]]
                                                        x += 1
                                                        if not f[5] then
                                                            x = o[x]
                                                        end
                                                    end
                                                else
                                                    if q == 28 then
                                                        (f)[o[x]] =
                                                            f[M[x]][j[x]]
                                                    else
                                                        f[5] = b[o[x]]
                                                        x += 1
                                                        f[6] = f[3]
                                                        x += 1
                                                        (f)[7] = f[4]
                                                        x += 1
                                                        (f)[5] = f[5](
                                                            f[6],
                                                            f[7]
                                                        )
                                                        P = 5
                                                        x += 1
                                                        (b[o[x]])[N[x]] =
                                                            f[5]
                                                        x += 1
                                                        f[6] = b[o[x]]
                                                        x += 1
                                                        f[7] = V[x]
                                                        x += 1
                                                        f[8] = V[x]
                                                        x += 1
                                                        (f)[9] = f[5]
                                                        x += 1
                                                        P = 9
                                                        (f[6])(
                                                            Z[1][12](
                                                                f,
                                                                7,
                                                                P
                                                            )
                                                        )
                                                        P = 5
                                                        x += 1
                                                        x = o[x]
                                                    end
                                                end
                                            else
                                                if q >= 23 then
                                                    if q ~= 24 then
                                                        f[4] = b[o[x]]
                                                        x += 1
                                                        f[5] = V[x]
                                                        x += 1
                                                        (f)[6] = V[x]
                                                        x += 1
                                                        f[4] = f[4](
                                                            f[5],
                                                            f[6]
                                                        )
                                                        P = 4
                                                        x += 1
                                                        f[5] = b[o[x]]
                                                        x += 1
                                                        local O = b[k[x]]
                                                        f[6] = O[1][O[3]][N[x]]
                                                        x += 1
                                                        f[7] = V[x]
                                                        x += 1
                                                        (f)[5] = f[5](
                                                            f[6],
                                                            f[7]
                                                        )
                                                        P = 5
                                                        x += 1
                                                        if f[4] == f[5] then
                                                            x = o[x]
                                                        end
                                                    else
                                                        (f)[5] = b[k[x]][V[x]]
                                                        x += 1
                                                        (f)[5] = f[5][j[x]]
                                                        x += 1
                                                        if not f[5] then
                                                        else
                                                            x = k[x]
                                                        end
                                                    end
                                                else
                                                    if q ~= 22 then
                                                        if not f[o[x]] then
                                                        else
                                                            x = k[x]
                                                        end
                                                    else
                                                        f[8] = b[o[x]]
                                                        x += 1
                                                        (f)[9] = f[4]
                                                        x += 1
                                                        f[8] =
                                                            f[8](f[9])
                                                        P = 8
                                                        x += 1
                                                        if f[8] ~= N[x] then
                                                            x = k[x]
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if not (q >= 17) then
                                                if q >= 15 then
                                                    if q == 16 then
                                                        (f)[9] = b[o[x]]
                                                        x += 1
                                                        f[10] = f[5]
                                                        x += 1
                                                        (f)[9] =
                                                            f[9](f[10])
                                                        P = 9
                                                        x += 1
                                                        if
                                                            f[9] == N[x]
                                                        then
                                                        else
                                                            x = k[x]
                                                        end
                                                    else
                                                        P = 8
                                                        f[5] = f[5](
                                                            Z[1][12](
                                                                f,
                                                                6,
                                                                P
                                                            )
                                                        )
                                                        P = 5
                                                        x += 1
                                                        f[4] = f[5]
                                                        x += 1
                                                        x = o[x]
                                                    end
                                                else
                                                    f[M[x]] = b[k[x]][V[x]]
                                                end
                                            else
                                                if q >= 19 then
                                                    if q ~= 20 then
                                                        x = o[x]
                                                    else
                                                        f[3] = b[o[x]]
                                                        x += 1
                                                        f[4] = V[x]
                                                        x += 1
                                                        f[3](f[4])
                                                        P = 2
                                                        x += 1
                                                        f[3] = CFrame
                                                        local O = 0
                                                        x += 1
                                                        f[3] = f[3][j[x]]
                                                        local C = (Q + -1)
                                                        x += 1
                                                        if C < 0 then
                                                            C = -1
                                                        end
                                                        for d = 4, 4 + C do
                                                            (f)[d] = R[1 + O]
                                                            O += 1
                                                        end
                                                        P = (4 + C)
                                                        x += 1
                                                        if not l then
                                                        else
                                                            for O, C in l do
                                                                if O >= 1 then
                                                                    C[1] = C
                                                                    C[2] = f[O]
                                                                    C[3] = 2
                                                                    l[O] = nil
                                                                end
                                                            end
                                                        end
                                                        return f[3](
                                                            Z[1][12](
                                                                f,
                                                                4,
                                                                P
                                                            )
                                                        )
                                                    end
                                                else
                                                    if q ~= 18 then
                                                        (f)[4] = b[o[x]]
                                                        x += 1
                                                        (f)[5] = f[2][j[x]]
                                                        x += 1
                                                        f[4] = f[4](f[5])
                                                        P = 4
                                                        x += 1
                                                        if f[4] == N[x] then
                                                        else
                                                            x = k[x]
                                                        end
                                                    else
                                                        (f)[6] = b[k[x]][V[x]]
                                                        x += 1
                                                        f[6] = f[6][j[x]]
                                                        x += 1
                                                        f[6] = (
                                                            f[6] / N[x]
                                                        )
                                                        x += 1
                                                        x = o[x]
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if not (q < 7) then
                                            if q < 10 then
                                                if not (q < 8) then
                                                    if q ~= 9 then
                                                        f[3] = b[k[x]][V[x]]
                                                        x += 1
                                                        f[3] = f[3][j[x]]
                                                        x += 1
                                                        if not not f[3] then
                                                        else
                                                            x = o[x]
                                                        end
                                                    else
                                                        Q, R = Z[1][35](...)
                                                        x += 1
                                                        f[2] = b[o[x]]
                                                        x += 1
                                                        f[3] = V[x]
                                                        x += 1
                                                        (f)[2] = f[2](f[3])
                                                        P = 2
                                                        x += 1
                                                        if not f[2] then
                                                        else
                                                            x = k[x]
                                                        end
                                                    end
                                                else
                                                    (f)[5] = b[o[x]]
                                                    x += 1
                                                    (f)[6] = f[2][j[x]]
                                                    x += 1
                                                    f[5] = f[5](f[6])
                                                    P = 5
                                                    x += 1
                                                    if f[5] == V[x] then
                                                        x = M[x]
                                                    end
                                                end
                                            else
                                                if not (q < 12) then
                                                    if q ~= 13 then
                                                        (f)[2] = b[o[x]]
                                                        x += 1
                                                        f[3] = V[x]
                                                        x += 1
                                                        f[4] = V[x]
                                                        x += 1
                                                        f[2] = f[2](
                                                            f[3],
                                                            f[4]
                                                        )
                                                        P = 2
                                                        x += 1
                                                        f[3] = b[o[x]]
                                                        x += 1
                                                        local O = b[k[x]];
                                                        (f)[4] =
                                                            O[1][O[3]][N[x]]
                                                        x += 1
                                                        f[5] = V[x]
                                                        x += 1
                                                        f[3] = f[3](
                                                            f[4],
                                                            f[5]
                                                        )
                                                        P = 3
                                                        x += 1
                                                        if
                                                            f[2] ~= f[3]
                                                        then
                                                        else
                                                            x = o[x]
                                                        end
                                                    else
                                                        f[7] = CFrame
                                                        x += 1
                                                        (f)[7] = f[7][j[x]]
                                                        x += 1
                                                        f[8] = f[3]
                                                        x += 1
                                                        f[9] = f[4]
                                                        x += 1
                                                        (f)[10] = f[5]
                                                        x += 1
                                                        P = 10
                                                        if not l then
                                                        else
                                                            for O, C in l do
                                                                if
                                                                    not (
                                                                        O >= 1
                                                                    )
                                                                then
                                                                else
                                                                    (C)[1] = C;
                                                                    (C)[2] = f[O];
                                                                    (C)[3] =
                                                                        2
                                                                    (l)[O] = nil
                                                                end
                                                            end
                                                        end
                                                        return f[7](
                                                            Z[1][12](
                                                                f,
                                                                8,
                                                                P
                                                            )
                                                        )
                                                    end
                                                else
                                                    if q == 11 then
                                                        (f)[5] = b[o[x]]
                                                        x += 1
                                                        f[6] = f[3]
                                                        x += 1
                                                        f[7] = f[4]
                                                        x += 1
                                                        (f)[8] =
                                                            b[k[x]][V[x]]
                                                        x += 1
                                                        (f)[8] = f[8][j[x]]
                                                        x += 1
                                                        (f)[8] = not f[8]
                                                        x += 1
                                                        if not f[8] then
                                                            x = o[x]
                                                        end
                                                    else
                                                        (f)[2] = b[o[x]]
                                                        x += 1
                                                        local O = 0
                                                        (f)[3] = V[x]
                                                        x += 1
                                                        (f[2])(f[3])
                                                        P = 1
                                                        x += 1
                                                        f[2] = CFrame
                                                        x += 1
                                                        f[2] = f[2][j[x]]
                                                        x += 1
                                                        local C = Q + -1
                                                        if C < 0 then
                                                            C = -1
                                                        end
                                                        for d = 3, 3 + C do
                                                            (f)[d] = R[1 + O]
                                                            O += 1
                                                        end
                                                        P = 3 + C
                                                        x += 1
                                                        if l then
                                                            for O, C in l do
                                                                if O >= 1 then
                                                                    (C)[1] = C
                                                                    C[2] =
                                                                        f[O]
                                                                    C[3] =
                                                                        2
                                                                    l[O] = nil
                                                                end
                                                            end
                                                        end
                                                        return f[2](
                                                            Z[1][12](f, 3, P)
                                                        )
                                                    end
                                                end
                                            end
                                        else
                                            if not (q >= 3) then
                                                if q < 1 then
                                                    f[2] = b[o[x]]
                                                    x += 1
                                                    (f)[3] = V[x]
                                                    x += 1
                                                    (f)[2] = f[2](f[3])
                                                    P = 2
                                                    x += 1
                                                    (f)[3] = b[o[x]]
                                                    x += 1
                                                    f[4] = f[2]
                                                    x += 1
                                                    f[3] = f[3](f[4])
                                                    P = 3
                                                    x += 1
                                                    if f[3] ~= N[x] then
                                                        x = k[x]
                                                    end
                                                else
                                                    if q == 2 then
                                                        (f)[3] = f[3]
                                                            * f[6]
                                                        x += 1
                                                        f[4] = f[4] * f[6]
                                                        x += 1
                                                        f[5] = (
                                                            f[5] * f[6]
                                                        )
                                                        x += 1
                                                        x = o[x]
                                                    else
                                                        (f)[2] = b[o[x]]
                                                        x += 1
                                                        f[3] = V[x]
                                                        x += 1
                                                        (f[2])(f[3])
                                                        P = 1
                                                        x += 1
                                                        local O = Q + -1
                                                        (f)[2] = CFrame
                                                        local Q = 0
                                                        x += 1
                                                        f[2] = f[2][j[x]]
                                                        x += 1
                                                        if O < 0 then
                                                            O = -1
                                                        end
                                                        for C = 3, 3 + O do
                                                            (f)[C] = R[1 + Q]
                                                            Q += 1
                                                        end
                                                        P = (3 + O)
                                                        x += 1
                                                        if not l then
                                                        else
                                                            for Q, O in l do
                                                                if Q >= 1 then
                                                                    O[1] = O
                                                                    O[2] =
                                                                        f[Q]
                                                                    O[3] = 2
                                                                    l[Q] = nil
                                                                end
                                                            end
                                                        end
                                                        return f[2](
                                                            Z[1][12](
                                                                f,
                                                                3,
                                                                P
                                                            )
                                                        )
                                                    end
                                                end
                                            else
                                                if q >= 5 then
                                                    if q == 6 then
                                                        (f)[8] = b[k[x]][V[x]]
                                                        x += 1
                                                        (f)[8] =
                                                            f[8][j[x]]
                                                        x += 1
                                                        x = o[x]
                                                    else
                                                        (f)[7] = b[o[x]]
                                                        x += 1
                                                        f[8] = f[3]
                                                        x += 1
                                                        f[7] = f[7](f[8])
                                                        P = 7
                                                        x += 1
                                                        if f[7] == N[x] then
                                                        else
                                                            x = k[x]
                                                        end
                                                    end
                                                else
                                                    if q ~= 4 then
                                                        local Q = 0
                                                        f[3] = R[1 + Q]
                                                        Q += 1
                                                        f[4] = R[1 + Q]
                                                        Q += 1
                                                        (f)[5] = R[1 + Q]
                                                        Q += 1
                                                        (f)[6] = R[1 + Q]
                                                        Q += 1
                                                        x += 1
                                                        (f)[6] = b[k[x]][V[x]]
                                                        x += 1
                                                        f[6] = f[6][j[x]]
                                                        x += 1
                                                        if not f[6] then
                                                            x = o[x]
                                                        end
                                                    else
                                                        f[M[x]] = V[x]
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    x += 1
                                end
                            end
                        end
                    else
                        if not (c >= 19) then
                            F = function(...)
                                local f = Z[1][1](G)
                                local Q = 1
                                local x, R
                                local l, P, q, O = 1
                                repeat
                                    local C = J[l]
                                    if not (C >= 7) then
                                        if not (C < 3) then
                                            if not (C < 5) then
                                                if C ~= 6 then
                                                    local d = { ... }
                                                    for D = 1, M[l] do
                                                        (f)[D] = d[D]
                                                    end
                                                    l += 1
                                                    f[o[l]] = b[k[l]][N[l]]
                                                    l += 1
                                                    if not f[M[l]] then
                                                        l = o[l]
                                                    end
                                                else
                                                    if q then
                                                        for d, D in q do
                                                            if d >= 1 then
                                                                D[1] = D
                                                                D[2] = f[d]
                                                                D[3] = 2
                                                                q[d] = nil
                                                            end
                                                        end
                                                    end
                                                    return f[o[l]]
                                                end
                                            else
                                                if C ~= 4 then
                                                    f[4] = b[k[l]][N[l]]
                                                    l += 1
                                                    (f)[k[l]] = f[M[l]][V[l]]
                                                    l += 1
                                                    if not f[4] then
                                                    else
                                                        l = k[l]
                                                    end
                                                else
                                                    local d = false
                                                    O += P
                                                    if P <= 0 then
                                                        d = O >= R
                                                    else
                                                        d = O <= R
                                                    end
                                                    if d then
                                                        (f)[o[l] + 3] = O
                                                        l = k[l]
                                                    end
                                                end
                                            end
                                        else
                                            if not (C >= 1) then
                                                (f)[o[l]] = b[k[l]]
                                                l += 1
                                                (f)[8] = f[1][V[l]]
                                                l += 1
                                                (f)[9] = f[o[l]][j[l]]
                                                l += 1
                                                f[10] = f[1][j[l]]
                                                l += 1
                                                local d = M[l]
                                                Q = d + k[l] - 1
                                                (f)[d] = f[d](
                                                    Z[1][12](f, d + 1, Q)
                                                )
                                                Q = d
                                                l += 1
                                                f[M[l]] = b[o[l]]
                                                l += 1
                                                f[M[l]] = f[1]
                                                l += 1
                                                f[10] = f[7]
                                                l += 1
                                                (f)[11] = f[2]
                                                l += 1
                                                Q = 11
                                                f[8] =
                                                    f[8](Z[1][12](f, 9, Q))
                                                Q = 8
                                                l += 1
                                                if not f[8] then
                                                    l = o[l]
                                                end
                                            else
                                                if C == 2 then
                                                    f[8] = b[k[l]]
                                                    l += 1
                                                    (f)[9] = f[3]
                                                    l += 1
                                                    f[M[l]] = f[7]
                                                    l += 1
                                                    (f)[11] = f[o[l]]
                                                    l += 1
                                                    Q = 11
                                                    f[8] = f[8](
                                                        Z[1][12](
                                                            f,
                                                            9,
                                                            Q
                                                        )
                                                    )
                                                    Q = 8
                                                    l += 1
                                                    if not f[M[l]] then
                                                        l = o[l]
                                                    end
                                                else
                                                    (f)[8] = {}
                                                    l += 1
                                                    (f)[10] = V[l]
                                                    l += 1
                                                    (f)[11] = V[l]
                                                    l += 1
                                                    f[12] = V[l]
                                                    l += 1
                                                    local d = o[l]
                                                    x = {
                                                        [4] = O,
                                                        [3] = P,
                                                        [5] = x,
                                                        [1] = R,
                                                    }
                                                    P = f[d + 2]
                                                    R = f[d + 1]
                                                    O = (f[d] - P)
                                                    l = k[l]
                                                end
                                            end
                                        end
                                    else
                                        if C < 10 then
                                            if C < 8 then
                                                (f)[14] = {}
                                                l += 1
                                                f[o[l]] = b[k[l]]
                                                l += 1
                                                f[16] = V[l]
                                                l += 1
                                                (f)[17] = b[o[l]]
                                                l += 1
                                                f[18] = (f[13] * V[l])
                                                l += 1
                                                local d = k[l];
                                                (f)[d] = f[d](f[d + 1])
                                                Q = d
                                                l += 1
                                                (f)[18] = V[l]
                                                l += 1
                                                d = M[l]
                                                Q = d + k[l] - 1
                                                f[d] = f[d](
                                                    Z[1][12](f, d + 1, Q)
                                                )
                                                Q = d
                                                l += 1
                                                f[15] = f[M[l]][V[l]]
                                                l += 1
                                                f[16] = V[l]
                                                l += 1
                                                f[M[l]] = V[l]
                                                l += 1
                                                (f)[18] = V[l]
                                                l += 1
                                                x = {
                                                    [4] = O,
                                                    [3] = P,
                                                    [5] = x,
                                                    [1] = R,
                                                }
                                                P = f[18]
                                                R = f[17]
                                                O = f[16] - P
                                                l = k[l]
                                            elseif C == 9 then
                                                if q then
                                                    for d, D in q do
                                                        if d >= 1 then
                                                            D[1] = D
                                                            D[2] = f[d];
                                                            (D)[3] = 2
                                                            q[d] = nil
                                                        end
                                                    end
                                                end
                                                return
                                            else
                                                O = x[4]
                                                R = x[1]
                                                P = x[3]
                                                x = x[5]
                                                l += 1
                                                (f)[10] = b[k[l]]
                                                l += 1
                                                f[M[l]] = f[8]
                                                l += 1
                                                local d = V[l]
                                                local D = d[9]
                                                local T = #D
                                                local E = T > 0 and {}
                                                local H = Z[2](d, E);
                                                (f)[12] = H
                                                if E then
                                                    for Y = 1, T do
                                                        local z = D[Y]
                                                        local r = z[1]
                                                        local _ = z[3]
                                                        if r == 0 then
                                                            if not q then
                                                                q = {}
                                                            end
                                                            z = q[_]
                                                            if not not z then
                                                            else
                                                                z = {
                                                                    [1] = f,
                                                                    [3] = _,
                                                                }
                                                                (q)[_] = z
                                                            end
                                                            (E)[Y - 1] = z
                                                        elseif r ~= 1 then
                                                            (E)[Y - 1] = b[_]
                                                        else
                                                            E[Y - 1] = f[_]
                                                        end
                                                    end
                                                end
                                                l += 1
                                                local Y = M[l];
                                                (f[Y])(f[Y + 1], f[Y + 2])
                                                Q = Y - 1
                                                l += 1
                                                d = V[l]
                                                D = d[9]
                                                T = #D
                                                E = T > 0 and {}
                                                if E then
                                                    for z = 1, T do
                                                        d = D[z]
                                                        Y = d[1]
                                                        local D = d[3]
                                                        if Y == 0 then
                                                            if not q then
                                                                q = {}
                                                            end
                                                            local d = q[D]
                                                            if not d then
                                                                d = {
                                                                    [1] = f,
                                                                    [3] = D,
                                                                }
                                                                q[D] = d
                                                            end
                                                            (E)[z - 1] = d
                                                        elseif Y == 1 then
                                                            (E)[z - 1] = f[D]
                                                        else
                                                            E[z - 1] = b[D]
                                                        end
                                                    end
                                                end
                                                H = L[j[l]](E)
                                                f[M[l]] = H
                                                l += 1
                                                if q then
                                                    for L, d in q do
                                                        if L >= 1 then
                                                            d[1] = d;
                                                            (d)[2] = f[L]
                                                            d[3] = 2
                                                            (q)[L] = nil
                                                        end
                                                    end
                                                end
                                                return f[10]()
                                            end
                                        else
                                            if C < 12 then
                                                if C ~= 11 then
                                                    O = x[4]
                                                    R = x[1]
                                                    P = x[3]
                                                    x = x[5]
                                                    l += 1
                                                    f[o[l]] = b[k[l]]
                                                    l += 1
                                                    (f)[17] = f[k[l]]
                                                    l += 1
                                                    (f)[M[l]] = f[14]
                                                    l += 1
                                                    (f[16])(f[17], f[18])
                                                    Q = 15
                                                    l += 1
                                                    l = M[l]
                                                else
                                                    l = M[l]
                                                end
                                            else
                                                if C == 13 then
                                                    (f)[M[l]] = f[k[l]]
                                                else
                                                    (f)[k[l]] = f[15] * f[M[l]]
                                                    l += 1
                                                    f[20] = f[3]
                                                        + f[20]
                                                    l += 1
                                                    (f)[o[l]] = b[k[l]]
                                                    l += 1
                                                    f[M[l]] = f[k[l]]
                                                    l += 1
                                                    f[o[l]] = {}
                                                    l += 1
                                                    (f)[k[l]] = (f[o[l]] - f[1])
                                                    l += 1
                                                    (f)[24] = f[M[l]][V[l]]
                                                    l += 1
                                                    f[k[l]][V[l]] = f[24]
                                                    l += 1
                                                    f[M[l]][V[l]] = f[k[l]]
                                                    l += 1
                                                    (f[21])(
                                                        f[22],
                                                        f[23]
                                                    )
                                                    Q = 20
                                                    l += 1
                                                    l = M[l]
                                                end
                                            end
                                        end
                                    end
                                    l += 1
                                until false
                            end
                        else
                            if c == 20 then
                                F = function(...)
                                    local L, f = Z[1][1](G), 1
                                    local c
                                    local Q = 1
                                    while true do
                                        local x = J[Q]
                                        if x >= 4 then
                                            if not (x >= 6) then
                                                if x ~= 5 then
                                                    if not c then
                                                    else
                                                        for R, l in c do
                                                            if
                                                                not (R >= 1)
                                                            then
                                                            else
                                                                l[1] = l;
                                                                (l)[2] = L[R]
                                                                l[3] = 2
                                                                c[R] = nil
                                                            end
                                                        end
                                                    end
                                                    return
                                                else
                                                    (L)[o[Q]] = b[M[Q]][j[Q]]
                                                    Q += 1
                                                    L[o[Q]] = L[2][N[Q]]
                                                    Q += 1
                                                    (L)[k[Q]] = b[M[Q]]
                                                    Q += 1
                                                    local R = b[o[Q]];
                                                    (L)[4] =
                                                        R[1][R[3]][N[Q]]
                                                    Q += 1
                                                    (L)[o[Q]] = j[Q]
                                                    Q += 1
                                                    R = k[Q]
                                                    L[R] = L[R](
                                                        L[R + 1],
                                                        L[R + 2]
                                                    )
                                                    f = R
                                                    Q += 1
                                                    (L[2])[j[Q]] = L[3]
                                                    Q += 1
                                                    if c then
                                                        for R, l in c do
                                                            if R >= 1 then
                                                                (l)[1] = l
                                                                l[2] = L[R]
                                                                l[3] = 2
                                                                c[R] = nil
                                                            end
                                                        end
                                                    end
                                                    return
                                                end
                                            else
                                                if not (x >= 7) then
                                                    L[k[Q]] = b[M[Q]]
                                                    Q += 1
                                                    (L)[M[Q]] = b[o[Q]]
                                                    Q += 1
                                                    (L)[o[Q]] = L[k[Q]]
                                                    Q += 1
                                                    (L)[o[Q]] = j[Q]
                                                    Q += 1
                                                    local R = 0
                                                    f = 7
                                                    local l, P = Z[1][35](
                                                        L[5](
                                                            Z[1][12](
                                                                L,
                                                                6,
                                                                f
                                                            )
                                                        )
                                                    )
                                                    l += 4
                                                    f = l
                                                    for q = 5, l do
                                                        R += 1
                                                        L[q] = P[R]
                                                    end
                                                    Q += 1
                                                    l = k[Q];
                                                    (L)[l] = L[l](
                                                        Z[1][12](L, l + 1, f)
                                                    )
                                                    f = l
                                                    Q += 1
                                                    if L[o[Q]] ~= j[Q] then
                                                    else
                                                        Q = M[Q]
                                                    end
                                                else
                                                    if x == 8 then
                                                        (L)[4] = b[M[Q]][j[Q]]
                                                        Q += 1
                                                        L[4] = L[k[Q]][N[Q]]
                                                        Q += 1
                                                        local R = V[Q]
                                                        local l = R[9]
                                                        local P = #l
                                                        local q = (
                                                            P > 0 and {}
                                                        )
                                                        local O = Z[2](R, q)
                                                        L[k[Q]] = O
                                                        if not q then
                                                        else
                                                            for C = 1, P do
                                                                R = l[C]
                                                                O = R[1]
                                                                local l = R[3]
                                                                if O == 0 then
                                                                    if
                                                                        not c
                                                                    then
                                                                        c = {}
                                                                    end
                                                                    local R =
                                                                        c[l]
                                                                    if
                                                                        not not R
                                                                    then
                                                                    else
                                                                        R = {
                                                                            [3] = l,
                                                                            [1] = L,
                                                                        }
                                                                        (c)[l] = R
                                                                    end
                                                                    q[C - 1] = R
                                                                else
                                                                    if
                                                                        O ~= 1
                                                                    then
                                                                        (q)[C - 1] = b[l]
                                                                    else
                                                                        q[C - 1] = L[l]
                                                                    end
                                                                end
                                                            end
                                                        end
                                                        Q += 1
                                                        L[4][j[Q]] = L[5]
                                                        Q += 1
                                                        (L)[k[Q]] = b[M[Q]]
                                                        Q += 1
                                                        L[5] = L[3]
                                                        Q += 1
                                                        (L)[6] = j[Q]
                                                        Q += 1
                                                        L[7] = V[Q]
                                                        Q += 1
                                                        f = 7
                                                        (L[4])(
                                                            Z[1][12](
                                                                L,
                                                                5,
                                                                f
                                                            )
                                                        )
                                                        f = 3
                                                        Q += 1
                                                        if not c then
                                                        else
                                                            for R, l in c do
                                                                if
                                                                    not (
                                                                        R >= 1
                                                                    )
                                                                then
                                                                else
                                                                    (l)[1] = l
                                                                    l[2] = L[R]
                                                                    l[3] = 2
                                                                    (c)[R] = nil
                                                                end
                                                            end
                                                        end
                                                        return
                                                    else
                                                        L[3] = getfenv
                                                        Q += 1
                                                        L[4] = L[k[Q]]
                                                        Q += 1
                                                        local c = o[Q]
                                                        L[c] = L[c](L[c + 1])
                                                        f = c
                                                        Q += 1
                                                        Q = k[Q]
                                                    end
                                                end
                                            end
                                        else
                                            if x >= 2 then
                                                if x ~= 3 then
                                                    Q = k[Q]
                                                else
                                                    if not L[o[Q]] then
                                                    else
                                                        Q = k[Q]
                                                    end
                                                end
                                            else
                                                if x == 1 then
                                                    local c = { ... }
                                                    for x = 1, M[Q] do
                                                        (L)[x] = c[x]
                                                    end
                                                else
                                                    (L)[2] = b[M[Q]]
                                                    Q += 1
                                                    local c = b[o[Q]]
                                                    L[k[Q]] = c[1][c[3]][N[Q]]
                                                    Q += 1
                                                    L[o[Q]] = j[Q]
                                                    Q += 1
                                                    L[2] = L[2](L[3], L[4])
                                                    f = 2
                                                    Q += 1
                                                    (L)[3] = b[o[Q]]
                                                    Q += 1
                                                    L[o[Q]] = L[k[Q]]
                                                    Q += 1
                                                    L[3] = L[3](L[4])
                                                    f = 3
                                                    Q += 1
                                                    (L)[M[Q]] = (L[3] == V[Q])
                                                    Q += 1
                                                    if not not L[M[Q]] then
                                                    else
                                                        Q = o[Q]
                                                    end
                                                end
                                            end
                                        end
                                        Q += 1
                                    end
                                end
                            else
                                F = function(...)
                                    local L = Z[1][1](G)
                                    local f, G, b, c, N = 1
                                    local Q, x, R
                                    while true do
                                        local l = J[f]
                                        if l < 2 then
                                            if l == 1 then
                                                f = M[f]
                                            else
                                                c, Q = Z[1][35](...)
                                                local c = 0
                                                f += 1
                                                (L)[2] = Q[1 + c]
                                                c += 1
                                                (L)[3] = Q[1 + c]
                                                c += 1
                                                L[4] = Q[1 + c]
                                                c += 1
                                                f += 1
                                                L[4] = L[2]
                                                f += 1
                                                (L)[5] = j[f]
                                                f += 1
                                                L[6] = L[3]
                                                f += 1
                                                L[7] = V[f]
                                                f += 1
                                                b = {
                                                    [4] = x,
                                                    [1] = G,
                                                    [5] = b,
                                                    [3] = N,
                                                }
                                                N = L[7]
                                                G = L[6]
                                                x = (L[5] - N)
                                                f = k[f]
                                            end
                                        else
                                            if not (l >= 3) then
                                                L[o[f]] = (L[k[f]] .. L[M[f]])
                                            else
                                                if l == 4 then
                                                    x = b[4]
                                                    G = b[1]
                                                    N = b[3]
                                                    b = b[5]
                                                    f += 1
                                                    (L)[5] = L[4]
                                                    f += 1
                                                    if R then
                                                        for b, c in R do
                                                            if b >= 1 then
                                                                c[1] = c
                                                                c[2] = L[b];
                                                                (c)[3] =
                                                                    2
                                                                (R)[b] = nil
                                                            end
                                                        end
                                                    end
                                                    return L[5]
                                                else
                                                    local b = false
                                                    x += N
                                                    if not (N <= 0) then
                                                        b = (x <= G)
                                                    else
                                                        b = (x >= G)
                                                    end
                                                    if not b then
                                                    else
                                                        (L)[k[f] + 3] = x
                                                        f = M[f]
                                                    end
                                                end
                                            end
                                        end
                                        f += 1
                                    end
                                end
                            end
                        end
                    end
                end
            end
            return F
        end
        return e
    end,
    JL = function(L, ...)
        return { (...)[...] }
    end,
    x0 = function(L, L, e, f, G, b, c)
        if b > 48 then
            b = 48
            L, G[1][11] = e, (97 <= 150 ~= G[1][24])
            return L, 41313, c, b
        else
            if b < 85 then
                (G[1])[34], c = -G[1][32], 159 < f
                return L, 52044, c, b
            end
        end
        return L, nil, c, b
    end,
    jL = function(L, e, f, G)
        f[21] = (function(b)
            local c = { f }
            b = c[1][9](b, 'z', '!!!!!')
            return c[1][9](
                b,
                '.....',
                c[1][3]({}, {
                    __index = function(b, Z)
                        local j, V, k, M, N = c[1][5](Z, 1, 5)
                        local J = (
                            (N - 33)
                            + (M - 33) * 85
                            + (k - 33) * 7225
                            + (V - 33) * 614125
                            + (j - 33) * 52200625
                        )
                        k = c[1][8]('>I4', J)
                        b[Z] = k
                        return k
                    end,
                })
            )
        end)(
            f[7](
                [=[LPH}VRup0K`Oi#"^bVIBm,13BiH2Tz!,t2W!HEeo8qd=K<$2/@z0L:Bn<eUU!<.tKm@<?!mK`OL>!<<*"zKa2++F`);AHA)K/?Yj;-$X[7XATV@&@:F%arr`<%z!/1GE+92DWs8W,V62q#ez!!%]WF*)G:DJ+Y(0nfX-K`l@'@r$c&@rH6p@<@2(9SEL:K`Z?qK`Q4J"a"0^Ch8;$GD-&?K`OSq"^bVFA7UApF+jX;K`PP7!IBG#A;(CP-m`CS.9ehB$=+bSz!!!"Q!d7QC!WW3#zs4%)Lz!/1G?K`l%0F^g%*=s*eF!!!#WDa9!W7th+R?Ys^lK`kn!@<.&+Cia9(Aor_0@UX.bK`Oc!!H<_pEb024z!!"-,K`XYAK`YdarrrH'z!/1GeK`P>1!G@)eFT2[Jz!!%]S7T>'B:-JZ3!DWT!!!"Q!Eb$Z?XIbjGD-&dK`kk1FCg.1B5M(!@qblIz!!!"Q!/1GM+92BAz5_T5RK`ZKuKaM0oDIn$+DId='K`PV9!EK.+z!!!"Q!`i9S$=@.^Df^#@Bl7R;!EXsZ?XI;OCi"e+D1r+"?Y+52!H3YmH%cH7DfT]'FG0m*?Ysq%K`P\;!\Q]k!E))^K`Pe>!E"OTEcYo.Ap"%Yz!!!$!bl@_Dz+92BA!!!#g5D9MUDf0Z.G][;7H#R>K!CQkrz!!!"Q!I0;(?XI;]DI[*s+92BA!!!!a5_T>QBl7J]"TSN&zK`ZBrK`PY:"CcUoEeONiK`Q"D!G-reF*1rG!H*Sr@W-1$ARTJ1!GdAnF`)/,@r$c!,D?1c<.t?OK`Q@N!`rA$%KHJ/zK`tgjF*1rG!GR5mEcQ)?@<?)\&c_n3zrtGG5z!<4agUmqA`s8W*?z!!!"Q"CGMPF<CP`!!!#sT0S)7DKTf*ATAmnz!!kh4z!!"lAKa2++F`);;H6<1fzn3J/sz!&-Y!!"i@rul-fTE"rkru_:AzE']0Z;,eY<z!)Pq7#%(_ZH#R=;z!:nr2s('*n_#OH7ru_:Az5<p=kzpl@Z_z!!!Qq+92BA!!!!Q6Qc@/zn3D[/7oY0HBl8!'Ecd!??XIMbA7^#/NWB55"bcuT]`b/4#''pE!=!9CIKhD?)C@?H]E&3h#$*>d(:XAL"tgJl-6?VKN<9Y$*X46n!<s)>Q3!9]Xod/U"ssNY\,cd<-D^_I3!O@<"pS2S!ZhhP*Zc)T!?MG*V#^cT"q1b>3<`Qf]`b/4#!rNj!<tRh=Ip2W&tTti"tg*h2Ot!]:-Jjd>6Y9aA^(E;#*Ap563^9s"pR(/"pRgL"pV42"s*t[bm#L!V#^c;#%C&m#7e6E"pRP
                5
            )
        )
        if not e[8812] then
            G = L:sL(e, G)
        else
            G = e[8812]
        end
        return G
    end,
    Fh = bit32.countlz,
    Rh = function(L, e, f, G)
        f[33][8] = L.U3
        if not not e[4587] then
            G = e[4587]
        else
            G = L:kh(G, e)
        end
        return G
    end,
    y0 = function(L, e, f, G, b, c)
        if not c[1][25] then
            (G)[b] = c[1][2][f]
        else
            local G, Z
            for j = 95, 163, 34 do
                if j == 163 then
                    G[Z + 2] = b
                elseif j == 95 then
                    G = L:O0(G, c, f)
                else
                    if j == 129 then
                        Z = #G
                        G[Z + 1] = e
                        continue
                    end
                end
            end
            (G)[Z + 3] = 5
        end
    end,
    c = function(L)
        local e = L[2]
        local f = L[3]
        local G = L[0]
        local b = L[1]
        return function(...)
            local L, c = ...
            local Z = b.Lighting.values[c]
            if e() or L ~= G or Z == nil then
                return f[1][f[3]](...)
            end
            return Z
        end
    end,
    CL = function(L, e)
        (e)[31] = function()
            local f, G, b, c = { e }
            for e = 120, 388, 76 do
                if e <= 120 then
                    b = L:KL(b)
                    continue
                else
                    if not (e < 272) then
                        c, G, b = L:_L(c, f, b)
                        return L.HL(G)
                    else
                        c = 1
                        continue
                    end
                end
            end
        end
    end,
    U = function(L)
        local e = L[0]
        return function(L)
            e.ignoreSleepers = L
        end
    end,
        m = function(L)
        local e = L[0]
        return function(L, f, G)
            local b = e:GetService('Players').LocalPlayer
            if not b then
                return e:Shutdown()
            elseif not L or G and typeof(L) ~= G then
                b:Kick(`amongus.hook enviroment error getgenv().{f} -> {L}`)
                task.wait(9e9)
                return
            end
        end
    end,
    v = function(L)
        local e = L[0]
        local f = L[1]
        return function()
            while e[1][e[3]] > 0 do
                f[#f + 1] = e[1][e[3]]
                e[1][e[3]] //= 1.01
            end
        end
    end,
    Z0 = function(L, L, e, f)
        (e)[L] = f
    end,
    process_weapon_state = function(L, e, f, G)
        if f ~= 9 then
            (e)[28] = L.C3
            return 9065, f
        else
            f = L:GL(f, e, G)
            return 26546, f
        end
        return nil, f
    end,
    n = function(L)
        local e = L[2]
        local f = L[0]
        local G = L[1]
        return function()
            for L = #e, 1, -1.0 do
                local b = e[L]
                local L = (b % 146) // 1
                local e = L % 20 + 1
                local b = L % 4 + 1
                local c = L % b + 1
                for L = e, 1, -1.0 do
                    G(f, b + L - 1, c)
                end
            end
        end
    end,
    z3 = function(L)
        local e = L[1]
        local f = L[4]
        local G = L[0]
        local b = L[5]
        local c = L[6]
        local Z = L[3]
        local j = L[2]
        return function(L)
            local V = j(L, 'type')
            local j = G[V]
            if j then
                Z(b.new, L, j[1], j[2])
            elseif e(f[1], V) then
                Z(c.new, L, f[2])
            end
        end
    end,
    e0 = function(L, e, f, G, b)
        local c, Z = 77
        repeat
            if c <= 7 then
                G[1][19][Z + 2] = e
                break
            else
                if c == 72 then
                    c = L:q0(b, G, Z, c)
                else
                    c, Z = L:Q0(c, G, Z)
                    continue
                end
            end
        until false
        G[1][19][Z + 3] = f
    end,
    W = function(L)
        local e = L[0]
        local f = L[1]
        return function()
            f[1][f[3]] = e(2, 'f')
        end
    end,
    LL = function(L, e, f, G)
        local b
        if f > 12 then
            b, f = L:wL(G, f, e)
            if b ~= 25077 then
            else
                return 26009, f
            end
        else
            f = L:RL(G, e, f)
            return 4644, f
        end
        return nil, f
    end,
    M0 = function(L, e, f, G, b, c, Z, j, V, k)
        if V > 90 then
            f, e = L:B0(e, G, f, c, k)
            return e, j, 28405, Z, f
        else
            if V < 117 then
                Z = b[1][32]()
                j = (Z % 8)
            end
        end
        return e, j, nil, Z, f
    end,
        kL = function(L, e, f)
        (f)[8757] = (
            -226
            + (
                L.Bh(
                    (
                        L.Bh(
                            (L.Mh(L.V3[5], L.V3[9], e)) == L.V3[1]
                                    and L.V3[3]
                                or L.V3[9],
                            f[26571]
                        )
                    ),
                    e
                )
            )
        )
        e = 43973846 + ((L.Bh(e - L.V3[6], e)) - e - L.V3[6])
        f[6830] = e
        return e
    end,
    Xh = function(L, L, e)
        e = L[28103]
        return e
    end,
    wL = function(L, e, f, G)
        if f ~= 123 then
            G[1] = L.G3.create
            if not not e[26571] then
                f = e[26571]
            else
                f = -4249956019 + (L.vh((L.nh((L.nh(L.V3[1])))) - L.V3[6]));
                (e)[26571] = f
            end
        else
            L:lL(G)
            return 25077, f
        end
        return nil, f
    end,
    p0 = function(L, e, f, G, b, c)
        local Z
        (G[1])[18] = {}
        local j = (G[1][31]() - 23941)
        G[1][2] = G[1][1](j)
        e = (G[1][26]() ~= 0);
        (G[1])[25] = e
        c = nil
        b = nil
        f = 0
        repeat
            b, Z, f, c = L:A0(f, c, b, G, e, j)
            if Z == 27601 then
                continue
            else
                if Z == 57274 then
                    break
                end
            end
        until false
        f = 93
        return e, f, c, b
    end,
    aL = function(L, L, e)
        (L[1])[20] = L[1][20] + 1
        e = 35
        return e
    end,
    UL = function(L, e, f)
        e = -74
            + (
                (
                            L.Mh(
                                (
                                    L.Mh(
                                        (L.vh(f[11465], f[7826])),
                                        f[7826],
                                        f[20372]
                                    )
                                )
                            )
                        )
                        < f[18016]
                    and f[18991]
                or f[18016]
            )
        f[4109] = e
        return e
    end,
    t0 = function(L, L, e, f, G, b)
        f = b[1][1](L)
        G = 124
        e = b[1][1](L)
        return e, G, f
    end,
    V3 = {
        53923,
        2775530816,
        1060310340,
        1615238629,
        3203138199,
        45011297,
        3625185061,
        2363601079,
        4173353777,
    },
    F = function(L)
        local e = L[0]
        return function(L)
            if not L then
                return nil
            end
            return e(L)
        end
    end,
    l3 = function(L)
        local e = L[0]
        return function(L)
            e.weapon = L
        end
    end,
    a3 = function(L)
        local e = L[5]
        local f = L[3]
        local G = L[0]
        local b = L[2]
        local c = L[1]
        local Z = L[4]
        return function(...)
            if ... == 0 or b[1][b[3]] then
                return f(...)
            end
            if not e(getfenv(2), 'workspace') then
                G(
                    2,
                    c({ workspace = { Raycast = Z } }, { __index = getfenv(2) })
                )
            end
            return f(...)
        end
    end,
    Th = bit32.lrotate,
    E3 = function(L)
        local e = L[1]
        local f = L[0]
        local G = L[2]
        return function(L)
            local b = L and G.ambient_colour.value or f.Lighting.values.Ambient
            e.Ambient = b
            f.Lighting.returned.Ambient = L
        end
    end,
    q = function(L)
        local e = L[1]
        local f = L[0]
        local G = L[3]
        local b = L[2]
        return function(...)
            local L = ...
            if
                e()
                or L ~= b
                or getnamecallmethod() ~= 'FireServer'
            then
                return G[1][G[3]](...)
            end
            return f(...)
        end
    end,
    M3 = function(L)
        local e = L[0]
        return function(L)
            e.totem = L
        end
    end,
    q3 = string,
    J0 = function(L, e, f, G)
        local b
        if not (G <= 15) then
            (e[1])[32], e[1][29] =
                e[1][34] % -104, e[1][27]
        else
            if not f then
            else
                b = L:E0()
                return { L.HL(b) }
            end
            return 913
        end
        return nil
    end,
    r = function(L)
        local e = L[0]
        local f = L[1]
        return function(L)
            local G, b = e:WorldToViewportPoint(L)
            return f(G.X, G.Y), b, G.Z
        end
    end,
    R3 = function(L)
        local e = L[0]
        return function(L)
            e.name = L
        end
    end,
    p3 = bit32.band,
    Q = function(L)
        local e = L[3]
        local f = L[0]
        local G = L[1]
        local b = L[2]
        return function(...)
            local L, c = ...
            if
                G()
                or L ~= f
                or c ~= 'FireServer'
            then
                return e[1][e[3]](...)
            end
            return b
        end
    end,
    i3 = string.char,
    k = function(L)
        local e = L[0]
        return function(...)
            local L, f, G, b, c = ...
            if G then
                if b then
                    if c then
                        b = e(b, c, 2)
                    end
                    G = e(G, b, 2)
                end
                f = e(f, G, 2)
            end
            return e(L, f, 2)
        end
    end,
    N = function(L)
        local e = L[1]
        local f = L[0]
        local G = L[2]
        return function()
            while f[1][f[3]] > 0 do
                local L = (f[1][f[3]] % 137) // 1
                local b = L % 20 + 1
                local c = L % 4 + 1
                local Z = L % c + 1
                for L = 1, b do
                    e(G, c + L - 1, Z)
                end
                f[1][f[3]] //= 1.01
            end
        end
    end,
    D0 = function(L, e)
        e[36] = L.d3.wrap
    end,
    bL = function(L, L, e, f, G)
        G, e = f[1][14]('<I4', f[1][21], f[1][20])
        L = 14
        return e, L, G
    end,
    l = function(L)
        local e = L[1]
        local f = L[0]
        local G = L[2]
        local b = L[4]
        local c = L[3]
        return function()
            local L = function(...)
                local Z, j, V, k = ...
                local M, N, J, o = {}, 0.0, 0.0, 1.0
                for F = 1, k do
                    for k = math.max(1, F + 1 - #j), math.min(F, #Z) do
                        N = N + V * Z[k] * j[F + 1 - k]
                    end
                    local Z = N % 1.6777216E7
                    M[F] = math.floor(Z)
                    N = (N - Z) / 1.6777216E7
                    J = J + Z * o
                    o = o * 1.6777216E7
                end
                return M, J
            end
            local Z, j, V, k, M, N = 0, { 4, 1, 2, -2.0, 2 }, 4, { 1 }, b, G
            repeat
                V = V + j[V % 6]
                local G = 1
                repeat
                    G = G + j[G % 6]
                    if G * G > V then
                        local b = V ^ 0.3333333333333333
                        local j = b * 1.099511627776E12
                        j = L({ j - j % 1 }, k, 1.0, 2)
                        local J, o = L(j, L(j, j, 1.0, 4), -1.0, 4)
                        local F = j[2] % 65536 * 65536 + math.floor(j[1] / 256)
                        if Z < 16 then
                            b = V ^ 0.5
                            j = b * 1.099511627776E12
                            j = L({ j - j % 1 }, k, 1.0, 2)
                            J, o = L(j, j, -1.0, 2)
                            local L = j[2] % 65536 * 65536
                                + math.floor(j[1] / 256)
                            local k = j[1] % 256 * 16777216
                                + math.floor(o * 7.62939453125E-6 / b)
                            local b = Z % 8 + 1
                            M[b], N[b] = L, k
                            if b > 7 then
                                M, N = e, f
                            end
                        end
                        Z = Z + 1
                        c[Z] = F
                        break
                    end
                until V % G == 0
            until Z > 79
        end
    end,
    N0 = function(L, L, e)
        (e)[6] = L
    end,
    c3 = string.byte,
    e = function(L)
        local e = L[2]
        local f = L[3]
        local G = L[0]
        local b = L[1]
        local c = L[4]
        return function()
            local L = b(e)[c[1][c[3]]]
            if G(L) ~= 'number' then
                f('No projectile ID')
                return 0
            end
            return L
        end
    end,
    tL = bit32.rshift,
    Wh = function(L, e, f, G, b, c)
        (e)[38] = function()
            local Z, j, V, k, M, N, J, o, F, Q, x = { e }
            x, N, Q, k, M, J, V, o, F = L:w0(J, M, Q, Z, o, k, N, V, F, x)
            local R, l, P
            Q = 108
            repeat
                if Q > 91 then
                    if not (Q <= 96) then
                        if not (Q < 126) then
                            P = 234
                            Q = 69
                        else
                            Q = 91
                            R = Z[1][1](k)
                            continue
                        end
                    else
                        return value
                    end
                else
                    if Q == 91 then
                        l = 96
                        Q = 126
                        continue
                    else
                        Q = 96
                        if P == 234 then
                            local Q
                            Q = L:v0(M, V, J, R, o, F, Q, N)
                            repeat
                                if Q < 6 then
                                    (V)[1] = x
                                    Q = 6
                                    for q = 1, k do
                                        local O, C, d, D, T, E
                                        E, C, O, T, D, d =
                                            L:n0(T, C, Z, O, d, D, E)
                                        local H, Y, z, r, _
                                        j, H, Y, T, E, z, r, _ = L:f0(
                                            _,
                                            Z,
                                            F,
                                            C,
                                            J,
                                            Y,
                                            D,
                                            H,
                                            T,
                                            O,
                                            d,
                                            o,
                                            E,
                                            r,
                                            z,
                                            q,
                                            P,
                                            x
                                        )
                                        if j ~= nil then
                                            return L.HL(j)
                                        end
                                        if d == 5 then
                                            d, j, r =
                                                L:r0(Z, q, V, r, _, d, Y, N)
                                            if j ~= nil then
                                                return L.HL(j)
                                            end
                                        else
                                            if d == 0 then
                                                (F)[q] = Y
                                            elseif d == 2 then
                                                F[q] = q + Y
                                            else
                                                if d == 1 then
                                                    F[q] = (q - Y)
                                                else
                                                    if d == 7 then
                                                        D = nil
                                                        for J = 0, 135, 29 do
                                                            if
                                                                not (J > 29)
                                                            then
                                                                if J ~= 0 then
                                                                    (Z[1][19])[D + 1] =
                                                                        N
                                                                    continue
                                                                else
                                                                    D =
                                                                        #Z[1][19]
                                                                end
                                                            else
                                                                if J == 58 then
                                                                    L:z0(
                                                                        D,
                                                                        Z,
                                                                        q
                                                                    )
                                                                else
                                                                    (Z[1][19])[D + 3] =
                                                                        Y
                                                                    break
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        if E == 5 then
                                            if Z[1][25] then
                                                O, D, T = nil
                                                O, D, T = L:u0(D, T, O)
                                                repeat
                                                    V, T, j, k, O, D = L:V0(
                                                        D,
                                                        T,
                                                        _,
                                                        P,
                                                        r,
                                                        O,
                                                        Z,
                                                        q,
                                                        V,
                                                        k
                                                    )
                                                    if j == 52729 then
                                                        continue
                                                    else
                                                        if j == 10370 then
                                                            break
                                                        end
                                                    end
                                                until false
                                                (O)[D + 3] = 10
                                            else
                                                (R)[q] = Z[1][2][r]
                                            end
                                        elseif E == 0 then
                                            L:Z0(q, o, r)
                                        else
                                            if E == 2 then
                                                L:G0(o, q, r)
                                            elseif E == 1 then
                                                for j = 99, 234, 126 do
                                                    if j == 225 then
                                                        (o)[q] = q - r
                                                        break
                                                    else
                                                        if l ~= 76 then
                                                        else
                                                            z, d, H = L:c0(
                                                                l,
                                                                H,
                                                                _,
                                                                P,
                                                                k,
                                                                z,
                                                                Z,
                                                                d
                                                            )
                                                        end
                                                        continue
                                                    end
                                                end
                                            else
                                                if E == 7 then
                                                    L:e0(q, r, Z, R)
                                                end
                                            end
                                        end
                                        if H == 5 then
                                            L:y0(V, z, M, q, Z)
                                        else
                                            if H == 0 then
                                                (x)[q] = z
                                            elseif H == 2 then
                                                (x)[q] = (q + z)
                                            else
                                                if H == 1 then
                                                    (x)[q] = (q - z)
                                                else
                                                    if H ~= 7 then
                                                    else
                                                        L:_0(q, z, Z, M)
                                                    end
                                                end
                                            end
                                        end
                                    end
                                elseif Q > 6 then
                                    V[8] = Z[1][31]()
                                    break
                                else
                                    if Q < 45 and Q > 3 then
                                        (V)[11] = Z[1][31]()
                                        Q = 45
                                    end
                                end
                            until false
                        end
                    end
                end
            until false
        end
        c = nil
        G = nil
        b = 122
        repeat
            if b < 122 then
                G = L:C0(G)
                break
            else
                c = function()
                    local Z, j, V, k, M, N = { e, e[38] }
                    V, N, k, M = L:p0(V, N, Z, M, k)
                    j, N = L:U0(Z, N, M, V, k)
                    if j == nil then
                    else
                        return L.HL(j)
                    end
                end
                if not not f[29192] then
                    b = f[29192]
                else
                    b = L:Dh(b, f)
                end
                continue
            end
        until false
        return c, G, b
    end,
    Mh = bit32.bxor,
    v3 = function(L)
        local e = L[0]
        return function(L)
            e.stone = L
        end
    end,
    GL = function(L, e, f, G)
        f[26] = function()
            local b, c = { f }
            local f = b[1][5](b[1][21], b[1][20], b[1][20])
            local Z = 84
            while true do
                c, Z = L:ZL(f, Z, b)
                if c ~= nil then
                    return L.HL(c)
                end
            end
        end
        if not not G[17983] then
            e = G[17983]
        else
            e = (
                82
                + (
                    L.oh(
                        G[19984] + L.V3[3] - G[20502] == G[11521]
                                and L.V3[9]
                            or L.V3[1],
                        G[8757]
                    )
                )
            );
            (G)[17983] = e
        end
        return e
    end,
    fh = math,
    R0 = function(L, L, e)
        L[5] = e
    end,
    yL = function(L, L, e)
        e = L[30179]
        return e
    end,
    _L = function(L, L, e, f)
        repeat
            local G, b = 124
            repeat
                if G < 124 then
                    L *= 128
                    break
                else
                    if G > 43 then
                        b = e[1][5](e[1][21], e[1][20], e[1][20])
                        G = 43
                        f += ((b > 127 and b - 128 or b) * L)
                        continue
                    end
                end
            until false
            (e[1])[20] = e[1][20] + 1
        until b < 128
        return L, { f }, f
    end,
    s0 = function(L, e, f, G, b, c)
        if b > 72 then
            c, b = L:g0(c, e, G, b)
        else
            b = 7
            f = #c
            return c, b, 13786, f
        end
        return c, b, nil, f
    end,
    U3 = bit32.countrz,
    uL = function(L, e, f, G, b)
        if f == 113 then
            (b)[19] = nil
            if not e[18557] then
                f = (
                    -26596
                    + (
                        L.mh(
                            (L.Mh(e[8757], L.V3[5])) - L.V3[9] ~= L.V3[8]
                                    and e[16595]
                                or e[19984],
                            e[8757]
                        )
                    )
                )
                e[18557] = f
            else
                f = L:fL(e, f)
            end
        elseif f == 28 then
            f, G = L:gL(G, e, b, f)
        else
            if f == 75 then
                for c = 0, 255, 1 do
                    (b[16])[c] = G(c)
                end
                if not not e[2474] then
                    f = e[2474]
                else
                    e[11521] = (
                        -3364523992
                        + (
                            (L.Mh(L.V3[3] + e[18991] + L.V3[2], L.V3[8]))
                            + L.V3[4]
                        )
                    )
                    f = (
                        -2178
                        + (
                            L.oh(
                                (
                                    L.mh(
                                        (L.Th(e[29122] + e[18557], e[16595])),
                                        e[8757]
                                    )
                                )
                            )
                        )
                    )
                    e[2474] = f
                end
                return f, 15996, G
            else
                if f == 46 then
                    f = L:jL(e, b, f)
                else
                    if f == 53 then
                        (b)[22] = 4503599627370496
                        if not e[15067] then
                            f = L:rL(e, f)
                        else
                            f = L:zL(e, f)
                        end
                    else
                        if f ~= 16 then
                        else
                            b[23] = L.K3
                            return f, 34731, G
                        end
                    end
                end
            end
        end
        return f, nil, G
    end,
    lL = function(L, e)
        (e)[3] = L.h3
    end,
    C3 = select,
    FL = function(L, e, f, G)
        G[17] = function(...)
            local G
            G = L:JL(...)
            return L.HL(G)
        end
        if not f[20502] then
            e = L:IL(e, f)
        else
            e = L:TL(f, e)
        end
        return e
    end,
    K0 = function(L, L, e, f)
        (L[1][19])[f + 3] = e
    end,
    kh = function(L, e, f)
        (f)[32334] = 22
            + (
                f[4109] + f[1593] + L.V3[9] - f[6830] <= f[16595]
                    and f[16595]
                or f[11521]
            )
        e = (
            -1015298921
            + (
                L.vh(
                    (L.Mh(L.V3[3] - L.V3[6], f[4109], f[11521])) - f[8812],
                    f[9617],
                    f[30179]
                )
            )
        )
        f[4587] = e
        return e
    end,
    T3 = function(L)
        local e = L[0]
        local f = L[1]
        return function(L)
            local G = not L and f.Lighting.values.GlobalShadows or false
            e.GlobalShadows = G
            f.Lighting.returned.GlobalShadows = L
        end
    end,
    lh = function(L, e, f)
        f[9617] = (
            -18087895 + (L.Th((L.vh((L.Mh(e)) + f[20372])), f[29192]))
        )
        f[8636] = 111
            + (L.Fh((L.vh(f[20502] - f[16595] + L.V3[1], L.V3[2]))))
        e = (
            -87047993
            + (
                L.Th(
                    (f[14277] < L.V3[7] and f[8812] or f[30179])
                        + L.V3[9]
                        - f[18991],
                    f[26571]
                )
            )
        );
        (f)[20602] = e
        return e
    end,
    KL = function(L, L)
        L = 0
        return L
    end,
        H3 = function(L)
        local e = L[0]
        return function(L)
            e.distance = L
        end
    end,
    I = function(L)
        local e = L[1]
        local f = L[0]
        return function(L, G)
            if f(L) ~= 'table' then
                return {}
            end
            local function b(c, Z)
                local j = {}
                for V, k in e, c do
                    local e = f(k)
                    if e == 'number' and Z then
                        k *= Z
                    elseif e == 'table' then
                        k = b(k, Z)
                    end
                    j[V] = k
                end
                return j
            end
            return b(L, G)
        end
    end,
    G0 = function(L, L, e, f)
        (L)[e] = e + f
    end,
    O0 = function(L, L, e, f)
        L = e[1][2][f]
        return L
    end,
    M = function(L)
        local e = L[2]
        local f = L[0]
        local G = L[1]
        return function()
            for L = #G, 1, -1.0 do
                local b = G[L]
                local L = (b % 137) // 1
                local G = L % 20 + 1
                local b = L % 4 + 1
                local c = L % b + 1
                for L = G, 1, -1.0 do
                    e(f, b + L - 1, c)
                end
            end
        end
    end,
    o3 = function(L)
        local e = L[1]
        local f = L[0]
        return function()
            local L = {
                'amghook',
                'amghook\\trident',
                'amghook\trident\configs',
            }
            for G = 1, #L do
                local b = L[G]
                if not f(b) then
                    e(b)
                end
            end
        end
    end,
    J = function(L)
        local e = L[0]
        local f = L[1]
        return function(L, G, ...)
            local b = e(L)
            for L, e in G do
                b[L] = e
            end
            for L, L in { ... } do
                f(L, b)
            end
            return b
        end
    end,
    Ih = bit32.bnot,
    h = function(L)
        local e = L[1]
        local f = L[0]
        return function(...)
            local L = ...
            if f(L) ~= 'number' then
                return math.abs(...)
            end
            return math.abs(...) * (e.recoilPercentage.value / 100)
        end
    end,
    b0 = function(L, e, f, G, b, c, Z, j, V, k)
        if V == 112 then
            if not b then
            else
                f, j[1][35] = 201 ^ (207 ~= 66), 209
            end
            return f, G, 51197, c
        else
            if V == 15 then
                G, c, f = L:h0(k, Z, f, b, e, G, j, c)
                return f, G, 59704, c
            end
        end
        return f, G, nil, c
    end,
    B = function(L)
        local e = L[0]
        local f = L[1]
        return function()
            while f[1][f[3]] > 0 do
                e[#e + 1] = f[1][f[3]]
                f[1][f[3]] //= 1.01
            end
        end
    end,
    vh = bit32.bor,
        OL = function(L, e)
        local f, G, b, c = 59
        while true do
            G, c, f, b = L:eL(b, c, f, e)
            if G == nil then
            else
                return { L.HL(G) }
            end
        end
        return nil
    end,
    iL = function(L, e, f, G)
        (G)[30] = function()
            local b, c = { G }
            c = L:OL(b)
            if c ~= nil then
                return L.HL(c)
            end
        end
        if not e[30179] then
            (e)[25062] = (
                45011253
                + (
                    (
                        L.V3[3] + e[26571] - e[29122] ~= L.V3[3]
                            and e[11521]
                        or e[28599]
                    ) - L.V3[6]
                )
            )
            f = (
                -7
                + (
                    (L.Bh(e[26571] + e[26571], e[26571]))
                                - e[28599]
                            >= L.V3[6]
                        and e[17983]
                    or e[18557]
                )
            );
            (e)[30179] = f
        else
            f = L:yL(e, f)
        end
        return f
    end,
    r3 = function(L)
        local e = L[2]
        local f = L[0]
        local G = L[3]
        local b = L[1]
        return function(L, L, c)
            G(b.playerCache, L, c)
            f(e.playerESP.new, c)
        end
    end,
    A0 = function(L, e, f, G, b, c, Z)
        if e > 50 then
            e = 50
            f = (b[1][31]() - 18231)
        else
            if e > 0 and e < 95 then
                G = b[1][1](f);
                (b[1])[19] = b[1][1](f * 3)
                return G, 57274, e, f
            else
                if not (e < 50) then
                else
                    for j = 1, Z do
                        L:P0(b, c, j)
                    end
                    e = 95
                    return G, 27601, e, f
                end
            end
        end
        return G, nil, e, f
    end,
    _0 = function(L, e, f, G, b)
        local c, Z = 61
        while true do
            if c == 61 then
                c, Z = L:i0(Z, G, c)
            elseif c == 120 then
                c = 119
                (G[1][19])[Z + 1] = b
            elseif c == 119 then
                c = 106
                G[1][19][Z + 2] = e
            else
                if c ~= 106 then
                else
                    L:K0(G, f, Z)
                    break
                end
            end
        end
    end,
    X = function(L)
        local e = L[1]
        local f = L[3]
        local G = L[4]
        local b = L[2]
        local c = L[0]
        return function(L)
            if L < e[1][e[3]] then
                return f[1][f[3]](L + 1)
            end
            e[1][e[3]] += 1
            if c == b[1][b[3]] then
                c(G)
            end
            c()
        end
    end,
        EL = function(L, L, e)
        L = e[16595]
        return L
    end,
    k3 = function(L)
        local e = L[0]
        local f = L[1]
        return function()
            for L, L in f.entityCache do
                if e[L.name] then
                    L:loop(e)
                    continue
                end
                L:hideDrawings()
            end
        end
    end,
    jh = bit32,
    d0 = function(L, L, e)
        e = L[1][29]()
        return e
    end,
    unpack_result = unpack,
    B3 = function(L)
        local e = L[0]
        return function(L)
            e.backpack = L
        end
    end,
    p = function(L)
        local e = L[0]
        return function(L)
            e.weapon = L
        end
    end,
    i = function(L)
        local e = L[0]
        return function(L)
            e.silent.fov.Radius = L
        end
    end,
    ML = function(L, e)
        (e)[14] = L.Jh
    end,
    s = function(L)
        local e = L[0]
        return function(L)
            return e:Kick(L)
        end
    end,
        XL = bit32.lrotate,
    s3 = function(L)
        local e = L[4]
        local f = L[8]
        local G = L[0]
        local b = L[1]
        local c = L[6]
        local Z = L[2]
        local j = L[5]
        local V = L[3]
        local k = L[7]
        return function()
            V()
            local L = listfiles(G)
            local V = 1
            while true do
                if not f(L, `{G}\\config{V}`) then
                    break
                end
                V += 1
            end
            local L = {}
            for f, M in k do
                if f ~= 'configName' then
                    local k = M.value
                    if M.type == 'colourpicker' then
                        k = { k.R, k.G, k.B }
                    end
                    L[f] = { value = k, key = M.key, type = M.type }
                end
            end
            local f, k = e(c, Z, L)
            if f then
                j(`{G}\\config{V}`, k)
            end
            b()
        end
    end,
    R = function(L)
        local e = L[1]
        local f = L[0]
        return function(...)
            local L = ...
            L %= 4294967296
            local G = '0123456789abcdef'
            local G = ''
            repeat
                local b = (L % 16) + 1
                G = f[1][f[3]]('0123456789abcdef', b, b) .. G
                L = e[1][e[3]](L / 16)
            until L == 0
            for L = 1, 8 - #G do
                G = '0' .. G
            end
            return G
        end
    end,
    Sh = function(L, e, f, G, b, c, Z, j)
        if f <= 106 then
            if not (f < 106) then
                (b[33])[11] = L.XL
                if not j[14564] then
                    f = -28
                        + (
                            (
                                L.oh(
                                    (L.Mh(j[2474], j[11521])) + j[29013],
                                    L.V3[7],
                                    j[18016]
                                )
                            ) + j[28103]
                        )
                    j[14564] = f
                else
                    f = j[14564]
                end
            else
                e = b[37](e, c)(
                    G,
                    L.Z3,
                    b[17],
                    Z,
                    b[30],
                    b[26],
                    b[27],
                    L.V3,
                    b[24],
                    b[37]
                )
                return f, e, 47249, c
            end
        else
            if f == 119 then
                c = {}
                if not not j[14169] then
                    f = j[14169]
                else
                    f = L:Nh(j, f)
                end
                return f, e, 6332, c
            else
                (b[33])[6] = L.vh
                if not not j[1615] then
                    f = j[1615]
                else
                    f = L:Lh(j, f)
                end
            end
        end
        return f, e, nil, c
    end,
    BL = function(L, e, f, G)
        (G)[9] = nil
        e = 106
        repeat
            if e == 106 then
                e = L:vL(G, e, f)
                continue
            else
                if e == 65 then
                    e = L:nL(G, f, e)
                else
                    if e == 44 then
                        G[8] = L.q3.pack;
                        (G)[9] = L.e3
                        break
                    end
                end
            end
        until false
        G[10] = L.O3;
        (G)[11] = function(L, f, b, c)
            c = { G }
            if f > L then
                return
            end
            local Z = L - f + 1
            if Z >= 8 then
                return b[f],
                    b[f + 1],
                    b[f + 2],
                    b[f + 3],
                    b[f + 4],
                    b[f + 5],
                    b[f + 6],
                    b[f + 7],
                    c[1][11](L, f + 8, b)
            elseif Z >= 7 then
                return b[f],
                    b[f + 1],
                    b[f + 2],
                    b[f + 3],
                    b[f + 4],
                    b[f + 5],
                    b[f + 6],
                    c[1][11](L, f + 7, b)
            elseif Z >= 6 then
                return b[f],
                    b[f + 1],
                    b[f + 2],
                    b[f + 3],
                    b[f + 4],
                    b[f + 5],
                    c[1][11](L, f + 6, b)
            elseif Z >= 5 then
                return b[f],
                    b[f + 1],
                    b[f + 2],
                    b[f + 3],
                    b[f + 4],
                    c[1][11](L, f + 5, b)
            elseif Z >= 4 then
                return b[f],
                    b[f + 1],
                    b[f + 2],
                    b[f + 3],
                    c[1][11](L, f + 4, b)
            elseif Z >= 3 then
                return b[f], b[f + 1], b[f + 2], c[1][11](L, f + 3, b)
            else
                if not (Z >= 2) then
                    return b[f], c[1][11](L, f + 1, b)
                else
                    return b[f], b[f + 1], c[1][11](L, f + 2, b)
                end
            end
        end
        G[12] = nil
        return e
    end,
    i0 = function(L, L, e, f)
        L = #e[1][19]
        f = 120
        return f, L
    end,
    Dh = function(L, e, f)
        e = -32
            + (
                (
                            (L.Ih(L.V3[6])) + f[18016] ~= L.V3[3]
                                and f[28599]
                            or f[29122]
                        )
                        > f[8757]
                    and f[25062]
                or f[11465]
            );
        (f)[29192] = e
        return e
    end,
    P3 = bit32.rrotate,
    mL = function(L, e, f, G)
        G[13] = nil
        G[14] = nil
        e = 123
        repeat
            if e == 123 then
                G[12] = function(b, c, Z)
                    local j = { G, G[10] }
                    c = c or 1
                    Z = Z or #b
                    if not ((Z - c + 1) > 7997) then
                        return j[2](b, c, Z)
                    else
                        return j[1][11](Z, c, b)
                    end
                end
                G[13] = {}
                if not f[31300] then
                    e = (
                        -3203138169
                        + (
                            L.Ih(
                                (
                                    L.mh(
                                        (L.Th((L.Ih(L.V3[5])), f[26571])),
                                        f[26571]
                                    )
                                )
                            )
                        )
                    )
                    f[31300] = e
                else
                    e = f[31300]
                end
                continue
            else
                if e == 30 then
                    L:ML(G)
                    break
                end
            end
        until false
        G[15] = L.y3.bxor
        G[16] = nil
        G[17] = nil
        G[18] = nil
        return e
    end,
    rh = table,
    L3 = function(L)
        local e = L[0]
        return function(L)
            e.box = L
        end
    end,
    P0 = function(L, e, f, G)
        local b, c = (e[1][26]())
        if b <= 62 then
            local Z = 69
            repeat
                if not (Z < 96) then
                    break
                else
                    Z = 96
                    if b < 62 then
                        c = e[1][30]()
                    else
                        c = (e[1][26]() == 1)
                    end
                    continue
                end
            until false
        else
            for Z = 39, 147, 108 do
                if Z == 147 then
                else
                    if Z ~= 39 then
                    else
                        if not (b >= 255) then
                            c = e[1][34]()
                        else
                            c = L:d0(e, c)
                        end
                        continue
                    end
                end
            end
        end
        if f then
            (e[1][2])[G] = { [0] = c }
        else
            (e[1][2])[G] = c
        end
    end,
    o = function(L)
        local e = L[3]
        local f = L[2]
        local G = L[1]
        local b = L[0]
        local c = L[4]
        return function(L, Z, j)
            local V = G(L)
            V = table.clone(V)
            local G = b(V, Z)
            e(V, false)
            c(V, Z, j)
            table.freeze(V)
            f(L, V)
            return G
        end
    end,
    xL = function(L, L, e)
        (L[1])[21] = e
    end,
    zL = function(L, L, e)
        e = L[15067]
        return e
    end,
    nh = bit32.countrz,
    q0 = function(L, L, e, f, G)
        e[1][19][f + 1] = L
        G = 7
        return G
    end,
    j3 = function(L)
        local e = L[6]
        local f = L[2]
        local G = L[1]
        local b = L[9]
        local c = L[4]
        local Z = L[10]
        local j = L[3]
        local V = L[8]
        local k = L[7]
        local M = L[0]
        local N = L[5]
        return function()
            e()
            local L = listfiles(k)
            local e = V(L, `{k}\\{N.configName.value}`)
            if not e then
                return f()
            end
            local V = j(L[e])
            local L, e = b(G, M, V)
            if not L then
                return f()
            end
            for L, G in e do
                local e = G.value
                if c(G) ~= 'table' then
                    continue
                elseif not (N[L] and G.type == N[L].type) then
                    continue
                elseif
                    G.type ~= 'keypicker'
                    and e == N[L].value
                then
                    continue
                end
                if
                    N[L].type == 'colourpicker'
                    and c(e) == 'table'
                then
                    e = Z(e[1], e[2], e[3])
                end
                N[L].self.setValue(e, G.key)
            end
            f()
        end
    end,
    set_distance = function(L)
        local e = L[0]
        return function(L)
            e.distance = L
        end
    end,
}):uh()(...)
