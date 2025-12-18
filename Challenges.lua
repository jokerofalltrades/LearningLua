--[[ Challenge 1
local VALID_INPUTS = {
    rock = true,
    paper = true,
    scissors = true
}
local function challenge_one ()
    local input = io.read()
    return VALID_INPUTS[input] ~= nil
end
challenge_one()
--]]
--[[ Challenge 2
local user_string = io.read()
local character_counter = {}
for i = 1, #user_string do
    local chr = string.byte(user_string, i)
    character_counter[chr] = (character_counter[chr] or 0) + 1
end
for key, value in pairs(character_counter) do
    print(string.char(key)..": "..value)
end
--]]
--[[ Challenge 3
local function is_even_and_positive(n)
    return n > 0 and n % 2 == 0
end
print(is_even_and_positive(34))
--]]
--[[ Challenge 4
local t = {}
t[1] = "a"
t[3] = "c"

for i, v in ipairs(t) do
    print(i, v)
end
--]]
--[[ This will print 1    a
as ipairs stops at a null value, which t[2] is.
you could either change ipairs to pairs or t[3] to t[2]
--]]

-- Challenge 5
local ACTIONS = {rock = 1, paper = 2, scissors = 3}

local function get_numerical_action ()
    local action = io.read()
    return ACTIONS[action] or nil
end

print(get_numerical_action())

-- Challenge 6
local function get_result2 (score1, score2)
	local result = -1
	if result == -1 then
	    score1 = score1 + 1
	elseif result == 1 then
	    score2 = score2 + 1
	end
	return score1, score2
end
local score1 = 0 ; local score2 = 1
score1, score2 = get_result2(score1, score2)

-- Challenge 7
local revACTIONS = {}
for key, value in pairs(ACTIONS) do revACTIONS[value] = key end
local human_player = {action = "", numerical_action = 1, score = 0}
local ai_player = {action = "", numerical_action = 1, score = 0}
function ai_player.get_action (self)
    self.numerical_action = math.random(3)
    self.action = revACTIONS[self.numerical_action]
end
function human_player.get_action (self)
    self.action = io.read()
    self.numerical_action = ACTIONS[self.action]
end
local score_matrix = {
    {0, -1,  1},
    {1,  0, -1},
    {-1, 1,  0}
}
local function get_result ()
    local result = score_matrix[human_player.numerical_action][ai_player.numerical_action]
    if result == 1 then
        human_player.score = human_player.score + 1
        print("You win!")
    elseif result == -1 then
        ai_player.score = ai_player.score + 1
        print("The AI won...")
    else
        print("Draw!")
    end
end

while true do
    human_player.get_action(human_player)
    ai_player.get_action(ai_player)
    get_result()
    print("Your score: "..human_player.score.."\nAI score: "..ai_player.score)
    print("type exit to leave else press enter")
    if string.lower(io.read()) == "exit" then
        break
    end
end

-- Challenge 8
--[[
I'm not 100% sure how to do it without metatables but you can replace the colon operator with a . and pass self into the function and its behaviour will remain the same.
--]]