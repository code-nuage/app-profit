local json = require("json")

local http_code = require("../Utils/http-code")
local mime = require("../Utils/mime")

local model = require("../Models/category")
-- local model_item = require("../Models/item")

--+ FORMAT CHECKING FUNCTIONS +--
local function is_create_format_valid(data)
    if type(data) ~= "table" then
        return false, "Invalid data format"
    end

    if type(data.name) ~= "string" then
        return false, "Invalid name: must be a string"
    end

    if type(data.description) ~= "string" then
        return false, "Invalid name: must be a string"
    end

    if type(data.item_id) ~= "number" then
        return false, "Invalid item_id: must be a number"
    -- else
    --     if not model_item.get_by_id(data.item_id) then
    --         return false, "Invalid item_id: must be a valid item ID"
    --     end
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

    return json.encode({error = "Decoding error: Can't create category"}),
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

    return json.encode({error = "Category " .. id .. " not found"}),
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

    return json.encode({error = "No category found"}),
    http_code.NOT_FOUND,
    mime.json
end

function controller.delete(id)
    if not model.get_by_id(id) then
        return json.encode({error = "Category " .. id .. " not found."}),
        http_code.NOT_FOUND,
        mime.json
    end

    local returned_data = model.delete(id)

    if returned_data then
        return json.encode({result = "Category " .. id .. " deleted."}),
        http_code.SUCCESS,
        mime.json
    end

    return json.encode({error = "Can't delete category " .. id .. "."}),
    http_code.SERVER_ERROR,
    mime.json
end

return controller