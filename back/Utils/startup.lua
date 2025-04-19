local goodbwhy = require("../Utils/goo-db-why")

local config = require("../config")

goodbwhy.select_database(config.database.name)

local user_model = require("../Models/user")
local category_model = require("../Models/category")

return function()
    local app_state = goodbwhy.dir.select("Configuration"):where_id(1):get()

    if not (app_state and app_state.state == "Started") then
        print([[
=============== PRE-STARTUP CONFIGURATOIN ================

Hey! It looks like it's the first startup of the backend of profit-app.
An ADMIN user will be created with name "ADMIN" and password "ADMIN".
Don't forget to modify it.

==========================================================
]])

        -- if not goodbwhy.dir.select("Configuration"):where_id(1):get() then
            goodbwhy.dir.select("Configuration"):insert({state = "Started"})
        -- else
        --     goodbwhy.dir.select("Configuration"):where_id(1):update({state = "Started"})
        -- end

        if not user_model.get_by_id(1) then
            user_model.create({name = "ADMIN", password = "ADMIN", birthdate = "1970-01-01", role = "ADMIN", email = "email@exemple.com"})
        elseif user_model.get_by_id(1).name == "ADMIN" then
            user_model.update_by_id(1, {name = "ADMIN", password = "ADMIN", birthdate = "1970-01-01", role = "ADMIN", email = "email@exemple.com"})
        end
        
        print(user_model.get_by_id(1).name == "ADMIN")
    end
end