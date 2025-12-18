local function clear()
    os.execute("clear 2>/dev/null || cls")
end

local ACTIONS = { rock = 1, paper = 2, scissors = 3 }
local REV_ACTIONS = { "rock", "paper", "scissors"}
-- Rows are player one, columns player two. 1st index is Rock, 2nd Paper, 3rd Scissors
local SCORE_MATRIX = {
    {0, -1,  1},
    {1,  0, -1},
    {-1, 1,  0}
}

local function get_result(players)
    -- Currently Calculates result for two people only.
    local result = SCORE_MATRIX [ ACTIONS[players[1].action()] ] [ ACTIONS[players[2].action()] ]
    for _, player in ipairs(players) do
        if not player.is_human() then
            print(player.name() .. " chose " .. player.action() .. ".")
        end
    end
    if result == 1 then
        players[1].increment_score()
        print(players[1].name() .. " won!")
    elseif result == -1 then
        players[2].increment_score()
        print(players[2].name() .. " won!")
    else
        print("It was a draw!")
    end
end

local new_player = require("RPSPlayer")
local player1 = new_player(1, true)
local player2 = new_player(2, false)
local players = {player1, player2}
math.randomseed(os.time())
for _, player in ipairs(players) do player.set_name() ; clear() end
while true do
    clear()
    for _, player in ipairs(players) do while not player.get_action(ACTIONS, REV_ACTIONS) do print("That is an invalid input!") end clear() end
    get_result(players)
    for _, player in ipairs(players) do player.show_state() end
    print("Type exit to leave else press enter.")
    if string.lower(io.read()) == "exit" then
        break
    end
end
clear()
print("Final Scores:")
for _, player in ipairs(players) do player.show_state() end
