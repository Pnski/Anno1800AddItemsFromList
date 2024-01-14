--[[
function getList()
    getting the list of items from the csv, located in the modfolder
]]--

function getList()
    test =1
end

--[[
function getModFolder()
    get the current modfolder?
]]

function getModFolder()
    test = 1
end

--[[
funtion getCheatItem(Item : GUID)
]]

function getCheatItem(Item)
    test=1
end

--[[
    getAllItems()
    call function
]]

function getAllItems()
        test = 1
end

function modlog(t)
    local file = io.open("annopathfile.txt", "a")
    io.output(file)
    io.write(t,"\n")
    io.close(file)
end

function testinghard()
    str = debug.getinfo(2, "S").source:sub(2)

    modlog(str)
end

print("items loaded!")