local json = require("json")
local sha256 = require("sha256")
local fs = require("coro-fs")

local user = {}
local user_path = "Database/Users/"

function user.list_id()
    local user_id = {}
    local get_next_file = fs.scandir(user_path)                                -- Get the generative function to list through the directory

    while true do
        local entry = get_next_file()
        if not entry then break end
        local user_file = io.open(user_path .. entry.name, "r")
        if user_file then
            local data = json.decode(user_file:read("*a"))
            table.insert(user_id, data.id)
            user_file:close()
        end
    end

    return user_id
end

function user.create(data)
    local list_id = user.list_id()
    for index, value in ipairs(list_id) do
        print(value)
    end
    local next_id
    if list_id[1] ~= nil then
        table.sort(list_id)                                                    -- Get the largest ID at the end
        next_id = list_id[#list_id] + 1                                        -- Get the latest (so the largest) ID and adds 1 to it
    else
        next_id = 1
    end

    data.password = sha256(data.password)                                      -- Hash the password to store it hashed in the database
    data.created_at = os.date("%Y-%m-%d")
    data.updated_at = data.created_at
    data.id = next_id

    return data
end

function user.read(id)
    local file = io.open(user_path .. id .. ".json", "r")
    if file then
        local json_data = file:read("*a")
        local data = json.decode(json_data)
        file:close()
        return json.encode(data)
    end
end

return user