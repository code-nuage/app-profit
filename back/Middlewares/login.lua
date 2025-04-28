local json = require("json")
local jwt = require("jwt")

local http_code = require("../Utils/http-code")
local mime = require("../Utils/mime")
local secret = require("../secret")

local model = require("../Models/user")

return function(json_data)
    local data = json.decode(json_data)

    if data then
        if model.user_exists(data.email) then
            if model.is_password_valid(data.email, data.password) then
                local jwt_token = jwt.sign({email=data.email, password = data.password},
                {secret = secret.secret_key})

                return json.encode({message = "You're logged in!"}),
                http_code.SUCCESS,
                "jwt=" .. jwt_token
                .. "; HttpOnly; "
                .. "Secure; "
                .. "Path=/; "
                .. "SameSite=Lax; "
                .. "Max-Age=" .. 1000 * 60 * 60 * 24,                           -- Set the cookie
                mime.json
            end
            return json.encode({error = "Your password is wrong."}),
            http_code.BAD_REQUEST,
            _,
            mime.json
        end
        return json.encode({error = "You're not registered yet."}),
        http_code.BAD_REQUEST,
        _,
        mime.json
    end

    return json.encode({error = "Can't decode data"}),
    http_code.BAD_REQUEST,
    _,
    mime.json
end