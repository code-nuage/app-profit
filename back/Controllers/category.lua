local json = require("json")

local model_category = require("../Models/category")

local category = {}

local function assert_create_format(data)
    if data then
        if type(data.name == "string") and
        type(data.description == "string") and
        type(data.allergens == "table") then
            return true
        end
    end
end

local function assert_update_format(data)
    if data then
        if (type(data.name == "string") or data.name == nil) and               -- AND priority is higher than OR
        (type(data.description == "string") or data.description == nil) and
        (type(data.allergens == "table") or data.allergens == nil)  then
            return true
        end
    end
end

--+ CREATE +--
function category.create(json_data, category_name)
    local data = json.decode(json_data)
    if data then
        if assert_create_format(data) then
            return json.encode(model_category.create(data, category_name)), 200
        end
        return json.encode({error = "Bad data format"}), 400
    end
    return json.encode({error = "Unable to decode data"}), 500
end

--+ READ +--
function category.read(id, category_name)
    local json_data = model_category.read(id, category_name)
    if json_data then
        return json_data, 200
    end
    return json.encode({error = "Category not found"}), 404
end

function category.read_all(category_name)
    local json_datas = model_category.read_all(category_name)
    if json_datas then
        return json_datas, 200
    end
    return json.encode({error = "No category found"}), 404
end

--+ UPDATE +--
function category.update(id, json_data, category_name)
    local data = json.decode(json_data)
    if data then
        if assert_update_format(data) then
            data = model_category.update(id, json.decode(json_data), category_name)
            return "Updated category " .. category_name .. " " .. id .. "\n" .. data, 200
        end
        return json.encode({error = "Bad data format"}), 400
    end
    return json.encode({error = "Unable to decode data"}), 500
end

--+ DELETE +--
function category.delete(id, category_name)
    model_category.delete(id, category_name)
    return "Deleted category " .. category_name .. " " .. id, 200
end

return category