local json = require("json")

local model_user = require("../Models/user")

local user = {}

local function assert_create_format(data)
    if data then
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
        return false
    end
    return false
end

local function assert_update_format(data)
    if data then
        if (type(data.name) == "string" or type(data.name) == "nil") and       -- AND priority is higher than OR
        (type(data.password) == "string" or type(data.password) == "nil") and
        (type(data.birth) == "string" or type(data.birth) == "nil") and
        (type(data.role) == "string" or type(data.role) == "nil") then
            if data.birth and 
            not data.birth:match("^%d%d%d%d%-%d%d%-%d%d$") then                -- Since strings are truthy, we don't need anything else
                print("Bad date format")
                return false
            end
            if data.role and 
            not (data.role == "USER" or data.role == "ADMIN") then
                print("Bad role name")
                return false
            end
            return true
        end
    end
end

--+ CREATE +--
function user.create(json_data)
    local data = json.decode(json_data)
    if data then
        if assert_create_format(data) then
            data = model_user.create(data)

            return json.encode(data), 200
        end
        return json.encode({error = "Bad data format"}), 400
    end
    return json.encode({error = "Unable to decode data"}), 500
end

--+ READ +--
function user.read(id)
    local json_data = model_user.read(id)
    if json_data then
        return json_data, 200
    end
    return json.encode({error = "User not found"}), 404
end

function user.read_all()
    local json_datas = model_user.read_all()
    if json_datas then
        return json_datas, 200
    end
    return json.encode({error = "No user found"}), 404
end

--+ UPDATE +--
function user.update(id, json_data)
    local data = json.decode(json_data)
    if assert_update_format(data) then
        data = model_user.update(id, json.decode(json_data))
        return "Updated user " .. id .. "\n" .. data, 200
    end
    return json.encode({error = "Bad data format"}), 400
end

--+ DELETE +--
function user.delete(id)
    model_user.delete(id)
    return "Deleted user " .. id, 200
end

return user