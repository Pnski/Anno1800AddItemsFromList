local pathOfFile = "C:\\Users\\Public\\mod.io\\items.csv"
local mGUID = {}
mGUID.min=1
mGUID.mmin=1337471142
mGUID.mmax=2147483647
mGUID.split=1000000
mGUID.sMin=mGUID.min
mGUID.sMax=1000000 --all vanilla stuff

--local tasks = {  } -- queue

local function crawler()
    local _itemlist = {}
    for k = mGUID.sMin,mGUID.sMax do
        if #ts.ToolOneHelper.GetItemRarity(k) > 0 then
            --GUID,Name,Metatext,Allocation
            table.insert(_itemlist, {k,ts.GetItemAssetData(k).Text,ts.ToolOneHelper.GetItemAllocation(k),ts.ToolOneHelper.GetItemRarity(k)})
        end
    end
    return _itemlist
end

local function doCSV()
    local f=io.open(pathOfFile,"w")
    for k,v in pairs(crawler()) do
        f:write("0,"..table.concat(v, ",").."\n")
    end
    f:close()
end

local function file_exists()
    local f=io.open(pathOfFile,"r")
    if f~=nil then
        io.close(f)
        return true
    else
        doCSV()
        return false
    end
end

local function getCSVcontent()
    local _itemlist = {}
    for line in io.lines(pathOfFile) do
        local Amount, GUID = line:match("%s*(.-),%s*(.-),%s*(.-)$")
        if tonumber(Amount) ~= nil then
            if tonumber(Amount) > 0 then
                _itemlist[#_itemlist + 1] = { Amount = Amount, GUID = tonumber(GUID)}
            end
        end
    end
    return _itemlist
end

local function getCheatItem(Item, Amount)
    for i = 1,Amount,1 do
        ts.Area.Current.Economy.SetCheatItem(Item)
    end
end

function getAllItems()
    if file_exists() then
        for i,v in pairs(getCSVcontent()) do
            getCheatItem(v.GUID,v.Amount)
        end
    else
        print("generated csv, waiting for edit.")
        return
    end
end

print("items loaded!")