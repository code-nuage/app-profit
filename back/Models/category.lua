local goodbwhy = require("../Utils/goo-db-why")

goodbwhy.select_database("Database")

local function get_time()
    return os.date("%Y-%m-%d %H:%M:%S")
end

local model = {}

function model.create(data)
    data.created_at = get_time()
    data.updated_at = data.created_at

    return goodbwhy.dir.select("Categories"):insert(data)
end

function model.get_by_id(id)
    return goodbwhy.dir.select("Categories"):where_id(id):get()
end

function model.get_all()
    return goodbwhy.dir.select("Categories"):get()
end

function model.delete(id)
    return goodbwhy.dir.select("Categories"):where_id(id):delete()
end

return model