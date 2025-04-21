local json = require("json")
local http_code = require("../Utils/http-code")
local mime = require("../Utils/mime")

local model = require("../Models/user")

return function(json_data)
    local data = json.decode(json_data)

    if data then
        if model.user_exists(data.email) then
            if model.is_password_valid(data.email, data.password) then
                return json.encode({message = "You're logged in!"}),
                http_code.SUCCESS,
                mime.json
            end
            return json.encode({error = "Your password is wrong."}),
            http_code.BAD_REQUEST,
            mime.json
        end
        return json.encode({error = "You're not registered yet."}),
        http_code.BAD_REQUEST,
        mime.json
    end

    return json.encode({error = "Can't decode data"}),
    http_code.BAD_REQUEST,
    mime.json
end