local json = require("json")
local jwt = require("jwt")

local secret_key = require("../config").secret

local http_code = require("../Utils/http-code")
local mime = require("../Utils/mime")
local cookiebuilder = require("../Utils/cookie-builder")

local model = require("../Models/user")

return function(json_data)
    local data = json.decode(json_data)

    if data then
        if model.user_exists(data.email) then
            if model.is_password_valid(data.email, data.password) then
                local hashed_password = model.get_by_email(data.email).password-- Don't store clear password in the JWT!
                local jwt_token = jwt.sign(                                    -- Create the token with hashed password
                {email = data.email, password = hashed_password},
                {secret = secret_key})

                local cookie = cookiebuilder("jwt", jwt_token,
                {["Path"] = "/",
                "HttpOnly",
                "Secure",
                ["SameSite"] = "None",
                "Partitioned",
                ["Max-Age"] = 1000 * 60 * 60 * 24})
                
                return json.encode({message = "You're logged in!"}),
                http_code.SUCCESS,
                cookie,                                                        -- Set the cookie
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