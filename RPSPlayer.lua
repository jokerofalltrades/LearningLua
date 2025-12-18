return function(number, human)
    local player_state = { name = "", action = "", score = 0, human = human }

    local function set_name()
        if human then
            print("Hi Player " .. number .. "! Please enter your name:")
            player_state.name = io.read()
        else
            player_state.name = "AI Player " .. number
        end
    end

    local function get_action(ACTIONS, REV_ACTIONS)
        if human then
            print("Hi " .. player_state.name .. "! What is your action? Rock, Paper or Scissors?")
            player_state.action = string.lower(io.read())
            if ACTIONS[player_state.action] then
                return true
            end
            return false
        else
            player_state.action = REV_ACTIONS[math.random(3)]
            return true
        end
    end

    local function show_state()
        print(player_state.name .. "'s Score: " .. player_state.score)
    end

    local function increment_score()
        player_state.score = player_state.score + 1
    end

    local function action() return player_state.action end
    local function name() return player_state.name end
    local function is_human() return player_state.human end

    return {
        set_name = set_name,
        get_action = get_action,
        show_state = show_state,
        increment_score = increment_score,
        action = action,
        name = name,
        is_human = is_human
    }
end