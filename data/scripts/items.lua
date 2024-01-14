local pathOfFile = "items\\items.csv"

local function file_exists()
    local f=io.open(pathOfFile,"r")
    if f~=nil then
        io.close(f)
        return true
    else
        downloadCSV()
        return false
    end
 end

local function downloadCSV()
    -- retrieve the content of a URL
    io.popen("mkdir items")
    -- curl doesnt create folder
    if not file_exists(pathOfFile) then
        io.popen("curl https://raw.githubusercontent.com/Pnski/Anno1800AddItemsFromList/main/data/Itemliste.csv > ".. pathOfFile)
        system.waitForGameTimeDelta(5000) --wait 5s
        io.popen(pathOfFile)
    end
end

local function getCSVcontent()
    itemlist = {}
    for line in io.lines(pathOfFile) do
        local Amount, GUID = line:match("%s*(.-),%s*(.-),%s*(.-)$")
        if tonumber(Amount) ~= nil then
            if tonumber(Amount) > 0 then
                itemlist[#itemlist + 1] = { Amount = Amount, GUID = tonumber(GUID)}
            end
        end
    end
    for k, v in pairs(itemlist) do
        print(k,v)
    end
end

local function getCheatItem(Item, Amount)
    for i = 1,Amount,1 do
        print("Storing ",Item," to harbour")
        ts.Area.Current.Economy.SetCheatItem(Item)
    end
end

function getAllItems()
    getCSVcontent()
    for i in pairs(itemlist) do
        getCheatItem(itemlist[i].GUID,itemlist[i].Amount)
    end
end

print("items loaded!")