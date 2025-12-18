return function()
    local number = 0

    local function increment()
    	number = number + 1
    end

    local function get()
        return number
    end

    return {
        increment = increment,
        get = get,
    }
end