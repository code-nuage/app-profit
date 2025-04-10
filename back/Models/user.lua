local json = require("json")
local sha256 = require("sha256")
local goodbwhy = require("goo-db-why")

goodbwhy.select_db("Database")
local dir = goodbwhy.select("Users")
local date_format = "%Y-%m-%d %H:%M:%S"

local user = {}

function user.create(data)
    data.password = sha256(data.password)                                      -- Hash the password to store it hashed in the database
    data.created_at = os.date(date_format)
    data.updated_at = data.created_at

    dir:insert(data)

    return data
end

function user.read(id)
    local data = dir:get_by_id(id)
    local json_data = json.encode(data)

    return json_data
end

function user.read_all()
    local ids = dir:get_ids()
    local datas = {}
    for _, id in ipairs(ids) do
        local data = dir:get_by_id(id)
        table.insert(datas, data)
    end

    if #datas > 0 then
        local json_datas = json.encode(datas)

        return json_datas
    end
    return false
end

function user.update(id, data)
    if data.password then
        data.password = sha256(data.password)                                      -- Hash the password to store it hashed in the database
    end
    data.updated_at = os.date(date_format)

    dir:update(id, data)

    local json_data = json.encode(data)
    return json_data
end

function user.delete(id)
    dir:delete(id)
end

return user