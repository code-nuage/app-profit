local json = require("json")

local model_user = require("../Models/user")

local user = {}
local user_path = "Database/Users/"

local function assert_user_format(json_data)
    local data = json.decode(json_data)
    if type(data.name) == "string" and
    type(data.password) == "string" and
    type(data.birth) == "string" and
    type(data.role) == "string" then
        if not data.birth:match("^%d%d%d%d%-%d%d%-%d%d$") then
            print("Bad date format")
            return false
        end
        if not (data.role == "USER" or data.role == "ADMIN") then
            print("Bad role name")
            return false
        end
        return true
    end
end

function user.create(json_data)
    if assert_user_format(json_data) then
        local data = json.decode(json_data)
        data = model_user.create(data)
        local file = io.open(user_path .. data.id .. ".json", "w+")

        if file then
            local final_data = json.encode(data)
            file:write(final_data)
            file:close()

            return "Created user\n" .. final_data, 200
        end
    end
    return "Bad data format", 400
end

function user.read(id)
    local json_data = model_user.read(id)
    if json_data then
        return json_data, 200
    end
    return json.encode({error = "User not found"}), 404
end

function user.read_all()
    local id_list = model_user.list_id()
    local data_list = {}

    for _, id in pairs(id_list) do
        local json_data = json.decode(model_user.read(id))
        table.insert(data_list, json_data)
    end

    local json_data_list = json.encode(data_list)
    return json_data_list, 200
end

function user.update(id, json_data)

end

return user