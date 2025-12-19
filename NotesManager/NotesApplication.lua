local function clear()
    os.execute("clear 2>/dev/null || cls")
end

local notes_manager = require("NotesManager")
if notes_manager.load_from_file("notes.txt") then print("Notes loaded successfully!") end

local action_mapper = {
add = function() print("Enter a note to add:") ; notes_manager.add_note(io.read()) end,
remove = function()
    notes_manager.print_notes()
    print("Enter the index of the note you want to remove:")
    notes_manager.remove_note(tonumber(io.read())) end,
print = function() notes_manager.print_notes() end,
edit = function()
    notes_manager.print_notes()
    print("Enter the index of the note you want to edit:")
    local index = tonumber(io.read())
    print("Enter the new note:")
    notes_manager.edit_note(index, io.read())
end,
clear = function() notes_manager.clear_notes() end
}

while true do
    print([[Hello and Welcome to your Notes Manager!
Here are the following actions you can perform:
'add' - add a note
'remove' - remove a note
'print' - print your notes
'edit' - edit a note
'clear' - clears all notes
'exit' - save your notes and exit the program]])
    local action = io.read()
    clear()
    if action == "exit" then notes_manager.save_to_file("notes.txt") ; print("Your notes have been saved!") ; break end
    action_mapper[action]()
    if action ~= "print" then clear() end
end
