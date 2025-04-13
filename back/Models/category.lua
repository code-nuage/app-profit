local json = require("json")
local sha256 = require("sha256")
local goodbwhy = require("goo-db-why")

goodbwhy.select_db("Database")
local date_format = "%Y-%m-%d %H:%M:%S"

local dir_names = {
    ["taste"] = "Tastes",                                                      -- Avoiding syntax sugar because its goal is to rebind category name to the name of the goodbwhy directory
    ["material"] = "Materials",
    ["texture"] = "Textures",
    ["color"] = "Colors",
    ["lube"] = "Lubes",
}

local category = {}

function category.create(data, category_name)
    data.created_at = os.date(date_format)
    data.updated_at = data.created_at

    goodbwhy.select(category_name):insert(data)

    return data
end

function category.read(id, category_name)
    -- print(dir_names[category_name])
    local data = goodbwhy.select(category_name):get_by_id(id)
    local json_data = json.encode(data)

    return json_data
end

function category.read_all(category_name)


    print(category_name)

    local ids = goodbwhy.select(category_name):get_ids()
    local datas = {}
    for _, id in ipairs(ids) do
        local data = goodbwhy.select(category_name):get_by_id(id)
        table.insert(datas, data)
    end

    if #datas > 0 then
        local json_datas = json.encode(datas)

        return json_datas
    end
    return false
end

function category.update(id, data, category_name)
    data.updated_at = os.date(date_format)

    goodbwhy.select(category_name):update(id, data)

    local json_data = json.encode(data)
    return json_data
end

function category.delete(id, category_name)
    print(category_name)
    goodbwhy.select(category_name):delete(id)
end

return category