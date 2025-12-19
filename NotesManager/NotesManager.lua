local notes = {}
local ordered_notes = {}

local function update_ordered_notes()
    local temp_notes = {}
    local seen = {}
    -- Keep existing order of notes
    for _, note in ipairs(ordered_notes) do
        if notes[note] then table.insert(temp_notes, note) ; seen[note] = true end
    end
    -- Add any new notes
	for note, show in pairs(notes) do
		if show and not seen[note] then table.insert(temp_notes, note) end
	end
	ordered_notes = temp_notes
end

local function add_note(note) notes[note] = true ; update_ordered_notes() end

local function remove_note(note_index) notes[ordered_notes[note_index]] = nil ; update_ordered_notes() end

local function edit_note(note_index, new_note) remove_note(note_index) ; add_note(new_note) end

local function clear_notes() for note, _ in pairs(notes) do notes[note] = nil end update_ordered_notes() end

local function print_notes()
    for index, note in ipairs(ordered_notes) do print(index .. ": " .. note) end
end

local function save_to_file(filename)
    local file = assert(io.open(filename, "w"))
    for _, note in ipairs(ordered_notes) do file:write(note, "\n") end
    file:close()
end

local function load_from_file(filename)
    local file = io.open(filename, "r")
    if not file then return false end  -- file doesn't exist yet
    clear_notes()
    for line in file:lines() do
        notes[line] = true
        table.insert(ordered_notes, line)
    end
    file:close()
    return true
end


return {
    add_note = add_note,
    remove_note = remove_note,
    edit_note = edit_note,
    clear_notes = clear_notes,
    print_notes = print_notes,
    save_to_file = save_to_file,
    load_from_file = load_from_file
}