local json = require("json")

local http_code = require("../Utils/http-code")
local mime = require("../Utils/mime")

local model = require("../Models/user")

--+ FORMAT CHECKING HELPERS +--
local function is_valid_date(date)
    if type(date) ~= "string" then return false end
    local year, month, day = date:match("^(%d%d%d%d)%-(%d%d)%-(%d%d)$")
    if not year or not month or not day then
        return false
    end
    year, month, day = tonumber(year), tonumber(month), tonumber(day)
    if not year or not month or not day then
        return false
    end
    return month >= 1 and month <= 12 and day >= 1 and day <= 31
end

local function is_valid_email(email)
    if type(email) ~= "string" then return false end
    return email:match("^[%w%.%-_]+@[%w%-_]+%.%w%w+$") ~= nil
end

--+ FORMAT CHECKING FUNCTIONS +--
local function is_create_format_valid(data)
    if type(data) ~= "table" then
        return false, "Invalid data format"
    end

    if type(data.name) ~= "string" or
    #data.name < 4 or
    #data.name > 16 then
        return false, "Invalid name: must be between 4 and 16 characters"
    end

    if type(data.password) ~= "string" or
    #data.password < 8 or
    #data.password > 24 then
        return false, "Invalid password: must be between 8 and 24 characters"
    end

    if not is_valid_date(data.birthdate) then
        return false, "Invalid birthdate: must be in YYYY-MM-DD format"
    end

    if not is_valid_email(data.email) then
        return false, "Invalid email format"
    end

    if data.role ~= "USER" and data.role ~= "ADMIN" then
        return false, "Invalid role: must be USER or ADMIN"
    end

    return true
end

local function is_update_format_valid(data)
    if type(data) ~= "table" then
        return false, "Invalid data format"
    end

    if data.name and
    (type(data.name) ~= "string" or
    #data.name < 4 or
    #data.name > 16) then
        return false, "Invalid name: must be between 4 and 16 characters"
    end

    if data.password and
    (type(data.password) ~= "string" or
    #data.password < 8 or
    #data.password > 24) then
        return false, "Invalid password: must be between 8 and 24 characters"
    end

    if data.birthdate and not is_valid_date(data.birthdate) then
        return false, "Invalid birthdate: must be in YYYY-MM-DD format"
    end

    if data.email and not is_valid_email(data.email) then
        return false, "Invalid email format"
    end

    if data.role and
    (data.role ~= "USER" and data.role ~= "ADMIN") then
        return false, "Invalid role: must be USER or ADMIN"
    end

    return true
end

--+     CONTROLLER     +--
local controller = {}

--+ CREATE +--
function controller.create(json_data)
    local data = json.decode(json_data)

    local ok, err = is_create_format_valid(data)

    if not ok then
        return json.encode({error = err}),
        http_code.BAD_REQUEST,
        mime.json
    end

    local returned_data = model.create(data)

    if returned_data then
        return json.encode(returned_data),
        http_code.SUCCESS,
        mime.json
    end

    return json.encode({error = "Decoding error: Can't create user"}),
    http_code.SERVER_ERROR,
    mime.json
end

--+ READ +--
function controller.read_by_id(id)
    local data = model.get_by_id(id)

    if data then
        return json.encode(data),
        http_code.SUCCESS,
        mime.json
    end

    return json.encode({error = "User " .. id .. " not found"}),
    http_code.NOT_FOUND,
    mime.json
end

function controller.read_all()
    local data = model.get_all()

    if data then
        return json.encode(data),
        http_code.SUCCESS,
        mime.json
    end

    return json.encode({error = "No user found"}),
    http_code.NOT_FOUND,
    mime.json
end

--+ UPDATE +--
function controller.update_by_id(id, json_data)
    if not model.get_by_id(id) then
        return json.encode({error = "User " .. id .. " not found."}),
        http_code.NOT_FOUND,
        mime.json
    end

    local data = json.decode(json_data)

    local ok, err = is_update_format_valid(data)

    if not ok then
        return json.encode({error = err}),
        http_code.BAD_REQUEST,
        mime.json
    end

    local returned_data = model.update_by_id(id, data)

    if returned_data then
        return json.encode({result = "User " .. id .. " updated."}),
        http_code.SUCCESS,
        mime.json
    end

    return json.encode({error = "Can't update user " .. id .. "."}),
    http_code.SERVER_ERROR,
    mime.json
end

--+ DELETE +--
function controller.delete(id)
    if not model.get_by_id(id) then
        return json.encode({error = "User " .. id .. " not found."}),
        http_code.NOT_FOUND,
        mime.json
    end

    local returned_data = model.delete(id)

    if returned_data then
        return json.encode({result = "User " .. id .. " deleted."}),
        http_code.SUCCESS,
        mime.json
    end

    return json.encode({error = "Can't delete user " .. id .. "."}),
    http_code.SERVER_ERROR,
    mime.json
end

return controller