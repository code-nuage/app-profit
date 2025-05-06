local goodbwhy = require("../Utils/goo-db-why")
local sha256 = require("../Utils/sha256")

local config = require("../config")

goodbwhy.select_database(config.database.name)

local function get_time()
    return os.date("%Y-%m-%d %H:%M:%S")
end

local model = {}

function model.create(data)
    data.password = sha256(data.password)
    data.created_at = get_time()
    data.updated_at = data.created_at

    return goodbwhy.dir.select("Users"):insert(data)
end

function model.get_by_id(id)
    return goodbwhy.dir.select("Users"):where_id(id):get()
end

function model.get_by_email(email)
    return goodbwhy.dir.select("Users"):where("email", email):get()
end

function model.get_all()
    return goodbwhy.dir.select("Users"):get()
end

function model.user_exists(email)
    local data = goodbwhy.dir.select("Users"):where("email", email):get()
    if data then
        return true                                                            -- User exists
    end
end

function model.is_password_valid(email, password)
    local data = goodbwhy.dir.select("Users"):where("email", email):get()
    if data then
        if sha256(password) == data.password then
            return true                                                        -- Password is valid
        end
        return false
    end
    return false
end

function model.update_by_id(id, data)
    data.updated_at = get_time()

    return goodbwhy.dir.select("Users"):where_id(id):update(data)
end

function model.delete(id)
    return goodbwhy.dir.select("Users"):where_id(id):delete()
end

return model