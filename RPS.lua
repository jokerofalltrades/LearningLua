function table.location(table, element)
    for key, value in pairs(table) do
        if value == element then
            return key
        end
    end
    return nil
end

function table.contains (table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

local function clear ()
    os.execute("clear 2>/dev/null || cls")
end

local valid_actions = {"rock", "paper", "scissors"}
-- Rows are player one, columns player two. 1st index is Rock, 2nd Paper, 3rd Scissors
local score_matrix = {
    {0, -1,  1},
    {1,  0, -1},
    {-1, 1,  0}
}
local Player = {name = "", action = "", score = 0, numeric_action = 0}

function Player:new (object)
    object = object or {}
    setmetatable(object, self)
    self.__index = self
    return object
end

function Player:set_name ()
    print("Please enter your name:")
    self.name = io.read()
end

function Player:get_action ()
    clear()
    while true do
        print("Hi "..self.name.."! What is your action? Rock, Paper or Scissors?")
        self.action = string.lower(io.read())
        if table.contains(valid_actions, self.action) then
            self.numeric_action = table.location(valid_actions, self.action)
            return
        else
            print("That is an invalid input!")
        end
    end
end

local function get_result (player1, player2)
    local result = score_matrix[player1.numeric_action][player2.numeric_action]
    if result == 1 then
        player1.score = player1.score + 1
        print(player1.name.." won!")
    elseif result == -1 then
        player2.score = player2.score + 1
        print(player2.name.." won!")
    else
        print("It was a draw!")
    end
end

local player1 = Player:new()
local player2 = Player:new()
local players = {player1, player2}
for _, player in ipairs(players) do player:set_name() end
while true do
    for _, player in ipairs(players) do player:get_action() end
    clear()
    get_result(players[1], players[2])
    for _, player in ipairs(players) do print(player.name.."'s Score: "..player.score) end
    print("Type exit to leave else press enter.")
    if string.lower(io.read()) == "exit" then
        break
    end
end
clear()
print("Final Scores:")
for _, player in ipairs(players) do print(player.name.."'s Score: "..player.score) end